DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
-- UPDATE mysql.user SET Password='' WHERE User='root';
-- UPDATE mysql.user SET Password=PASSWORD('mysql') WHERE User='root';

-- CREATE USER 'root'@'controller' IDENTIFIED BY 'mysql';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED by 'mysql' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'neutron' IDENTIFIED by 'mysql' WITH GRANT OPTION;

FLUSH PRIVILEGES;

DROP DATABASE IF EXISTS neutron;

CREATE DATABASE neutron;
GRANT ALL PRIVILEGES ON neutron.* to neutron@localhost IDENTIFIED by 'neutron';
GRANT ALL PRIVILEGES ON neutron.* to neutron@'%' IDENTIFIED by 'neutron';
