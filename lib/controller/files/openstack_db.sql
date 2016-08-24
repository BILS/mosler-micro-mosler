DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
-- UPDATE mysql.user SET Password='' WHERE User='root';
-- UPDATE mysql.user SET Password=PASSWORD('mysql') WHERE User='root';

-- SET PASSWORD FOR 'root'@'localhost' = PASSWORD('mysql');
-- ALTER USER 'root' IDENTIFIED BY 'mysql';

-- CREATE USER 'root'@'controller' IDENTIFIED BY 'mysql';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED by 'mysql' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'controller' IDENTIFIED by 'mysql' WITH GRANT OPTION;

FLUSH PRIVILEGES;

DROP DATABASE IF EXISTS nova;
DROP DATABASE IF EXISTS nova_api;
DROP DATABASE IF EXISTS keystone;
DROP DATABASE IF EXISTS glance;

CREATE DATABASE keystone;
GRANT ALL PRIVILEGES ON keystone.* to keystone@localhost IDENTIFIED by 'keystone';
GRANT ALL PRIVILEGES ON keystone.* to keystone@'%' IDENTIFIED by 'keystone';

CREATE DATABASE glance;
GRANT ALL PRIVILEGES ON glance.* to glance@localhost IDENTIFIED by 'glance';
GRANT ALL PRIVILEGES ON glance.* to glance@'%' IDENTIFIED by 'glance';

CREATE DATABASE nova;
GRANT ALL PRIVILEGES ON nova.* to nova@localhost IDENTIFIED by 'nova';
GRANT ALL PRIVILEGES ON nova.* to nova@'%' IDENTIFIED by 'nova';

CREATE DATABASE nova_api;
GRANT ALL PRIVILEGES ON nova_api.* to nova@localhost IDENTIFIED by 'nova';
GRANT ALL PRIVILEGES ON nova_api.* to nova@'%' IDENTIFIED by 'nova';
