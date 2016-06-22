#!/bin/bash

myuid=`id -u`

if [ "$myuid" -eq 0 ]; then
  :
else
  echo "Please run as root/sudo"
  exit 1
fi

. /root/.keystonerc

tmpfil=/tmp/nfssan.$$

test -e "$tmpfil" && exit 1

ssh root@hnas-emulation 'showmount -e' > $tmpfil

grep '^192.168' $tmpfil | sed -e 's/(.*//' | sort | uniq -c | while read count net; do

  if [ "$count" -gt 1 ] ; then
    echo 'INSANITY!'
    echo
    echo "Network $net can access $count exports."

    egrep '(Export name|^192.168)' "$tmpfil" | while read a b c; do
     if [ "x$a" = xExport ]; then
       lastexport="$c"
     else
       echo "$a" | grep -q "$net" && echo "$net has access to $lastexport"
     fi
    done


    echo "Bailing out early, other problems may be masked. Fix these and rerun."
    rm -f "$tmpfil"
    exit 1
  fi
done

# No net has access to more than one export, good.

neutron net-list > "$tmpfil".net

egrep '(Export name|^192.168)' "$tmpfil" | while read a b c; do
   if [ "x$a" = xExport ]; then
     project="${c#/}"
   else
     net="${a%(*}"
     if grep -q "${project}-private_net .* $net" "$tmpfil".net; then
       : Everything is awesome. 
     else
       echo "Failed to find matching net definition for export $project to $net." 
     fi
   fi
done


rm -f "$tmpfil" "$tmpfil".net
exit 0

