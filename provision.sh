#!/usr/bin/env bash

# Get credentials and machines settings
HERE=$(dirname ${BASH_SOURCE[0]})
source $HERE/settings.sh

export TL_HOME MOSLER_HOME MOSLER_MISC MOSLER_IMAGES
export LIB=${MM_HOME}/lib

export VAULT=vault
export CONNECTION_TIMEOUT=1 #seconds
DO_COPY=yes
export DO_CHEAT=no

function usage {
    echo "Usage: $0 [options]"
    echo -e "\noptions are"
    echo -e "\t--machines <list>,"
    echo -e "\t        -m <list>      \tA comma-separated list of machines"
    echo -e "\t                       \tDefaults to: \"${MACHINES[@]// /,}\"."
    echo -e "\t                       \tWe filter out machines that don't appear in the default list."
    echo -e "\t--vault <name>         \tName of the drop folder in the servers"
    echo -e "\t                       \tDefaults to '${VAULT}'"
    echo -e "\t--no-copy,-n           \tSkips the steps of syncing files to the servers"
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
        --no-copy|-n) DO_COPY=no;;
        --cheat) DO_CHEAT=yes;;
        --vault) VAULT=$2; shift;;
        --timeout|-t) CONNECTION_TIMEOUT=$2; shift;;
        --) shift; break;;
        *) echo "$0: error - unrecognized option $1" 1>&2; usage; exit 1;;
    esac
    shift
done

#######################################################################
function thumb_up {
    [ -n "$1" ] && echo -ne "$1 "
    echo -e "\xF0\x9F\x91\x8D"
}
function oups {
    [ -n "$1" ] && echo -ne "$1 "
    echo -e "\e[31m\xF0\x9F\x9A\xAB\e[0m"
}

