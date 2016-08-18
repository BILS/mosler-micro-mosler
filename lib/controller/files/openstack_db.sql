DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
-- UPDATE mysql.user SET Password='' WHERE User='root';
-- UPDATE mysql.user SET Password=PASSWORD('mysql') WHERE User='root';

-- CREATE USER 'root'@'openstack-controller' IDENTIFIED BY 'mysql';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED by 'mysql' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'openstack-controller' IDENTIFIED by 'mysql' WITH GRANT OPTION;

FLUSH PRIVILEGES;

--  DROP DATABASE IF EXISTS nova;
--  DROP DATABASE IF EXISTS neutron;
--  DROP DATABASE IF EXISTS keystone;
--  DROP DATABASE IF EXISTS glance;
--  DROP DATABASE IF EXISTS heat;

CREATE DATABASE nova;
CREATE DATABASE keystone;
CREATE DATABASE glance;
CREATE DATABASE neutron;
CREATE DATABASE heat;

GRANT ALL PRIVILEGES ON nova.* to nova@localhost IDENTIFIED by 'nova';
GRANT ALL PRIVILEGES ON nova.* to nova@'%' IDENTIFIED by 'nova';

GRANT ALL PRIVILEGES ON neutron.* to neutron@localhost IDENTIFIED by 'neutron';
GRANT ALL PRIVILEGES ON neutron.* to neutron@'%' IDENTIFIED by 'neutron';

GRANT ALL PRIVILEGES ON keystone.* to keystone@localhost IDENTIFIED by 'keystone';
GRANT ALL PRIVILEGES ON keystone.* to keystone@'%' IDENTIFIED by 'keystone';

GRANT ALL PRIVILEGES ON glance.* to glance@localhost IDENTIFIED by 'glance';
GRANT ALL PRIVILEGES ON glance.* to glance@'%' IDENTIFIED by 'glance';
      
GRANT ALL PRIVILEGES ON heat.* to heat@localhost IDENTIFIED by 'heat';
GRANT ALL PRIVILEGES ON heat.* to heat@'%' IDENTIFIED by 'heat';

