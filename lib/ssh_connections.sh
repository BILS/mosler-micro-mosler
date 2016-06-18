# Must be included after utils.sh

#######################################################################
# Checking if machines are available
# Filtering them out otherwise
#######################################################################
SSH_CONFIG=${MM_TMP}/ssh_config.${OS_TENANT_NAME}
SSH_KNOWN_HOSTS=${MM_TMP}/ssh_known_hosts.${OS_TENANT_NAME}

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
    #            s.settimeout(${CONNECTION_TIMEOUT:-1}.0); \
    #            s.connect(('${FLOATING_IPs[${MACHINES[$i]}]}', 22))" &> /dev/null \
    # CONNECTION_TIMEOUT defaults to 1 second if not defined
    nc -4 -z -w ${CONNECTION_TIMEOUT:-1} ${FLOATING_IPs[${MACHINES[$i]}]} 22 \
	&& report_ok ${MACHINES[$i]} \
	    || { CONNECTION_FAIL+=" ${MACHINES[$i]}"; filter_out $i; }
    print_progress
done
for machine in ${MACHINES[@]}; do ssh-keyscan -4 -T 1 ${FLOATING_IPs[$machine]} >> ${SSH_KNOWN_HOSTS} 2>/dev/null; done
#Note: I silence the errors from stderr (2) to /dev/null. Don't send them to &1.
# The exit status of ssh-keyscan is 0 even when the connection failed: Using nc instead.

echo "" # new line
[ -n "$CONNECTION_FAIL" ] && echo "Filtering out:$CONNECTION_FAIL"
