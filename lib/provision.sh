#!/usr/bin/env bash

# Get credentials and machines settings
source $(dirname ${BASH_SOURCE[0]})/settings.sh

export VAULT=vault
CONNECTION_TIMEOUT=1 #seconds
export DO_CHEAT=no
WITH_KEY=yes

function usage {
    echo "Usage: ${MM_CMD:-$0} [options]"
    echo -e "\noptions are"
    echo -e "\t--machines <list>,"
    echo -e "\t        -m <list>      \tA comma-separated list of machines"
    echo -e "\t                       \tDefaults to: \"${MACHINES[@]// /,}\"."
    echo -e "\t                       \tWe filter out machines that don't appear in the default list."
    echo -e "\t--vault <name>         \tName of the drop folder in the servers"
    echo -e "\t                       \tDefaults to '${VAULT}'"
    echo -e "\t--timeout <seconds>,   \tSkips the steps of syncing files to the servers"
    echo -e "\t       -t <seconds>    \tSkips the steps of syncing files to the servers"
    echo -e "\t--cheat                \tUses tricks to provision machines faster (like mysql pre-dumps)"
    echo -e "\t--quiet,-q             \tRemoves the verbose output"
    echo -e "\t--help,-h              \tOutputs this message and exits"
    echo -e "\t-- ...                 \tAny other options appearing after the -- will be ignored"
}

# While there are arguments or '--' is reached
while [ $# -gt 0 ]; do
    case "$1" in
        --quiet|-q) VERBOSE=no;;
        --help|-h) usage; exit 0;;
        --machines|-m) CUSTOM_MACHINES=$2; shift;;
        --cheat) DO_CHEAT=yes;;
        --vault) VAULT=$2; shift;;
        --timeout|-t) CONNECTION_TIMEOUT=$2; shift;;
        --no-key) WITH_KEY=no;;
        --) shift; break;;
        *) echo "$0: error - unrecognized option $1" 1>&2; usage; exit 1;;
    esac
    shift
done

[ $VERBOSE == 'no' ] && exec 1>${MM_TMP}/provision.log
ORG_FD1=$(tty)

