########################################################################
declare -a MSG
MSG[0]=$'\e[34m\xE2\x80\xA6\e[0m'     # ... (ellipsis)
MSG[1]=$'\e[32m\xE2\x9C\x93\e[0m'     # ok (checkmark)
MSG[2]=$'\e[31m\xE2\x9C\x97\e[0m'     # fail (cross)
MSG[3]=$'\e[31m\xF0\x9F\x9A\xAB\e[0m' # filtered (forbidden sign)
MSG[4]=$'\xF0\x9F\x91\x8D'            # success (thumb up)
########################################################################

# Used in the print_progress so that we show the filtered ones too
ALL_MACHINES=("${MACHINES[@]}")

function thumb_up {
    [ -n "$1" ] && echo -ne "$1 "
    echo -e ${MSG[4]}
}
function oups {
    [ -n "$1" ] && echo -ne "$1 "
    echo -e ${MSG[3]}
}

function print_progress {
    ( flock -x 200 # lock exclusively fd 200. Unlock is automatic
      printf "\e[2K\r|" # clear line and go back to the beginning
      for machine in ${ALL_MACHINES[@]}; do printf " %s %3b |" $machine ${MSG[$(<${MM_TMP}/$machine/progress)]}; done
    ) 200>${MM_TMP}/progress_lock
}

function reset_progress { # Initialization
    for machine in ${MACHINES[@]}; do echo -n 0 > ${MM_TMP}/$machine/progress; done
}
function report_ok { # Not testing if $1 exists. It will!
    echo -n 1 > ${MM_TMP}/$1/progress
}
function report_fail {
    echo -n 2 > ${MM_TMP}/$1/progress
    #curl -X POST ${NOTIFICATION_URL}/fail/$1 &>/dev/null
}
function filter_out {
    echo -n 3 > ${MM_TMP}/${MACHINES[$1]}/progress
    unset MACHINES[$1]
}
function filter_out_machine {
    for i in ${!MACHINES[@]}; do
	[ ${MACHINES[$i]} == $1 ] && filter_out $i && return 0 # Found, removed and done!
    done
    return 1 # not found
}
