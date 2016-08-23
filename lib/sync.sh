#!/usr/bin/env bash

# Get credentials and machines settings
source $(dirname ${BASH_SOURCE[0]})/settings.sh

export VAULT=vault
CONNECTION_TIMEOUT=1 #seconds
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
    echo -e "\t--no-key,-n            \tDisables the SSH key generation for supernode"
    echo -e "\t--timeout <seconds>,"
    echo -e "\t       -t <seconds>    \tMaximal waiting time for each server connection"
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
        --vault) VAULT=$2; shift;;
        --timeout|-t) CONNECTION_TIMEOUT=$2; shift;;
        --no-key|-n) WITH_KEY=no;;
        --) shift; break;;
        *) echo "$0: error - unrecognized option $1" 1>&2; usage; exit 1;;
    esac
    shift
done

[ $VERBOSE == 'no' ] && exec 1>${MM_TMP}/sync.log
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
	    echo "Unknown machine: $cm" > ${ORG_FD1}
	fi
    done
    MACHINES=(${CUSTOM_MACHINES})

    echo "Using these machines: ${CUSTOM_MACHINES// /,}"

fi

#######################################################################
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
}
trap 'cleanup' INT TERM #EXIT #HUP ERR
# Or just kill the parent. That should kill the processes in that process group
# trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

#export TL_HOME MOSLER_IMAGES

echo "Syncing servers"
FAIL=0
reset_progress
print_progress
for machine in ${MACHINES[@]}
do
    { # scoping, in that current shell
	( # In a subshell

	    FOLDER=$LIB/${PROVISION[$machine]}
	    [ ! -d ${FOLDER} ] && oups "\nProvisioning folder unknown for $machine" && exit 1

	    exec &>${MM_TMP}/$machine/sync/log
	    set -x -e # Print commands && exit if errors

	    # Preparing the drop folder
	    ssh -F ${SSH_CONFIG} ${FLOATING_IPs[$machine]} mkdir -p ${VAULT}
	    
	    # Copying all files to the VAULT on that machine
	    [ -d ${FOLDER}/files ] &&
		rsync -avL -e "ssh -F ${SSH_CONFIG}" ${FOLDER}/files/ ${FLOATING_IPs[$machine]}:${VAULT}/.
	    
	    # [ "$machine" == "thinlinc" ] && [ -d $TL_HOME ] &&
	    # 	rsync -av -e "ssh -F ${SSH_CONFIG}" $TL_HOME/ ${FLOATING_IPs[$machine]}:${VAULT}/.
	    
	    # if [ "$machine" == "controller" ]; then
	    # 	for img in project-computenode-stable project-loginnode-stable topolino-q-stable; do
	    # 	    [ -f ${MOSLER_IMAGES}/$img ] &&
	    # 		rsync -av --no-perms -e "ssh -F ${SSH_CONFIG}" ${MOSLER_IMAGES}/$img ${FLOATING_IPs[$machine]}:${VAULT}/.
	    # 	done
	    # fi
	    
	    # Phase 2: running some commands
	    _SCRIPT=${MM_TMP}/$machine/sync/run.sh
	    # Render the template
	    python -c "import os, sys, jinja2; \
                       sys.stdout.write(jinja2.Environment( loader=jinja2.FileSystemLoader(os.environ.get('LIB')) ) \
                                 .from_string(sys.stdin.read()) \
                                 .render(env=os.environ))" \
		   <${FOLDER}/sync.jn2 \
		   >${_SCRIPT}
	    ssh -F ${SSH_CONFIG} ${FLOATING_IPs[$machine]} 'sudo bash -e -x 2>&1' <${_SCRIPT}
	)
	RET=$?
	if [ $RET -eq 0 ]; then report_ok $machine; else report_fail $machine; fi
	print_progress
	exit $RET
    } &
    JOB_PIDS[$machine]=$!
done
# Wait for all the copying to finish
for job in ${JOB_PIDS[@]}; do wait ${job} || ((FAIL++)); print_progress; done

########################################################################
if [ $WITH_KEY = yes ] && [[ " ${MACHINES[@]} " =~ " supernode " ]]; then # if contains supernode
    echo -e "\nHandling supernode access to other machines"
    # If one of the two does not exit, recreate them the key pair.
    if [ ! -e ${MM_TMP}/ssh_key ] || [ -e ${MM_TMP}/ssh_key.pub ]; then
	rm -f ${MM_TMP}/ssh_key ${MM_TMP}/ssh_key.pub
	ssh-keygen -q -t rsa -N "" -f ${MM_TMP}/ssh_key -C supernode
    fi
    cat > ${MM_TMP}/ssh_key.config <<EOF
Host ${MACHINES[@]// /,}
        User root
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null
EOF
    scp -q -F ${SSH_CONFIG} ${MM_TMP}/ssh_key.config ${MM_TMP}/ssh_key ${MM_TMP}/ssh_key.pub ${FLOATING_IPs[supernode]}:${VAULT}/.
    ssh -F ${SSH_CONFIG} ${FLOATING_IPs[supernode]} 'sudo bash -e -x 2>&1' <<EOF >/dev/null
mv ${VAULT}/ssh_key /root/.ssh/id_rsa
mv ${VAULT}/ssh_key.pub /root/.ssh/id_rsa.pub
mv ${VAULT}/ssh_key.config /root/.ssh/config
chown root:root /root/.ssh/config /root/.ssh/id_rsa /root/.ssh/id_rsa.pub
chmod 600 /root/.ssh/id_rsa /root/.ssh/config
chmod 644 /root/.ssh/id_rsa.pub
EOF
    for machine in ${MACHINES[@]}
    do
	[ "$machine" == "supernode" ] && continue
	scp -q -F ${SSH_CONFIG} ${MM_TMP}/ssh_key.pub ${FLOATING_IPs[$machine]}:${VAULT}/id_rsa.pub
	ssh -F ${SSH_CONFIG} ${FLOATING_IPs[$machine]} 'sudo bash -e -x 2>&1' <<EOF >/dev/null
sed -i -e '/supernode/d' /root/.ssh/authorized_keys
cat ${VAULT}/id_rsa.pub >> /root/.ssh/authorized_keys
#rm ${VAULT}/id_rsa.pub
EOF
    done
fi

########################################################################
exec 1>${ORG_FD1}
print_progress # to have a clear picture
if (( FAIL > 0 )) ; then
    oups "\nFailed copying"
    exit 1
else
    thumb_up "\nSyncing successful"
fi
