#!/usr/bin/env bash

# Get credentials and machines settings
source $(dirname ${BASH_SOURCE[0]})/settings.sh

function usage {
    echo "Usage: ${MM_CMD:-$0} [--help|-h] <machine>"
}

# While there are arguments or '--' is reached
while [ $# -gt 0 ]; do
    case "$1" in
        --help|-h) usage; exit 0;;
	hnas|nfs) host='storage';;
	network) host='neutron';;
        --) shift; break;;
        *) host=$1;;
    esac
    shift
done

[ -z $host ] && usage && exit 1

[ -z "${FLOATING_IPs[$host]}" ] && echo "Unknown machine: $host" && exit 1

[ -f ${MM_TMP}/ssh_config ] && CONF="-F ${MM_TMP}/ssh_config"

echo "Connecting to $host [${FLOATING_IPs[$host]}]"
ssh $@ -t $CONF ${FLOATING_IPs[$host]} 'sudo bash'