#######################################################################
# Logic to allow the user to specify some machines
if [ -n ${CUSTOM_MACHINES:-''} ]; then
    CUSTOM_MACHINES_TMP=${CUSTOM_MACHINES//,/ } # replace all commas with space
    CUSTOM_MACHINES="" # Filtering the ones which don't exist in settings.sh
    for cm in $CUSTOM_MACHINES_TMP; do
	if [[ "${MACHINES[@]}" =~ "$cm" ]]; then
	    CUSTOM_MACHINES+="$cm "
	else
	    echo "Unknown machine: $cm"
	fi
	# for m in ${MACHINES[@]}; do
	#     [ "$cm" = "$m" ] && CUSTOM_MACHINES+=" $cm" && break
	# done
    done
    MACHINES=(${CUSTOM_MACHINES})

    if [ ${#MACHINES[@]} -eq 0 ]; then
	oups "Nothing to be done. Exiting..."
	exit 2
    else
	[ "$VERBOSE" = "yes" ] && echo "Using these machines: ${CUSTOM_MACHINES// /,}"
    fi
fi

mkdir -p ${PROVISION_TMP}

########################################################################
# Finding a suitable port for the notification server
NOTIFICATION_PORT=${PORT}
while fuser ${NOTIFICATION_PORT}/tcp &>/dev/null ; do (( NOTIFICATION_PORT++ )); done
NOTIFICATION_URL=http://${PHONE_HOME}:${NOTIFICATION_PORT}

function kill_notifications {
    [ "$VERBOSE" = "yes" ] && echo "Stopping the notification server"
    fuser -k ${NOTIFICATION_PORT}/tcp &>/dev/null
    #kill -9 ${NOTIFICATION_PID}
}

[ "$VERBOSE" = "yes" ] && echo "Starting the notification server [on port ${NOTIFICATION_PORT}]"
python $LIB/notifications.py ${NOTIFICATION_PORT} "${MACHINES[@]}" &> ${PROVISION_TMP}/notifications.log &
NOTIFICATION_PID=$!
sleep 1


#######################################################################
# Logic to print progress and start/pause
export FAIL=0

function print_progress {
    ans=$(curl ${NOTIFICATION_URL}/show_progress 2>/dev/null) # silence the progress bar
    echo -ne "\r$ans"
}

function reset_progress { # Initialization
    FAIL=0
    for m in ${MACHINES[@]}; do
	curl -X POST -d '\e[34m...\e[0m' ${NOTIFICATION_URL}/progress/$m &>/dev/null 
    done
}
# Not testing if $1 exists. It will!
function report_ok {
    curl -X POST -d ' \e[32m\xE2\x9C\x93\e[0m ' ${NOTIFICATION_URL}/progress/$1 &>/dev/null 
}
function report_fail {
    curl -X POST -d ' \e[31m\xE2\x9C\x97\e[0m ' ${NOTIFICATION_URL}/progress/$1 &>/dev/null
    curl -X POST ${NOTIFICATION_URL}/fail/$1 &>/dev/null
}
function filter_out {
    curl -X POST -d ' \e[31m\xF0\x9F\x9A\xAB\e[0m ' ${NOTIFICATION_URL}/progress/${MACHINES[$1]} &>/dev/null 
    unset MACHINES[$1]
}

function filter_out_machine {
    for i in ${!MACHINES[@]}; do
	[ ${MACHINES[$i]} == $1 ] && filter_out $i && return 0 # Found, removed and done!
    done
    return 1 # not found
}

#######################################################################
# Checking if machines are available
# Filtering them out otherwise
#######################################################################

SSH_CONFIG=${PROVISION_TMP}/ssh_config.${OS_TENANT_NAME}
SSH_KNOWN_HOSTS=${PROVISION_TMP}/ssh_known_hosts.${OS_TENANT_NAME}

[ "$VERBOSE" = "yes" ] && echo -e "Checking the connections:"
reset_progress
CONNECTION_FAIL=""
cat > ${SSH_CONFIG} <<ENDSSHCFG
Host ${FLOATING_CIDR%0/24}*
	User centos
	ControlMaster auto
	ControlPersist 60s
	StrictHostKeyChecking no
	UserKnownHostsFile ${SSH_KNOWN_HOSTS}
	ForwardAgent yes
ENDSSHCFG

:> ${SSH_KNOWN_HOSTS}
for i in ${!MACHINES[@]}; do
    # python -c "import socket; \
    #            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM); \
    #            s.settimeout(${CONNECTION_TIMEOUT}.0); \
    #            s.connect(('${FLOATING_IPs[${MACHINES[$i]}]}', 22))" &> /dev/null \
    nc -4 -z -w ${CONNECTION_TIMEOUT} ${FLOATING_IPs[${MACHINES[$i]}]} 22 \
	&& report_ok ${MACHINES[$i]} \
	    || { CONNECTION_FAIL+=" ${MACHINES[$i]}"; filter_out $i; }
    print_progress
done
for machine in ${MACHINES[@]}; do ssh-keyscan -4 -T 1 ${FLOATING_IPs[$machine]} >> ${SSH_KNOWN_HOSTS} 2>/dev/null; done
#Note: I silence the errors from stderr (2) to /dev/null. Don't send them to &1.
# The exit status of ssh-keyscan is 0 even when the connection failed: Using nc instead.

if [ -n "$CONNECTION_FAIL" ]; then
    oups "\nFiltering out:$CONNECTION_FAIL"
else
    echo ""
    #thumb_up "\nAll connections are ready"
fi

########################################################################
# Finding a suitable port for the notification server
NOTIFICATION_PORT=${PORT}
while fuser ${NOTIFICATION_PORT}/tcp ; do (( NOTIFICATION_PORT++ )); done

function kill_notifications {
    [ "$VERBOSE" = "yes" ] && echo "Stopping the notification server"
    fuser -k ${NOTIFICATION_PORT}/tcp &>/dev/null
    #kill -9 ${NOTIFICATION_PID}
}

# Cleaning up after us. Catching EXIT is enough. Even on errors
trap "echo; kill_notifications || true; exit 1" EXIT #INT TERM ERR 

[ "$VERBOSE" = "yes" ] && echo "Starting the notification server [on port ${NOTIFICATION_PORT}]"
python $LIB/notifications.py ${NOTIFICATION_PORT} "${MACHINES[@]}" &> ${PROVISION_TMP}/notifications.log &
NOTIFICATION_PID=$!

########################################################################
# For the parallel execution
=======
########################################################################
# For the parallel execution
########################################################################
>>>>>>> 2c8a5d94deb0782656f6cdb82a7051bcb9d36a9d

declare -A JOB_PIDS
# function kill_bg_jobs {
#     [ "$VERBOSE" = "yes" ] && echo -e "\nStopping background jobs"
#     for job in ${JOB_PIDS[@]}; do kill -9 $job &>/dev/null; done
# }
function cleanup {
    [ "$VERBOSE" = "yes" ] && echo -e "\nStopping background jobs"
    kill -9 $(jobs -p) &>/dev/null
    #kill_notifications
}
#set -e # exit if errors
# Cleaning up after us. Catching EXIT is enough. Even on errors
# shopt -qs huponexit
trap 'cleanup' INT TERM #EXIT #HUP ERR

# Or just kill the parent. That should kill the processes in that process group
# trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

########################################################################
# Copying files
########################################################################

if [ "$DO_COPY" = "yes" ]; then

    export CONFIGS=${MM_HOME}/configs

    python -c "import os, sys, jinja2; \
               sys.stdout.write(jinja2.Template(sys.stdin.read()).render(env=os.environ))" \
	   <${LIB}/files.jn2 \
	   >${PROVISION_TMP}/files

    # In order to avoid many concurrent ssh connections towards the same
    # server, we gather the file to copy and cluster them per server. 
    #
    # We will launch a new process, per machine, that copies the listed
    # files for that machine.
    
    # Cleaning the listings
    [ "$VERBOSE" = "yes" ] && echo "Preparing listings"
    for machine in ${MACHINES[@]}; do : > ${PROVISION_TMP}/copy.$machine; done

    # Ignore empty lines and cluster the files per machine
    sed '/^$/d' ${PROVISION_TMP}/files | while IFS='' read -r line; do
	src=${line#*:}
	machine=${line%%:*}
	if [ -e $src ]; then
	    echo "$src" >> ${PROVISION_TMP}/copy.$machine
	else
	    echo -e "\tIgnoring $src [for $machine]."
	fi
    done

    [ "$VERBOSE" = "yes" ] && echo "Copying files"
    reset_progress
    print_progress
    for machine in ${MACHINES[@]}
    do
	{ # scoping, in that current shell
	    ( # In a subshell
		exec &>${PROVISION_TMP}/rsync.$machine
		set -x -e # Print commands && exit if errors
		# Preparing the drop folder
		ssh -F ${SSH_CONFIG} ${FLOATING_IPs[$machine]} mkdir -p ${VAULT}
		# Copying all files to the VAULT on that machine
		while read -r f ; do
		    rsync -av -e "ssh -F ${SSH_CONFIG}" $f ${FLOATING_IPs[$machine]}:${VAULT}/.
		done < ${PROVISION_TMP}/copy.$machine
	    )
	    RET=$?
	    if [ $RET -eq 0 ]; then
		report_ok $machine 
	    else
		report_fail $machine
	    fi
	    print_progress
	    exit $RET
	} &
	JOB_PIDS[$machine]=$!
    done
    # Wait for all the copying to finish
    for job in ${JOB_PIDS[@]}; do wait ${job} || ((FAIL++)); print_progress; done
    print_progress # to have a clear picture
    if (( FAIL > 0 )) ; then
	oups "\nFailed copying"
	echo "Exiting..." 
	kill_notifications
	exit 1
    # else
    # 	[ "$VERBOSE" = "yes" ] && thumb_up "\nFiles copied"
    fi
fi

#######################################################################
# Aaaaannnnnddd...... cue music!
########################################################################
[ "$VERBOSE" = "yes" ] && echo -e "\nConfiguring servers:"
reset_progress
print_progress
declare -A PROVISION_PIDS

function major_booboo {
    for machine in ${!PROVISION_PIDS[@]}
    do
	kill -9 ${PROVISION_PIDS[$machine]} &>/dev/null || true
    done
    print_progress
    oups "\a\nProvisioning of some servers failed"
}
set -e # exit if errors
trap "major_booboo" ERR

export DB_SERVER=${MACHINE_IPs[openstack-controller]} # Used in the templates
for machine in ${MACHINES[@]}
do
    # Selecting the template
     _TEMPLATE=${LIB}/${PROVISION[$machine]}.jn2
    if [ -z "${PROVISION[$machine]}" ] || [ ! -f ${_SCRIPT} ]; then
	oups "\tProvisioning script unknown for $machine"
	filter_out_machine $machine
    else

	_SCRIPT=${PROVISION_TMP}/run.$machine
	_LOG=${PROVISION_TMP}/log.$machine
	# Common functions for notifications
	cat > ${_SCRIPT} <<EOF
#!/usr/bin/env bash

function register {
    curl -X POST -d \$2 ${NOTIFICATION_URL}/$machine/\$1 2>/dev/null
}

function wait_for {
    local -r -i timeout=\${4:-30} # default: 30 seconds
    local -i t=0 # local integer variable
    local -i backoff=1

    while (( (t++) <= timeout )) ; do
	echo -e "Try \$t \\tTimeout: \$timeout"
        res=\$(curl ${NOTIFICATION_URL}/\$1/\$2 2>/dev/null)
        if [ \$? -ne 0 ] ; then echo "Unable to get status for \$2 on \$1"; break; fi
        if [ "\$res" == "\$3" ] ; then echo "Task \$2 is \$3 on \$1 (after \$t seconds)"; return 0; fi
        if [ "\$res" == "ERR" ] ; then echo "Task \$2 failed on \$1: Exiting..."; break; fi
	sleep \$backoff
        if (( (t % 10) == 0 )); then (( backoff*=2 )); fi
        echo "backoff: \$backoff"
    done
    exit 1
}

# -w doesn't work on nc
function wait_port {
    local -r -i timeout=\${3:-30} # default: 30 seconds
    local -i t=0 # local integer variable
    local -i backoff=1
    while (( (t++) <= timeout )) ; do
	echo -e "Try \$t \\tTimeout: \$timeout"
	nc -4 -z -v \$1 \$2 && return 0
        res=\$(curl ${NOTIFICATION_URL}/fail/\$1 2>/dev/null)
        if [ \$? -ne 0 ] ; then echo "Unable to get contact to \$1"; break; fi
        if [ "\$res" == "FAIL" ] ; then echo "\$1 has already failed: Giving up here..."; break; fi
	sleep \$backoff
        if (( (t % 10) == 0 )); then
	    backoff=\$(( backoff * 2 ))
            echo "new backoff: \$backoff"
	fi
    done
    exit 1
}
EOF

	# Rendering the template
	# It will use the (exported) environment variables
	python -c "import os, sys, jinja2; \
            sys.stdout.write(jinja2.Environment(loader=jinja2.FileSystemLoader(os.environ.get('LIB'))).from_string(sys.stdin.read()).render(env=os.environ))" \
	       <${_TEMPLATE} \
	       >> ${_SCRIPT}

	{ # Scoping, in that current shell
	    ssh -F ${SSH_CONFIG} ${FLOATING_IPs[$machine]} 'sudo bash -e -x -v 2>&1' <${_SCRIPT} &>${_LOG}
	    RET=$?
	    if [ $RET -eq 0 ]; then
		report_ok $machine 
	    else
		report_fail $machine
	    fi
	    print_progress
	    exit $RET
	} &
	PROVISION_PIDS[$machine]=$!
    fi
done
    
for job in ${JOB_PIDS[@]}; do wait $job || ((FAIL++)); done
print_progress

if (( FAIL > 0 )); then
    oups "\a\n${FAIL} servers failed to be configured"
else
    [ "$VERBOSE" = "yes" ] && echo "" && thumb_up "Servers configured"
fi
=======
fi

#######################################################################
# Aaaaannnnnddd...... cue music!
########################################################################
[ "$VERBOSE" = "yes" ] && echo -e "\nConfiguring servers:"
reset_progress
print_progress
export DB_SERVER=${MACHINE_IPs[openstack-controller]} # Used in the templates
for machine in ${MACHINES[@]}
do
    # Selecting the template
     _TEMPLATE=${LIB}/${PROVISION[$machine]}.jn2
    if [ -z "${PROVISION[$machine]}" ] || [ ! -f ${_SCRIPT} ]; then
	oups "\tProvisioning script unknown for $machine"
	filter_out_machine $machine
    else

	_SCRIPT=${PROVISION_TMP}/run.$machine
	_LOG=${PROVISION_TMP}/log.$machine
	# Common functions for notifications
	cat > ${_SCRIPT} <<EOF
#!/usr/bin/env bash

function register {
    curl -X POST -d \$2 ${NOTIFICATION_URL}/$machine/\$1 2>/dev/null
}

function wait_for {
    local -r -i timeout=\${4:-30} # default: 30 seconds
    local -i t=0 # local integer variable
    local -i backoff=1

    while (( (t++) <= timeout )) ; do
	echo -e "Try \$t \\tTimeout: \$timeout"
        res=\$(curl ${NOTIFICATION_URL}/\$1/\$2 2>/dev/null)
        if [ \$? -ne 0 ] ; then echo "Unable to get status for \$2 on \$1"; break; fi
        if [ "\$res" == "\$3" ] ; then echo "Task \$2 is \$3 on \$1 (after \$t seconds)"; return 0; fi
        if [ "\$res" == "ERR" ] ; then echo "Task \$2 failed on \$1: Exiting..."; break; fi
	sleep \$backoff
        if (( (t % 10) == 0 )); then (( backoff*=2 )); fi
        echo "backoff: \$backoff"
    done
    exit 1
}

# -w doesn't work on nc
function wait_port {
    local -r -i timeout=\${3:-30} # default: 30 seconds
    local -i t=0 # local integer variable
    local -i backoff=1
    while (( (t++) <= timeout )) ; do
	echo -e "Try \$t \\tTimeout: \$timeout"
	nc -4 -z -v \$1 \$2 && return 0
        res=\$(curl ${NOTIFICATION_URL}/fail/\$1 2>/dev/null)
        if [ \$? -ne 0 ] ; then echo "Unable to get contact to \$1"; break; fi
        if [ "\$res" == "FAIL" ] ; then echo "\$1 has already failed: Giving up here..."; break; fi
	sleep \$backoff
        if (( (t % 10) == 0 )); then
	    backoff=\$(( backoff * 2 ))
            echo "new backoff: \$backoff"
	fi
    done
    exit 1
}
EOF

	# Rendering the template
	# It will use the (exported) environment variables
	python -c "import os, sys, jinja2; \
            sys.stdout.write(jinja2.Environment(loader=jinja2.FileSystemLoader(os.environ.get('LIB'))).from_string(sys.stdin.read()).render(env=os.environ))" \
	       <${_TEMPLATE} \
	       >> ${_SCRIPT}

	{ # Scoping, in that current shell
	    ssh -F ${SSH_CONFIG} ${FLOATING_IPs[$machine]} 'sudo bash -e -x -v 2>&1' <${_SCRIPT} &>${_LOG}
	    RET=$?
	    if [ $RET -eq 0 ]; then
		report_ok $machine 
	    else
		report_fail $machine
	    fi
	    print_progress
	    exit $RET
	} &
	JOB_PIDS[$machine]=$!
    fi
done
    
for job in ${JOB_PIDS[@]}; do wait $job || ((FAIL++)); done
print_progress

if (( FAIL > 0 )); then
    oups "\a\n${FAIL} servers failed to be configured"
else
    [ "$VERBOSE" = "yes" ] && thumb_up "\nServers configured"
fi

>>>>>>> 2c8a5d94deb0782656f6cdb82a7051bcb9d36a9d
kill_notifications
