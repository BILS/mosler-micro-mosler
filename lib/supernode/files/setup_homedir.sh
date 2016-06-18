#!/bin/sh

dir="$1"
uname="$2"
uid="$3"
ugid="$4"

mkdir -p "$dir"

for p in .bashrc .bash_logout .bash_profile; do
     test -e "$dir/$p" || (cp "/etc/skel/$p" "$dir/$p"; chown "$uid"."$ugid"  "$dir/$p")
done

chown "$uid"."$ugid" "$dir"
