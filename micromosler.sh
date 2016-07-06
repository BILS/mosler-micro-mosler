#!/usr/bin/env bash

function usage {
    echo "Usage: $0 command [options]"
    echo -e "\ncommands are:"
    echo -e "\tinit         \tInitializes the VMs"
    echo -e "\tclean        \tRemoves allocated resources"
    echo -e "\tsync         \tCopies relevant files to the VMs"
    echo -e "\tprovision    \tConfigures the infracstructure"

    echo -e "\nSupply --help (or -h) to see the options for each command"

    echo -e "\nThe typical order to set up MicroMosler is to call:"
    echo -e "\t$0 init --all   # --all to create networks too"
    echo -e "\t$0 sync"
    echo -e "\t$0 provision"
    echo ""
}

case "$1" in
    init|clean|sync|provision) _CMD=$1;;
    *) echo "$0: error - unrecognized command $1" 1>&2; usage; exit 1;;
esac
shift

export MM_CMD="$0 ${_CMD}"
$(dirname ${BASH_SOURCE[0]})/lib/${_CMD}.sh $@