#######################################################################
# Logic to allow the user to specify some machines
if [ -n ${CUSTOM_MACHINES:-''} ]; then
    CUSTOM_MACHINES_TMP=${CUSTOM_MACHINES//,/ } # replace all commas with space
    CUSTOM_MACHINES="" # Filtering the ones which don't exist in settings.sh
    for cm in $CUSTOM_MACHINES_TMP; do
	if [[ "${MACHINES[@]}" =~ "$cm" ]]; then
	    CUSTOM_MACHINES+="$cm "
	else
	    echo "Unknown machine: $cm" >${ORG_FD1}
	fi
	# for m in ${MACHINES[@]}; do
	#     [ "$cm" = "$m" ] && CUSTOM_MACHINES+=" $cm" && break
	# done
    done
    MACHINES=(${CUSTOM_MACHINES})

    echo "Using these machines: ${CUSTOM_MACHINES// /,}"

fi

#######################################################################
# Prepare the tmp folders
for machine in ${MACHINES[@]}; do mkdir -p ${MM_TMP}/$machine/provision; done

#######################################################################
export TL_HOME MOSLER_IMAGES
export LIB=${MM_HOME}/lib
source $LIB/utils.sh

#######################################################################
source $LIB/ssh_connections.sh

if [ ${#MACHINES[@]} -eq 0 ]; then
    echo "Nothing to be done. Exiting..." >${ORG_FD1}
    exit 2 # or 0?
fi

#######################################################################

declare -A JOB_PIDS
function cleanup {
    echo -e "\nStopping background jobs"
    kill -9 $(jobs -p) &>/dev/null
    exit 1
}
trap 'cleanup' INT TERM #EXIT #HUP ERR
# Or just kill the parent. That should kill the processes in that process group
# trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

#######################################################################
# Aaaaannnnnddd...... cue music!
########################################################################
echo -e "Configuring servers:"
FAIL=0
reset_progress
print_progress
export DB_SERVER=${MACHINE_IPs[openstack-controller]} # Used in the templates
export NFS_SERVER=${MACHINE_IPs[hnas-emulation]} # 

# set -e # exit in errors
# trap 'print_progress; oups "\a\nErrors found: Aborting"' ERR

for machine in ${MACHINES[@]}
do
    # Selecting the template
    _TEMPLATE=${LIB}/${PROVISION[$machine]}/provision.jn2
    if [ ! -f ${_TEMPLATE} ]; then
	oups "\tProvisioning script unknown for $machine"
	filter_out_machine $machine
    else

	_SCRIPT=${MM_TMP}/$machine/provision/run.sh
	_LOG=${MM_TMP}/$machine/provision/log
	# Rendering the template
	# It will use the (exported) environment variables
	cat > ${_SCRIPT} <<'EOF'
#!/usr/bin/env bash

# -w doesn't work on nc
function wait_port {
    local -i t=${3:-30} # default: 30 seconds, well...if you don't count the backoff...
    local -i backoff=1
    local -i stride=20
    while (( t > 0 )) ; do
	echo -e "Time left: $t"
	nc -4 -z -v $1 $2 && return 0
	(( t-=backoff ))
	sleep $backoff
        if (( (t % stride) == 0 )); then (( backoff*=2 )); fi
    done
    exit 1
}
EOF
	python -c "import os, sys, jinja2; \
                   sys.stdout.write(jinja2.Environment( loader=jinja2.FileSystemLoader(os.environ.get('LIB')) ) \
                             .from_string(sys.stdin.read()) \
                             .render(env=os.environ))" \
	       < ${_TEMPLATE} \
	       >>${_SCRIPT}

	{ # Scoping, in that current shell
	    ssh -F ${SSH_CONFIG} ${FLOATING_IPs[$machine]} 'sudo bash -e -x 2>&1' <${_SCRIPT} &>${_LOG}
	    RET=$?
	    if [ $RET -eq 0 ]; then report_ok $machine; else report_fail $machine; fi
	    print_progress
	    exit $RET
	} &
	JOB_PIDS[$machine]=$!
    fi
done
    
for job in ${JOB_PIDS[@]}; do wait $job || ((FAIL++)); done

########################################################################
if [ $WITH_KEY = yes ]; then
    echo "Handling supernode access to other machines"
    # If one of the two does not exit, recreate them the key pair.
    if [ ! -e ${MM_TMP}/ssh_key.${OS_TENANT_NAME} ] || [ -e ${MM_TMP}/ssh_key.${OS_TENANT_NAME}.pub ]; then
	rm -f ${MM_TMP}/ssh_key.${OS_TENANT_NAME} ${MM_TMP}/ssh_key.${OS_TENANT_NAME}.pub
	ssh-keygen -q -t rsa -N "" -f ${MM_TMP}/ssh_key.${OS_TENANT_NAME} -C supernode
    fi
    scp -q -F ${SSH_CONFIG} ${MM_TMP}/ssh_key.${OS_TENANT_NAME} ${MM_TMP}/ssh_key.${OS_TENANT_NAME}.pub ${FLOATING_IPs[supernode]}:${VAULT}/.
    ssh -F ${SSH_CONFIG} ${FLOATING_IPs[supernode]} 'sudo bash -e -x 2>&1' <<EOF &>/dev/null
mv ${VAULT}/ssh_key.${OS_TENANT_NAME} /root/.ssh/id_rsa
mv ${VAULT}/ssh_key.${OS_TENANT_NAME}.pub /root/.ssh/id_rsa.pub
chmod 600 /root/.ssh/id_rsa
chmod 644 /root/.ssh/id_rsa.pub
EOF
    for machine in ${MACHINES[@]}
    do
	[ "$machine" == "supernode" ] && continue
	scp -q -F ${SSH_CONFIG} ${MM_TMP}/ssh_key.${OS_TENANT_NAME}.pub ${FLOATING_IPs[$machine]}:${VAULT}/id_rsa.pub
	ssh -F ${SSH_CONFIG} ${FLOATING_IPs[$machine]} 'sudo bash -e -x 2>&1' <<EOF &>/dev/null
sudo sed -i -e '/supernode/d' /root/.ssh/authorized_keys
cat ${VAULT}/id_rsa.pub >> /root/.ssh/authorized_keys
rm ${VAULT}/id_rsa.pub
EOF
    done
fi

########################################################################
exec 1>${ORG_FD1}
print_progress # to have a clear picture
if (( FAIL > 0 )); then
    oups "\a\n${FAIL} servers failed to be configured"
else
    thumb_up "\nServers configured"
fi
