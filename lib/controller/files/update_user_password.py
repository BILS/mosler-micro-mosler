#!/usr/bin/env python

import fcntl
import os
import sys
import ldap
import re
from base64 import b64decode

import ConfigParser

KEYSTONE_CONFIG = '/etc/keystone/keystone.conf'
PASSWORD_PATH='/tmp/password_changes.txt'

if not os.path.isfile(KEYSTONE_CONFIG):
   sys.stderr.write("Can't find config file\n")
   sys.exit(1)

CONF = ConfigParser.ConfigParser()
CONF.read(KEYSTONE_CONFIG)


USER_DN_BASE = '%s=%%s,%s' % (CONF.get('ldap',"user_id_attribute"), CONF.get('ldap',"user_tree_dn"))


if not os.path.isfile(PASSWORD_PATH):
   #sys.stderr.write("No new passwords\n")
   sys.exit()

fh = open(PASSWORD_PATH, 'r')
fcntl.lockf(fh, fcntl.LOCK_SH)

conn = ldap.initialize(CONF.get('ldap',"url"))
res = conn.simple_bind(CONF.get('ldap',"user"), CONF.get('ldap',"password"))

lines = fh.readlines()

os.unlink(PASSWORD_PATH)
fh.close()

for line in lines:
   (user, oldpw, newpw) = map(b64decode, line.split())
   #print "%s: <%s>-<%s>" % (user, oldpw, newpw)
   user_dn = USER_DN_BASE % user
   try:
       res = conn.passwd_s(user_dn, oldpw, newpw)
   except Exception as ex:
       sys.stderr.write("ERROR: %s (user: %s)\n" % (ex, user_dn))
