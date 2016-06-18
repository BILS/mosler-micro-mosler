#!/bin/sh -x

log_path="/var/log/uppmax-logs"
mkdir -p "$log_path"

cd /usr/local/etc/sync

timestamp="$( date +"%Y%m%d-%H%M%S" )"

out_log="$log_path/sync-${timestamp}.out"
err_log="$log_path/sync-${timestamp}.err"

printf "==> Output to '%s'\n" "$out_log"
printf "==> Errors to '%s'\n" "$err_log"

trap 'echo "!!> TERMINATED: $( date )" | tee -a $out_log >>$err_log; exit 1' INT TERM HUP

for path in apps comp libs libs_sl6 parallel uppmax mf dist/userrepos; do
    timestamp="$( date )"

    source="$SUDO_USER@tintin.uppmax.uu.se:/sw/$path/"
    target="/sw/$path/"

    if [ -f uppmax-exclude-${path}.txt ]; then
        extra_exclude_file="uppmax-exclude-${path}.txt"
    else
        extra_exclude_file="/dev/null"
    fi

    rsync $opt_dryrun --verbose \
        --delete --delete-excluded --ignore-errors \
        --omit-dir-times --prune-empty-dirs --archive --stats \
        --human-readable \
        --exclude-from uppmax-exclude-common.txt \
        --exclude-from "$extra_exclude_file" \
        --filter 'protect meles' --filter 'protect meles/' \
        --filter 'protect /uppmax-local-node-compat/' \
        "$source" "$target"

done >"$out_log" 2>"$err_log"

echo "==> DONE" >>"$out_log"

# vim: et list sw=4 sts=4
