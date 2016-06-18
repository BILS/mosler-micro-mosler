#!/bin/sh

mkdir -p /var/lib/tl-director
mkdir -p /var/lib/tl-auth

chmod a+w /var/lib/tl-director
chmod a+w /var/lib/tl-auth

cd /var/lib/tl-director

while true; do

  mapping=''
  for user in *; do
    project="`cat "$user"`"
    ip="`sed -n  "s/^$project://p" /usr/local/etc/tlprojects `"

    if [ "x$ip" = x ]; then
      :
    else    
      /usr/local/sbin/establish_user "$user"
      mapping="$mapping $user:$ip"
    fi
  done
   
  /opt/thinlinc/bin/hivetool -r /etc/hiveconf.d/thinlinc.hconf  /thinlinc/vsmserver/explicit_agentselection="$mapping"

  /sbin/service vsmserver restart
  inotifywait -e close_write,create,delete,modify /var/lib/tl-director/    
done

