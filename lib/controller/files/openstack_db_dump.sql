-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: 
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `glance`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `glance` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `glance`;

--
-- Table structure for table `image_locations`
--

DROP TABLE IF EXISTS `image_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` varchar(36) NOT NULL,
  `value` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `meta_data` text,
  `status` varchar(30) NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`),
  KEY `ix_image_locations_image_id` (`image_id`),
  KEY `ix_image_locations_deleted` (`deleted`),
  CONSTRAINT `image_locations_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_locations`
--

LOCK TABLES `image_locations` WRITE;
/*!40000 ALTER TABLE `image_locations` DISABLE KEYS */;
INSERT INTO `image_locations` VALUES (1,'00000000-0000-0000-0000-000000000001','file:///var/lib/glance/images/00000000-0000-0000-0000-000000000001','2016-06-20 15:15:37','2016-06-20 15:15:37',NULL,0,'{}','active'),(2,'00000000-0000-0000-0000-000000000002','file:///var/lib/glance/images/00000000-0000-0000-0000-000000000002','2016-06-20 15:16:48','2016-06-20 15:16:48',NULL,0,'{}','active'),(3,'00000000-0000-0000-0000-000000000003','file:///var/lib/glance/images/00000000-0000-0000-0000-000000000003','2016-06-20 15:17:48','2016-06-20 15:17:48',NULL,0,'{}','active');
/*!40000 ALTER TABLE `image_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_members`
--

DROP TABLE IF EXISTS `image_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` varchar(36) NOT NULL,
  `member` varchar(255) NOT NULL,
  `can_share` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `image_members_image_id_member_deleted_at_key` (`image_id`,`member`,`deleted_at`),
  KEY `ix_image_members_image_id` (`image_id`),
  KEY `ix_image_members_deleted` (`deleted`),
  KEY `ix_image_members_image_id_member` (`image_id`,`member`),
  CONSTRAINT `image_members_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_members`
--

LOCK TABLES `image_members` WRITE;
/*!40000 ALTER TABLE `image_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_properties`
--

DROP TABLE IF EXISTS `image_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `image_id` (`image_id`,`name`),
  UNIQUE KEY `ix_image_properties_image_id_name` (`image_id`,`name`),
  KEY `ix_image_properties_image_id` (`image_id`),
  KEY `ix_image_properties_deleted` (`deleted`),
  CONSTRAINT `image_properties_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_properties`
--

LOCK TABLES `image_properties` WRITE;
/*!40000 ALTER TABLE `image_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_tags`
--

DROP TABLE IF EXISTS `image_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` varchar(36) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_image_tags_image_id` (`image_id`),
  KEY `ix_image_tags_image_id_tag_value` (`image_id`,`value`),
  CONSTRAINT `image_tags_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_tags`
--

LOCK TABLES `image_tags` WRITE;
/*!40000 ALTER TABLE `image_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `status` varchar(30) NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `disk_format` varchar(20) DEFAULT NULL,
  `container_format` varchar(20) DEFAULT NULL,
  `checksum` varchar(32) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `min_disk` int(11) NOT NULL,
  `min_ram` int(11) NOT NULL,
  `protected` tinyint(1) DEFAULT NULL,
  `virtual_size` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_images_is_public` (`is_public`),
  KEY `ix_images_deleted` (`deleted`),
  KEY `checksum_image_idx` (`checksum`),
  KEY `owner_image_idx` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES ('00000000-0000-0000-0000-000000000001','project-computenode-stable',2057895936,'active',1,'2016-06-20 15:14:42','2016-06-20 15:15:37',NULL,0,'qcow2','bare','a8b1f39fd0f37e1c6eed1893533e005d','bf1426df28854987b417debc6591eec3',0,0,0,NULL),('00000000-0000-0000-0000-000000000002','project-loginnode-stable',2567307264,'active',1,'2016-06-20 15:15:40','2016-06-20 15:16:48',NULL,0,'qcow2','bare','2c0f12a491da95d89c363e840523b18a','bf1426df28854987b417debc6591eec3',0,0,0,NULL),('00000000-0000-0000-0000-000000000003','topolino-q-stable',2203582464,'active',1,'2016-06-20 15:16:51','2016-06-20 15:17:48',NULL,0,'qcow2','bare','05bd23b4ed03964b3ffb7c542733f7a0','bf1426df28854987b417debc6591eec3',0,0,0,NULL);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrate_version`
--

DROP TABLE IF EXISTS `migrate_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrate_version` (
  `repository_id` varchar(250) NOT NULL,
  `repository_path` text,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrate_version`
--

LOCK TABLES `migrate_version` WRITE;
/*!40000 ALTER TABLE `migrate_version` DISABLE KEYS */;
INSERT INTO `migrate_version` VALUES ('Glance Migrations','/usr/lib/python2.6/site-packages/glance/db/sqlalchemy/migrate_repo',34);
/*!40000 ALTER TABLE `migrate_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_info`
--

DROP TABLE IF EXISTS `task_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_info` (
  `task_id` varchar(36) NOT NULL,
  `input` text,
  `result` text,
  `message` text,
  PRIMARY KEY (`task_id`),
  CONSTRAINT `task_info_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_info`
--

LOCK TABLES `task_info` WRITE;
/*!40000 ALTER TABLE `task_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `id` varchar(36) NOT NULL,
  `type` varchar(30) NOT NULL,
  `status` varchar(30) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_tasks_type` (`type`),
  KEY `ix_tasks_status` (`status`),
  KEY `ix_tasks_deleted` (`deleted`),
  KEY `ix_tasks_owner` (`owner`),
  KEY `ix_tasks_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'glance'
--

--
-- Current Database: `heat`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `heat` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `heat`;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `stack_id` varchar(36) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `resource_status` varchar(255) DEFAULT NULL,
  `resource_name` varchar(255) DEFAULT NULL,
  `physical_resource_id` varchar(255) DEFAULT NULL,
  `resource_status_reason` varchar(255) DEFAULT NULL,
  `resource_type` varchar(255) DEFAULT NULL,
  `resource_properties` blob,
  `resource_action` varchar(255) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_uuid_key` (`uuid`),
  KEY `stack_id` (`stack_id`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`stack_id`) REFERENCES `stack` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrate_version`
--

DROP TABLE IF EXISTS `migrate_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrate_version` (
  `repository_id` varchar(250) NOT NULL,
  `repository_path` text,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrate_version`
--

LOCK TABLES `migrate_version` WRITE;
/*!40000 ALTER TABLE `migrate_version` DISABLE KEYS */;
INSERT INTO `migrate_version` VALUES ('heat','/usr/lib/python2.6/site-packages/heat/db/sqlalchemy/migrate_repo',43);
/*!40000 ALTER TABLE `migrate_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raw_template`
--

DROP TABLE IF EXISTS `raw_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raw_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `template` longtext,
  `files` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raw_template`
--

LOCK TABLES `raw_template` WRITE;
/*!40000 ALTER TABLE `raw_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `raw_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource` (
  `id` varchar(36) NOT NULL,
  `nova_instance` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `status_reason` varchar(255) DEFAULT NULL,
  `stack_id` varchar(36) NOT NULL,
  `rsrc_metadata` longtext,
  `action` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stack_id` (`stack_id`),
  CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`stack_id`) REFERENCES `stack` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource`
--

LOCK TABLES `resource` WRITE;
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource_data`
--

DROP TABLE IF EXISTS `resource_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` text,
  `redact` tinyint(1) DEFAULT NULL,
  `resource_id` varchar(36) NOT NULL,
  `decrypt_method` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `resource_data_ibfk_1` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource_data`
--

LOCK TABLES `resource_data` WRITE;
/*!40000 ALTER TABLE `resource_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `resource_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_config`
--

DROP TABLE IF EXISTS `software_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `software_config` (
  `id` varchar(36) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `group` varchar(255) DEFAULT NULL,
  `config` longtext,
  `tenant` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_software_config_tenant` (`tenant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_config`
--

LOCK TABLES `software_config` WRITE;
/*!40000 ALTER TABLE `software_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `software_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_deployment`
--

DROP TABLE IF EXISTS `software_deployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `software_deployment` (
  `id` varchar(36) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `server_id` varchar(36) NOT NULL,
  `config_id` varchar(36) NOT NULL,
  `input_values` longtext,
  `output_values` longtext,
  `action` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `status_reason` varchar(255) DEFAULT NULL,
  `tenant` varchar(64) NOT NULL,
  `stack_user_project_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `config_id` (`config_id`),
  KEY `ix_software_deployment_created_at` (`created_at`),
  KEY `ix_software_deployment_server_id` (`server_id`),
  KEY `ix_software_deployment_tenant` (`tenant`),
  CONSTRAINT `software_deployment_ibfk_1` FOREIGN KEY (`config_id`) REFERENCES `software_config` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_deployment`
--

LOCK TABLES `software_deployment` WRITE;
/*!40000 ALTER TABLE `software_deployment` DISABLE KEYS */;
/*!40000 ALTER TABLE `software_deployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stack`
--

DROP TABLE IF EXISTS `stack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stack` (
  `id` varchar(36) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `raw_template_id` int(11) NOT NULL,
  `user_creds_id` int(11) DEFAULT NULL,
  `username` varchar(256) DEFAULT NULL,
  `owner_id` varchar(36) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `status_reason` varchar(255) DEFAULT NULL,
  `parameters` longtext,
  `timeout` int(11) DEFAULT NULL,
  `tenant` varchar(256) DEFAULT NULL,
  `disable_rollback` tinyint(1) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `stack_user_project_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `raw_template_id` (`raw_template_id`),
  KEY `user_creds_id` (`user_creds_id`),
  CONSTRAINT `stack_ibfk_1` FOREIGN KEY (`raw_template_id`) REFERENCES `raw_template` (`id`),
  CONSTRAINT `stack_ibfk_2` FOREIGN KEY (`user_creds_id`) REFERENCES `user_creds` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stack`
--

LOCK TABLES `stack` WRITE;
/*!40000 ALTER TABLE `stack` DISABLE KEYS */;
/*!40000 ALTER TABLE `stack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stack_lock`
--

DROP TABLE IF EXISTS `stack_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stack_lock` (
  `stack_id` varchar(36) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `engine_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`stack_id`),
  CONSTRAINT `stack_lock_ibfk_1` FOREIGN KEY (`stack_id`) REFERENCES `stack` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stack_lock`
--

LOCK TABLES `stack_lock` WRITE;
/*!40000 ALTER TABLE `stack_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `stack_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_creds`
--

DROP TABLE IF EXISTS `user_creds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_creds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `tenant` varchar(1024) DEFAULT NULL,
  `auth_url` text,
  `tenant_id` varchar(256) DEFAULT NULL,
  `trustor_user_id` varchar(64) DEFAULT NULL,
  `trust_id` varchar(255) DEFAULT NULL,
  `decrypt_method` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_creds`
--

LOCK TABLES `user_creds` WRITE;
/*!40000 ALTER TABLE `user_creds` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_creds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watch_data`
--

DROP TABLE IF EXISTS `watch_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watch_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `data` longtext,
  `watch_rule_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `watch_rule_id` (`watch_rule_id`),
  CONSTRAINT `watch_data_ibfk_1` FOREIGN KEY (`watch_rule_id`) REFERENCES `watch_rule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watch_data`
--

LOCK TABLES `watch_data` WRITE;
/*!40000 ALTER TABLE `watch_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `watch_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watch_rule`
--

DROP TABLE IF EXISTS `watch_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watch_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `rule` longtext,
  `last_evaluated` datetime DEFAULT NULL,
  `stack_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stack_id` (`stack_id`),
  CONSTRAINT `watch_rule_ibfk_1` FOREIGN KEY (`stack_id`) REFERENCES `stack` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watch_rule`
--

LOCK TABLES `watch_rule` WRITE;
/*!40000 ALTER TABLE `watch_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `watch_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'heat'
--

--
-- Current Database: `keystone`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `keystone` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `keystone`;

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment` (
  `type` enum('UserProject','GroupProject','UserDomain','GroupDomain') NOT NULL,
  `actor_id` varchar(64) NOT NULL,
  `target_id` varchar(64) NOT NULL,
  `role_id` varchar(64) NOT NULL,
  `inherited` tinyint(1) NOT NULL,
  PRIMARY KEY (`type`,`actor_id`,`target_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
INSERT INTO `assignment` VALUES ('UserProject','admin','bf1426df28854987b417debc6591eec3','99000ea770fd43d2848c352740703bd9',0),('UserProject','admin','bf1426df28854987b417debc6591eec3','9fe2ff9ee4384b1894a90878d3e92bab',0),('UserProject','glance','d1f763063ff147fb905a2a85133a6a44','99000ea770fd43d2848c352740703bd9',0),('UserProject','heat','d1f763063ff147fb905a2a85133a6a44','99000ea770fd43d2848c352740703bd9',0),('UserProject','keystone','d1f763063ff147fb905a2a85133a6a44','99000ea770fd43d2848c352740703bd9',0),('UserProject','neutron','d1f763063ff147fb905a2a85133a6a44','99000ea770fd43d2848c352740703bd9',0),('UserProject','nova','d1f763063ff147fb905a2a85133a6a44','99000ea770fd43d2848c352740703bd9',0);
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credential`
--

DROP TABLE IF EXISTS `credential`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credential` (
  `id` varchar(64) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `project_id` varchar(64) DEFAULT NULL,
  `blob` text NOT NULL,
  `type` varchar(255) NOT NULL,
  `extra` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credential`
--

LOCK TABLES `credential` WRITE;
/*!40000 ALTER TABLE `credential` DISABLE KEYS */;
/*!40000 ALTER TABLE `credential` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domain`
--

DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain` (
  `id` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `extra` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain`
--

LOCK TABLES `domain` WRITE;
/*!40000 ALTER TABLE `domain` DISABLE KEYS */;
INSERT INTO `domain` VALUES ('default','Default',1,'{\"description\": \"Owns users and tenants (i.e. projects) available on Identity API v2.\"}');
/*!40000 ALTER TABLE `domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endpoint`
--

DROP TABLE IF EXISTS `endpoint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endpoint` (
  `id` varchar(64) NOT NULL,
  `legacy_endpoint_id` varchar(64) DEFAULT NULL,
  `interface` varchar(8) NOT NULL,
  `region` varchar(255) DEFAULT NULL,
  `service_id` varchar(64) NOT NULL,
  `url` text NOT NULL,
  `extra` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `endpoint_service_id_fkey` (`service_id`),
  CONSTRAINT `endpoint_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endpoint`
--

LOCK TABLES `endpoint` WRITE;
/*!40000 ALTER TABLE `endpoint` DISABLE KEYS */;
INSERT INTO `endpoint` VALUES ('0a7e103a58044cab93b60e39ad4868f7','b58c465d629747db81093243a58e5075','public','regionOne','07ce45e5577a43ddbbadc2cc4f84a2ef','http://openstack-controller:9696','{}',1),('348bcc07dc184d44bfff35e40c79fcb7','18c54fde7f4846108f636d35f1a986cf','internal','regionOne','524daa4891eb436491c17e63aef7e3fd','http://openstack-controller:8000/v1','{}',1),('398acd69e71b486c9b0b7016f116381d','2f0caa0a7e3b429080d67373b900f004','internal','regionOne','7ae7c781334b468896daad9e65aa2095','http://openstack-controller:8774/v2/%(tenant_id)s','{}',1),('3a51ffebe3614a25b3c4431af890509b','18c54fde7f4846108f636d35f1a986cf','admin','regionOne','524daa4891eb436491c17e63aef7e3fd','http://openstack-controller:8000/v1','{}',1),('7023a36e37494618aeec6b9cee9ac8d3','81cbd5b7d5bd44cb9e142ef37e1febf4','public','regionOne','dd79383f48b7467ebe199b9e53157a6e','http://openstack-controller:5000/v2.0','{}',1),('7ce8811f80b94646b26327b79b6c8d61','eb52629e9a08476ea97be10ab59c7dbb','public','regionOne','fa7defdabf2e46f79ed18610346142ee','http://openstack-controller:9292','{}',1),('87d3e2b2e48e4883aa045d79d8621dc7','b58c465d629747db81093243a58e5075','internal','regionOne','07ce45e5577a43ddbbadc2cc4f84a2ef','http://openstack-controller:9696','{}',1),('92e6b156946242938eaf9b499390e531','cdd19bdd6fb947f98292455bc8a83ff0','public','regionOne','215b44f6884c4469af940c09aee84dfd','http://openstack-controller:8004/v1/%(tenant_id)s','{}',1),('a4962266b60742d3af2bbe05da938874','18c54fde7f4846108f636d35f1a986cf','public','regionOne','524daa4891eb436491c17e63aef7e3fd','http://openstack-controller:8000/v1','{}',1),('a9eb8d30cd8f4bba90f352b7f803e494','2f0caa0a7e3b429080d67373b900f004','public','regionOne','7ae7c781334b468896daad9e65aa2095','http://openstack-controller:8774/v2/%(tenant_id)s','{}',1),('ab4583a8b0634d2dbba7e05bb7708ca5','b58c465d629747db81093243a58e5075','admin','regionOne','07ce45e5577a43ddbbadc2cc4f84a2ef','http://openstack-controller:9696','{}',1),('b4550ee74a484f0baaa3279c7701f29a','eb52629e9a08476ea97be10ab59c7dbb','internal','regionOne','fa7defdabf2e46f79ed18610346142ee','http://openstack-controller:9292','{}',1),('c6cbae71743148a3abbffc86b62a45f4','81cbd5b7d5bd44cb9e142ef37e1febf4','admin','regionOne','dd79383f48b7467ebe199b9e53157a6e','http://openstack-controller:35357/v2.0','{}',1),('d06260d7978745d8a210d65a54540ef1','cdd19bdd6fb947f98292455bc8a83ff0','internal','regionOne','215b44f6884c4469af940c09aee84dfd','http://openstack-controller:8004/v1/%(tenant_id)s','{}',1),('deaf08db1caa43aca53f9a881a89fbd2','cdd19bdd6fb947f98292455bc8a83ff0','admin','regionOne','215b44f6884c4469af940c09aee84dfd','http://openstack-controller:8004/v1/%(tenant_id)s','{}',1),('e8611dcfb5434eee9a4b7ff169292bc4','81cbd5b7d5bd44cb9e142ef37e1febf4','internal','regionOne','dd79383f48b7467ebe199b9e53157a6e','http://openstack-controller:5000/v2.0','{}',1),('fc16f2c5891a47e4ba578413acf22c4a','2f0caa0a7e3b429080d67373b900f004','admin','regionOne','7ae7c781334b468896daad9e65aa2095','http://openstack-controller:8774/v2/%(tenant_id)s','{}',1),('fc19216a2db04d9798905d7ca9dfe2a8','eb52629e9a08476ea97be10ab59c7dbb','admin','regionOne','fa7defdabf2e46f79ed18610346142ee','http://openstack-controller:9292','{}',1);
/*!40000 ALTER TABLE `endpoint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `id` varchar(64) NOT NULL,
  `domain_id` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` text,
  `extra` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_id` (`domain_id`,`name`),
  CONSTRAINT `group_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrate_version`
--

DROP TABLE IF EXISTS `migrate_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrate_version` (
  `repository_id` varchar(250) NOT NULL,
  `repository_path` text,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrate_version`
--

LOCK TABLES `migrate_version` WRITE;
/*!40000 ALTER TABLE `migrate_version` DISABLE KEYS */;
INSERT INTO `migrate_version` VALUES ('keystone','/usr/lib/python2.6/site-packages/keystone/common/sql/migrate_repo',44);
/*!40000 ALTER TABLE `migrate_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `policy`
--

DROP TABLE IF EXISTS `policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy` (
  `id` varchar(64) NOT NULL,
  `type` varchar(255) NOT NULL,
  `blob` text NOT NULL,
  `extra` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy`
--

LOCK TABLES `policy` WRITE;
/*!40000 ALTER TABLE `policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `id` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `extra` text,
  `description` text,
  `enabled` tinyint(1) DEFAULT NULL,
  `domain_id` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_id` (`domain_id`,`name`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('bf1426df28854987b417debc6591eec3','admin','{}','Admin Tenant',1,'default'),('d1f763063ff147fb905a2a85133a6a44','services','{}','Service Tenant',1,'default');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `id` varchar(64) NOT NULL,
  `description` varchar(255) NOT NULL,
  `parent_region_id` varchar(64) DEFAULT NULL,
  `extra` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `extra` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('5743da57fb344acc9e23aedb47020f28','service','{}'),('99000ea770fd43d2848c352740703bd9','admin','{}'),('9fe2ff9ee4384b1894a90878d3e92bab','_member_','{\"enabled\": \"True\", \"description\": \"Default role for project membership\"}');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `id` varchar(64) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `extra` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES ('07ce45e5577a43ddbbadc2cc4f84a2ef','network','{\"name\": \"neutron\", \"description\": \"OpenStack Networking\"}',1),('215b44f6884c4469af940c09aee84dfd','orchestration','{\"name\": \"heat\", \"description\": \"Orchestration\"}',1),('524daa4891eb436491c17e63aef7e3fd','cloudformation','{\"name\": \"heat-cfn\", \"description\": \"Orchestration CloudFormation\"}',1),('7ae7c781334b468896daad9e65aa2095','compute','{\"name\": \"nova\", \"description\": \"OpenStack Compute\"}',1),('dd79383f48b7467ebe199b9e53157a6e','identity','{\"name\": \"keystone\", \"description\": \"OpenStack Identity\"}',1),('fa7defdabf2e46f79ed18610346142ee','image','{\"name\": \"glance\", \"description\": \"OpenStack Image Service\"}',1);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` varchar(64) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `extra` text,
  `valid` tinyint(1) NOT NULL,
  `trust_id` varchar(64) DEFAULT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_token_expires` (`expires`),
  KEY `ix_token_expires_valid` (`expires`,`valid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES ('0e0d542f0e8e49ac9533e959c47c1b79','2016-06-20 16:17:57','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:17:57.709986\", \"expires\": \"2016-06-20T16:17:57Z\", \"id\": \"0e0d542f0e8e49ac9533e959c47c1b79\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"0e0d542f0e8e49ac9533e959c47c1b79\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin'),('2c54e462994a4b4e9a4c2a2246b38689','2016-06-20 16:17:54','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:17:54.674020\", \"expires\": \"2016-06-20T16:17:54Z\", \"id\": \"2c54e462994a4b4e9a4c2a2246b38689\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"2c54e462994a4b4e9a4c2a2246b38689\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin'),('4b5b32ed7c9943138f771cb1df3f4c75','2016-06-20 16:14:41','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:14:41.793601\", \"expires\": \"2016-06-20T16:14:41Z\", \"id\": \"4b5b32ed7c9943138f771cb1df3f4c75\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"4b5b32ed7c9943138f771cb1df3f4c75\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin'),('7f528892fd764d869147b048c899cbe8','2016-06-20 16:17:56','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:17:56.168535\", \"expires\": \"2016-06-20T16:17:56Z\", \"id\": \"7f528892fd764d869147b048c899cbe8\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"7f528892fd764d869147b048c899cbe8\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin'),('87302fc49d2649aebe3e06dfeb28bebd','2016-06-20 16:14:42','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:14:42.485567\", \"expires\": \"2016-06-20T16:14:42Z\", \"id\": \"87302fc49d2649aebe3e06dfeb28bebd\", \"tenant\": {\"id\": \"d1f763063ff147fb905a2a85133a6a44\", \"enabled\": true, \"description\": \"Service Tenant\", \"name\": \"services\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\", \"publicURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\", \"publicURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"glance\", \"roles_links\": [], \"id\": \"glance\", \"roles\": [{\"name\": \"admin\"}], \"name\": \"glance\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"glance\", \"tenantId\": \"services\", \"email\": \"glance@localhost\", \"name\": \"glance\", \"id\": \"glance\"}, \"key\": \"87302fc49d2649aebe3e06dfeb28bebd\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"d1f763063ff147fb905a2a85133a6a44\", \"enabled\": true, \"description\": \"Service Tenant\", \"name\": \"services\"}, \"metadata\": {\"roles\": [\"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'glance'),('8858d8cffdb2440b84cfc72f5a9e8e2e','2016-06-20 16:17:58','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:17:58.767780\", \"expires\": \"2016-06-20T16:17:58Z\", \"id\": \"8858d8cffdb2440b84cfc72f5a9e8e2e\", \"tenant\": {\"id\": \"d1f763063ff147fb905a2a85133a6a44\", \"enabled\": true, \"description\": \"Service Tenant\", \"name\": \"services\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\", \"publicURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\", \"publicURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"nova\", \"roles_links\": [], \"id\": \"nova\", \"roles\": [{\"name\": \"admin\"}], \"name\": \"nova\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"nova\", \"tenantId\": \"services\", \"email\": \"nova@localhost\", \"name\": \"nova\", \"id\": \"nova\"}, \"key\": \"8858d8cffdb2440b84cfc72f5a9e8e2e\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"d1f763063ff147fb905a2a85133a6a44\", \"enabled\": true, \"description\": \"Service Tenant\", \"name\": \"services\"}, \"metadata\": {\"roles\": [\"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'nova'),('8895ab571f4f49bb931af46267367924','2016-06-20 16:17:51','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:17:51.423354\", \"expires\": \"2016-06-20T16:17:51Z\", \"id\": \"8895ab571f4f49bb931af46267367924\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"8895ab571f4f49bb931af46267367924\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin'),('a0ad981b8f764c448cc858801abf6afd','2016-06-20 16:15:01','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:15:01.992472\", \"expires\": \"2016-06-20T16:15:01Z\", \"id\": \"a0ad981b8f764c448cc858801abf6afd\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"a0ad981b8f764c448cc858801abf6afd\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin'),('a910cc97b08d48448c2d38537df6e514','2016-06-20 16:16:51','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:16:51.179353\", \"expires\": \"2016-06-20T16:16:51Z\", \"id\": \"a910cc97b08d48448c2d38537df6e514\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"a910cc97b08d48448c2d38537df6e514\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin'),('bbb70264c0224032ab2cb45927cde1c9','2016-06-20 16:15:03','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:15:03.769586\", \"expires\": \"2016-06-20T16:15:03Z\", \"id\": \"bbb70264c0224032ab2cb45927cde1c9\", \"tenant\": {\"id\": \"d1f763063ff147fb905a2a85133a6a44\", \"enabled\": true, \"description\": \"Service Tenant\", \"name\": \"services\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\", \"publicURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\", \"publicURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"neutron\", \"roles_links\": [], \"id\": \"neutron\", \"roles\": [{\"name\": \"admin\"}], \"name\": \"neutron\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"neutron\", \"tenantId\": \"services\", \"email\": \"neutron@localhost\", \"name\": \"neutron\", \"id\": \"neutron\"}, \"key\": \"bbb70264c0224032ab2cb45927cde1c9\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"d1f763063ff147fb905a2a85133a6a44\", \"enabled\": true, \"description\": \"Service Tenant\", \"name\": \"services\"}, \"metadata\": {\"roles\": [\"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'neutron'),('bcbb5adeb1364cecbf3fd2f9af72b519','2016-06-20 16:15:40','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:15:40.434539\", \"expires\": \"2016-06-20T16:15:40Z\", \"id\": \"bcbb5adeb1364cecbf3fd2f9af72b519\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"bcbb5adeb1364cecbf3fd2f9af72b519\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin'),('c77db92ead8947448fbb4950189e3d08','2016-06-20 16:17:58','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:17:58.485256\", \"expires\": \"2016-06-20T16:17:58Z\", \"id\": \"c77db92ead8947448fbb4950189e3d08\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"c77db92ead8947448fbb4950189e3d08\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin'),('d59957d957324440a6666ded76f3c408','2016-06-20 16:17:51','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:17:51.576763\", \"expires\": \"2016-06-20T16:17:51Z\", \"id\": \"d59957d957324440a6666ded76f3c408\", \"tenant\": {\"id\": \"d1f763063ff147fb905a2a85133a6a44\", \"enabled\": true, \"description\": \"Service Tenant\", \"name\": \"services\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\", \"publicURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\", \"publicURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"nova\", \"roles_links\": [], \"id\": \"nova\", \"roles\": [{\"name\": \"admin\"}], \"name\": \"nova\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"nova\", \"tenantId\": \"services\", \"email\": \"nova@localhost\", \"name\": \"nova\", \"id\": \"nova\"}, \"key\": \"d59957d957324440a6666ded76f3c408\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"d1f763063ff147fb905a2a85133a6a44\", \"enabled\": true, \"description\": \"Service Tenant\", \"name\": \"services\"}, \"metadata\": {\"roles\": [\"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'nova'),('da28b794bc2b456abd469e2a83367b44','2016-06-20 16:14:42','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:14:42.127036\", \"expires\": \"2016-06-20T16:14:42Z\", \"id\": \"da28b794bc2b456abd469e2a83367b44\", \"tenant\": {\"id\": \"d1f763063ff147fb905a2a85133a6a44\", \"enabled\": true, \"description\": \"Service Tenant\", \"name\": \"services\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\", \"publicURL\": \"http://openstack-controller:8774/v2/d1f763063ff147fb905a2a85133a6a44\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\", \"publicURL\": \"http://openstack-controller:8004/v1/d1f763063ff147fb905a2a85133a6a44\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"glance\", \"roles_links\": [], \"id\": \"glance\", \"roles\": [{\"name\": \"admin\"}], \"name\": \"glance\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"glance\", \"tenantId\": \"services\", \"email\": \"glance@localhost\", \"name\": \"glance\", \"id\": \"glance\"}, \"key\": \"da28b794bc2b456abd469e2a83367b44\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"d1f763063ff147fb905a2a85133a6a44\", \"enabled\": true, \"description\": \"Service Tenant\", \"name\": \"services\"}, \"metadata\": {\"roles\": [\"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'glance'),('e86eb9ae9b3b417d99a84ebee9ec5cb7','2016-06-20 16:17:56','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:17:56.943498\", \"expires\": \"2016-06-20T16:17:56Z\", \"id\": \"e86eb9ae9b3b417d99a84ebee9ec5cb7\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"e86eb9ae9b3b417d99a84ebee9ec5cb7\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin'),('ea4913a1c0eb449ca083c09b892b74c4','2016-06-20 16:17:55','{\"bind\": null, \"token_data\": {\"access\": {\"token\": {\"issued_at\": \"2016-06-20T15:17:55.437179\", \"expires\": \"2016-06-20T16:17:55Z\", \"id\": \"ea4913a1c0eb449ca083c09b892b74c4\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}}, \"serviceCatalog\": [{\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"398acd69e71b486c9b0b7016f116381d\", \"internalURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8774/v2/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"compute\", \"name\": \"nova\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9696\", \"region\": \"regionOne\", \"id\": \"0a7e103a58044cab93b60e39ad4868f7\", \"internalURL\": \"http://openstack-controller:9696\", \"publicURL\": \"http://openstack-controller:9696\"}], \"endpoints_links\": [], \"type\": \"network\", \"name\": \"neutron\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:9292\", \"region\": \"regionOne\", \"id\": \"7ce8811f80b94646b26327b79b6c8d61\", \"internalURL\": \"http://openstack-controller:9292\", \"publicURL\": \"http://openstack-controller:9292\"}], \"endpoints_links\": [], \"type\": \"image\", \"name\": \"glance\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8000/v1\", \"region\": \"regionOne\", \"id\": \"348bcc07dc184d44bfff35e40c79fcb7\", \"internalURL\": \"http://openstack-controller:8000/v1\", \"publicURL\": \"http://openstack-controller:8000/v1\"}], \"endpoints_links\": [], \"type\": \"cloudformation\", \"name\": \"heat-cfn\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"region\": \"regionOne\", \"id\": \"92e6b156946242938eaf9b499390e531\", \"internalURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\", \"publicURL\": \"http://openstack-controller:8004/v1/bf1426df28854987b417debc6591eec3\"}], \"endpoints_links\": [], \"type\": \"orchestration\", \"name\": \"heat\"}, {\"endpoints\": [{\"adminURL\": \"http://openstack-controller:35357/v2.0\", \"region\": \"regionOne\", \"id\": \"7023a36e37494618aeec6b9cee9ac8d3\", \"internalURL\": \"http://openstack-controller:5000/v2.0\", \"publicURL\": \"http://openstack-controller:5000/v2.0\"}], \"endpoints_links\": [], \"type\": \"identity\", \"name\": \"keystone\"}], \"user\": {\"username\": \"admin\", \"roles_links\": [], \"id\": \"admin\", \"roles\": [{\"name\": \"_member_\"}, {\"name\": \"admin\"}], \"name\": \"admin\"}, \"metadata\": {\"is_admin\": 0, \"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}}, \"user\": {\"username\": \"admin\", \"tenantId\": \"admin\", \"email\": \"admin@mosler.uppmax.uu.se\", \"name\": \"admin\", \"id\": \"admin\"}, \"key\": \"ea4913a1c0eb449ca083c09b892b74c4\", \"token_version\": \"v2.0\", \"tenant\": {\"id\": \"bf1426df28854987b417debc6591eec3\", \"enabled\": true, \"description\": \"Admin Tenant\", \"name\": \"admin\"}, \"metadata\": {\"roles\": [\"9fe2ff9ee4384b1894a90878d3e92bab\", \"99000ea770fd43d2848c352740703bd9\"]}}',1,NULL,'admin');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trust`
--

DROP TABLE IF EXISTS `trust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trust` (
  `id` varchar(64) NOT NULL,
  `trustor_user_id` varchar(64) NOT NULL,
  `trustee_user_id` varchar(64) NOT NULL,
  `project_id` varchar(64) DEFAULT NULL,
  `impersonation` tinyint(1) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `extra` text,
  `remaining_uses` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trust`
--

LOCK TABLES `trust` WRITE;
/*!40000 ALTER TABLE `trust` DISABLE KEYS */;
/*!40000 ALTER TABLE `trust` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trust_role`
--

DROP TABLE IF EXISTS `trust_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trust_role` (
  `trust_id` varchar(64) NOT NULL,
  `role_id` varchar(64) NOT NULL,
  PRIMARY KEY (`trust_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trust_role`
--

LOCK TABLES `trust_role` WRITE;
/*!40000 ALTER TABLE `trust_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `trust_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `extra` text,
  `password` varchar(128) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `domain_id` varchar(64) NOT NULL,
  `default_project_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain_id` (`domain_id`,`name`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_membership`
--

DROP TABLE IF EXISTS `user_group_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group_membership` (
  `user_id` varchar(64) NOT NULL,
  `group_id` varchar(64) NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `user_group_membership_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_group_membership_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_membership`
--

LOCK TABLES `user_group_membership` WRITE;
/*!40000 ALTER TABLE `user_group_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'keystone'
--

--
-- Current Database: `mysql`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mysql` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `mysql`;

--
-- Table structure for table `columns_priv`
--

DROP TABLE IF EXISTS `columns_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `columns_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Table_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Column_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`,`Column_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `columns_priv`
--

LOCK TABLES `columns_priv` WRITE;
/*!40000 ALTER TABLE `columns_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `columns_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db`
--

DROP TABLE IF EXISTS `db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Host`,`Db`,`User`),
  KEY `User` (`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db`
--

LOCK TABLES `db` WRITE;
/*!40000 ALTER TABLE `db` DISABLE KEYS */;
INSERT INTO `db` VALUES ('%','nova','nova','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost','nova','nova','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost','neutron','neutron','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('%','neutron','neutron','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost','keystone','keystone','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('%','keystone','keystone','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost','glance','glance','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('%','glance','glance','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('localhost','heat','heat','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y'),('%','heat','heat','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y');
/*!40000 ALTER TABLE `db` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` char(64) NOT NULL DEFAULT '',
  `body` longblob NOT NULL,
  `definer` char(77) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `execute_at` datetime DEFAULT NULL,
  `interval_value` int(11) DEFAULT NULL,
  `interval_field` enum('YEAR','QUARTER','MONTH','DAY','HOUR','MINUTE','WEEK','SECOND','MICROSECOND','YEAR_MONTH','DAY_HOUR','DAY_MINUTE','DAY_SECOND','HOUR_MINUTE','HOUR_SECOND','MINUTE_SECOND','DAY_MICROSECOND','HOUR_MICROSECOND','MINUTE_MICROSECOND','SECOND_MICROSECOND') DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_executed` datetime DEFAULT NULL,
  `starts` datetime DEFAULT NULL,
  `ends` datetime DEFAULT NULL,
  `status` enum('ENABLED','DISABLED','SLAVESIDE_DISABLED') NOT NULL DEFAULT 'ENABLED',
  `on_completion` enum('DROP','PRESERVE') NOT NULL DEFAULT 'DROP',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH') NOT NULL DEFAULT '',
  `comment` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `originator` int(10) unsigned NOT NULL,
  `time_zone` char(64) CHARACTER SET latin1 NOT NULL DEFAULT 'SYSTEM',
  `character_set_client` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `collation_connection` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `db_collation` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `body_utf8` longblob,
  PRIMARY KEY (`db`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Events';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `func`
--

DROP TABLE IF EXISTS `func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `func` (
  `name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ret` tinyint(1) NOT NULL DEFAULT '0',
  `dl` char(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` enum('function','aggregate') CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User defined functions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `func`
--

LOCK TABLES `func` WRITE;
/*!40000 ALTER TABLE `func` DISABLE KEYS */;
/*!40000 ALTER TABLE `func` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_category`
--

DROP TABLE IF EXISTS `help_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_category` (
  `help_category_id` smallint(5) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `parent_category_id` smallint(5) unsigned DEFAULT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_category`
--

LOCK TABLES `help_category` WRITE;
/*!40000 ALTER TABLE `help_category` DISABLE KEYS */;
INSERT INTO `help_category` VALUES (1,'Geographic',0,''),(2,'Polygon properties',35,''),(3,'WKT',35,''),(4,'Numeric Functions',39,''),(5,'Plugins',36,''),(6,'MBR',35,''),(7,'Control flow functions',39,''),(8,'Transactions',36,''),(9,'Help Metadata',36,''),(10,'Account Management',36,''),(11,'Point properties',35,''),(12,'Encryption Functions',39,''),(13,'LineString properties',35,''),(14,'Miscellaneous Functions',39,''),(15,'Logical operators',39,''),(16,'Functions and Modifiers for Use with GROUP BY',36,''),(17,'Information Functions',39,''),(18,'Storage Engines',36,''),(19,'Comparison operators',39,''),(20,'Bit Functions',39,''),(21,'Table Maintenance',36,''),(22,'User-Defined Functions',36,''),(23,'Data Types',36,''),(24,'Compound Statements',36,''),(25,'Geometry constructors',35,''),(26,'GeometryCollection properties',1,''),(27,'Administration',36,''),(28,'Data Manipulation',36,''),(29,'Utility',36,''),(30,'Language Structure',36,''),(31,'Geometry relations',35,''),(32,'Date and Time Functions',39,''),(33,'WKB',35,''),(34,'Procedures',36,''),(35,'Geographic Features',36,''),(36,'Contents',0,''),(37,'Geometry properties',35,''),(38,'String Functions',39,''),(39,'Functions',36,''),(40,'Data Definition',36,'');
/*!40000 ALTER TABLE `help_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_keyword`
--

LOCK TABLES `help_keyword` WRITE;
/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
INSERT INTO `help_keyword` VALUES (0,'JOIN'),(1,'HOST'),(2,'REPEAT'),(3,'SERIALIZABLE'),(4,'REPLACE'),(5,'AT'),(6,'SCHEDULE'),(7,'RETURNS'),(8,'STARTS'),(9,'MASTER_SSL_CA'),(10,'NCHAR'),(11,'ONLY'),(12,'COLUMNS'),(13,'COMPLETION'),(14,'WORK'),(15,'DATETIME'),(16,'MODE'),(17,'OPEN'),(18,'INTEGER'),(19,'ESCAPE'),(20,'VALUE'),(21,'MASTER_SSL_VERIFY_SERVER_CERT'),(22,'SQL_BIG_RESULT'),(23,'DROP'),(24,'GEOMETRYCOLLECTIONFROMWKB'),(25,'EVENTS'),(26,'MONTH'),(27,'PROFILES'),(28,'DUPLICATE'),(29,'REPLICATION'),(30,'UNLOCK'),(31,'INNODB'),(32,'YEAR_MONTH'),(33,'SUBJECT'),(34,'PREPARE'),(35,'LOCK'),(36,'NDB'),(37,'CHECK'),(38,'FULL'),(39,'INT4'),(40,'BY'),(41,'NO'),(42,'MINUTE'),(43,'PARTITION'),(44,'DATA'),(45,'DAY'),(46,'SHARE'),(47,'REAL'),(48,'SEPARATOR'),(49,'MASTER_HEARTBEAT_PERIOD'),(50,'DELETE'),(51,'ON'),(52,'CONNECTION'),(53,'CLOSE'),(54,'X509'),(55,'USE'),(56,'WHERE'),(57,'PRIVILEGES'),(58,'SPATIAL'),(59,'EVENT'),(60,'SUPER'),(61,'SQL_BUFFER_RESULT'),(62,'IGNORE'),(63,'QUICK'),(64,'SIGNED'),(65,'OFFLINE'),(66,'SECURITY'),(67,'AUTOEXTEND_SIZE'),(68,'NDBCLUSTER'),(69,'POLYGONFROMWKB'),(70,'FALSE'),(71,'LEVEL'),(72,'FORCE'),(73,'BINARY'),(74,'TO'),(75,'CHANGE'),(76,'CURRENT_USER'),(77,'HOUR_MINUTE'),(78,'UPDATE'),(79,'PRESERVE'),(80,'INTO'),(81,'FEDERATED'),(82,'VARYING'),(83,'MAX_SIZE'),(84,'HOUR_SECOND'),(85,'VARIABLE'),(86,'ROLLBACK'),(87,'PROCEDURE'),(88,'TIMESTAMP'),(89,'IMPORT'),(90,'AGAINST'),(91,'CHECKSUM'),(92,'COUNT'),(93,'LONGBINARY'),(94,'THEN'),(95,'INSERT'),(96,'ENGINES'),(97,'HANDLER'),(98,'PORT'),(99,'DAY_SECOND'),(100,'EXISTS'),(101,'MUTEX'),(102,'HELP_DATE'),(103,'RELEASE'),(104,'BOOLEAN'),(105,'MOD'),(106,'DEFAULT'),(107,'TYPE'),(108,'NO_WRITE_TO_BINLOG'),(109,'OPTIMIZE'),(110,'RESET'),(111,'INSTALL'),(112,'ITERATE'),(113,'DO'),(114,'BIGINT'),(115,'SET'),(116,'ISSUER'),(117,'DATE'),(118,'STATUS'),(119,'FULLTEXT'),(120,'COMMENT'),(121,'MASTER_CONNECT_RETRY'),(122,'INNER'),(123,'STOP'),(124,'MASTER_LOG_FILE'),(125,'MRG_MYISAM'),(126,'PRECISION'),(127,'REQUIRE'),(128,'TRAILING'),(129,'PARTITIONS'),(130,'LONG'),(131,'OPTION'),(132,'REORGANIZE'),(133,'ELSE'),(134,'DEALLOCATE'),(135,'IO_THREAD'),(136,'CASE'),(137,'CIPHER'),(138,'CONTINUE'),(139,'FROM'),(140,'READ'),(141,'LEFT'),(142,'ELSEIF'),(143,'MINUTE_SECOND'),(144,'COMPACT'),(145,'RESTORE'),(146,'DEC'),(147,'FOR'),(148,'WARNINGS'),(149,'MIN_ROWS'),(150,'STRING'),(151,'CONDITION'),(152,'ENCLOSED'),(153,'FUNCTION'),(154,'AGGREGATE'),(155,'FIELDS'),(156,'INT3'),(157,'ARCHIVE'),(158,'AVG_ROW_LENGTH'),(159,'ADD'),(160,'KILL'),(161,'FLOAT4'),(162,'TABLESPACE'),(163,'VIEW'),(164,'REPEATABLE'),(165,'INFILE'),(166,'HELP_VERSION'),(167,'ORDER'),(168,'USING'),(169,'MIDDLEINT'),(170,'GRANT'),(171,'UNSIGNED'),(172,'DECIMAL'),(173,'GEOMETRYFROMTEXT'),(174,'INDEXES'),(175,'FOREIGN'),(176,'CACHE'),(177,'HOSTS'),(178,'COMMIT'),(179,'SCHEMAS'),(180,'LEADING'),(181,'SNAPSHOT'),(182,'DECLARE'),(183,'LOAD'),(184,'SQL_CACHE'),(185,'CONVERT'),(186,'DYNAMIC'),(187,'COLLATE'),(188,'POLYGONFROMTEXT'),(189,'BYTE'),(190,'GLOBAL'),(191,'LINESTRINGFROMWKB'),(192,'WHEN'),(193,'COLUMN_FORMAT'),(194,'HAVING'),(195,'AS'),(196,'STARTING'),(197,'RELOAD'),(198,'AUTOCOMMIT'),(199,'REVOKE'),(200,'GRANTS'),(201,'OUTER'),(202,'FLOOR'),(203,'EXPLAIN'),(204,'WITH'),(205,'AFTER'),(206,'STD'),(207,'CSV'),(208,'DISABLE'),(209,'UNINSTALL'),(210,'OUTFILE'),(211,'LOW_PRIORITY'),(212,'FILE'),(213,'NODEGROUP'),(214,'SCHEMA'),(215,'SONAME'),(216,'POW'),(217,'DUAL'),(218,'MULTIPOINTFROMWKB'),(219,'INDEX'),(220,'BACKUP'),(221,'MULTIPOINTFROMTEXT'),(222,'DEFINER'),(223,'MASTER_BIND'),(224,'REMOVE'),(225,'EXTENDED'),(226,'MULTILINESTRINGFROMWKB'),(227,'CROSS'),(228,'CONTRIBUTORS'),(229,'NATIONAL'),(230,'GROUP'),(231,'SHA'),(232,'ONLINE'),(233,'UNDO'),(234,'IGNORE_SERVER_IDS'),(235,'ZEROFILL'),(236,'CLIENT'),(237,'MASTER_PASSWORD'),(238,'OWNER'),(239,'RELAY_LOG_FILE'),(240,'TRUE'),(241,'CHARACTER'),(242,'MASTER_USER'),(243,'TABLE'),(244,'ENGINE'),(245,'INSERT_METHOD'),(246,'CASCADE'),(247,'RELAY_LOG_POS'),(248,'SQL_CALC_FOUND_ROWS'),(249,'UNION'),(250,'MYISAM'),(251,'LEAVE'),(252,'MODIFY'),(253,'MATCH'),(254,'MASTER_LOG_POS'),(255,'DISTINCTROW'),(256,'DESC'),(257,'TIME'),(258,'NUMERIC'),(259,'EXPANSION'),(260,'CODE'),(261,'CURSOR'),(262,'GEOMETRYCOLLECTIONFROMTEXT'),(263,'CHAIN'),(264,'LOGFILE'),(265,'FLUSH'),(266,'CREATE'),(267,'DESCRIBE'),(268,'EXTENT_SIZE'),(269,'MAX_UPDATES_PER_HOUR'),(270,'INT2'),(271,'PROCESSLIST'),(272,'ENDS'),(273,'LOGS'),(274,'RECOVER'),(275,'DISCARD'),(276,'HEAP'),(277,'SOUNDS'),(278,'BETWEEN'),(279,'MULTILINESTRINGFROMTEXT'),(280,'REPAIR'),(281,'PACK_KEYS'),(282,'FAST'),(283,'VALUES'),(284,'CALL'),(285,'LOOP'),(286,'VARCHARACTER'),(287,'BEFORE'),(288,'TRUNCATE'),(289,'SHOW'),(290,'ALL'),(291,'REDUNDANT'),(292,'USER_RESOURCES'),(293,'PARTIAL'),(294,'BINLOG'),(295,'END'),(296,'SECOND'),(297,'AND'),(298,'FLOAT8'),(299,'PREV'),(300,'HOUR'),(301,'SELECT'),(302,'DATABASES'),(303,'OR'),(304,'IDENTIFIED'),(305,'WRAPPER'),(306,'MASTER_SSL_CIPHER'),(307,'SQL_SLAVE_SKIP_COUNTER'),(308,'BOTH'),(309,'BOOL'),(310,'YEAR'),(311,'MASTER_PORT'),(312,'CONCURRENT'),(313,'HELP'),(314,'UNIQUE'),(315,'TRIGGERS'),(316,'PROCESS'),(317,'OPTIONS'),(318,'CONSISTENT'),(319,'MASTER_SSL'),(320,'DATE_ADD'),(321,'MAX_CONNECTIONS_PER_HOUR'),(322,'LIKE'),(323,'PLUGIN'),(324,'FETCH'),(325,'IN'),(326,'COLUMN'),(327,'DUMPFILE'),(328,'USAGE'),(329,'EXECUTE'),(330,'MEMORY'),(331,'CEIL'),(332,'QUERY'),(333,'MASTER_HOST'),(334,'LINES'),(335,'SQL_THREAD'),(336,'SERVER'),(337,'MAX_QUERIES_PER_HOUR'),(338,'MASTER_SSL_CERT'),(339,'MULTIPOLYGONFROMWKB'),(340,'TRANSACTION'),(341,'DAY_MINUTE'),(342,'STDDEV'),(343,'DATE_SUB'),(344,'REBUILD'),(345,'GEOMETRYFROMWKB'),(346,'INT1'),(347,'RENAME'),(348,'PARSER'),(349,'RIGHT'),(350,'ALTER'),(351,'MAX_ROWS'),(352,'SOCKET'),(353,'STRAIGHT_JOIN'),(354,'NATURAL'),(355,'VARIABLES'),(356,'ESCAPED'),(357,'SHA1'),(358,'KEY_BLOCK_SIZE'),(359,'PASSWORD'),(360,'OFFSET'),(361,'CHAR'),(362,'NEXT'),(363,'ERRORS'),(364,'SQL_LOG_BIN'),(365,'TEMPORARY'),(366,'COMMITTED'),(367,'SQL_SMALL_RESULT'),(368,'UPGRADE'),(369,'XA'),(370,'BEGIN'),(371,'DELAY_KEY_WRITE'),(372,'PROFILE'),(373,'MEDIUM'),(374,'INTERVAL'),(375,'SSL'),(376,'DAY_HOUR'),(377,'NAME'),(378,'REFERENCES'),(379,'AES_ENCRYPT'),(380,'STORAGE'),(381,'ISOLATION'),(382,'CEILING'),(383,'EVERY'),(384,'INT8'),(385,'AUTHORS'),(386,'RESTRICT'),(387,'UNCOMMITTED'),(388,'LINESTRINGFROMTEXT'),(389,'IS'),(390,'NOT'),(391,'ANALYSE'),(392,'DATAFILE'),(393,'DES_KEY_FILE'),(394,'COMPRESSED'),(395,'START'),(396,'PLUGINS'),(397,'SAVEPOINT'),(398,'IF'),(399,'PRIMARY'),(400,'PURGE'),(401,'LAST'),(402,'USER'),(403,'EXIT'),(404,'KEYS'),(405,'LIMIT'),(406,'KEY'),(407,'MERGE'),(408,'UNTIL'),(409,'SQL_NO_CACHE'),(410,'DELAYED'),(411,'ANALYZE'),(412,'CONSTRAINT'),(413,'SERIAL'),(414,'ACTION'),(415,'WRITE'),(416,'INITIAL_SIZE'),(417,'SESSION'),(418,'DATABASE'),(419,'NULL'),(420,'POWER'),(421,'USE_FRM'),(422,'TERMINATED'),(423,'SLAVE'),(424,'NVARCHAR'),(425,'ASC'),(426,'RETURN'),(427,'OPTIONALLY'),(428,'ENABLE'),(429,'DIRECTORY'),(430,'MAX_USER_CONNECTIONS'),(431,'WHILE'),(432,'LOCAL'),(433,'DISTINCT'),(434,'AES_DECRYPT'),(435,'MASTER_SSL_KEY'),(436,'NONE'),(437,'TABLES'),(438,'<>'),(439,'RLIKE'),(440,'TRIGGER'),(441,'COLLATION'),(442,'SHUTDOWN'),(443,'HIGH_PRIORITY'),(444,'BTREE'),(445,'FIRST'),(446,'COALESCE'),(447,'WAIT'),(448,'TYPES'),(449,'MASTER'),(450,'FIXED'),(451,'MULTIPOLYGONFROMTEXT'),(452,'ROW_FORMAT');
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_relation`
--

DROP TABLE IF EXISTS `help_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_relation` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `help_keyword_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`help_keyword_id`,`help_topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='keyword-topic relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_relation`
--

LOCK TABLES `help_relation` WRITE;
/*!40000 ALTER TABLE `help_relation` DISABLE KEYS */;
INSERT INTO `help_relation` VALUES (1,0),(357,0),(475,1),(234,2),(450,3),(3,4),(424,4),(89,5),(89,6),(409,6),(97,7),(89,8),(186,9),(432,10),(437,11),(21,12),(348,12),(424,12),(465,12),(89,13),(409,13),(146,14),(231,15),(88,16),(357,16),(18,17),(106,17),(134,17),(348,17),(97,18),(502,18),(382,19),(3,20),(104,20),(245,20),(186,21),(357,22),(9,23),(31,23),(35,23),(87,23),(187,23),(232,23),(239,23),(265,23),(278,23),(302,23),(332,23),(408,23),(418,23),(419,23),(465,23),(480,23),(108,24),(123,25),(170,25),(378,26),(82,27),(104,28),(200,29),(37,30),(348,31),(403,31),(470,31),(378,32),(200,33),(36,34),(239,34),(437,34),(37,35),(357,35),(470,36),(420,37),(465,37),(470,37),(21,38),(296,38),(348,38),(454,38),(470,38),(502,39),(50,40),(77,40),(83,40),(200,40),(357,40),(364,40),(424,40),(465,40),(470,40),(470,41),(474,41),(378,42),(465,43),(470,43),(120,44),(213,44),(424,44),(470,44),(475,44),(378,45),(357,46),(97,47),(316,47),(364,48),(186,49),(50,50),(470,50),(474,50),(1,51),(89,51),(409,51),(474,51),(176,52),(470,52),(53,53),(106,53),(200,54),(1,55),(57,55),(195,55),(50,56),(83,56),(106,56),(194,57),(200,57),(251,57),(211,58),(465,58),(89,59),(302,59),(359,59),(409,59),(200,60),(357,61),(1,62),(83,62),(104,62),(357,62),(424,62),(465,62),(50,63),(420,63),(468,63),(231,64),(87,65),(211,65),(465,65),(200,66),(195,67),(470,68),(91,69),(484,69),(387,70),(450,71),(1,72),(40,73),(231,73),(271,73),(186,74),(271,74),(462,74),(186,75),(465,75),(89,76),(409,76),(378,77),(83,78),(104,78),(357,78),(474,78),(89,79),(409,79),(3,80),(104,80),(306,80),(357,80),(470,81),(259,82),(195,83),(378,84),(130,85),(146,86),(437,86),(462,86),(17,87),(190,87),(304,87),(330,87),(348,87),(357,87),(419,87),(442,87),(490,87),(99,88),(189,88),(424,89),(465,89),(88,90),(404,91),(470,91),(69,92),(331,92),(435,92),(287,93),(29,94),(59,94),(85,94),(104,95),(196,95),(303,95),(488,95),(284,96),(348,96),(106,97),(315,97),(475,98),(378,99),(9,100),(31,100),(89,100),(155,100),(187,100),(278,100),(302,100),(348,101),(368,101),(109,102),(146,103),(437,103),(462,103),(24,104),(88,104),(113,105),(174,105),(3,106),(104,106),(155,106),(201,106),(213,106),(245,106),(465,106),(470,106),(465,107),(115,108),(328,108),(468,108),(472,108),(115,109),(465,109),(39,110),(119,110),(151,110),(266,110),(422,111),(125,112),(89,113),(126,113),(409,113),(498,113),(222,114),(3,115),(83,115),(104,115),(130,115),(146,115),(155,115),(183,115),(213,115),(334,115),(348,115),(357,115),(424,115),(465,115),(470,115),(474,115),(479,115),(496,115),(200,116),(132,117),(231,117),(264,117),(378,117),(60,118),(137,118),(216,118),(224,118),(330,118),(337,118),(348,118),(368,118),(403,118),(211,119),(465,119),(470,119),(89,120),(195,120),(409,120),(470,120),(186,121),(1,122),(54,123),(186,124),(470,125),(316,126),(200,127),(458,128),(257,129),(287,130),(200,131),(251,131),(465,132),(59,133),(85,133),(239,134),(54,135),(326,135),(59,136),(85,136),(200,137),(315,138),(50,139),(120,139),(123,139),(348,139),(357,139),(362,139),(458,139),(37,140),(106,140),(437,140),(450,140),(1,141),(29,142),(378,143),(470,144),(180,145),(210,146),(181,147),(315,147),(348,147),(357,147),(423,147),(331,148),(348,148),(470,149),(97,150),(181,151),(424,152),(35,153),(68,153),(97,153),(212,153),(235,153),(304,153),(337,153),(348,153),(395,153),(408,153),(419,153),(97,154),(348,155),(424,155),(254,156),(470,157),(465,158),(470,158),(62,159),(195,159),(465,159),(480,159),(176,160),(168,161),(195,162),(418,162),(465,162),(480,162),(31,163),(159,163),(457,163),(450,164),(424,165),(191,166),(50,167),(83,167),(357,167),(364,167),(465,167),(1,168),(50,168),(86,168),(254,169),(200,170),(251,170),(24,171),(129,171),(168,171),(210,171),(231,171),(316,171),(502,171),(97,172),(156,172),(231,172),(414,173),(348,174),(465,175),(470,175),(474,175),(475,175),(101,176),(151,176),(306,176),(145,177),(348,177),(146,178),(437,178),(160,179),(348,179),(458,180),(146,181),(437,181),(181,182),(201,182),(315,182),(423,182),(120,183),(306,183),(362,183),(424,183),(357,184),(231,185),(379,185),(470,186),(155,187),(213,187),(470,187),(397,188),(467,189),(130,190),(137,190),(183,190),(350,190),(450,190),(455,191),(59,192),(85,192),(470,193),(357,194),(1,195),(37,195),(357,195),(424,196),(200,197),(146,198),(251,199),(193,200),(348,200),(1,201),(222,202),(257,203),(88,204),(200,204),(211,204),(465,204),(470,204),(465,205),(262,206),(424,207),(470,207),(89,208),(409,208),(465,208),(293,209),(357,210),(3,211),(37,211),(50,211),(83,211),(104,211),(424,211),(200,212),(195,213),(155,214),(187,214),(213,214),(311,214),(348,214),(97,215),(279,216),(281,217),(466,218),(1,219),(62,219),(87,219),(101,219),(211,219),(306,219),(310,219),(348,219),(465,219),(470,219),(360,220),(427,221),(89,222),(409,222),(186,223),(465,224),(257,225),(468,225),(274,226),(1,227),(7,228),(348,228),(259,229),(432,229),(49,230),(195,230),(227,230),(232,230),(357,230),(429,231),(87,232),(211,232),(465,232),(315,233),(186,234),(24,235),(129,235),(168,235),(210,235),(316,235),(502,235),(200,236),(186,237),(475,238),(186,239),(387,240),(155,241),(213,241),(259,241),(334,241),(348,241),(357,241),(424,241),(432,241),(470,241),(186,242),(62,243),(110,243),(115,243),(180,243),(216,243),(278,243),(280,243),(323,243),(348,243),(360,243),(362,243),(404,243),(420,243),(465,243),(468,243),(470,243),(472,243),(195,244),(348,244),(368,244),(418,244),(465,244),(470,244),(480,244),(470,245),(31,246),(278,246),(470,246),(474,246),(186,247),(357,248),(307,249),(470,250),(312,251),(465,252),(88,253),(186,254),(357,255),(257,256),(357,256),(364,256),(231,257),(317,257),(377,257),(210,258),(88,259),(68,260),(490,260),(423,261),(248,262),(146,263),(49,264),(195,264),(227,264),(232,264),(151,265),(328,265),(17,266),(22,266),(49,266),(62,266),(77,266),(89,266),(97,266),(155,266),(195,266),(211,266),(212,266),(280,266),(304,266),(311,266),(348,266),(359,266),(395,266),(457,266),(470,266),(475,266),(257,267),(195,268),(200,269),(236,270),(348,271),(454,271),(89,272),(40,273),(271,273),(348,273),(437,274),(465,275),(470,276),(380,277),(147,278),(107,279),(465,280),(468,280),(470,281),(420,282),(3,283),(104,283),(340,284),(345,285),(259,286),(271,287),(323,288),(7,289),(10,289),(17,289),(21,289),(25,289),(34,289),(40,289),(60,289),(68,289),(69,289),(82,289),(123,289),(134,289),(137,289),(145,289),(160,289),(170,289),(193,289),(194,289),(216,289),(224,289),(280,289),(284,289),(296,289),(310,289),(311,289),(330,289),(331,289),(334,289),(337,289),(348,289),(350,289),(359,289),(368,289),(395,289),(403,289),(454,289),(489,289),(490,289),(494,289),(200,290),(251,290),(307,290),(357,290),(470,291),(328,292),(470,293),(123,294),(351,294),(29,295),(59,295),(85,295),(234,295),(329,295),(345,295),(437,295),(498,295),(378,296),(147,297),(318,297),(316,298),(106,299),(378,300),(3,301),(104,301),(257,301),(303,301),(357,301),(160,302),(348,302),(141,303),(77,304),(200,304),(475,305),(186,306),(183,307),(458,308),(24,309),(111,309),(378,310),(186,311),(424,312),(118,313),(392,313),(465,314),(25,315),(348,315),(200,316),(376,317),(475,317),(146,318),(437,318),(186,319),(378,320),(200,321),(348,322),(380,322),(293,323),(348,323),(422,323),(385,324),(88,325),(123,325),(357,325),(465,326),(357,327),(200,328),(86,329),(200,329),(357,330),(399,331),(88,332),(151,332),(176,332),(186,333),(424,334),(54,335),(326,335),(9,336),(376,336),(475,336),(200,337),(186,338),(124,339),(146,340),(450,340),(378,341),(410,342),(378,343),(465,344),(144,345),(24,346),(110,347),(223,347),(409,347),(465,347),(211,348),(465,348),(470,348),(1,349),(62,350),(159,350),(200,350),(213,350),(227,350),(235,350),(376,350),(409,350),(442,350),(465,350),(480,350),(470,351),(475,352),(1,353),(357,353),(1,354),(348,355),(350,355),(424,356),(429,357),(470,358),(77,359),(200,359),(475,359),(479,359),(357,360),(231,361),(467,361),(106,362),(69,363),(348,363),(496,364),(278,365),(450,366),(357,367),(213,368),(420,368),(437,369),(146,370),(329,370),(437,370),(470,371),(489,372),(420,373),(89,374),(378,374),(200,375),(378,376),(213,377),(200,378),(470,378),(474,378),(446,379),(284,380),(450,381),(451,382),(89,383),(129,384),(10,385),(348,385),(31,386),(278,386),(474,386),(450,387),(58,388),(84,389),(207,389),(371,389),(459,389),(84,390),(89,390),(155,390),(207,390),(314,390),(190,391),(195,392),(480,392),(328,393),(470,394),(146,395),(326,395),(437,395),(34,396),(462,397),(9,398),(29,398),(31,398),(89,398),(155,398),(187,398),(278,398),(302,398),(481,398),(465,399),(271,400),(106,401),(77,402),(223,402),(332,402),(475,402),(315,403),(310,404),(348,404),(465,404),(50,405),(83,405),(106,405),(123,405),(357,405),(62,406),(104,406),(465,406),(470,406),(474,406),(470,407),(234,408),(357,409),(3,410),(104,410),(488,410),(465,411),(472,411),(465,412),(470,412),(245,413),(470,413),(470,414),(474,414),(37,415),(437,415),(195,416),(480,416),(130,417),(137,417),(350,417),(450,417),(155,418),(187,418),(213,418),(311,418),(348,418),(475,418),(84,419),(371,419),(474,419),(485,420),(468,421),(424,422),(39,423),(54,423),(89,423),(145,423),(224,423),(326,423),(409,423),(259,424),(357,425),(364,425),(493,426),(424,427),(89,428),(409,428),(465,428),(213,429),(470,429),(200,430),(498,431),(37,432),(115,432),(328,432),(424,432),(468,432),(472,432),(0,433),(96,433),(290,433),(307,433),(357,433),(364,433),(386,433),(435,433),(499,434),(186,435),(200,436),(37,437),(134,437),(296,437),(348,437),(497,438),(28,439),(22,440),(265,440),(348,440),(348,441),(494,441),(200,442),(104,443),(357,443),(211,444),(106,445),(465,445),(470,445),(465,446),(195,447),(480,447),(348,448),(40,449),(60,449),(120,449),(186,449),(266,449),(271,449),(362,449),(210,450),(470,450),(202,451),(470,452);
/*!40000 ALTER TABLE `help_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_topic`
--

DROP TABLE IF EXISTS `help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_topic` (
  `help_topic_id` int(10) unsigned NOT NULL,
  `name` char(64) NOT NULL,
  `help_category_id` smallint(5) unsigned NOT NULL,
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`help_topic_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help topics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_topic`
--

LOCK TABLES `help_topic` WRITE;
/*!40000 ALTER TABLE `help_topic` DISABLE KEYS */;
INSERT INTO `help_topic` VALUES (0,'MIN',16,'Syntax:\nMIN([DISTINCT] expr)\n\nReturns the minimum value of expr. MIN() may take a string argument; in\nsuch cases, it returns the minimum string value. See\nhttp://dev.mysql.com/doc/refman/5.1/en/mysql-indexes.html. The DISTINCT\nkeyword can be used to find the minimum of the distinct values of expr,\nhowever, this produces the same result as omitting DISTINCT.\n\nMIN() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','mysql> SELECT student_name, MIN(test_score), MAX(test_score)\n    ->        FROM student\n    ->        GROUP BY student_name;\n','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(1,'JOIN',28,'MySQL supports the following JOIN syntaxes for the table_references\npart of SELECT statements and multiple-table DELETE and UPDATE\nstatements:\n\ntable_references:\n    escaped_table_reference [, escaped_table_reference] ...\n\nescaped_table_reference:\n    table_reference\n  | { OJ table_reference }\n\ntable_reference:\n    table_factor\n  | join_table\n\ntable_factor:\n    tbl_name [[AS] alias] [index_hint_list]\n  | table_subquery [AS] alias\n  | ( table_references )\n\njoin_table:\n    table_reference [INNER | CROSS] JOIN table_factor [join_condition]\n  | table_reference STRAIGHT_JOIN table_factor\n  | table_reference STRAIGHT_JOIN table_factor ON conditional_expr\n  | table_reference {LEFT|RIGHT} [OUTER] JOIN table_reference join_condition\n  | table_reference NATURAL [{LEFT|RIGHT} [OUTER]] JOIN table_factor\n\njoin_condition:\n    ON conditional_expr\n  | USING (column_list)\n\nindex_hint_list:\n    index_hint [, index_hint] ...\n\nindex_hint:\n    USE {INDEX|KEY}\n      [FOR {JOIN|ORDER BY|GROUP BY}] ([index_list])\n  | IGNORE {INDEX|KEY}\n      [FOR {JOIN|ORDER BY|GROUP BY}] (index_list)\n  | FORCE {INDEX|KEY}\n      [FOR {JOIN|ORDER BY|GROUP BY}] (index_list)\n\nindex_list:\n    index_name [, index_name] ...\n\nA table reference is also known as a join expression.\n\nThe syntax of table_factor is extended in comparison with the SQL\nStandard. The latter accepts only table_reference, not a list of them\ninside a pair of parentheses.\n\nThis is a conservative extension if we consider each comma in a list of\ntable_reference items as equivalent to an inner join. For example:\n\nSELECT * FROM t1 LEFT JOIN (t2, t3, t4)\n                 ON (t2.a=t1.a AND t3.b=t1.b AND t4.c=t1.c)\n\nis equivalent to:\n\nSELECT * FROM t1 LEFT JOIN (t2 CROSS JOIN t3 CROSS JOIN t4)\n                 ON (t2.a=t1.a AND t3.b=t1.b AND t4.c=t1.c)\n\nIn MySQL, JOIN, CROSS JOIN, and INNER JOIN are syntactic equivalents\n(they can replace each other). In standard SQL, they are not\nequivalent. INNER JOIN is used with an ON clause, CROSS JOIN is used\notherwise.\n\nIn general, parentheses can be ignored in join expressions containing\nonly inner join operations. MySQL also supports nested joins (see\nhttp://dev.mysql.com/doc/refman/5.1/en/nested-join-optimization.html).\n\nIndex hints can be specified to affect how the MySQL optimizer makes\nuse of indexes. For more information, see\nhttp://dev.mysql.com/doc/refman/5.1/en/index-hints.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/join.html\n\n','SELECT left_tbl.*\n  FROM left_tbl LEFT JOIN right_tbl ON left_tbl.id = right_tbl.id\n  WHERE right_tbl.id IS NULL;\n','http://dev.mysql.com/doc/refman/5.1/en/join.html'),(2,'HEX',38,'Syntax:\nHEX(str), HEX(N)\n\nFor a string argument str, HEX() returns a hexadecimal string\nrepresentation of str where each character in str is converted to two\nhexadecimal digits. The inverse of this operation is performed by the\nUNHEX() function.\n\nFor a numeric argument N, HEX() returns a hexadecimal string\nrepresentation of the value of N treated as a longlong (BIGINT) number.\nThis is equivalent to CONV(N,10,16). The inverse of this operation is\nperformed by CONV(HEX(N),16,10).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT 0x616263, HEX(\'abc\'), UNHEX(HEX(\'abc\'));\n        -> \'abc\', 616263, \'abc\'\nmysql> SELECT HEX(255), CONV(HEX(255),16,10);\n        -> \'FF\', 255\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(3,'REPLACE',28,'Syntax:\nREPLACE [LOW_PRIORITY | DELAYED]\n    [INTO] tbl_name [(col_name,...)]\n    {VALUES | VALUE} ({expr | DEFAULT},...),(...),...\n\nOr:\n\nREPLACE [LOW_PRIORITY | DELAYED]\n    [INTO] tbl_name\n    SET col_name={expr | DEFAULT}, ...\n\nOr:\n\nREPLACE [LOW_PRIORITY | DELAYED]\n    [INTO] tbl_name [(col_name,...)]\n    SELECT ...\n\nREPLACE works exactly like INSERT, except that if an old row in the\ntable has the same value as a new row for a PRIMARY KEY or a UNIQUE\nindex, the old row is deleted before the new row is inserted. See [HELP\nINSERT].\n\nREPLACE is a MySQL extension to the SQL standard. It either inserts, or\ndeletes and inserts. For another MySQL extension to standard SQL---that\neither inserts or updates---see\nhttp://dev.mysql.com/doc/refman/5.1/en/insert-on-duplicate.html.\n\nNote that unless the table has a PRIMARY KEY or UNIQUE index, using a\nREPLACE statement makes no sense. It becomes equivalent to INSERT,\nbecause there is no index to be used to determine whether a new row\nduplicates another.\n\nValues for all columns are taken from the values specified in the\nREPLACE statement. Any missing columns are set to their default values,\njust as happens for INSERT. You cannot refer to values from the current\nrow and use them in the new row. If you use an assignment such as SET\ncol_name = col_name + 1, the reference to the column name on the right\nhand side is treated as DEFAULT(col_name), so the assignment is\nequivalent to SET col_name = DEFAULT(col_name) + 1.\n\nTo use REPLACE, you must have both the INSERT and DELETE privileges for\nthe table.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/replace.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/replace.html'),(4,'CONTAINS',31,'Contains(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 completely contains g2. This\ntests the opposite relationship as Within().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(5,'SRID',37,'SRID(g)\n\nReturns an integer indicating the Spatial Reference System ID for the\ngeometry value g.\n\nIn MySQL, the SRID value is just an integer associated with the\ngeometry value. All calculations are done assuming Euclidean (planar)\ngeometry.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SELECT SRID(GeomFromText(\'LineString(1 1,2 2)\',101));\n+-----------------------------------------------+\n| SRID(GeomFromText(\'LineString(1 1,2 2)\',101)) |\n+-----------------------------------------------+\n|                                           101 |\n+-----------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(6,'CURRENT_TIMESTAMP',32,'Syntax:\nCURRENT_TIMESTAMP, CURRENT_TIMESTAMP()\n\nCURRENT_TIMESTAMP and CURRENT_TIMESTAMP() are synonyms for NOW().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(7,'SHOW CONTRIBUTORS',27,'Syntax:\nSHOW CONTRIBUTORS\n\nThe SHOW CONTRIBUTORS statement displays information about the people\nwho contribute to MySQL source or to causes that we support. For each\ncontributor, it displays Name, Location, and Comment values.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-contributors.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-contributors.html'),(8,'VARIANCE',16,'Syntax:\nVARIANCE(expr)\n\nReturns the population standard variance of expr. This is an extension\nto standard SQL. The standard SQL function VAR_POP() can be used\ninstead.\n\nVARIANCE() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(9,'DROP SERVER',40,'Syntax:\nDROP SERVER [ IF EXISTS ] server_name\n\nDrops the server definition for the server named server_name. The\ncorresponding row in the mysql.servers table is deleted. This statement\nrequires the SUPER privilege.\n\nDropping a server for a table does not affect any FEDERATED tables that\nused this connection information when they were created. See [HELP\nCREATE SERVER].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-server.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-server.html'),(10,'SHOW AUTHORS',27,'Syntax:\nSHOW AUTHORS\n\nThe SHOW AUTHORS statement displays information about the people who\nwork on MySQL. For each author, it displays Name, Location, and Comment\nvalues.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-authors.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-authors.html'),(11,'VAR_SAMP',16,'Syntax:\nVAR_SAMP(expr)\n\nReturns the sample variance of expr. That is, the denominator is the\nnumber of rows minus one.\n\nVAR_SAMP() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(12,'CONCAT',38,'Syntax:\nCONCAT(str1,str2,...)\n\nReturns the string that results from concatenating the arguments. May\nhave one or more arguments. If all arguments are nonbinary strings, the\nresult is a nonbinary string. If the arguments include any binary\nstrings, the result is a binary string. A numeric argument is converted\nto its equivalent binary string form; if you want to avoid that, you\ncan use an explicit type cast, as in this example:\n\nSELECT CONCAT(CAST(int_col AS CHAR), char_col);\n\nCONCAT() returns NULL if any argument is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT CONCAT(\'My\', \'S\', \'QL\');\n        -> \'MySQL\'\nmysql> SELECT CONCAT(\'My\', NULL, \'QL\');\n        -> NULL\nmysql> SELECT CONCAT(14.3);\n        -> \'14.3\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(13,'GEOMETRY HIERARCHY',35,'Geometry is the base class. It is an abstract class. The instantiable\nsubclasses of Geometry are restricted to zero-, one-, and\ntwo-dimensional geometric objects that exist in two-dimensional\ncoordinate space. All instantiable geometry classes are defined so that\nvalid instances of a geometry class are topologically closed (that is,\nall defined geometries include their boundary).\n\nThe base Geometry class has subclasses for Point, Curve, Surface, and\nGeometryCollection:\n\no Point represents zero-dimensional objects.\n\no Curve represents one-dimensional objects, and has subclass\n  LineString, with sub-subclasses Line and LinearRing.\n\no Surface is designed for two-dimensional objects and has subclass\n  Polygon.\n\no GeometryCollection has specialized zero-, one-, and two-dimensional\n  collection classes named MultiPoint, MultiLineString, and\n  MultiPolygon for modeling geometries corresponding to collections of\n  Points, LineStrings, and Polygons, respectively. MultiCurve and\n  MultiSurface are introduced as abstract superclasses that generalize\n  the collection interfaces to handle Curves and Surfaces.\n\nGeometry, Curve, Surface, MultiCurve, and MultiSurface are defined as\nnoninstantiable classes. They define a common set of methods for their\nsubclasses and are included for extensibility.\n\nPoint, LineString, Polygon, GeometryCollection, MultiPoint,\nMultiLineString, and MultiPolygon are instantiable classes.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/gis-geometry-class-hierarchy.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/gis-geometry-class-hierarchy.html'),(14,'CHAR FUNCTION',38,'Syntax:\nCHAR(N,... [USING charset_name])\n\nCHAR() interprets each argument N as an integer and returns a string\nconsisting of the characters given by the code values of those\nintegers. NULL values are skipped.\nBy default, CHAR() returns a binary string. To produce a string in a\ngiven character set, use the optional USING clause:\n\nmysql> SELECT CHARSET(CHAR(0x65)), CHARSET(CHAR(0x65 USING utf8));\n+---------------------+--------------------------------+\n| CHARSET(CHAR(0x65)) | CHARSET(CHAR(0x65 USING utf8)) |\n+---------------------+--------------------------------+\n| binary              | utf8                           |\n+---------------------+--------------------------------+\n\nIf USING is given and the result string is illegal for the given\ncharacter set, a warning is issued. Also, if strict SQL mode is\nenabled, the result from CHAR() becomes NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT CHAR(77,121,83,81,\'76\');\n        -> \'MySQL\'\nmysql> SELECT CHAR(77,77.3,\'77.3\');\n        -> \'MMM\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(15,'DATETIME',23,'DATETIME\n\nA date and time combination. The supported range is \'1000-01-01\n00:00:00\' to \'9999-12-31 23:59:59\'. MySQL displays DATETIME values in\n\'YYYY-MM-DD HH:MM:SS\' format, but permits assignment of values to\nDATETIME columns using either strings or numbers.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-type-overview.html'),(16,'SHOW CREATE TRIGGER',27,'Syntax:\nSHOW CREATE TRIGGER trigger_name\n\nThis statement shows the CREATE TRIGGER statement that creates the\nnamed trigger.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-create-trigger.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-create-trigger.html'),(17,'SHOW CREATE PROCEDURE',27,'Syntax:\nSHOW CREATE PROCEDURE proc_name\n\nThis statement is a MySQL extension. It returns the exact string that\ncan be used to re-create the named stored procedure. A similar\nstatement, SHOW CREATE FUNCTION, displays information about stored\nfunctions (see [HELP SHOW CREATE FUNCTION]).\n\nBoth statements require that you be the owner of the routine or have\nSELECT access to the mysql.proc table. If you do not have privileges\nfor the routine itself, the value displayed for the Create Procedure or\nCreate Function field will be NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-create-procedure.html\n\n','mysql> SHOW CREATE PROCEDURE test.simpleproc\\G\n*************************** 1. row ***************************\n           Procedure: simpleproc\n            sql_mode:\n    Create Procedure: CREATE PROCEDURE `simpleproc`(OUT param1 INT)\n                      BEGIN\n                      SELECT COUNT(*) INTO param1 FROM t;\n                      END\ncharacter_set_client: latin1\ncollation_connection: latin1_swedish_ci\n  Database Collation: latin1_swedish_ci\n\nmysql> SHOW CREATE FUNCTION test.hello\\G\n*************************** 1. row ***************************\n            Function: hello\n            sql_mode:\n     Create Function: CREATE FUNCTION `hello`(s CHAR(20))\n                      RETURNS CHAR(50)\n                      RETURN CONCAT(\'Hello, \',s,\'!\')\ncharacter_set_client: latin1\ncollation_connection: latin1_swedish_ci\n  Database Collation: latin1_swedish_ci\n','http://dev.mysql.com/doc/refman/5.1/en/show-create-procedure.html'),(18,'OPEN',24,'Syntax:\nOPEN cursor_name\n\nThis statement opens a previously declared cursor. For an example, see\nhttp://dev.mysql.com/doc/refman/5.1/en/cursors.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/open.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/open.html'),(19,'INTEGER',23,'INTEGER[(M)] [UNSIGNED] [ZEROFILL]\n\nThis type is a synonym for INT.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(20,'LOWER',38,'Syntax:\nLOWER(str)\n\nReturns the string str with all characters changed to lowercase\naccording to the current character set mapping. The default is latin1\n(cp1252 West European).\n\nmysql> SELECT LOWER(\'QUADRATICALLY\');\n        -> \'quadratically\'\n\nLOWER() (and UPPER()) are ineffective when applied to binary strings\n(BINARY, VARBINARY, BLOB). To perform lettercase conversion, convert\nthe string to a nonbinary string:\n\nmysql> SET @str = BINARY \'New York\';\nmysql> SELECT LOWER(@str), LOWER(CONVERT(@str USING latin1));\n+-------------+-----------------------------------+\n| LOWER(@str) | LOWER(CONVERT(@str USING latin1)) |\n+-------------+-----------------------------------+\n| New York    | new york                          |\n+-------------+-----------------------------------+\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(21,'SHOW COLUMNS',27,'Syntax:\nSHOW [FULL] COLUMNS {FROM | IN} tbl_name [{FROM | IN} db_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW COLUMNS displays information about the columns in a given table.\nIt also works for views. The LIKE clause, if present, indicates which\ncolumn names to match. The WHERE clause can be given to select rows\nusing more general conditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\n\nmysql> SHOW COLUMNS FROM City;\n+------------+----------+------+-----+---------+----------------+\n| Field      | Type     | Null | Key | Default | Extra          |\n+------------+----------+------+-----+---------+----------------+\n| Id         | int(11)  | NO   | PRI | NULL    | auto_increment |\n| Name       | char(35) | NO   |     |         |                |\n| Country    | char(3)  | NO   | UNI |         |                |\n| District   | char(20) | YES  | MUL |         |                |\n| Population | int(11)  | NO   |     | 0       |                |\n+------------+----------+------+-----+---------+----------------+\n5 rows in set (0.00 sec)\n\nIf the data types differ from what you expect them to be based on a\nCREATE TABLE statement, note that MySQL sometimes changes data types\nwhen you create or alter a table. The conditions under which this\noccurs are described in\nhttp://dev.mysql.com/doc/refman/5.1/en/silent-column-changes.html.\n\nThe FULL keyword causes the output to include the column collation and\ncomments, as well as the privileges you have for each column.\n\nYou can use db_name.tbl_name as an alternative to the tbl_name FROM\ndb_name syntax. In other words, these two statements are equivalent:\n\nmysql> SHOW COLUMNS FROM mytable FROM mydb;\nmysql> SHOW COLUMNS FROM mydb.mytable;\n\nSHOW COLUMNS displays the following values for each table column:\n\nField indicates the column name.\n\nType indicates the column data type.\n\nCollation indicates the collation for nonbinary string columns, or NULL\nfor other columns. This value is displayed only if you use the FULL\nkeyword.\n\nThe Null field contains YES if NULL values can be stored in the column,\nNO if not.\n\nThe Key field indicates whether the column is indexed:\n\no If Key is empty, the column either is not indexed or is indexed only\n  as a secondary column in a multiple-column, nonunique index.\n\no If Key is PRI, the column is a PRIMARY KEY or is one of the columns\n  in a multiple-column PRIMARY KEY.\n\no If Key is UNI, the column is the first column of a UNIQUE index. (A\n  UNIQUE index permits multiple NULL values, but you can tell whether\n  the column permits NULL by checking the Null field.)\n\no If Key is MUL, the column is the first column of a nonunique index in\n  which multiple occurrences of a given value are permitted within the\n  column.\n\nIf more than one of the Key values applies to a given column of a\ntable, Key displays the one with the highest priority, in the order\nPRI, UNI, MUL.\n\nA UNIQUE index may be displayed as PRI if it cannot contain NULL values\nand there is no PRIMARY KEY in the table. A UNIQUE index may display as\nMUL if several columns form a composite UNIQUE index; although the\ncombination of the columns is unique, each column can still hold\nmultiple occurrences of a given value.\n\nThe Default field indicates the default value that is assigned to the\ncolumn. This is NULL if the column has an explicit default of NULL. As\nof MySQL 5.1.23, Default is also NULL if the column definition has no\nDEFAULT clause.\n\nThe Extra field contains any additional information that is available\nabout a given column. The value is nonempty in these cases:\nauto_increment for columns that have the AUTO_INCREMENT attribute; as\nof MySQL 5.1.23, on update CURRENT_TIMESTAMP for TIMESTAMP columns that\nhave the ON UPDATE CURRENT_TIMESTAMP attribute.\n\nPrivileges indicates the privileges you have for the column. This value\nis displayed only if you use the FULL keyword.\n\nComment indicates any comment the column has. This value is displayed\nonly if you use the FULL keyword.\n\nSHOW FIELDS is a synonym for SHOW COLUMNS. You can also list a table\'s\ncolumns with the mysqlshow db_name tbl_name command.\n\nThe DESCRIBE statement provides information similar to SHOW COLUMNS.\nSee http://dev.mysql.com/doc/refman/5.1/en/describe.html.\n\nThe SHOW CREATE TABLE, SHOW TABLE STATUS, and SHOW INDEX statements\nalso provide information about tables. See [HELP SHOW].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-columns.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-columns.html'),(22,'CREATE TRIGGER',40,'Syntax:\nCREATE\n    [DEFINER = { user | CURRENT_USER }]\n    TRIGGER trigger_name\n    trigger_time trigger_event\n    ON tbl_name FOR EACH ROW\n    trigger_body\n\ntrigger_time: { BEFORE | AFTER }\n\ntrigger_event: { INSERT | UPDATE | DELETE }\n\nThis statement creates a new trigger. A trigger is a named database\nobject that is associated with a table, and that activates when a\nparticular event occurs for the table. The trigger becomes associated\nwith the table named tbl_name, which must refer to a permanent table.\nYou cannot associate a trigger with a TEMPORARY table or a view.\n\nTrigger names exist in the schema namespace, meaning that all triggers\nmust have unique names within a schema. Triggers in different schemas\ncan have the same name.\n\nThis section describes CREATE TRIGGER syntax. For additional\ndiscussion, see\nhttp://dev.mysql.com/doc/refman/5.1/en/trigger-syntax.html.\n\nCREATE TRIGGER requires the TRIGGER privilege for the table associated\nwith the trigger. The statement might also require the SUPER privilege,\ndepending on the DEFINER value, as described later in this section. If\nbinary logging is enabled, CREATE TRIGGER might require the SUPER\nprivilege, as described in\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-programs-logging.html.\n(Before MySQL 5.1.6, there is no TRIGGER privilege and this statement\nrequires the SUPER privilege in all cases.)\n\nThe DEFINER clause determines the security context to be used when\nchecking access privileges at trigger activation time, as described\nlater in this section.\n\ntrigger_time is the trigger action time. It can be BEFORE or AFTER to\nindicate that the trigger activates before or after each row to be\nmodified.\n\ntrigger_event indicates the kind of operation that activates the\ntrigger. These trigger_event values are permitted:\n\no INSERT: The trigger activates whenever a new row is inserted into the\n  table; for example, through INSERT, LOAD DATA, and REPLACE\n  statements.\n\no UPDATE: The trigger activates whenever a row is modified; for\n  example, through UPDATE statements.\n\no DELETE: The trigger activates whenever a row is deleted from the\n  table; for example, through DELETE and REPLACE statements. DROP TABLE\n  and TRUNCATE TABLE statements on the table do not activate this\n  trigger, because they do not use DELETE. Dropping a partition does\n  not activate DELETE triggers, either.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-trigger.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-trigger.html'),(23,'MONTH',32,'Syntax:\nMONTH(date)\n\nReturns the month for date, in the range 1 to 12 for January to\nDecember, or 0 for dates such as \'0000-00-00\' or \'2008-00-00\' that have\na zero month part.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT MONTH(\'2008-02-03\');\n        -> 2\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(24,'TINYINT',23,'TINYINT[(M)] [UNSIGNED] [ZEROFILL]\n\nA very small integer. The signed range is -128 to 127. The unsigned\nrange is 0 to 255.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(25,'SHOW TRIGGERS',27,'Syntax:\nSHOW TRIGGERS [{FROM | IN} db_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW TRIGGERS lists the triggers currently defined for tables in a\ndatabase (the default database unless a FROM clause is given). This\nstatement returns results only for databases and tables for which you\nhave the TRIGGER privilege, or (prior to MySQL 5.1.23) if you have the\nSUPER privilege). The LIKE clause, if present, indicates which table\nnames to match (not trigger names) and causes the statement to display\ntriggers for those tables. The WHERE clause can be given to select rows\nusing more general conditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\n\nFor the trigger ins_sum as defined in\nhttp://dev.mysql.com/doc/refman/5.1/en/triggers.html, the output of\nthis statement is as shown here:\n\nmysql> SHOW TRIGGERS LIKE \'acc%\'\\G\n*************************** 1. row ***************************\n             Trigger: ins_sum\n               Event: INSERT\n               Table: account\n           Statement: SET @sum = @sum + NEW.amount\n              Timing: BEFORE\n             Created: NULL\n            sql_mode: \n             Definer: me@localhost\ncharacter_set_client: latin1\ncollation_connection: latin1_swedish_ci\n  Database Collation: latin1_swedish_ci\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-triggers.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-triggers.html'),(26,'ISCLOSED',13,'IsClosed(ls)\n\nReturns 1 if the LineString value ls is closed (that is, its\nStartPoint() and EndPoint() values are the same) and is simple (does\nnot pass through the same point more than once). Returns 0 if ls is not\nclosed, and -1 if it is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @ls1 = \'LineString(1 1,2 2,3 3,2 2)\';\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SET @ls2 = \'LineString(1 1,2 2,3 3,1 1)\';\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT IsClosed(GeomFromText(@ls1));\n+------------------------------+\n| IsClosed(GeomFromText(@ls1)) |\n+------------------------------+\n|                            0 |\n+------------------------------+\n1 row in set (0.00 sec)\n\nmysql> SELECT IsClosed(GeomFromText(@ls2));\n+------------------------------+\n| IsClosed(GeomFromText(@ls2)) |\n+------------------------------+\n|                            1 |\n+------------------------------+\n1 row in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(27,'MASTER_POS_WAIT',14,'Syntax:\nMASTER_POS_WAIT(log_name,log_pos[,timeout])\n\nThis function is useful for control of master/slave synchronization. It\nblocks until the slave has read and applied all updates up to the\nspecified position in the master log. The return value is the number of\nlog events the slave had to wait for to advance to the specified\nposition. The function returns NULL if the slave SQL thread is not\nstarted, the slave\'s master information is not initialized, the\narguments are incorrect, or an error occurs. It returns -1 if the\ntimeout has been exceeded. If the slave SQL thread stops while\nMASTER_POS_WAIT() is waiting, the function returns NULL. If the slave\nis past the specified position, the function returns immediately.\n\nIf a timeout value is specified, MASTER_POS_WAIT() stops waiting when\ntimeout seconds have elapsed. timeout must be greater than 0; a zero or\nnegative timeout means no timeout.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(28,'REGEXP',38,'Syntax:\nexpr REGEXP pat, expr RLIKE pat\n\nPerforms a pattern match of a string expression expr against a pattern\npat. The pattern can be an extended regular expression. The syntax for\nregular expressions is discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/regexp.html. Returns 1 if expr\nmatches pat; otherwise it returns 0. If either expr or pat is NULL, the\nresult is NULL. RLIKE is a synonym for REGEXP, provided for mSQL\ncompatibility.\n\nThe pattern need not be a literal string. For example, it can be\nspecified as a string expression or table column.\n\n*Note*: Because MySQL uses the C escape syntax in strings (for example,\n\"\\n\" to represent the newline character), you must double any \"\\\" that\nyou use in your REGEXP strings.\n\nREGEXP is not case sensitive, except when used with binary strings.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/regexp.html\n\n','mysql> SELECT \'Monty!\' REGEXP \'.*\';\n        -> 1\nmysql> SELECT \'new*\\n*line\' REGEXP \'new\\\\*.\\\\*line\';\n        -> 1\nmysql> SELECT \'a\' REGEXP \'A\', \'a\' REGEXP BINARY \'A\';\n        -> 1  0\nmysql> SELECT \'a\' REGEXP \'^[a-d]\';\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/regexp.html'),(29,'IF STATEMENT',24,'Syntax:\nIF search_condition THEN statement_list\n    [ELSEIF search_condition THEN statement_list] ...\n    [ELSE statement_list]\nEND IF\n\nThe IF statement for stored programs implements a basic conditional\nconstruct.\n\n*Note*: There is also an IF() function, which differs from the IF\nstatement described here. See\nhttp://dev.mysql.com/doc/refman/5.1/en/control-flow-functions.html. The\nIF statement can have THEN, ELSE, and ELSEIF clauses, and it is\nterminated with END IF.\n\nIf the search_condition evaluates to true, the corresponding THEN or\nELSEIF clause statement_list executes. If no search_condition matches,\nthe ELSE clause statement_list executes.\n\nEach statement_list consists of one or more SQL statements; an empty\nstatement_list is not permitted.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/if.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/if.html'),(30,'^',20,'Syntax:\n^\n\nBitwise XOR:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html\n\n','mysql> SELECT 1 ^ 1;\n        -> 0\nmysql> SELECT 1 ^ 0;\n        -> 1\nmysql> SELECT 11 ^ 3;\n        -> 8\n','http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html'),(31,'DROP VIEW',40,'Syntax:\nDROP VIEW [IF EXISTS]\n    view_name [, view_name] ...\n    [RESTRICT | CASCADE]\n\nDROP VIEW removes one or more views. You must have the DROP privilege\nfor each view. If any of the views named in the argument list do not\nexist, MySQL returns an error indicating by name which nonexisting\nviews it was unable to drop, but it also drops all of the views in the\nlist that do exist.\n\nThe IF EXISTS clause prevents an error from occurring for views that\ndon\'t exist. When this clause is given, a NOTE is generated for each\nnonexistent view. See [HELP SHOW WARNINGS].\n\nRESTRICT and CASCADE, if given, are parsed and ignored.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-view.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-view.html'),(32,'WITHIN',31,'Within(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 is spatially within g2. This\ntests the opposite relationship as Contains().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(33,'WEEK',32,'Syntax:\nWEEK(date[,mode])\n\nThis function returns the week number for date. The two-argument form\nof WEEK() enables you to specify whether the week starts on Sunday or\nMonday and whether the return value should be in the range from 0 to 53\nor from 1 to 53. If the mode argument is omitted, the value of the\ndefault_week_format system variable is used. See\nhttp://dev.mysql.com/doc/refman/5.1/en/server-system-variables.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT WEEK(\'2008-02-20\');\n        -> 7\nmysql> SELECT WEEK(\'2008-02-20\',0);\n        -> 7\nmysql> SELECT WEEK(\'2008-02-20\',1);\n        -> 8\nmysql> SELECT WEEK(\'2008-12-31\',1);\n        -> 53\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(34,'SHOW PLUGINS',27,'Syntax:\nSHOW PLUGINS\n\nSHOW PLUGINS displays information about server plugins. Plugin\ninformation is also available in the INFORMATION_SCHEMA.PLUGINS table.\nSee http://dev.mysql.com/doc/refman/5.1/en/plugins-table.html.\n\nExample of SHOW PLUGINS output:\n\nmysql> SHOW PLUGINS\\G\n*************************** 1. row ***************************\n   Name: binlog\n Status: ACTIVE\n   Type: STORAGE ENGINE\nLibrary: NULL\nLicense: GPL\n*************************** 2. row ***************************\n   Name: CSV\n Status: ACTIVE\n   Type: STORAGE ENGINE\nLibrary: NULL\nLicense: GPL\n*************************** 3. row ***************************\n   Name: MEMORY\n Status: ACTIVE\n   Type: STORAGE ENGINE\nLibrary: NULL\nLicense: GPL\n*************************** 4. row ***************************\n   Name: MyISAM\n Status: ACTIVE\n   Type: STORAGE ENGINE\nLibrary: NULL\nLicense: GPL\n...\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-plugins.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-plugins.html'),(35,'DROP FUNCTION UDF',22,'Syntax:\nDROP FUNCTION function_name\n\nThis statement drops the user-defined function (UDF) named\nfunction_name.\n\nTo drop a function, you must have the DELETE privilege for the mysql\ndatabase. This is because DROP FUNCTION removes a row from the\nmysql.func system table that records the function\'s name, type, and\nshared library name.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-function-udf.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-function-udf.html'),(36,'PREPARE',8,'Syntax:\nPREPARE stmt_name FROM preparable_stmt\n\nThe PREPARE statement prepares a SQL statement and assigns it a name,\nstmt_name, by which to refer to the statement later. The prepared\nstatement is executed with EXECUTE and released with DEALLOCATE\nPREPARE. For examples, see\nhttp://dev.mysql.com/doc/refman/5.1/en/sql-syntax-prepared-statements.h\ntml.\n\nStatement names are not case sensitive. preparable_stmt is either a\nstring literal or a user variable that contains the text of the SQL\nstatement. The text must represent a single statement, not multiple\nstatements. Within the statement, ? characters can be used as parameter\nmarkers to indicate where data values are to be bound to the query\nlater when you execute it. The ? characters should not be enclosed\nwithin quotation marks, even if you intend to bind them to string\nvalues. Parameter markers can be used only where data values should\nappear, not for SQL keywords, identifiers, and so forth.\n\nIf a prepared statement with the given name already exists, it is\ndeallocated implicitly before the new statement is prepared. This means\nthat if the new statement contains an error and cannot be prepared, an\nerror is returned and no statement with the given name exists.\n\nThe scope of a prepared statement is the session within which it is\ncreated, which as several implications:\n\no A prepared statement created in one session is not available to other\n  sessions.\n\no When a session ends, whether normally or abnormally, its prepared\n  statements no longer exist. If auto-reconnect is enabled, the client\n  is not notified that the connection was lost. For this reason,\n  clients may wish to disable auto-reconnect. See\n  http://dev.mysql.com/doc/refman/5.1/en/auto-reconnect.html.\n\no A prepared statement created within a stored program continues to\n  exist after the program finishes executing and can be executed\n  outside the program later.\n\no A statement prepared in stored program context cannot refer to stored\n  procedure or function parameters or local variables because they go\n  out of scope when the program ends and would be unavailable were the\n  statement to be executed later outside the program. As a workaround,\n  refer instead to user-defined variables, which also have session\n  scope; see\n  http://dev.mysql.com/doc/refman/5.1/en/user-variables.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/prepare.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/prepare.html'),(37,'LOCK',8,'Syntax:\nLOCK TABLES\n    tbl_name [[AS] alias] lock_type\n    [, tbl_name [[AS] alias] lock_type] ...\n\nlock_type:\n    READ [LOCAL]\n  | [LOW_PRIORITY] WRITE\n\nUNLOCK TABLES\n\nMySQL enables client sessions to acquire table locks explicitly for the\npurpose of cooperating with other sessions for access to tables, or to\nprevent other sessions from modifying tables during periods when a\nsession requires exclusive access to them. A session can acquire or\nrelease locks only for itself. One session cannot acquire locks for\nanother session or release locks held by another session.\n\nLocks may be used to emulate transactions or to get more speed when\nupdating tables. This is explained in more detail later in this\nsection.\n\nLOCK TABLES explicitly acquires table locks for the current client\nsession. Table locks can be acquired for base tables or views. You must\nhave the LOCK TABLES privilege, and the SELECT privilege for each\nobject to be locked.\n\nFor view locking, LOCK TABLES adds all base tables used in the view to\nthe set of tables to be locked and locks them automatically. If you\nlock a table explicitly with LOCK TABLES, any tables used in triggers\nare also locked implicitly, as described in\nhttp://dev.mysql.com/doc/refman/5.1/en/lock-tables-and-triggers.html.\n\nUNLOCK TABLES explicitly releases any table locks held by the current\nsession. LOCK TABLES implicitly releases any table locks held by the\ncurrent session before acquiring new locks.\n\nAnother use for UNLOCK TABLES is to release the global read lock\nacquired with the FLUSH TABLES WITH READ LOCK statement, which enables\nyou to lock all tables in all databases. See [HELP FLUSH]. (This is a\nvery convenient way to get backups if you have a file system such as\nVeritas that can take snapshots in time.)\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/lock-tables.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/lock-tables.html'),(38,'UPDATEXML',38,'Syntax:\nUpdateXML(xml_target, xpath_expr, new_xml)\n\nThis function replaces a single portion of a given fragment of XML\nmarkup xml_target with a new XML fragment new_xml, and then returns the\nchanged XML. The portion of xml_target that is replaced matches an\nXPath expression xpath_expr supplied by the user. In MySQL 5.1, the\nXPath expression can contain at most 127 characters. (This limitation\nis lifted in MySQL 5.6.)\n\nIf no expression matching xpath_expr is found, or if multiple matches\nare found, the function returns the original xml_target XML fragment.\nAll three arguments should be strings.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/xml-functions.html\n\n','mysql> SELECT\n    ->   UpdateXML(\'<a><b>ccc</b><d></d></a>\', \'/a\', \'<e>fff</e>\') AS val1,\n    ->   UpdateXML(\'<a><b>ccc</b><d></d></a>\', \'/b\', \'<e>fff</e>\') AS val2,\n    ->   UpdateXML(\'<a><b>ccc</b><d></d></a>\', \'//b\', \'<e>fff</e>\') AS val3,\n    ->   UpdateXML(\'<a><b>ccc</b><d></d></a>\', \'/a/d\', \'<e>fff</e>\') AS val4,\n    ->   UpdateXML(\'<a><d></d><b>ccc</b><d></d></a>\', \'/a/d\', \'<e>fff</e>\') AS val5\n    -> \\G\n\n*************************** 1. row ***************************\nval1: <e>fff</e>\nval2: <a><b>ccc</b><d></d></a>\nval3: <a><e>fff</e><d></d></a>\nval4: <a><b>ccc</b><e>fff</e></a>\nval5: <a><d></d><b>ccc</b><d></d></a>\n','http://dev.mysql.com/doc/refman/5.1/en/xml-functions.html'),(39,'RESET SLAVE',8,'Syntax:\nRESET SLAVE\n\nRESET SLAVE makes the slave forget its replication position in the\nmaster\'s binary log. This statement is meant to be used for a clean\nstart: It deletes the master.info and relay-log.info files, all the\nrelay log files, and starts a new relay log file. To use RESET SLAVE,\nthe slave replication threads must be stopped (use STOP SLAVE if\nnecessary).\n\n*Note*: All relay log files are deleted, even if they have not been\ncompletely executed by the slave SQL thread. (This is a condition\nlikely to exist on a replication slave if you have issued a STOP SLAVE\nstatement or if the slave is highly loaded.)\n\nIf any startup options for setting connection parameters (such as\nmaster host, master port, master user, and master password) are in use,\nthen any corresponding connection information stored in the master.info\nfile is immediately reset using the values specified for these options.\nOptions for which values are not specified are cleared. However, since\nthese options are deprecated in MySQL 5.1 and removed altogether from\nMySQL 5.5, you are encouraged to use a CHANGE MASTER TO statement\ninstead to reset the connection parameters. (If you do not use the\nstartup options, you must issue CHANGE MASTER TO in such cases if you\ndo not want the connection settings to be cleared.)\n\nIf the slave SQL thread was in the middle of replicating temporary\ntables when it was stopped, and RESET SLAVE is issued, these replicated\ntemporary tables are deleted on the slave.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/reset-slave.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/reset-slave.html'),(40,'SHOW BINARY LOGS',27,'Syntax:\nSHOW BINARY LOGS\nSHOW MASTER LOGS\n\nLists the binary log files on the server. This statement is used as\npart of the procedure described in [HELP PURGE BINARY LOGS], that shows\nhow to determine which logs can be purged.\n\nmysql> SHOW BINARY LOGS;\n+---------------+-----------+\n| Log_name      | File_size |\n+---------------+-----------+\n| binlog.000015 |    724935 |\n| binlog.000016 |    733481 |\n+---------------+-----------+\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-binary-logs.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-binary-logs.html'),(41,'POLYGON',25,'Polygon(ls1,ls2,...)\n\nConstructs a Polygon value from a number of LineString or WKB\nLineString arguments. If any argument does not represent a LinearRing\n(that is, not a closed and simple LineString), the return value is\nNULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(42,'MINUTE',32,'Syntax:\nMINUTE(time)\n\nReturns the minute for time, in the range 0 to 59.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT MINUTE(\'2008-02-03 10:05:03\');\n        -> 5\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(43,'DAY',32,'Syntax:\nDAY(date)\n\nDAY() is a synonym for DAYOFMONTH().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(44,'MID',38,'Syntax:\nMID(str,pos,len)\n\nMID(str,pos,len) is a synonym for SUBSTRING(str,pos,len).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(45,'UUID',14,'Syntax:\nUUID()\n\nReturns a Universal Unique Identifier (UUID) generated according to\n\"DCE 1.1: Remote Procedure Call\" (Appendix A) CAE (Common Applications\nEnvironment) Specifications published by The Open Group in October 1997\n(Document Number C706,\nhttp://www.opengroup.org/public/pubs/catalog/c706.htm).\n\nA UUID is designed as a number that is globally unique in space and\ntime. Two calls to UUID() are expected to generate two different\nvalues, even if these calls are performed on two separate computers\nthat are not connected to each other.\n\nA UUID is a 128-bit number represented by a utf8 string of five\nhexadecimal numbers in aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee format:\n\no The first three numbers are generated from a timestamp.\n\no The fourth number preserves temporal uniqueness in case the timestamp\n  value loses monotonicity (for example, due to daylight saving time).\n\no The fifth number is an IEEE 802 node number that provides spatial\n  uniqueness. A random number is substituted if the latter is not\n  available (for example, because the host computer has no Ethernet\n  card, or we do not know how to find the hardware address of an\n  interface on your operating system). In this case, spatial uniqueness\n  cannot be guaranteed. Nevertheless, a collision should have very low\n  probability.\n\n  Currently, the MAC address of an interface is taken into account only\n  on FreeBSD and Linux. On other operating systems, MySQL uses a\n  randomly generated 48-bit number.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','mysql> SELECT UUID();\n        -> \'6ccd780c-baba-1026-9564-0040f4311e29\'\n','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(46,'LINESTRING',25,'LineString(pt1,pt2,...)\n\nConstructs a LineString value from a number of Point or WKB Point\narguments. If the number of arguments is less than two, the return\nvalue is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(47,'SLEEP',14,'Syntax:\nSLEEP(duration)\n\nSleeps (pauses) for the number of seconds given by the duration\nargument, then returns 0. If SLEEP() is interrupted, it returns 1. The\nduration may have a fractional part.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(48,'CONNECTION_ID',17,'Syntax:\nCONNECTION_ID()\n\nReturns the connection ID (thread ID) for the connection. Every\nconnection has an ID that is unique among the set of currently\nconnected clients.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> SELECT CONNECTION_ID();\n        -> 23786\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(49,'CREATE LOGFILE GROUP',40,'Syntax:\nCREATE LOGFILE GROUP logfile_group\n    ADD UNDOFILE \'undo_file\'\n    [INITIAL_SIZE [=] initial_size]\n    [UNDO_BUFFER_SIZE [=] undo_buffer_size]\n    [REDO_BUFFER_SIZE [=] redo_buffer_size]\n    [NODEGROUP [=] nodegroup_id]\n    [WAIT]\n    [COMMENT [=] comment_text]\n    ENGINE [=] engine_name\n\nThis statement creates a new log file group named logfile_group having\na single UNDO file named \'undo_file\'. A CREATE LOGFILE GROUP statement\nhas one and only one ADD UNDOFILE clause. For rules covering the naming\nof log file groups, see\nhttp://dev.mysql.com/doc/refman/5.1/en/identifiers.html.\n\n*Note*: All MySQL Cluster Disk Data objects share the same namespace.\nThis means that each Disk Data object must be uniquely named (and not\nmerely each Disk Data object of a given type). For example, you cannot\nhave a tablespace and a log file group with the same name, or a\ntablespace and a data file with the same name.\n\nBeginning with MySQL 5.1.8, you can have only one log file group per\nCluster at any given time. (See Bug #16386)\n\nPrior to MySQL Cluster NDB 6.2.17, 6.3.23, and 6.4.3, path and file\nnames for undo log files could not be longer than 128 characters. (Bug\n#31769)\n\nThe optional INITIAL_SIZE parameter sets the UNDO file\'s initial size;\nif not specified, it defaults to 128M (128 megabytes). The optional\nUNDO_BUFFER_SIZE parameter sets the size used by the UNDO buffer for\nthe log file group; The default value for UNDO_BUFFER_SIZE is 8M (eight\nmegabytes); this value cannot exceed the amount of system memory\navailable. Both of these parameters are specified in bytes. You may\noptionally follow either or both of these with a one-letter\nabbreviation for an order of magnitude, similar to those used in\nmy.cnf. Generally, this is one of the letters M (for megabytes) or G\n(for gigabytes).\n\nThe memory used for both INITIAL_SIZE and UNDO_BUFFER_SIZE comes from\nthe global pool whose size is determined by the value of the\nSharedGlobalMemory data node configuration parameter. This includes any\ndefault value implied for these options by the setting of the\nInitialLogFileGroup data node configuration parameter.\n\nBeginning with MySQL Cluster NDB 6.2.17, 6.3.23, and 6.4.3, the maximum\npermitted for UNDO_BUFFER_SIZE is 600M; previously, it was 150M. (Bug\n#34102)\n\nOn 32-bit systems, the maximum supported value for INITIAL_SIZE is 4G.\n(Bug #29186)\n\nBeginning with MySQL Cluster NDB 2.1.18, 6.3.24, and 7.0.4, the minimum\npermitted value for INITIAL_SIZE is 1M. (Bug #29574)\n\nThe ENGINE option determines the storage engine to be used by this log\nfile group, with engine_name being the name of the storage engine. In\nMySQL 5.1, this must be NDB (or NDBCLUSTER). If ENGINE is not set,\nMySQL tries to use the engine specified by the storage_engine server\nsystem variable. In any case, if the engine is not specified as NDB or\nNDBCLUSTER, the CREATE LOGFILE GROUP statement appears to succeed but\nactually fails to create the log file group, as shown here:\n\nmysql> CREATE LOGFILE GROUP lg1 \n    ->     ADD UNDOFILE \'undo.dat\' INITIAL_SIZE = 10M;\nQuery OK, 0 rows affected, 1 warning (0.00 sec)\n\nmysql> SHOW WARNINGS;\n+-------+------+------------------------------------------------------------------------------------------------+\n| Level | Code | Message                                                                                        |\n+-------+------+------------------------------------------------------------------------------------------------+\n| Error | 1478 | Table storage engine \'MyISAM\' does not support the create option \'TABLESPACE or LOGFILE GROUP\' |\n+-------+------+------------------------------------------------------------------------------------------------+\n1 row in set (0.00 sec)\n\nmysql> DROP LOGFILE GROUP lg1 ENGINE = NDB;              \nERROR 1529 (HY000): Failed to drop LOGFILE GROUP\n\nmysql> CREATE LOGFILE GROUP lg1 \n    ->     ADD UNDOFILE \'undo.dat\' INITIAL_SIZE = 10M\n    ->     ENGINE = NDB;\nQuery OK, 0 rows affected (2.97 sec)\n\nThe fact that the CREATE LOGFILE GROUP statement does not actually\nreturn an error when a non-NDB storage engine is named, but rather\nappears to succeed, is a known issue which we hope to address in a\nfuture release of MySQL Cluster.\n\nREDO_BUFFER_SIZE, NODEGROUP, WAIT, and COMMENT are parsed but ignored,\nand so have no effect in MySQL 5.1. These options are intended for\nfuture expansion.\n\nWhen used with ENGINE [=] NDB, a log file group and associated UNDO log\nfile are created on each Cluster data node. You can verify that the\nUNDO files were created and obtain information about them by querying\nthe INFORMATION_SCHEMA.FILES table. For example:\n\nmysql> SELECT LOGFILE_GROUP_NAME, LOGFILE_GROUP_NUMBER, EXTRA\n    -> FROM INFORMATION_SCHEMA.FILES\n    -> WHERE FILE_NAME = \'undo_10.dat\';\n+--------------------+----------------------+----------------+\n| LOGFILE_GROUP_NAME | LOGFILE_GROUP_NUMBER | EXTRA          |\n+--------------------+----------------------+----------------+\n| lg_3               |                   11 | CLUSTER_NODE=3 |\n| lg_3               |                   11 | CLUSTER_NODE=4 |\n+--------------------+----------------------+----------------+\n2 rows in set (0.06 sec)\n\nCREATE LOGFILE GROUP was added in MySQL 5.1.6. In MySQL 5.1, it is\nuseful only with Disk Data storage for MySQL Cluster. See\nhttp://dev.mysql.com/doc/refman/5.1/en/mysql-cluster-disk-data.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-logfile-group.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-logfile-group.html'),(50,'DELETE',28,'Syntax:\nSingle-table syntax:\n\nDELETE [LOW_PRIORITY] [QUICK] [IGNORE] FROM tbl_name\n    [WHERE where_condition]\n    [ORDER BY ...]\n    [LIMIT row_count]\n\nMultiple-table syntax:\n\nDELETE [LOW_PRIORITY] [QUICK] [IGNORE]\n    tbl_name[.*] [, tbl_name[.*]] ...\n    FROM table_references\n    [WHERE where_condition]\n\nOr:\n\nDELETE [LOW_PRIORITY] [QUICK] [IGNORE]\n    FROM tbl_name[.*] [, tbl_name[.*]] ...\n    USING table_references\n    [WHERE where_condition]\n\nFor the single-table syntax, the DELETE statement deletes rows from\ntbl_name and returns a count of the number of deleted rows. This count\ncan be obtained by calling the ROW_COUNT() function (see\nhttp://dev.mysql.com/doc/refman/5.1/en/information-functions.html). The\nWHERE clause, if given, specifies the conditions that identify which\nrows to delete. With no WHERE clause, all rows are deleted. If the\nORDER BY clause is specified, the rows are deleted in the order that is\nspecified. The LIMIT clause places a limit on the number of rows that\ncan be deleted.\n\nFor the multiple-table syntax, DELETE deletes from each tbl_name the\nrows that satisfy the conditions. In this case, ORDER BY and LIMIT\ncannot be used.\n\nwhere_condition is an expression that evaluates to true for each row to\nbe deleted. It is specified as described in\nhttp://dev.mysql.com/doc/refman/5.1/en/select.html.\n\nCurrently, you cannot delete from a table and select from the same\ntable in a subquery.\n\nYou need the DELETE privilege on a table to delete rows from it. You\nneed only the SELECT privilege for any columns that are only read, such\nas those named in the WHERE clause.\n\nAs stated, a DELETE statement with no WHERE clause deletes all rows. A\nfaster way to do this, when you do not need to know the number of\ndeleted rows, is to use TRUNCATE TABLE. However, within a transaction\nor if you have a lock on the table, TRUNCATE TABLE cannot be used\nwhereas DELETE can. See [HELP TRUNCATE TABLE], and [HELP LOCK].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/delete.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/delete.html'),(51,'ROUND',4,'Syntax:\nROUND(X), ROUND(X,D)\n\nRounds the argument X to D decimal places. The rounding algorithm\ndepends on the data type of X. D defaults to 0 if not specified. D can\nbe negative to cause D digits left of the decimal point of the value X\nto become zero.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT ROUND(-1.23);\n        -> -1\nmysql> SELECT ROUND(-1.58);\n        -> -2\nmysql> SELECT ROUND(1.58);\n        -> 2\nmysql> SELECT ROUND(1.298, 1);\n        -> 1.3\nmysql> SELECT ROUND(1.298, 0);\n        -> 1\nmysql> SELECT ROUND(23.298, -1);\n        -> 20\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(52,'NULLIF',7,'Syntax:\nNULLIF(expr1,expr2)\n\nReturns NULL if expr1 = expr2 is true, otherwise returns expr1. This is\nthe same as CASE WHEN expr1 = expr2 THEN NULL ELSE expr1 END.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/control-flow-functions.html\n\n','mysql> SELECT NULLIF(1,1);\n        -> NULL\nmysql> SELECT NULLIF(1,2);\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/control-flow-functions.html'),(53,'CLOSE',24,'Syntax:\nCLOSE cursor_name\n\nThis statement closes a previously opened cursor. For an example, see\nhttp://dev.mysql.com/doc/refman/5.1/en/cursors.html.\n\nAn error occurs if the cursor is not open.\n\nIf not closed explicitly, a cursor is closed at the end of the BEGIN\n... END block in which it was declared.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/close.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/close.html'),(54,'STOP SLAVE',8,'Syntax:\nSTOP SLAVE [thread_types]\n\nthread_types:\n    [thread_type [, thread_type] ... ]\n\nthread_type: IO_THREAD | SQL_THREAD\n\nStops the slave threads. STOP SLAVE requires the SUPER privilege.\nRecommended best practice is to execute STOP SLAVE on the slave before\nstopping the slave server (see\nhttp://dev.mysql.com/doc/refman/5.1/en/server-shutdown.html, for more\ninformation).\n\nWhen using the row-based logging format: Prior to MySQL 5.1.35, you\nshould always execute STOP SLAVE on the slave before stopping the slave\nserver to help avoid the possibility of an inconsistent slave; in MySQL\n5.1.35 and later, you should execute this statement on the slave prior\nto shutting down the slave server if you are replicating any tables\nthat use a nontransactional storage engine (see the Note later in this\nsection). In MySQL 5.1.55 and later, you can also use STOP SLAVE\nSQL_THREAD for this purpose.\n\nLike START SLAVE, this statement may be used with the IO_THREAD and\nSQL_THREAD options to name the thread or threads to be stopped.\n\n*Note*: The transactional behavior of STOP SLAVE changed in MySQL\n5.1.35. Previously, it took effect immediately. Beginning with MySQL\n5.1.35, it waits until any current replication event group affecting\none or more nontransactional tables has finished executing (if there is\nany such replication group), or until the user issues a KILL QUERY or\nKILL CONNECTION statement. (Bug #319, Bug #38205)\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/stop-slave.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/stop-slave.html'),(55,'TIMEDIFF',32,'Syntax:\nTIMEDIFF(expr1,expr2)\n\nTIMEDIFF() returns expr1 - expr2 expressed as a time value. expr1 and\nexpr2 are time or date-and-time expressions, but both must be of the\nsame type.\n\nThe result returned by TIMEDIFF() is limited to the range allowed for\nTIME values. Alternatively, you can use either of the functions\nTIMESTAMPDIFF() and UNIX_TIMESTAMP(), both of which return integers.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT TIMEDIFF(\'2000:01:01 00:00:00\',\n    ->                 \'2000:01:01 00:00:00.000001\');\n        -> \'-00:00:00.000001\'\nmysql> SELECT TIMEDIFF(\'2008-12-31 23:59:59.000001\',\n    ->                 \'2008-12-30 01:01:01.000002\');\n        -> \'46:58:57.999999\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(56,'REPLACE FUNCTION',38,'Syntax:\nREPLACE(str,from_str,to_str)\n\nReturns the string str with all occurrences of the string from_str\nreplaced by the string to_str. REPLACE() performs a case-sensitive\nmatch when searching for from_str.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT REPLACE(\'www.mysql.com\', \'w\', \'Ww\');\n        -> \'WwWwWw.mysql.com\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(57,'USE',29,'Syntax:\nUSE db_name\n\nThe USE db_name statement tells MySQL to use the db_name database as\nthe default (current) database for subsequent statements. The database\nremains the default until the end of the session or another USE\nstatement is issued:\n\nUSE db1;\nSELECT COUNT(*) FROM mytable;   # selects from db1.mytable\nUSE db2;\nSELECT COUNT(*) FROM mytable;   # selects from db2.mytable\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/use.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/use.html'),(58,'LINEFROMTEXT',3,'LineFromText(wkt[,srid]), LineStringFromText(wkt[,srid])\n\nConstructs a LINESTRING value using its WKT representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(59,'CASE OPERATOR',7,'Syntax:\nCASE value WHEN [compare_value] THEN result [WHEN [compare_value] THEN\nresult ...] [ELSE result] END\n\nCASE WHEN [condition] THEN result [WHEN [condition] THEN result ...]\n[ELSE result] END\n\nThe first version returns the result where value=compare_value. The\nsecond version returns the result for the first condition that is true.\nIf there was no matching result value, the result after ELSE is\nreturned, or NULL if there is no ELSE part.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/control-flow-functions.html\n\n','mysql> SELECT CASE 1 WHEN 1 THEN \'one\'\n    ->     WHEN 2 THEN \'two\' ELSE \'more\' END;\n        -> \'one\'\nmysql> SELECT CASE WHEN 1>0 THEN \'true\' ELSE \'false\' END;\n        -> \'true\'\nmysql> SELECT CASE BINARY \'B\'\n    ->     WHEN \'a\' THEN 1 WHEN \'b\' THEN 2 END;\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/control-flow-functions.html'),(60,'SHOW MASTER STATUS',27,'Syntax:\nSHOW MASTER STATUS\n\nThis statement provides status information about the binary log files\nof the master. It requires either the SUPER or REPLICATION CLIENT\nprivilege.\n\nExample:\n\nmysql> SHOW MASTER STATUS;\n+---------------+----------+--------------+------------------+\n| File          | Position | Binlog_Do_DB | Binlog_Ignore_DB |\n+---------------+----------+--------------+------------------+\n| mysql-bin.003 | 73       | test         | manual,mysql     |\n+---------------+----------+--------------+------------------+\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-master-status.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-master-status.html'),(61,'ADDTIME',32,'Syntax:\nADDTIME(expr1,expr2)\n\nADDTIME() adds expr2 to expr1 and returns the result. expr1 is a time\nor datetime expression, and expr2 is a time expression.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT ADDTIME(\'2007-12-31 23:59:59.999999\', \'1 1:1:1.000002\');\n        -> \'2008-01-02 01:01:01.000001\'\nmysql> SELECT ADDTIME(\'01:00:00.999999\', \'02:00:00.999998\');\n        -> \'03:00:01.999997\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(62,'SPATIAL',35,'For MyISAM tables, MySQL can create spatial indexes using syntax\nsimilar to that for creating regular indexes, but extended with the\nSPATIAL keyword. Currently, columns in spatial indexes must be declared\nNOT NULL. The following examples demonstrate how to create spatial\nindexes:\n\no With CREATE TABLE:\n\nCREATE TABLE geom (g GEOMETRY NOT NULL, SPATIAL INDEX(g)) ENGINE=MyISAM;\n\no With ALTER TABLE:\n\nALTER TABLE geom ADD SPATIAL INDEX(g);\n\no With CREATE INDEX:\n\nCREATE SPATIAL INDEX sp_index ON geom (g);\n\nFor MyISAM tables, SPATIAL INDEX creates an R-tree index. For storage\nengines that support nonspatial indexing of spatial columns, the engine\ncreates a B-tree index. A B-tree index on spatial values will be useful\nfor exact-value lookups, but not for range scans.\n\nFor more information on indexing spatial columns, see [HELP CREATE\nINDEX].\n\nTo drop spatial indexes, use ALTER TABLE or DROP INDEX:\n\no With ALTER TABLE:\n\nALTER TABLE geom DROP INDEX g;\n\no With DROP INDEX:\n\nDROP INDEX sp_index ON geom;\n\nExample: Suppose that a table geom contains more than 32,000\ngeometries, which are stored in the column g of type GEOMETRY. The\ntable also has an AUTO_INCREMENT column fid for storing object ID\nvalues.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-indexes.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-indexes.html'),(63,'TIMESTAMPDIFF',32,'Syntax:\nTIMESTAMPDIFF(unit,datetime_expr1,datetime_expr2)\n\nReturns datetime_expr2 - datetime_expr1, where datetime_expr1 and\ndatetime_expr2 are date or datetime expressions. One expression may be\na date and the other a datetime; a date value is treated as a datetime\nhaving the time part \'00:00:00\' where necessary. The unit for the\nresult (an integer) is given by the unit argument. The legal values for\nunit are the same as those listed in the description of the\nTIMESTAMPADD() function.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT TIMESTAMPDIFF(MONTH,\'2003-02-01\',\'2003-05-01\');\n        -> 3\nmysql> SELECT TIMESTAMPDIFF(YEAR,\'2002-05-01\',\'2001-01-01\');\n        -> -1\nmysql> SELECT TIMESTAMPDIFF(MINUTE,\'2003-02-01\',\'2003-05-01 12:05:55\');\n        -> 128885\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(64,'UPPER',38,'Syntax:\nUPPER(str)\n\nReturns the string str with all characters changed to uppercase\naccording to the current character set mapping. The default is latin1\n(cp1252 West European).\n\nmysql> SELECT UPPER(\'Hej\');\n        -> \'HEJ\'\n\nSee the description of LOWER() for information that also applies to\nUPPER(), such as information about how to perform lettercase conversion\nof binary strings (BINARY, VARBINARY, BLOB) for which these functions\nare ineffective.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(65,'FROM_UNIXTIME',32,'Syntax:\nFROM_UNIXTIME(unix_timestamp), FROM_UNIXTIME(unix_timestamp,format)\n\nReturns a representation of the unix_timestamp argument as a value in\n\'YYYY-MM-DD HH:MM:SS\' or YYYYMMDDHHMMSS.uuuuuu format, depending on\nwhether the function is used in a string or numeric context. The value\nis expressed in the current time zone. unix_timestamp is an internal\ntimestamp value such as is produced by the UNIX_TIMESTAMP() function.\n\nIf format is given, the result is formatted according to the format\nstring, which is used the same way as listed in the entry for the\nDATE_FORMAT() function.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT FROM_UNIXTIME(1196440219);\n        -> \'2007-11-30 10:30:19\'\nmysql> SELECT FROM_UNIXTIME(1196440219) + 0;\n        -> 20071130103019.000000\nmysql> SELECT FROM_UNIXTIME(UNIX_TIMESTAMP(),\n    ->                      \'%Y %D %M %h:%i:%s %x\');\n        -> \'2007 30th November 10:30:59 2007\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(66,'MEDIUMBLOB',23,'MEDIUMBLOB\n\nA BLOB column with a maximum length of 16,777,215 (224 - 1) bytes. Each\nMEDIUMBLOB value is stored using a 3-byte length prefix that indicates\nthe number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(67,'IFNULL',7,'Syntax:\nIFNULL(expr1,expr2)\n\nIf expr1 is not NULL, IFNULL() returns expr1; otherwise it returns\nexpr2. IFNULL() returns a numeric or string value, depending on the\ncontext in which it is used.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/control-flow-functions.html\n\n','mysql> SELECT IFNULL(1,0);\n        -> 1\nmysql> SELECT IFNULL(NULL,10);\n        -> 10\nmysql> SELECT IFNULL(1/0,10);\n        -> 10\nmysql> SELECT IFNULL(1/0,\'yes\');\n        -> \'yes\'\n','http://dev.mysql.com/doc/refman/5.1/en/control-flow-functions.html'),(68,'SHOW FUNCTION CODE',27,'Syntax:\nSHOW FUNCTION CODE func_name\n\nThis statement is similar to SHOW PROCEDURE CODE but for stored\nfunctions. See [HELP SHOW PROCEDURE CODE].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-function-code.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-function-code.html'),(69,'SHOW ERRORS',27,'Syntax:\nSHOW ERRORS [LIMIT [offset,] row_count]\nSHOW COUNT(*) ERRORS\n\nSHOW ERRORS is a diagnostic statement that is similar to SHOW WARNINGS,\nexcept that it displays information only for errors, rather than for\nerrors, warnings, and notes.\n\nThe LIMIT clause has the same syntax as for the SELECT statement. See\nhttp://dev.mysql.com/doc/refman/5.1/en/select.html.\n\nThe SHOW COUNT(*) ERRORS statement displays the number of errors. You\ncan also retrieve this number from the error_count variable:\n\nSHOW COUNT(*) ERRORS;\nSELECT @@error_count;\n\nSHOW ERRORS and error_count apply only to errors, not warnings or\nnotes. In other respects, they are similar to SHOW WARNINGS and\nwarning_count. In particular, SHOW ERRORS cannot display information\nfor more than max_error_count messages, and error_count can exceed the\nvalue of max_error_count if the number of errors exceeds\nmax_error_count.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-errors.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-errors.html'),(70,'LEAST',19,'Syntax:\nLEAST(value1,value2,...)\n\nWith two or more arguments, returns the smallest (minimum-valued)\nargument. The arguments are compared using the following rules:\n\no If any argument is NULL, the result is NULL. No comparison is needed.\n\no If the return value is used in an INTEGER context or all arguments\n  are integer-valued, they are compared as integers.\n\no If the return value is used in a REAL context or all arguments are\n  real-valued, they are compared as reals.\n\no If the arguments comprise a mix of numbers and strings, they are\n  compared as numbers.\n\no If any argument is a nonbinary (character) string, the arguments are\n  compared as nonbinary strings.\n\no In all other cases, the arguments are compared as binary strings.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT LEAST(2,0);\n        -> 0\nmysql> SELECT LEAST(34.0,3.0,5.0,767.0);\n        -> 3.0\nmysql> SELECT LEAST(\'B\',\'A\',\'C\');\n        -> \'A\'\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(71,'=',19,'=\n\nEqual:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 1 = 0;\n        -> 0\nmysql> SELECT \'0\' = 0;\n        -> 1\nmysql> SELECT \'0.0\' = 0;\n        -> 1\nmysql> SELECT \'0.01\' = 0;\n        -> 0\nmysql> SELECT \'.01\' = 0.01;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(72,'REVERSE',38,'Syntax:\nREVERSE(str)\n\nReturns the string str with the order of the characters reversed.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT REVERSE(\'abc\');\n        -> \'cba\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(73,'ISNULL',19,'Syntax:\nISNULL(expr)\n\nIf expr is NULL, ISNULL() returns 1, otherwise it returns 0.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT ISNULL(1+1);\n        -> 0\nmysql> SELECT ISNULL(1/0);\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(74,'BINARY',23,'BINARY(M)\n\nThe BINARY type is similar to the CHAR type, but stores binary byte\nstrings rather than nonbinary character strings. M represents the\ncolumn length in bytes.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(75,'BLOB DATA TYPE',23,'A BLOB is a binary large object that can hold a variable amount of\ndata. The four BLOB types are TINYBLOB, BLOB, MEDIUMBLOB, and LONGBLOB.\nThese differ only in the maximum length of the values they can hold.\nThe four TEXT types are TINYTEXT, TEXT, MEDIUMTEXT, and LONGTEXT. These\ncorrespond to the four BLOB types and have the same maximum lengths and\nstorage requirements. See\nhttp://dev.mysql.com/doc/refman/5.1/en/storage-requirements.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/blob.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/blob.html'),(76,'BOUNDARY',37,'Boundary(g)\n\nReturns a geometry that is the closure of the combinatorial boundary of\nthe geometry value g.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(77,'CREATE USER',10,'Syntax:\nCREATE USER user_specification\n    [, user_specification] ...\n\nuser_specification:\n    user [IDENTIFIED BY [PASSWORD] \'password\']\n\nThe CREATE USER statement creates new MySQL accounts. To use it, you\nmust have the global CREATE USER privilege or the INSERT privilege for\nthe mysql database. For each account, CREATE USER creates a new row in\nthe mysql.user table and assigns the account no privileges. An error\noccurs if the account already exists.\n\nEach account name uses the format described in\nhttp://dev.mysql.com/doc/refman/5.1/en/account-names.html. For example:\n\nCREATE USER \'jeffrey\'@\'localhost\' IDENTIFIED BY \'mypass\';\n\nIf you specify only the user name part of the account name, a host name\npart of \'%\' is used.\n\nThe user specification may indicate how the user should authenticate\nwhen connecting to the server:\n\no To enable the user to connect with no password (which is insecure),\n  include no IDENTIFIED BY clause:\n\nCREATE USER \'jeffrey\'@\'localhost\';\n\no To assign a password, use IDENTIFIED BY with the literal plaintext\n  password value:\n\nCREATE USER \'jeffrey\'@\'localhost\' IDENTIFIED BY \'mypass\';\n\no To avoid specifying the plaintext password if you know its hash value\n  (the value that PASSWORD() would return for the password), specify\n  the hash value preceded by the keyword PASSWORD:\n\nCREATE USER \'jeffrey\'@\'localhost\'\nIDENTIFIED BY PASSWORD \'*90E462C37378CED12064BB3388827D2BA3A9B689\';\n\nFor additional information about setting passwords, see\nhttp://dev.mysql.com/doc/refman/5.1/en/assigning-passwords.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-user.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-user.html'),(78,'POINT',25,'Point(x,y)\n\nConstructs a Point using its coordinates.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(79,'CURRENT_USER',17,'Syntax:\nCURRENT_USER, CURRENT_USER()\n\nReturns the user name and host name combination for the MySQL account\nthat the server used to authenticate the current client. This account\ndetermines your access privileges. The return value is a string in the\nutf8 character set.\n\nThe value of CURRENT_USER() can differ from the value of USER().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> SELECT USER();\n        -> \'davida@localhost\'\nmysql> SELECT * FROM mysql.user;\nERROR 1044: Access denied for user \'\'@\'localhost\' to\ndatabase \'mysql\'\nmysql> SELECT CURRENT_USER();\n        -> \'@localhost\'\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(80,'LCASE',38,'Syntax:\nLCASE(str)\n\nLCASE() is a synonym for LOWER().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(81,'<=',19,'Syntax:\n<=\n\nLess than or equal:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 0.1 <= 2;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(82,'SHOW PROFILES',27,'Syntax:\nSHOW PROFILES\n\nThe SHOW PROFILES statement, together with SHOW PROFILE, displays\nprofiling information that indicates resource usage for statements\nexecuted during the course of the current session. For more\ninformation, see [HELP SHOW PROFILE].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-profiles.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-profiles.html'),(83,'UPDATE',28,'Syntax:\nSingle-table syntax:\n\nUPDATE [LOW_PRIORITY] [IGNORE] table_reference\n    SET col_name1={expr1|DEFAULT} [, col_name2={expr2|DEFAULT}] ...\n    [WHERE where_condition]\n    [ORDER BY ...]\n    [LIMIT row_count]\n\nMultiple-table syntax:\n\nUPDATE [LOW_PRIORITY] [IGNORE] table_references\n    SET col_name1={expr1|DEFAULT} [, col_name2={expr2|DEFAULT}] ...\n    [WHERE where_condition]\n\nFor the single-table syntax, the UPDATE statement updates columns of\nexisting rows in the named table with new values. The SET clause\nindicates which columns to modify and the values they should be given.\nEach value can be given as an expression, or the keyword DEFAULT to set\na column explicitly to its default value. The WHERE clause, if given,\nspecifies the conditions that identify which rows to update. With no\nWHERE clause, all rows are updated. If the ORDER BY clause is\nspecified, the rows are updated in the order that is specified. The\nLIMIT clause places a limit on the number of rows that can be updated.\n\nFor the multiple-table syntax, UPDATE updates rows in each table named\nin table_references that satisfy the conditions. In this case, ORDER BY\nand LIMIT cannot be used.\n\nwhere_condition is an expression that evaluates to true for each row to\nbe updated. For expression syntax, see\nhttp://dev.mysql.com/doc/refman/5.1/en/expressions.html.\n\ntable_references and where_condition are specified as described in\nhttp://dev.mysql.com/doc/refman/5.1/en/select.html.\n\nYou need the UPDATE privilege only for columns referenced in an UPDATE\nthat are actually updated. You need only the SELECT privilege for any\ncolumns that are read but not modified.\n\nThe UPDATE statement supports the following modifiers:\n\no With the LOW_PRIORITY keyword, execution of the UPDATE is delayed\n  until no other clients are reading from the table. This affects only\n  storage engines that use only table-level locking (such as MyISAM,\n  MEMORY, and MERGE).\n\no With the IGNORE keyword, the update statement does not abort even if\n  errors occur during the update. Rows for which duplicate-key\n  conflicts occur are not updated. Rows for which columns are updated\n  to values that would cause data conversion errors are updated to the\n  closest valid values instead.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/update.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/update.html'),(84,'IS NOT NULL',19,'Syntax:\nIS NOT NULL\n\nTests whether a value is not NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 1 IS NOT NULL, 0 IS NOT NULL, NULL IS NOT NULL;\n        -> 1, 1, 0\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(85,'CASE STATEMENT',24,'Syntax:\nCASE case_value\n    WHEN when_value THEN statement_list\n    [WHEN when_value THEN statement_list] ...\n    [ELSE statement_list]\nEND CASE\n\nOr:\n\nCASE\n    WHEN search_condition THEN statement_list\n    [WHEN search_condition THEN statement_list] ...\n    [ELSE statement_list]\nEND CASE\n\nThe CASE statement for stored programs implements a complex conditional\nconstruct.\n\n*Note*: There is also a CASE expression, which differs from the CASE\nstatement described here. See\nhttp://dev.mysql.com/doc/refman/5.1/en/control-flow-functions.html. The\nCASE statement cannot have an ELSE NULL clause, and it is terminated\nwith END CASE instead of END.\n\nFor the first syntax, case_value is an expression. This value is\ncompared to the when_value expression in each WHEN clause until one of\nthem is equal. When an equal when_value is found, the corresponding\nTHEN clause statement_list executes. If no when_value is equal, the\nELSE clause statement_list executes, if there is one.\n\nThis syntax cannot be used to test for equality with NULL because NULL\n= NULL is false. See\nhttp://dev.mysql.com/doc/refman/5.1/en/working-with-null.html.\n\nFor the second syntax, each WHEN clause search_condition expression is\nevaluated until one is true, at which point its corresponding THEN\nclause statement_list executes. If no search_condition is equal, the\nELSE clause statement_list executes, if there is one.\n\nIf no when_value or search_condition matches the value tested and the\nCASE statement contains no ELSE clause, a Case not found for CASE\nstatement error results.\n\nEach statement_list consists of one or more SQL statements; an empty\nstatement_list is not permitted.\n\nTo handle situations where no value is matched by any WHEN clause, use\nan ELSE containing an empty BEGIN ... END block, as shown in this\nexample. (The indentation used here in the ELSE clause is for purposes\nof clarity only, and is not otherwise significant.)\n\nDELIMITER |\n\nCREATE PROCEDURE p()\n  BEGIN\n    DECLARE v INT DEFAULT 1;\n\n    CASE v\n      WHEN 2 THEN SELECT v;\n      WHEN 3 THEN SELECT 0;\n      ELSE\n        BEGIN\n        END;\n    END CASE;\n  END;\n  |\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/case.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/case.html'),(86,'EXECUTE STATEMENT',8,'Syntax:\nEXECUTE stmt_name\n    [USING @var_name [, @var_name] ...]\n\nAfter preparing a statement with PREPARE, you execute it with an\nEXECUTE statement that refers to the prepared statement name. If the\nprepared statement contains any parameter markers, you must supply a\nUSING clause that lists user variables containing the values to be\nbound to the parameters. Parameter values can be supplied only by user\nvariables, and the USING clause must name exactly as many variables as\nthe number of parameter markers in the statement.\n\nYou can execute a given prepared statement multiple times, passing\ndifferent variables to it or setting the variables to different values\nbefore each execution.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/execute.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/execute.html'),(87,'DROP INDEX',40,'Syntax:\nDROP [ONLINE|OFFLINE] INDEX index_name ON tbl_name\n\nDROP INDEX drops the index named index_name from the table tbl_name.\nThis statement is mapped to an ALTER TABLE statement to drop the index.\nSee [HELP ALTER TABLE].\n\nTo drop a primary key, the index name is always PRIMARY, which must be\nspecified as a quoted identifier because PRIMARY is a reserved word:\n\nDROP INDEX `PRIMARY` ON t;\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-index.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-index.html'),(88,'MATCH AGAINST',38,'Syntax:\nMATCH (col1,col2,...) AGAINST (expr [search_modifier])\n\nMySQL has support for full-text indexing and searching:\n\no A full-text index in MySQL is an index of type FULLTEXT.\n\no Full-text indexes can be used only with MyISAM tables. (In MySQL 5.6\n  and up, they can also be used with InnoDB tables.) Full-text indexes\n  can be created only for CHAR, VARCHAR, or TEXT columns.\n\no A FULLTEXT index definition can be given in the CREATE TABLE\n  statement when a table is created, or added later using ALTER TABLE\n  or CREATE INDEX.\n\no For large data sets, it is much faster to load your data into a table\n  that has no FULLTEXT index and then create the index after that, than\n  to load data into a table that has an existing FULLTEXT index.\n\nFull-text searching is performed using MATCH() ... AGAINST syntax.\nMATCH() takes a comma-separated list that names the columns to be\nsearched. AGAINST takes a string to search for, and an optional\nmodifier that indicates what type of search to perform. The search\nstring must be a string value that is constant during query evaluation.\nThis rules out, for example, a table column because that can differ for\neach row.\n\nThere are three types of full-text searches:\n\no A natural language search interprets the search string as a phrase in\n  natural human language (a phrase in free text). There are no special\n  operators. The stopword list applies. In addition, words that are\n  present in 50% or more of the rows are considered common and do not\n  match.\n\n  Full-text searches are natural language searches if the IN NATURAL\n  LANGUAGE MODE modifier is given or if no modifier is given. For more\n  information, see\n  http://dev.mysql.com/doc/refman/5.1/en/fulltext-natural-language.html\n  .\n\no A boolean search interprets the search string using the rules of a\n  special query language. The string contains the words to search for.\n  It can also contain operators that specify requirements such that a\n  word must be present or absent in matching rows, or that it should be\n  weighted higher or lower than usual. Common words such as \"some\" or\n  \"then\" are stopwords and do not match if present in the search\n  string. The IN BOOLEAN MODE modifier specifies a boolean search. For\n  more information, see\n  http://dev.mysql.com/doc/refman/5.1/en/fulltext-boolean.html.\n\no A query expansion search is a modification of a natural language\n  search. The search string is used to perform a natural language\n  search. Then words from the most relevant rows returned by the search\n  are added to the search string and the search is done again. The\n  query returns the rows from the second search. The IN NATURAL\n  LANGUAGE MODE WITH QUERY EXPANSION or WITH QUERY EXPANSION modifier\n  specifies a query expansion search. For more information, see\n  http://dev.mysql.com/doc/refman/5.1/en/fulltext-query-expansion.html.\n\nThe IN NATURAL LANGUAGE MODE and IN NATURAL LANGUAGE MODE WITH QUERY\nEXPANSION modifiers were added in MySQL 5.1.7.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/fulltext-search.html\n\n','mysql> SELECT id, body, MATCH (title,body) AGAINST\n    -> (\'Security implications of running MySQL as root\'\n    -> IN NATURAL LANGUAGE MODE) AS score\n    -> FROM articles WHERE MATCH (title,body) AGAINST\n    -> (\'Security implications of running MySQL as root\'\n    -> IN NATURAL LANGUAGE MODE);\n+----+-------------------------------------+-----------------+\n| id | body                                | score           |\n+----+-------------------------------------+-----------------+\n|  4 | 1. Never run mysqld as root. 2. ... | 1.5219271183014 |\n|  6 | When configured properly, MySQL ... | 1.3114095926285 |\n+----+-------------------------------------+-----------------+\n2 rows in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.1/en/fulltext-search.html'),(89,'CREATE EVENT',40,'Syntax:\nCREATE\n    [DEFINER = { user | CURRENT_USER }]\n    EVENT\n    [IF NOT EXISTS]\n    event_name\n    ON SCHEDULE schedule\n    [ON COMPLETION [NOT] PRESERVE]\n    [ENABLE | DISABLE | DISABLE ON SLAVE]\n    [COMMENT \'comment\']\n    DO event_body;\n\nschedule:\n    AT timestamp [+ INTERVAL interval] ...\n  | EVERY interval\n    [STARTS timestamp [+ INTERVAL interval] ...]\n    [ENDS timestamp [+ INTERVAL interval] ...]\n\ninterval:\n    quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |\n              WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |\n              DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}\n\nThis statement creates and schedules a new event. The event will not\nrun unless the Event Scheduler is enabled. For information about\nchecking Event Scheduler status and enabling it if necessary, see\nhttp://dev.mysql.com/doc/refman/5.1/en/events-configuration.html.\n\nCREATE EVENT requires the EVENT privilege for the schema in which the\nevent is to be created. It might also require the SUPER privilege,\ndepending on the DEFINER value, as described later in this section.\n\nThe minimum requirements for a valid CREATE EVENT statement are as\nfollows:\n\no The keywords CREATE EVENT plus an event name, which uniquely\n  identifies the event within a database schema. (Prior to MySQL\n  5.1.12, the event name needed to be unique only among events created\n  by the same user within a schema.)\n\no An ON SCHEDULE clause, which determines when and how often the event\n  executes.\n\no A DO clause, which contains the SQL statement to be executed by an\n  event.\n\nThis is an example of a minimal CREATE EVENT statement:\n\nCREATE EVENT myevent\n    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR\n    DO\n      UPDATE myschema.mytable SET mycol = mycol + 1;\n\nThe previous statement creates an event named myevent. This event\nexecutes once---one hour following its creation---by running an SQL\nstatement that increments the value of the myschema.mytable table\'s\nmycol column by 1.\n\nThe event_name must be a valid MySQL identifier with a maximum length\nof 64 characters. Event names are not case sensitive, so you cannot\nhave two events named myevent and MyEvent in the same schema. In\ngeneral, the rules governing event names are the same as those for\nnames of stored routines. See\nhttp://dev.mysql.com/doc/refman/5.1/en/identifiers.html.\n\nAn event is associated with a schema. If no schema is indicated as part\nof event_name, the default (current) schema is assumed. To create an\nevent in a specific schema, qualify the event name with a schema using\nschema_name.event_name syntax.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-event.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-event.html'),(90,'ABS',4,'Syntax:\nABS(X)\n\nReturns the absolute value of X.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT ABS(2);\n        -> 2\nmysql> SELECT ABS(-32);\n        -> 32\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(91,'POLYFROMWKB',33,'PolyFromWKB(wkb[,srid]), PolygonFromWKB(wkb[,srid])\n\nConstructs a POLYGON value using its WKB representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(92,'NOT LIKE',38,'Syntax:\nexpr NOT LIKE pat [ESCAPE \'escape_char\']\n\nThis is the same as NOT (expr LIKE pat [ESCAPE \'escape_char\']).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-comparison-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-comparison-functions.html'),(93,'SPACE',38,'Syntax:\nSPACE(N)\n\nReturns a string consisting of N space characters.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT SPACE(6);\n        -> \'      \'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(94,'MBR DEFINITION',6,'Its MBR (Minimum Bounding Rectangle), or Envelope. This is the bounding\ngeometry, formed by the minimum and maximum (X,Y) coordinates:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/gis-class-geometry.html\n\n','((MINX MINY, MAXX MINY, MAXX MAXY, MINX MAXY, MINX MINY))\n','http://dev.mysql.com/doc/refman/5.1/en/gis-class-geometry.html'),(95,'GEOMETRYCOLLECTION',25,'GeometryCollection(g1,g2,...)\n\nConstructs a GeometryCollection.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(96,'MAX',16,'Syntax:\nMAX([DISTINCT] expr)\n\nReturns the maximum value of expr. MAX() may take a string argument; in\nsuch cases, it returns the maximum string value. See\nhttp://dev.mysql.com/doc/refman/5.1/en/mysql-indexes.html. The DISTINCT\nkeyword can be used to find the maximum of the distinct values of expr,\nhowever, this produces the same result as omitting DISTINCT.\n\nMAX() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','mysql> SELECT student_name, MIN(test_score), MAX(test_score)\n    ->        FROM student\n    ->        GROUP BY student_name;\n','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(97,'CREATE FUNCTION UDF',22,'Syntax:\nCREATE [AGGREGATE] FUNCTION function_name RETURNS {STRING|INTEGER|REAL|DECIMAL}\n    SONAME shared_library_name\n\nA user-defined function (UDF) is a way to extend MySQL with a new\nfunction that works like a native (built-in) MySQL function such as\nABS() or CONCAT().\n\nfunction_name is the name that should be used in SQL statements to\ninvoke the function. The RETURNS clause indicates the type of the\nfunction\'s return value. DECIMAL is a legal value after RETURNS, but\ncurrently DECIMAL functions return string values and should be written\nlike STRING functions.\n\nshared_library_name is the basename of the shared object file that\ncontains the code that implements the function. The file must be\nlocated in the plugin directory. This directory is given by the value\nof the plugin_dir system variable.\n\n*Note*: This is a change in MySQL 5.1. For earlier versions of MySQL,\nthe shared object can be located in any directory that is searched by\nyour system\'s dynamic linker. For more information, see\nhttp://dev.mysql.com/doc/refman/5.1/en/udf-compiling.html.\n\nTo create a function, you must have the INSERT privilege for the mysql\ndatabase. This is necessary because CREATE FUNCTION adds a row to the\nmysql.func system table that records the function\'s name, type, and\nshared library name. If you do not have this table, you should run the\nmysql_upgrade command to create it. See\nhttp://dev.mysql.com/doc/refman/5.1/en/mysql-upgrade.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-function-udf.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-function-udf.html'),(98,'*',4,'Syntax:\n*\n\nMultiplication:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html\n\n','mysql> SELECT 3*5;\n        -> 15\nmysql> SELECT 18014398509481984*18014398509481984.0;\n        -> 324518553658426726783156020576256.0\n','http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html'),(99,'TIMESTAMP',23,'TIMESTAMP\n\nA timestamp. The range is \'1970-01-01 00:00:01\' UTC to \'2038-01-19\n03:14:07\' UTC. TIMESTAMP values are stored as the number of seconds\nsince the epoch (\'1970-01-01 00:00:00\' UTC). A TIMESTAMP cannot\nrepresent the value \'1970-01-01 00:00:00\' because that is equivalent to\n0 seconds from the epoch and the value 0 is reserved for representing\n\'0000-00-00 00:00:00\', the \"zero\" TIMESTAMP value.\n\nUnless specified otherwise, the first TIMESTAMP column in a table is\ndefined to be automatically set to the date and time of the most recent\nmodification if not explicitly assigned a value. This makes TIMESTAMP\nuseful for recording the timestamp of an INSERT or UPDATE operation.\nYou can also set any TIMESTAMP column to the current date and time by\nassigning it a NULL value, unless it has been defined with the NULL\nattribute to permit NULL values. The automatic initialization and\nupdating to the current date and time can be specified using DEFAULT\nCURRENT_TIMESTAMP and ON UPDATE CURRENT_TIMESTAMP clauses, as described\nin\nhttp://dev.mysql.com/doc/refman/5.1/en/timestamp-initialization.html.\n\n*Note*: The TIMESTAMP format that was used prior to MySQL 4.1 is not\nsupported in MySQL 5.1; see MySQL 3.23, 4.0, 4.1 Reference Manual for\ninformation regarding the old format.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-type-overview.html'),(100,'DES_DECRYPT',12,'Syntax:\nDES_DECRYPT(crypt_str[,key_str])\n\nDecrypts a string encrypted with DES_ENCRYPT(). If an error occurs,\nthis function returns NULL.\n\nThis function works only if MySQL has been configured with SSL support.\nSee http://dev.mysql.com/doc/refman/5.1/en/ssl-connections.html.\n\nIf no key_str argument is given, DES_DECRYPT() examines the first byte\nof the encrypted string to determine the DES key number that was used\nto encrypt the original string, and then reads the key from the DES key\nfile to decrypt the message. For this to work, the user must have the\nSUPER privilege. The key file can be specified with the --des-key-file\nserver option.\n\nIf you pass this function a key_str argument, that string is used as\nthe key for decrypting the message.\n\nIf the crypt_str argument does not appear to be an encrypted string,\nMySQL returns the given crypt_str.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(101,'CACHE INDEX',27,'Syntax:\nCACHE INDEX\n  tbl_index_list [, tbl_index_list] ...\n  IN key_cache_name\n\ntbl_index_list:\n  tbl_name [[INDEX|KEY] (index_name[, index_name] ...)]\n\nThe CACHE INDEX statement assigns table indexes to a specific key\ncache. It is used only for MyISAM tables. After the indexes have been\nassigned, they can be preloaded into the cache if desired with LOAD\nINDEX INTO CACHE.\n\nThe following statement assigns indexes from the tables t1, t2, and t3\nto the key cache named hot_cache:\n\nmysql> CACHE INDEX t1, t2, t3 IN hot_cache;\n+---------+--------------------+----------+----------+\n| Table   | Op                 | Msg_type | Msg_text |\n+---------+--------------------+----------+----------+\n| test.t1 | assign_to_keycache | status   | OK       |\n| test.t2 | assign_to_keycache | status   | OK       |\n| test.t3 | assign_to_keycache | status   | OK       |\n+---------+--------------------+----------+----------+\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/cache-index.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/cache-index.html'),(102,'ENDPOINT',13,'EndPoint(ls)\n\nReturns the Point that is the endpoint of the LineString value ls.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @ls = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT AsText(EndPoint(GeomFromText(@ls)));\n+-------------------------------------+\n| AsText(EndPoint(GeomFromText(@ls))) |\n+-------------------------------------+\n| POINT(3 3)                          |\n+-------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(103,'COMPRESS',12,'Syntax:\nCOMPRESS(string_to_compress)\n\nCompresses a string and returns the result as a binary string. This\nfunction requires MySQL to have been compiled with a compression\nlibrary such as zlib. Otherwise, the return value is always NULL. The\ncompressed string can be uncompressed with UNCOMPRESS().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','mysql> SELECT LENGTH(COMPRESS(REPEAT(\'a\',1000)));\n        -> 21\nmysql> SELECT LENGTH(COMPRESS(\'\'));\n        -> 0\nmysql> SELECT LENGTH(COMPRESS(\'a\'));\n        -> 13\nmysql> SELECT LENGTH(COMPRESS(REPEAT(\'a\',16)));\n        -> 15\n','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(104,'INSERT',28,'Syntax:\nINSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]\n    [INTO] tbl_name [(col_name,...)]\n    {VALUES | VALUE} ({expr | DEFAULT},...),(...),...\n    [ ON DUPLICATE KEY UPDATE\n      col_name=expr\n        [, col_name=expr] ... ]\n\nOr:\n\nINSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]\n    [INTO] tbl_name\n    SET col_name={expr | DEFAULT}, ...\n    [ ON DUPLICATE KEY UPDATE\n      col_name=expr\n        [, col_name=expr] ... ]\n\nOr:\n\nINSERT [LOW_PRIORITY | HIGH_PRIORITY] [IGNORE]\n    [INTO] tbl_name [(col_name,...)]\n    SELECT ...\n    [ ON DUPLICATE KEY UPDATE\n      col_name=expr\n        [, col_name=expr] ... ]\n\nINSERT inserts new rows into an existing table. The INSERT ... VALUES\nand INSERT ... SET forms of the statement insert rows based on\nexplicitly specified values. The INSERT ... SELECT form inserts rows\nselected from another table or tables. INSERT ... SELECT is discussed\nfurther in [HELP INSERT SELECT].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/insert.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/insert.html'),(105,'COUNT',16,'Syntax:\nCOUNT(expr)\n\nReturns a count of the number of non-NULL values of expr in the rows\nretrieved by a SELECT statement. The result is a BIGINT value.\n\nCOUNT() returns 0 if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','mysql> SELECT student.student_name,COUNT(*)\n    ->        FROM student,course\n    ->        WHERE student.student_id=course.student_id\n    ->        GROUP BY student_name;\n','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(106,'HANDLER',28,'Syntax:\nHANDLER tbl_name OPEN [ [AS] alias]\n\nHANDLER tbl_name READ index_name { = | <= | >= | < | > } (value1,value2,...)\n    [ WHERE where_condition ] [LIMIT ... ]\nHANDLER tbl_name READ index_name { FIRST | NEXT | PREV | LAST }\n    [ WHERE where_condition ] [LIMIT ... ]\nHANDLER tbl_name READ { FIRST | NEXT }\n    [ WHERE where_condition ] [LIMIT ... ]\n\nHANDLER tbl_name CLOSE\n\nThe HANDLER statement provides direct access to table storage engine\ninterfaces. It is available for InnoDB and MyISAM tables.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/handler.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/handler.html'),(107,'MLINEFROMTEXT',3,'MLineFromText(wkt[,srid]), MultiLineStringFromText(wkt[,srid])\n\nConstructs a MULTILINESTRING value using its WKT representation and\nSRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(108,'GEOMCOLLFROMWKB',33,'GeomCollFromWKB(wkb[,srid]), GeometryCollectionFromWKB(wkb[,srid])\n\nConstructs a GEOMETRYCOLLECTION value using its WKB representation and\nSRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(109,'HELP_DATE',9,'This help information was generated from the MySQL 5.1 Reference Manual\non: 2013-11-04\n','',''),(110,'RENAME TABLE',40,'Syntax:\nRENAME TABLE tbl_name TO new_tbl_name\n    [, tbl_name2 TO new_tbl_name2] ...\n\nThis statement renames one or more tables.\n\nThe rename operation is done atomically, which means that no other\nsession can access any of the tables while the rename is running. For\nexample, if you have an existing table old_table, you can create\nanother table new_table that has the same structure but is empty, and\nthen replace the existing table with the empty one as follows (assuming\nthat backup_table does not already exist):\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/rename-table.html\n\n','CREATE TABLE new_table (...);\nRENAME TABLE old_table TO backup_table, new_table TO old_table;\n','http://dev.mysql.com/doc/refman/5.1/en/rename-table.html'),(111,'BOOLEAN',23,'BOOL, BOOLEAN\n\nThese types are synonyms for TINYINT(1). A value of zero is considered\nfalse. Nonzero values are considered true:\n\nmysql> SELECT IF(0, \'true\', \'false\');\n+------------------------+\n| IF(0, \'true\', \'false\') |\n+------------------------+\n| false                  |\n+------------------------+\n\nmysql> SELECT IF(1, \'true\', \'false\');\n+------------------------+\n| IF(1, \'true\', \'false\') |\n+------------------------+\n| true                   |\n+------------------------+\n\nmysql> SELECT IF(2, \'true\', \'false\');\n+------------------------+\n| IF(2, \'true\', \'false\') |\n+------------------------+\n| true                   |\n+------------------------+\n\nHowever, the values TRUE and FALSE are merely aliases for 1 and 0,\nrespectively, as shown here:\n\nmysql> SELECT IF(0 = FALSE, \'true\', \'false\');\n+--------------------------------+\n| IF(0 = FALSE, \'true\', \'false\') |\n+--------------------------------+\n| true                           |\n+--------------------------------+\n\nmysql> SELECT IF(1 = TRUE, \'true\', \'false\');\n+-------------------------------+\n| IF(1 = TRUE, \'true\', \'false\') |\n+-------------------------------+\n| true                          |\n+-------------------------------+\n\nmysql> SELECT IF(2 = TRUE, \'true\', \'false\');\n+-------------------------------+\n| IF(2 = TRUE, \'true\', \'false\') |\n+-------------------------------+\n| false                         |\n+-------------------------------+\n\nmysql> SELECT IF(2 = FALSE, \'true\', \'false\');\n+--------------------------------+\n| IF(2 = FALSE, \'true\', \'false\') |\n+--------------------------------+\n| false                          |\n+--------------------------------+\n\nThe last two statements display the results shown because 2 is equal to\nneither 1 nor 0.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(112,'DEFAULT',14,'Syntax:\nDEFAULT(col_name)\n\nReturns the default value for a table column. An error results if the\ncolumn has no default value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','mysql> UPDATE t SET i = DEFAULT(i)+1 WHERE id < 100;\n','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(113,'MOD',4,'Syntax:\nMOD(N,M), N % M, N MOD M\n\nModulo operation. Returns the remainder of N divided by M.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT MOD(234, 10);\n        -> 4\nmysql> SELECT 253 % 7;\n        -> 1\nmysql> SELECT MOD(29,9);\n        -> 2\nmysql> SELECT 29 MOD 9;\n        -> 2\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(114,'TINYTEXT',23,'TINYTEXT [CHARACTER SET charset_name] [COLLATE collation_name]\n\nA TEXT column with a maximum length of 255 (28 - 1) characters. The\neffective maximum length is less if the value contains multi-byte\ncharacters. Each TINYTEXT value is stored using a 1-byte length prefix\nthat indicates the number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(115,'OPTIMIZE TABLE',21,'Syntax:\nOPTIMIZE [NO_WRITE_TO_BINLOG | LOCAL] TABLE\n    tbl_name [, tbl_name] ...\n\nReorganizes the physical storage of table data and associated index\ndata, to reduce storage space and improve I/O efficiency when accessing\nthe table. The exact changes made to each table depend on the storage\nengine\n(http://dev.mysql.com/doc/refman/5.5/en/glossary.html#glos_storage_engi\nne) used by that table.\n\nUse OPTIMIZE TABLE in these cases, depending on the type of table:\n\no After doing substantial insert, update, or delete operations on an\n  InnoDB table that has its own .ibd file\n  (http://dev.mysql.com/doc/refman/5.5/en/glossary.html#glos_ibd_file)\n  because it was created with the innodb_file_per_table option enabled.\n  The table and indexes are reorganized, and disk space can be\n  reclaimed for use by the operating system.\n\no After deleting a large part of a MyISAM or ARCHIVE table, or making\n  many changes to a MyISAM or ARCHIVE table with variable-length rows\n  (tables that have VARCHAR, VARBINARY, BLOB, or TEXT columns). Deleted\n  rows are maintained in a linked list and subsequent INSERT operations\n  reuse old row positions. You can use OPTIMIZE TABLE to reclaim the\n  unused space and to defragment the data file. After extensive changes\n  to a table, this statement may also improve performance of statements\n  that use the table, sometimes significantly.\n\nThis statement requires SELECT and INSERT privileges for the table.\n\nBeginning with MySQL 5.1.27, OPTIMIZE TABLE is also supported for\npartitioned tables. For information about using this statement with\npartitioned tables and table partitions, see\nhttp://dev.mysql.com/doc/refman/5.1/en/partitioning-maintenance.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/optimize-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/optimize-table.html'),(116,'DECODE',12,'Syntax:\nDECODE(crypt_str,pass_str)\n\nDecrypts the encrypted string crypt_str using pass_str as the password.\ncrypt_str should be a string returned from ENCODE().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(117,'<=>',19,'Syntax:\n<=>\n\nNULL-safe equal. This operator performs an equality comparison like the\n= operator, but returns 1 rather than NULL if both operands are NULL,\nand 0 rather than NULL if one operand is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 1 <=> 1, NULL <=> NULL, 1 <=> NULL;\n        -> 1, 1, 0\nmysql> SELECT 1 = 1, NULL = NULL, 1 = NULL;\n        -> 1, NULL, NULL\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(118,'HELP STATEMENT',29,'Syntax:\nHELP \'search_string\'\n\nThe HELP statement returns online information from the MySQL Reference\nmanual. Its proper operation requires that the help tables in the mysql\ndatabase be initialized with help topic information (see\nhttp://dev.mysql.com/doc/refman/5.1/en/server-side-help-support.html).\n\nThe HELP statement searches the help tables for the given search string\nand displays the result of the search. The search string is not case\nsensitive.\n\nThe search string can contain the the wildcard characters \"%\" and \"_\".\nThese have the same meaning as for pattern-matching operations\nperformed with the LIKE operator. For example, HELP \'rep%\' returns a\nlist of topics that begin with rep.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/help.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/help.html'),(119,'RESET',27,'Syntax:\nRESET reset_option [, reset_option] ...\n\nThe RESET statement is used to clear the state of various server\noperations. You must have the RELOAD privilege to execute RESET.\n\nRESET acts as a stronger version of the FLUSH statement. See [HELP\nFLUSH].\n\nThe RESET statement causes an implicit commit. See\nhttp://dev.mysql.com/doc/refman/5.1/en/implicit-commit.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/reset.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/reset.html'),(120,'LOAD DATA FROM MASTER',8,'Syntax:\nLOAD DATA FROM MASTER\n\nThis feature is deprecated and should be avoided. It is subject to\nremoval in a future version of MySQL.\n\nSince the current implementation of LOAD DATA FROM MASTER and LOAD\nTABLE FROM MASTER is very limited, these statements are deprecated as\nof MySQL 4.1 and removed in MySQL 5.5.\n\nThe recommended alternative solution to using LOAD DATA FROM MASTER or\nLOAD TABLE FROM MASTER is using mysqldump or mysqlhotcopy. The latter\nrequires Perl and two Perl modules (DBI and DBD:mysql) and works for\nMyISAM and ARCHIVE tables only. With mysqldump, you can create SQL\ndumps on the master and pipe (or copy) these to a mysql client on the\nslave. This has the advantage of working for all storage engines, but\ncan be quite slow, since it works using SELECT.\n\nThis statement takes a snapshot of the master and copies it to the\nslave. It updates the values of MASTER_LOG_FILE and MASTER_LOG_POS so\nthat the slave starts replicating from the correct position. Any table\nand database exclusion rules specified with the --replicate-*-do-* and\n--replicate-*-ignore-* options are honored. --replicate-rewrite-db is\nnot taken into account because a user could use this option to set up a\nnonunique mapping such as --replicate-rewrite-db=\"db1->db3\" and\n--replicate-rewrite-db=\"db2->db3\", which would confuse the slave when\nloading tables from the master.\n\nUse of this statement is subject to the following conditions:\n\no It works only for MyISAM tables. Attempting to load a non-MyISAM\n  table results in the following error:\n\nERROR 1189 (08S01): Net error reading from master\n\no It acquires a global read lock on the master while taking the\n  snapshot, which prevents updates on the master during the load\n  operation.\n\nIf you are loading large tables, you might have to increase the values\nof net_read_timeout and net_write_timeout on both the master and slave\nservers. See\nhttp://dev.mysql.com/doc/refman/5.1/en/server-system-variables.html.\n\nNote that LOAD DATA FROM MASTER does not copy any tables from the mysql\ndatabase. This makes it easy to have different users and privileges on\nthe master and the slave.\n\nTo use LOAD DATA FROM MASTER, the replication account that is used to\nconnect to the master must have the RELOAD and SUPER privileges on the\nmaster and the SELECT privilege for all master tables you want to load.\nAll master tables for which the user does not have the SELECT privilege\nare ignored by LOAD DATA FROM MASTER. This is because the master hides\nthem from the user: LOAD DATA FROM MASTER calls SHOW DATABASES to know\nthe master databases to load, but SHOW DATABASES returns only databases\nfor which the user has some privilege. See [HELP SHOW DATABASES]. On\nthe slave side, the user that issues LOAD DATA FROM MASTER must have\nprivileges for dropping and creating the databases and tables that are\ncopied.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/load-data-from-master.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/load-data-from-master.html'),(121,'GET_LOCK',14,'Syntax:\nGET_LOCK(str,timeout)\n\nTries to obtain a lock with a name given by the string str, using a\ntimeout of timeout seconds. Returns 1 if the lock was obtained\nsuccessfully, 0 if the attempt timed out (for example, because another\nclient has previously locked the name), or NULL if an error occurred\n(such as running out of memory or the thread was killed with mysqladmin\nkill). If you have a lock obtained with GET_LOCK(), it is released when\nyou execute RELEASE_LOCK(), execute a new GET_LOCK(), or your\nconnection terminates (either normally or abnormally). Locks obtained\nwith GET_LOCK() do not interact with transactions. That is, committing\na transaction does not release any such locks obtained during the\ntransaction.\n\nThis function can be used to implement application locks or to simulate\nrecord locks. Names are locked on a server-wide basis. If a name has\nbeen locked by one client, GET_LOCK() blocks any request by another\nclient for a lock with the same name. This enables clients that agree\non a given lock name to use the name to perform cooperative advisory\nlocking. But be aware that it also enables a client that is not among\nthe set of cooperating clients to lock a name, either inadvertently or\ndeliberately, and thus prevent any of the cooperating clients from\nlocking that name. One way to reduce the likelihood of this is to use\nlock names that are database-specific or application-specific. For\nexample, use lock names of the form db_name.str or app_name.str.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','mysql> SELECT GET_LOCK(\'lock1\',10);\n        -> 1\nmysql> SELECT IS_FREE_LOCK(\'lock2\');\n        -> 1\nmysql> SELECT GET_LOCK(\'lock2\',10);\n        -> 1\nmysql> SELECT RELEASE_LOCK(\'lock2\');\n        -> 1\nmysql> SELECT RELEASE_LOCK(\'lock1\');\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(122,'UCASE',38,'Syntax:\nUCASE(str)\n\nUCASE() is a synonym for UPPER().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(123,'SHOW BINLOG EVENTS',27,'Syntax:\nSHOW BINLOG EVENTS\n   [IN \'log_name\'] [FROM pos] [LIMIT [offset,] row_count]\n\nShows the events in the binary log. If you do not specify \'log_name\',\nthe first binary log is displayed.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-binlog-events.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-binlog-events.html'),(124,'MPOLYFROMWKB',33,'MPolyFromWKB(wkb[,srid]), MultiPolygonFromWKB(wkb[,srid])\n\nConstructs a MULTIPOLYGON value using its WKB representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(125,'ITERATE',24,'Syntax:\nITERATE label\n\nITERATE can appear only within LOOP, REPEAT, and WHILE statements.\nITERATE means \"start the loop again.\"\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/iterate.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/iterate.html'),(126,'DO',28,'Syntax:\nDO expr [, expr] ...\n\nDO executes the expressions but does not return any results. In most\nrespects, DO is shorthand for SELECT expr, ..., but has the advantage\nthat it is slightly faster when you do not care about the result.\n\nDO is useful primarily with functions that have side effects, such as\nRELEASE_LOCK().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/do.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/do.html'),(127,'CURTIME',32,'Syntax:\nCURTIME()\n\nReturns the current time as a value in \'HH:MM:SS\' or HHMMSS.uuuuuu\nformat, depending on whether the function is used in a string or\nnumeric context. The value is expressed in the current time zone.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT CURTIME();\n        -> \'23:50:26\'\nmysql> SELECT CURTIME() + 0;\n        -> 235026.000000\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(128,'CHAR_LENGTH',38,'Syntax:\nCHAR_LENGTH(str)\n\nReturns the length of the string str, measured in characters. A\nmulti-byte character counts as a single character. This means that for\na string containing five 2-byte characters, LENGTH() returns 10,\nwhereas CHAR_LENGTH() returns 5.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(129,'BIGINT',23,'BIGINT[(M)] [UNSIGNED] [ZEROFILL]\n\nA large integer. The signed range is -9223372036854775808 to\n9223372036854775807. The unsigned range is 0 to 18446744073709551615.\n\nSERIAL is an alias for BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(130,'SET',27,'Syntax:\nSET variable_assignment [, variable_assignment] ...\n\nvariable_assignment:\n      user_var_name = expr\n    | [GLOBAL | SESSION] system_var_name = expr\n    | [@@global. | @@session. | @@]system_var_name = expr\n\nThe SET statement assigns values to different types of variables that\naffect the operation of the server or your client. Older versions of\nMySQL employed SET OPTION, but this syntax is deprecated in favor of\nSET without OPTION.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/set-statement.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/set-statement.html'),(131,'CONV',4,'Syntax:\nCONV(N,from_base,to_base)\n\nConverts numbers between different number bases. Returns a string\nrepresentation of the number N, converted from base from_base to base\nto_base. Returns NULL if any argument is NULL. The argument N is\ninterpreted as an integer, but may be specified as an integer or a\nstring. The minimum base is 2 and the maximum base is 36. If to_base is\na negative number, N is regarded as a signed number. Otherwise, N is\ntreated as unsigned. CONV() works with 64-bit precision.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT CONV(\'a\',16,2);\n        -> \'1010\'\nmysql> SELECT CONV(\'6E\',18,8);\n        -> \'172\'\nmysql> SELECT CONV(-17,10,-18);\n        -> \'-H\'\nmysql> SELECT CONV(10+\'10\'+\'10\'+0xa,10,10);\n        -> \'40\'\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(132,'DATE',23,'DATE\n\nA date. The supported range is \'1000-01-01\' to \'9999-12-31\'. MySQL\ndisplays DATE values in \'YYYY-MM-DD\' format, but permits assignment of\nvalues to DATE columns using either strings or numbers.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-type-overview.html'),(133,'ASSIGN-VALUE',15,'Syntax:\n:=\n\nAssignment operator. Causes the user variable on the left hand side of\nthe operator to take on the value to its right. The value on the right\nhand side may be a literal value, another variable storing a value, or\nany legal expression that yields a scalar value, including the result\nof a query (provided that this value is a scalar value). You can\nperform multiple assignments in the same SET statement. You can perform\nmultiple assignments in the same statement-\n\nUnlike =, the := operator is never interpreted as a comparison\noperator. This means you can use := in any valid SQL statement (not\njust in SET statements) to assign a value to a variable.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/assignment-operators.html\n\n','mysql> SELECT @var1, @var2;\n        -> NULL, NULL\nmysql> SELECT @var1 := 1, @var2;\n        -> 1, NULL\nmysql> SELECT @var1, @var2;\n        -> 1, NULL\nmysql> SELECT @var1, @var2 := @var1;\n        -> 1, 1\nmysql> SELECT @var1, @var2;\n        -> 1, 1\n\nmysql> SELECT @var1:=COUNT(*) FROM t1;\n        -> 4\nmysql> SELECT @var1;\n        -> 4\n','http://dev.mysql.com/doc/refman/5.1/en/assignment-operators.html'),(134,'SHOW OPEN TABLES',27,'Syntax:\nSHOW OPEN TABLES [{FROM | IN} db_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW OPEN TABLES lists the non-TEMPORARY tables that are currently open\nin the table cache. See\nhttp://dev.mysql.com/doc/refman/5.1/en/table-cache.html. The WHERE\nclause can be given to select rows using more general conditions, as\ndiscussed in http://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\n\nThe FROM and LIKE clauses may be used beginning with MySQL 5.1.24. The\nLIKE clause, if present, indicates which table names to match. The FROM\nclause, if present, restricts the tables shown to those present in the\ndb_name database.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-open-tables.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-open-tables.html'),(135,'EXTRACT',32,'Syntax:\nEXTRACT(unit FROM date)\n\nThe EXTRACT() function uses the same kinds of unit specifiers as\nDATE_ADD() or DATE_SUB(), but extracts parts from the date rather than\nperforming date arithmetic.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT EXTRACT(YEAR FROM \'2009-07-02\');\n       -> 2009\nmysql> SELECT EXTRACT(YEAR_MONTH FROM \'2009-07-02 01:02:03\');\n       -> 200907\nmysql> SELECT EXTRACT(DAY_MINUTE FROM \'2009-07-02 01:02:03\');\n       -> 20102\nmysql> SELECT EXTRACT(MICROSECOND\n    ->                FROM \'2003-01-02 10:30:00.000123\');\n        -> 123\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(136,'ENCRYPT',12,'Syntax:\nENCRYPT(str[,salt])\n\nEncrypts str using the Unix crypt() system call and returns a binary\nstring. The salt argument must be a string with at least two characters\nor the result will be NULL. If no salt argument is given, a random\nvalue is used.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','mysql> SELECT ENCRYPT(\'hello\');\n        -> \'VxuFAJXVARROc\'\n','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(137,'SHOW STATUS',27,'Syntax:\nSHOW [GLOBAL | SESSION] STATUS\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW STATUS provides server status information. This information also\ncan be obtained using the mysqladmin extended-status command. The LIKE\nclause, if present, indicates which variable names to match. The WHERE\nclause can be given to select rows using more general conditions, as\ndiscussed in http://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\nThis statement does not require any privilege. It requires only the\nability to connect to the server.\nWith a LIKE clause, the statement displays only rows for those\nvariables with names that match the pattern:\n\nmysql> SHOW STATUS LIKE \'Key%\';\n+--------------------+----------+\n| Variable_name      | Value    |\n+--------------------+----------+\n| Key_blocks_used    | 14955    |\n| Key_read_requests  | 96854827 |\n| Key_reads          | 162040   |\n| Key_write_requests | 7589728  |\n| Key_writes         | 3813196  |\n+--------------------+----------+\n\nWith the GLOBAL modifier, SHOW STATUS displays the status values for\nall connections to MySQL. With SESSION, it displays the status values\nfor the current connection. If no modifier is present, the default is\nSESSION. LOCAL is a synonym for SESSION.\n\nSome status variables have only a global value. For these, you get the\nsame value for both GLOBAL and SESSION. The scope for each status\nvariable is listed at\nhttp://dev.mysql.com/doc/refman/5.1/en/server-status-variables.html.\n\nEach invocation of the SHOW STATUS statement uses an internal temporary\ntable and increments the global Created_tmp_tables value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-status.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-status.html'),(138,'EXTRACTVALUE',38,'Syntax:\nExtractValue(xml_frag, xpath_expr)\n\nExtractValue() takes two string arguments, a fragment of XML markup\nxml_frag and an XPath expression xpath_expr (also known as a locator);\nit returns the text (CDATA) of the first text node which is a child of\nthe elements or elements matched by the XPath expression. In MySQL 5.1,\nthe XPath expression can contain at most 127 characters. (This\nlimitation is lifted in MySQL 5.6.)\n\nUsing this function is the equivalent of performing a match using the\nxpath_expr after appending /text(). In other words,\nExtractValue(\'<a><b>Sakila</b></a>\', \'/a/b\') and\nExtractValue(\'<a><b>Sakila</b></a>\', \'/a/b/text()\') produce the same\nresult.\n\nIf multiple matches are found, the content of the first child text node\nof each matching element is returned (in the order matched) as a\nsingle, space-delimited string.\n\nIf no matching text node is found for the expression (including the\nimplicit /text())---for whatever reason, as long as xpath_expr is\nvalid, and xml_frag consists of elements which are properly nested and\nclosed---an empty string is returned. No distinction is made between a\nmatch on an empty element and no match at all. This is by design.\n\nIf you need to determine whether no matching element was found in\nxml_frag or such an element was found but contained no child text\nnodes, you should test the result of an expression that uses the XPath\ncount() function. For example, both of these statements return an empty\nstring, as shown here:\n\nmysql> SELECT ExtractValue(\'<a><b/></a>\', \'/a/b\');\n+-------------------------------------+\n| ExtractValue(\'<a><b/></a>\', \'/a/b\') |\n+-------------------------------------+\n|                                     |\n+-------------------------------------+\n1 row in set (0.00 sec)\n\nmysql> SELECT ExtractValue(\'<a><c/></a>\', \'/a/b\');\n+-------------------------------------+\n| ExtractValue(\'<a><c/></a>\', \'/a/b\') |\n+-------------------------------------+\n|                                     |\n+-------------------------------------+\n1 row in set (0.00 sec)\n\nHowever, you can determine whether there was actually a matching\nelement using the following:\n\nmysql> SELECT ExtractValue(\'<a><b/></a>\', \'count(/a/b)\');\n+-------------------------------------+\n| ExtractValue(\'<a><b/></a>\', \'count(/a/b)\') |\n+-------------------------------------+\n| 1                                   |\n+-------------------------------------+\n1 row in set (0.00 sec)\n\nmysql> SELECT ExtractValue(\'<a><c/></a>\', \'count(/a/b)\');\n+-------------------------------------+\n| ExtractValue(\'<a><c/></a>\', \'count(/a/b)\') |\n+-------------------------------------+\n| 0                                   |\n+-------------------------------------+\n1 row in set (0.01 sec)\n\n*Important*: ExtractValue() returns only CDATA, and does not return any\ntags that might be contained within a matching tag, nor any of their\ncontent (see the result returned as val1 in the following example).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/xml-functions.html\n\n','mysql> SELECT\n    ->   ExtractValue(\'<a>ccc<b>ddd</b></a>\', \'/a\') AS val1,\n    ->   ExtractValue(\'<a>ccc<b>ddd</b></a>\', \'/a/b\') AS val2,\n    ->   ExtractValue(\'<a>ccc<b>ddd</b></a>\', \'//b\') AS val3,\n    ->   ExtractValue(\'<a>ccc<b>ddd</b></a>\', \'/b\') AS val4,\n    ->   ExtractValue(\'<a>ccc<b>ddd</b><b>eee</b></a>\', \'//b\') AS val5;\n\n+------+------+------+------+---------+\n| val1 | val2 | val3 | val4 | val5    |\n+------+------+------+------+---------+\n| ccc  | ddd  | ddd  |      | ddd eee |\n+------+------+------+------+---------+\n','http://dev.mysql.com/doc/refman/5.1/en/xml-functions.html'),(139,'OLD_PASSWORD',12,'Syntax:\nOLD_PASSWORD(str)\n\nOLD_PASSWORD() was added when the implementation of PASSWORD() was\nchanged in MySQL 4.1 to improve security. OLD_PASSWORD() returns the\nvalue of the pre-4.1 implementation of PASSWORD() as a binary string,\nand is intended to permit you to reset passwords for any pre-4.1\nclients that need to connect to your version 5.1 MySQL server without\nlocking them out. See\nhttp://dev.mysql.com/doc/refman/5.1/en/password-hashing.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(140,'FORMAT',38,'Syntax:\nFORMAT(X,D)\n\nFormats the number X to a format like \'#,###,###.##\', rounded to D\ndecimal places, and returns the result as a string. If D is 0, the\nresult has no decimal point or fractional part.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT FORMAT(12332.123456, 4);\n        -> \'12,332.1235\'\nmysql> SELECT FORMAT(12332.1,4);\n        -> \'12,332.1000\'\nmysql> SELECT FORMAT(12332.2,0);\n        -> \'12,332\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(141,'||',15,'Syntax:\nOR, ||\n\nLogical OR. When both operands are non-NULL, the result is 1 if any\noperand is nonzero, and 0 otherwise. With a NULL operand, the result is\n1 if the other operand is nonzero, and NULL otherwise. If both operands\nare NULL, the result is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/logical-operators.html\n\n','mysql> SELECT 1 || 1;\n        -> 1\nmysql> SELECT 1 || 0;\n        -> 1\nmysql> SELECT 0 || 0;\n        -> 0\nmysql> SELECT 0 || NULL;\n        -> NULL\nmysql> SELECT 1 || NULL;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/logical-operators.html'),(142,'BIT_LENGTH',38,'Syntax:\nBIT_LENGTH(str)\n\nReturns the length of the string str in bits.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT BIT_LENGTH(\'text\');\n        -> 32\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(143,'EXTERIORRING',2,'ExteriorRing(poly)\n\nReturns the exterior ring of the Polygon value poly as a LineString.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @poly =\n    -> \'Polygon((0 0,0 3,3 3,3 0,0 0),(1 1,1 2,2 2,2 1,1 1))\';\nmysql> SELECT AsText(ExteriorRing(GeomFromText(@poly)));\n+-------------------------------------------+\n| AsText(ExteriorRing(GeomFromText(@poly))) |\n+-------------------------------------------+\n| LINESTRING(0 0,0 3,3 3,3 0,0 0)           |\n+-------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(144,'GEOMFROMWKB',33,'GeomFromWKB(wkb[,srid]), GeometryFromWKB(wkb[,srid])\n\nConstructs a geometry value of any type using its WKB representation\nand SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(145,'SHOW SLAVE HOSTS',27,'Syntax:\nSHOW SLAVE HOSTS\n\nDisplays a list of replication slaves currently registered with the\nmaster. Only slaves started with the --report-host=host_name option are\nvisible in this list.\n\nThe list is displayed on any server (not just the master server). The\noutput looks like this:\n\nmysql> SHOW SLAVE HOSTS;\n+------------+-----------+------+-----------+\n| Server_id  | Host      | Port | Master_id |\n+------------+-----------+------+-----------+\n|  192168010 | iconnect2 | 3306 | 192168011 |\n| 1921680101 | athena    | 3306 | 192168011 |\n+------------+-----------+------+-----------+\n\no Server_id: The unique server ID of the slave server, as configured in\n  the server\'s option file, or on the command line with\n  --server-id=value.\n\no Host: The host name of the slave server, as configured in the\n  server\'s option file, or on the command line with\n  --report-host=host_name. Note that this can differ from the machine\n  name as configured in the operating system.\n\no Port: The port the slave server is listening on.\n\no Master_id: The unique server ID of the master server that the slave\n  server is replicating from.\n\nSome MySQL versions report another variable, Rpl_recovery_rank. This\nvariable was never used, and was eventually removed. (Bug #13963)\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-slave-hosts.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-slave-hosts.html'),(146,'START TRANSACTION',8,'Syntax:\nSTART TRANSACTION [WITH CONSISTENT SNAPSHOT]\nBEGIN [WORK]\nCOMMIT [WORK] [AND [NO] CHAIN] [[NO] RELEASE]\nROLLBACK [WORK] [AND [NO] CHAIN] [[NO] RELEASE]\nSET autocommit = {0 | 1}\n\nThese statements provide control over use of transactions\n(http://dev.mysql.com/doc/refman/5.5/en/glossary.html#glos_transaction)\n:\n\no START TRANSACTION or BEGIN start a new transaction.\n\no COMMIT commits the current transaction, making its changes permanent.\n\no ROLLBACK rolls back the current transaction, canceling its changes.\n\no SET autocommit disables or enables the default autocommit mode for\n  the current session.\n\nBy default, MySQL runs with autocommit\n(http://dev.mysql.com/doc/refman/5.5/en/glossary.html#glos_autocommit)\nmode enabled. This means that as soon as you execute a statement that\nupdates (modifies) a table, MySQL stores the update on disk to make it\npermanent. The change cannot be rolled back.\n\nTo disable autocommit mode implicitly for a single series of\nstatements, use the START TRANSACTION statement:\n\nSTART TRANSACTION;\nSELECT @A:=SUM(salary) FROM table1 WHERE type=1;\nUPDATE table2 SET summary=@A WHERE type=1;\nCOMMIT;\n\nWith START TRANSACTION, autocommit remains disabled until you end the\ntransaction with COMMIT or ROLLBACK. The autocommit mode then reverts\nto its previous state.\n\nYou can also begin a transaction like this:\n\nSTART TRANSACTION WITH CONSISTENT SNAPSHOT;\n\nThe WITH CONSISTENT SNAPSHOT option starts a consistent read\n(http://dev.mysql.com/doc/refman/5.5/en/glossary.html#glos_consistent_r\nead) for storage engines that are capable of it. This applies only to\nInnoDB. The effect is the same as issuing a START TRANSACTION followed\nby a SELECT from any InnoDB table. See\nhttp://dev.mysql.com/doc/refman/5.1/en/innodb-consistent-read.html. The\nWITH CONSISTENT SNAPSHOT option does not change the current transaction\nisolation level\n(http://dev.mysql.com/doc/refman/5.5/en/glossary.html#glos_isolation_le\nvel), so it provides a consistent snapshot only if the current\nisolation level is one that permits a consistent read. The only\nisolation level that permits a consistent read is REPEATABLE READ. For\nall other isolation levels, the WITH CONSISTENT SNAPSHOT clause is\nignored.\n\n*Important*: Many APIs used for writing MySQL client applications (such\nas JDBC) provide their own methods for starting transactions that can\n(and sometimes should) be used instead of sending a START TRANSACTION\nstatement from the client. See\nhttp://dev.mysql.com/doc/refman/5.1/en/connectors-apis.html, or the\ndocumentation for your API, for more information.\n\nTo disable autocommit mode explicitly, use the following statement:\n\nSET autocommit=0;\n\nAfter disabling autocommit mode by setting the autocommit variable to\nzero, changes to transaction-safe tables (such as those for InnoDB or\nNDBCLUSTER) are not made permanent immediately. You must use COMMIT to\nstore your changes to disk or ROLLBACK to ignore the changes.\n\nautocommit is a session variable and must be set for each session. To\ndisable autocommit mode for each new connection, see the description of\nthe autocommit system variable at\nhttp://dev.mysql.com/doc/refman/5.1/en/server-system-variables.html.\n\nBEGIN and BEGIN WORK are supported as aliases of START TRANSACTION for\ninitiating a transaction. START TRANSACTION is standard SQL syntax and\nis the recommended way to start an ad-hoc transaction.\n\nThe BEGIN statement differs from the use of the BEGIN keyword that\nstarts a BEGIN ... END compound statement. The latter does not begin a\ntransaction. See [HELP BEGIN END].\n\n*Note*: Within all stored programs (stored procedures and functions,\ntriggers, and events), the parser treats BEGIN [WORK] as the beginning\nof a BEGIN ... END block. Begin a transaction in this context with\nSTART TRANSACTION instead.\n\nThe optional WORK keyword is supported for COMMIT and ROLLBACK, as are\nthe CHAIN and RELEASE clauses. CHAIN and RELEASE can be used for\nadditional control over transaction completion. The value of the\ncompletion_type system variable determines the default completion\nbehavior. See\nhttp://dev.mysql.com/doc/refman/5.1/en/server-system-variables.html.\n\nThe AND CHAIN clause causes a new transaction to begin as soon as the\ncurrent one ends, and the new transaction has the same isolation level\nas the just-terminated transaction. The RELEASE clause causes the\nserver to disconnect the current client session after terminating the\ncurrent transaction. Including the NO keyword suppresses CHAIN or\nRELEASE completion, which can be useful if the completion_type system\nvariable is set to cause chaining or release completion by default.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/commit.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/commit.html'),(147,'BETWEEN AND',19,'Syntax:\nexpr BETWEEN min AND max\n\nIf expr is greater than or equal to min and expr is less than or equal\nto max, BETWEEN returns 1, otherwise it returns 0. This is equivalent\nto the expression (min <= expr AND expr <= max) if all the arguments\nare of the same type. Otherwise type conversion takes place according\nto the rules described in\nhttp://dev.mysql.com/doc/refman/5.1/en/type-conversion.html, but\napplied to all the three arguments.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 2 BETWEEN 1 AND 3, 2 BETWEEN 3 and 1;\n        -> 1, 0\nmysql> SELECT 1 BETWEEN 2 AND 3;\n        -> 0\nmysql> SELECT \'b\' BETWEEN \'a\' AND \'c\';\n        -> 1\nmysql> SELECT 2 BETWEEN 2 AND \'3\';\n        -> 1\nmysql> SELECT 2 BETWEEN 2 AND \'x-3\';\n        -> 0\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(148,'MULTIPOLYGON',25,'MultiPolygon(poly1,poly2,...)\n\nConstructs a MultiPolygon value from a set of Polygon or WKB Polygon\narguments.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(149,'TIME_FORMAT',32,'Syntax:\nTIME_FORMAT(time,format)\n\nThis is used like the DATE_FORMAT() function, but the format string may\ncontain format specifiers only for hours, minutes, seconds, and\nmicroseconds. Other specifiers produce a NULL value or 0.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT TIME_FORMAT(\'100:00:00\', \'%H %k %h %I %l\');\n        -> \'100 100 04 04 4\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(150,'LEFT',38,'Syntax:\nLEFT(str,len)\n\nReturns the leftmost len characters from the string str, or NULL if any\nargument is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT LEFT(\'foobarbar\', 5);\n        -> \'fooba\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(151,'FLUSH QUERY CACHE',27,'You can defragment the query cache to better utilize its memory with\nthe FLUSH QUERY CACHE statement. The statement does not remove any\nqueries from the cache.\n\nThe RESET QUERY CACHE statement removes all query results from the\nquery cache. The FLUSH TABLES statement also does this.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/query-cache-status-and-maintenance.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/query-cache-status-and-maintenance.html'),(152,'SET DATA TYPE',23,'SET(\'value1\',\'value2\',...) [CHARACTER SET charset_name] [COLLATE\ncollation_name]\n\nA set. A string object that can have zero or more values, each of which\nmust be chosen from the list of values \'value1\', \'value2\', ... SET\nvalues are represented internally as integers.\n\nA SET column can have a maximum of 64 distinct members. A table can\nhave no more than 255 unique element list definitions among its ENUM\nand SET columns considered as a group. For more information on this\nlimit, see http://dev.mysql.com/doc/refman/5.1/en/limits-frm-file.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(153,'RAND',4,'Syntax:\nRAND(), RAND(N)\n\nReturns a random floating-point value v in the range 0 <= v < 1.0. If a\nconstant integer argument N is specified, it is used as the seed value,\nwhich produces a repeatable sequence of column values. In the following\nexample, note that the sequences of values produced by RAND(3) is the\nsame both places where it occurs.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> CREATE TABLE t (i INT);\nQuery OK, 0 rows affected (0.42 sec)\n\nmysql> INSERT INTO t VALUES(1),(2),(3);\nQuery OK, 3 rows affected (0.00 sec)\nRecords: 3  Duplicates: 0  Warnings: 0\n\nmysql> SELECT i, RAND() FROM t;\n+------+------------------+\n| i    | RAND()           |\n+------+------------------+\n|    1 | 0.61914388706828 |\n|    2 | 0.93845168309142 |\n|    3 | 0.83482678498591 |\n+------+------------------+\n3 rows in set (0.00 sec)\n\nmysql> SELECT i, RAND(3) FROM t;\n+------+------------------+\n| i    | RAND(3)          |\n+------+------------------+\n|    1 | 0.90576975597606 |\n|    2 | 0.37307905813035 |\n|    3 | 0.14808605345719 |\n+------+------------------+\n3 rows in set (0.00 sec)\n\nmysql> SELECT i, RAND() FROM t;\n+------+------------------+\n| i    | RAND()           |\n+------+------------------+\n|    1 | 0.35877890638893 |\n|    2 | 0.28941420772058 |\n|    3 | 0.37073435016976 |\n+------+------------------+\n3 rows in set (0.00 sec)\n\nmysql> SELECT i, RAND(3) FROM t;\n+------+------------------+\n| i    | RAND(3)          |\n+------+------------------+\n|    1 | 0.90576975597606 |\n|    2 | 0.37307905813035 |\n|    3 | 0.14808605345719 |\n+------+------------------+\n3 rows in set (0.01 sec)\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(154,'RPAD',38,'Syntax:\nRPAD(str,len,padstr)\n\nReturns the string str, right-padded with the string padstr to a length\nof len characters. If str is longer than len, the return value is\nshortened to len characters.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT RPAD(\'hi\',5,\'?\');\n        -> \'hi???\'\nmysql> SELECT RPAD(\'hi\',1,\'?\');\n        -> \'h\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(155,'CREATE DATABASE',40,'Syntax:\nCREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name\n    [create_specification] ...\n\ncreate_specification:\n    [DEFAULT] CHARACTER SET [=] charset_name\n  | [DEFAULT] COLLATE [=] collation_name\n\nCREATE DATABASE creates a database with the given name. To use this\nstatement, you need the CREATE privilege for the database. CREATE\nSCHEMA is a synonym for CREATE DATABASE.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-database.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-database.html'),(156,'DEC',23,'DEC[(M[,D])] [UNSIGNED] [ZEROFILL], NUMERIC[(M[,D])] [UNSIGNED]\n[ZEROFILL], FIXED[(M[,D])] [UNSIGNED] [ZEROFILL]\n\nThese types are synonyms for DECIMAL. The FIXED synonym is available\nfor compatibility with other database systems.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(157,'VAR_POP',16,'Syntax:\nVAR_POP(expr)\n\nReturns the population standard variance of expr. It considers rows as\nthe whole population, not as a sample, so it has the number of rows as\nthe denominator. You can also use VARIANCE(), which is equivalent but\nis not standard SQL.\n\nVAR_POP() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(158,'ELT',38,'Syntax:\nELT(N,str1,str2,str3,...)\n\nELT() returns the Nth element of the list of strings: str1 if N = 1,\nstr2 if N = 2, and so on. Returns NULL if N is less than 1 or greater\nthan the number of arguments. ELT() is the complement of FIELD().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT ELT(1, \'ej\', \'Heja\', \'hej\', \'foo\');\n        -> \'ej\'\nmysql> SELECT ELT(4, \'ej\', \'Heja\', \'hej\', \'foo\');\n        -> \'foo\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(159,'ALTER VIEW',40,'Syntax:\nALTER\n    [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]\n    [DEFINER = { user | CURRENT_USER }]\n    [SQL SECURITY { DEFINER | INVOKER }]\n    VIEW view_name [(column_list)]\n    AS select_statement\n    [WITH [CASCADED | LOCAL] CHECK OPTION]\n\nThis statement changes the definition of a view, which must exist. The\nsyntax is similar to that for CREATE VIEW and the effect is the same as\nfor CREATE OR REPLACE VIEW. See [HELP CREATE VIEW]. This statement\nrequires the CREATE VIEW and DROP privileges for the view, and some\nprivilege for each column referred to in the SELECT statement. As of\nMySQL 5.1.23, ALTER VIEW is permitted only to the definer or users with\nthe SUPER privilege.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/alter-view.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/alter-view.html'),(160,'SHOW DATABASES',27,'Syntax:\nSHOW {DATABASES | SCHEMAS}\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW DATABASES lists the databases on the MySQL server host. SHOW\nSCHEMAS is a synonym for SHOW DATABASES. The LIKE clause, if present,\nindicates which database names to match. The WHERE clause can be given\nto select rows using more general conditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\n\nYou see only those databases for which you have some kind of privilege,\nunless you have the global SHOW DATABASES privilege. You can also get\nthis list using the mysqlshow command.\n\nIf the server was started with the --skip-show-database option, you\ncannot use this statement at all unless you have the SHOW DATABASES\nprivilege.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-databases.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-databases.html'),(161,'~',20,'Syntax:\n~\n\nInvert all bits.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html\n\n','mysql> SELECT 5 & ~1;\n        -> 4\n','http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html'),(162,'TEXT',23,'TEXT[(M)] [CHARACTER SET charset_name] [COLLATE collation_name]\n\nA TEXT column with a maximum length of 65,535 (216 - 1) characters. The\neffective maximum length is less if the value contains multi-byte\ncharacters. Each TEXT value is stored using a 2-byte length prefix that\nindicates the number of bytes in the value.\n\nAn optional length M can be given for this type. If this is done, MySQL\ncreates the column as the smallest TEXT type large enough to hold\nvalues M characters long.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(163,'CONCAT_WS',38,'Syntax:\nCONCAT_WS(separator,str1,str2,...)\n\nCONCAT_WS() stands for Concatenate With Separator and is a special form\nof CONCAT(). The first argument is the separator for the rest of the\narguments. The separator is added between the strings to be\nconcatenated. The separator can be a string, as can the rest of the\narguments. If the separator is NULL, the result is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT CONCAT_WS(\',\',\'First name\',\'Second name\',\'Last Name\');\n        -> \'First name,Second name,Last Name\'\nmysql> SELECT CONCAT_WS(\',\',\'First name\',NULL,\'Last Name\');\n        -> \'First name,Last Name\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(164,'ROW_COUNT',17,'Syntax:\nROW_COUNT()\n\nROW_COUNT() returns the number of rows changed, deleted, or inserted by\nthe last statement if it was an UPDATE, DELETE, or INSERT. For other\nstatements, the value may not be meaningful.\n\nFor UPDATE statements, the affected-rows value by default is the number\nof rows actually changed. If you specify the CLIENT_FOUND_ROWS flag to\nmysql_real_connect() when connecting to mysqld, the affected-rows value\nis the number of rows \"found\"; that is, matched by the WHERE clause.\n\nFor REPLACE statements, the affected-rows value is 2 if the new row\nreplaced an old row, because in this case, one row was inserted after\nthe duplicate was deleted.\n\nFor INSERT ... ON DUPLICATE KEY UPDATE statements, the affected-rows\nvalue is 1 if the row is inserted as a new row and 2 if an existing row\nis updated.\n\nThe ROW_COUNT() value is similar to the value from the\nmysql_affected_rows() C API function and the row count that the mysql\nclient displays following statement execution.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> INSERT INTO t VALUES(1),(2),(3);\nQuery OK, 3 rows affected (0.00 sec)\nRecords: 3  Duplicates: 0  Warnings: 0\n\nmysql> SELECT ROW_COUNT();\n+-------------+\n| ROW_COUNT() |\n+-------------+\n|           3 |\n+-------------+\n1 row in set (0.00 sec)\n\nmysql> DELETE FROM t WHERE i IN(1,2);\nQuery OK, 2 rows affected (0.00 sec)\n\nmysql> SELECT ROW_COUNT();\n+-------------+\n| ROW_COUNT() |\n+-------------+\n|           2 |\n+-------------+\n1 row in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(165,'ASIN',4,'Syntax:\nASIN(X)\n\nReturns the arc sine of X, that is, the value whose sine is X. Returns\nNULL if X is not in the range -1 to 1.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT ASIN(0.2);\n        -> 0.20135792079033\nmysql> SELECT ASIN(\'foo\');\n\n+-------------+\n| ASIN(\'foo\') |\n+-------------+\n|           0 |\n+-------------+\n1 row in set, 1 warning (0.00 sec)\n\nmysql> SHOW WARNINGS;\n+---------+------+-----------------------------------------+\n| Level   | Code | Message                                 |\n+---------+------+-----------------------------------------+\n| Warning | 1292 | Truncated incorrect DOUBLE value: \'foo\' |\n+---------+------+-----------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(166,'SIGN',4,'Syntax:\nSIGN(X)\n\nReturns the sign of the argument as -1, 0, or 1, depending on whether X\nis negative, zero, or positive.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT SIGN(-32);\n        -> -1\nmysql> SELECT SIGN(0);\n        -> 0\nmysql> SELECT SIGN(234);\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(167,'SEC_TO_TIME',32,'Syntax:\nSEC_TO_TIME(seconds)\n\nReturns the seconds argument, converted to hours, minutes, and seconds,\nas a TIME value. The range of the result is constrained to that of the\nTIME data type. A warning occurs if the argument corresponds to a value\noutside that range.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT SEC_TO_TIME(2378);\n        -> \'00:39:38\'\nmysql> SELECT SEC_TO_TIME(2378) + 0;\n        -> 3938\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(168,'FLOAT',23,'FLOAT[(M,D)] [UNSIGNED] [ZEROFILL]\n\nA small (single-precision) floating-point number. Permissible values\nare -3.402823466E+38 to -1.175494351E-38, 0, and 1.175494351E-38 to\n3.402823466E+38. These are the theoretical limits, based on the IEEE\nstandard. The actual range might be slightly smaller depending on your\nhardware or operating system.\n\nM is the total number of digits and D is the number of digits following\nthe decimal point. If M and D are omitted, values are stored to the\nlimits permitted by the hardware. A single-precision floating-point\nnumber is accurate to approximately 7 decimal places.\n\nUNSIGNED, if specified, disallows negative values.\n\nUsing FLOAT might give you some unexpected problems because all\ncalculations in MySQL are done with double precision. See\nhttp://dev.mysql.com/doc/refman/5.1/en/no-matching-rows.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(169,'LOCATE',38,'Syntax:\nLOCATE(substr,str), LOCATE(substr,str,pos)\n\nThe first syntax returns the position of the first occurrence of\nsubstring substr in string str. The second syntax returns the position\nof the first occurrence of substring substr in string str, starting at\nposition pos. Returns 0 if substr is not in str.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT LOCATE(\'bar\', \'foobarbar\');\n        -> 4\nmysql> SELECT LOCATE(\'xbar\', \'foobar\');\n        -> 0\nmysql> SELECT LOCATE(\'bar\', \'foobarbar\', 5);\n        -> 7\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(170,'SHOW EVENTS',27,'Syntax:\nSHOW EVENTS [{FROM | IN} schema_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nThis statement displays information about Event Manager events. It\nrequires the EVENT privilege for the database from which the events are\nto be shown.\n\nIn its simplest form, SHOW EVENTS lists all of the events in the\ncurrent schema:\n\nmysql> SELECT CURRENT_USER(), SCHEMA();\n+----------------+----------+\n| CURRENT_USER() | SCHEMA() |\n+----------------+----------+\n| jon@ghidora    | myschema |\n+----------------+----------+\n1 row in set (0.00 sec)\n\nmysql> SHOW EVENTS\\G\n*************************** 1. row ***************************\n                  Db: myschema\n                Name: e_daily\n             Definer: jon@ghidora\n           Time zone: SYSTEM\n                Type: RECURRING\n          Execute at: NULL\n      Interval value: 10\n      Interval field: SECOND\n              Starts: 2006-02-09 10:41:23\n                Ends: NULL\n              Status: ENABLED\n          Originator: 0\ncharacter_set_client: latin1\ncollation_connection: latin1_swedish_ci\n  Database Collation: latin1_swedish_ci\n\nTo see events for a specific schema, use the FROM clause. For example,\nto see events for the test schema, use the following statement:\n\nSHOW EVENTS FROM test;\n\nThe LIKE clause, if present, indicates which event names to match. The\nWHERE clause can be given to select rows using more general conditions,\nas discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-events.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-events.html'),(171,'CHARSET',17,'Syntax:\nCHARSET(str)\n\nReturns the character set of the string argument.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> SELECT CHARSET(\'abc\');\n        -> \'latin1\'\nmysql> SELECT CHARSET(CONVERT(\'abc\' USING utf8));\n        -> \'utf8\'\nmysql> SELECT CHARSET(USER());\n        -> \'utf8\'\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(172,'SUBDATE',32,'Syntax:\nSUBDATE(date,INTERVAL expr unit), SUBDATE(expr,days)\n\nWhen invoked with the INTERVAL form of the second argument, SUBDATE()\nis a synonym for DATE_SUB(). For information on the INTERVAL unit\nargument, see the discussion for DATE_ADD().\n\nmysql> SELECT DATE_SUB(\'2008-01-02\', INTERVAL 31 DAY);\n        -> \'2007-12-02\'\nmysql> SELECT SUBDATE(\'2008-01-02\', INTERVAL 31 DAY);\n        -> \'2007-12-02\'\n\nThe second form enables the use of an integer value for days. In such\ncases, it is interpreted as the number of days to be subtracted from\nthe date or datetime expression expr.\n\nmysql> SELECT SUBDATE(\'2008-01-02 12:00:00\', 31);\n        -> \'2007-12-02 12:00:00\'\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(173,'DAYOFYEAR',32,'Syntax:\nDAYOFYEAR(date)\n\nReturns the day of the year for date, in the range 1 to 366.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT DAYOFYEAR(\'2007-02-03\');\n        -> 34\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(174,'%',4,'Syntax:\nN % M, N MOD M\n\nModulo operation. Returns the remainder of N divided by M. For more\ninformation, see the description for the MOD() function in\nhttp://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html'),(175,'LONGTEXT',23,'LONGTEXT [CHARACTER SET charset_name] [COLLATE collation_name]\n\nA TEXT column with a maximum length of 4,294,967,295 or 4GB (232 - 1)\ncharacters. The effective maximum length is less if the value contains\nmulti-byte characters. The effective maximum length of LONGTEXT columns\nalso depends on the configured maximum packet size in the client/server\nprotocol and available memory. Each LONGTEXT value is stored using a\n4-byte length prefix that indicates the number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(176,'KILL',27,'Syntax:\nKILL [CONNECTION | QUERY] thread_id\n\nEach connection to mysqld runs in a separate thread. You can see which\nthreads are running with the SHOW PROCESSLIST statement and kill a\nthread with the KILL thread_id statement.\n\nKILL permits an optional CONNECTION or QUERY modifier:\n\no KILL CONNECTION is the same as KILL with no modifier: It terminates\n  the connection associated with the given thread_id.\n\no KILL QUERY terminates the statement that the connection is currently\n  executing, but leaves the connection itself intact.\n\nIf you have the PROCESS privilege, you can see all threads. If you have\nthe SUPER privilege, you can kill all threads and statements.\nOtherwise, you can see and kill only your own threads and statements.\n\nYou can also use the mysqladmin processlist and mysqladmin kill\ncommands to examine and kill threads.\n\n*Note*: You cannot use KILL with the Embedded MySQL Server library\nbecause the embedded server merely runs inside the threads of the host\napplication. It does not create any connection threads of its own.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/kill.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/kill.html'),(177,'DISJOINT',31,'Disjoint(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 is spatially disjoint from (does\nnot intersect) g2.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(178,'ASTEXT',3,'AsText(g), AsWKT(g)\n\nConverts a value in internal geometry format to its WKT representation\nand returns the string result.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-to-convert-geometries-between-formats.html\n\n','mysql> SET @g = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT AsText(GeomFromText(@g));\n+--------------------------+\n| AsText(GeomFromText(@g)) |\n+--------------------------+\n| LINESTRING(1 1,2 2,3 3)  |\n+--------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/functions-to-convert-geometries-between-formats.html'),(179,'LPAD',38,'Syntax:\nLPAD(str,len,padstr)\n\nReturns the string str, left-padded with the string padstr to a length\nof len characters. If str is longer than len, the return value is\nshortened to len characters.\n\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT LPAD(\'hi\',4,\'??\');\n        -> \'??hi\'\nmysql> SELECT LPAD(\'hi\',1,\'??\');\n        -> \'h\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(180,'RESTORE TABLE',21,'Syntax:\nRESTORE TABLE tbl_name [, tbl_name] ... FROM \'/path/to/backup/directory\'\n\n*Note*: This statement is deprecated and is removed in MySQL 5.5.\n\nRESTORE TABLE restores the table or tables from a backup that was made\nwith BACKUP TABLE. The directory should be specified as a full path\nname.\n\nExisting tables are not overwritten; if you try to restore over an\nexisting table, an error occurs. Just as for BACKUP TABLE, RESTORE\nTABLE currently works only for MyISAM tables. Restored tables are not\nreplicated from master to slave.\n\nThe backup for each table consists of its .frm format file and .MYD\ndata file. The restore operation restores those files, and then uses\nthem to rebuild the .MYI index file. Restoring takes longer than\nbacking up due to the need to rebuild the indexes. The more indexes the\ntable has, the longer it takes.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/restore-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/restore-table.html'),(181,'DECLARE CONDITION',24,'Syntax:\nDECLARE condition_name CONDITION FOR condition_value\n\ncondition_value:\n    mysql_error_code\n  | SQLSTATE [VALUE] sqlstate_value\n\nThe DECLARE ... CONDITION statement declares a named error condition,\nassociating a name with a condition that needs specific handling. The\nname can be referred to in a subsequent DECLARE ... HANDLER statement\n(see [HELP DECLARE HANDLER]).\n\nCondition declarations must appear before cursor or handler\ndeclarations.\n\nThe condition_value for DECLARE ... CONDITION can be a MySQL error code\n(a number) or an SQLSTATE value (a 5-character string literal). You\nshould not use MySQL error code 0 or SQLSTATE values that begin with\n\'00\', because those indicate success rather than an error condition.\nFor a list of MySQL error codes and SQLSTATE values, see\nhttp://dev.mysql.com/doc/refman/5.1/en/error-messages-server.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/declare-condition.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/declare-condition.html'),(182,'OVERLAPS',31,'Overlaps(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 spatially overlaps g2. The term\nspatially overlaps is used if two geometries intersect and their\nintersection results in a geometry of the same dimension but not equal\nto either of the given geometries.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(183,'SET GLOBAL SQL_SLAVE_SKIP_COUNTER',8,'Syntax:\nSET GLOBAL sql_slave_skip_counter = N\n\nThis statement skips the next N events from the master. This is useful\nfor recovering from replication stops caused by a statement.\n\nThis statement is valid only when the slave threads are not running.\nOtherwise, it produces an error.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/set-global-sql-slave-skip-counter.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/set-global-sql-slave-skip-counter.html'),(184,'NUMGEOMETRIES',26,'NumGeometries(gc)\n\nReturns the number of geometries in the GeometryCollection value gc.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @gc = \'GeometryCollection(Point(1 1),LineString(2 2, 3 3))\';\nmysql> SELECT NumGeometries(GeomFromText(@gc));\n+----------------------------------+\n| NumGeometries(GeomFromText(@gc)) |\n+----------------------------------+\n|                                2 |\n+----------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(185,'MONTHNAME',32,'Syntax:\nMONTHNAME(date)\n\nReturns the full name of the month for date. As of MySQL 5.1.12, the\nlanguage used for the name is controlled by the value of the\nlc_time_names system variable\n(http://dev.mysql.com/doc/refman/5.1/en/locale-support.html).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT MONTHNAME(\'2008-02-03\');\n        -> \'February\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(186,'CHANGE MASTER TO',8,'Syntax:\nCHANGE MASTER TO option [, option] ...\n\noption:\n    MASTER_BIND = \'interface_name\'\n  | MASTER_HOST = \'host_name\'\n  | MASTER_USER = \'user_name\'\n  | MASTER_PASSWORD = \'password\'\n  | MASTER_PORT = port_num\n  | MASTER_CONNECT_RETRY = interval\n  | MASTER_HEARTBEAT_PERIOD = interval\n  | MASTER_LOG_FILE = \'master_log_name\'\n  | MASTER_LOG_POS = master_log_pos\n  | RELAY_LOG_FILE = \'relay_log_name\'\n  | RELAY_LOG_POS = relay_log_pos\n  | MASTER_SSL = {0|1}\n  | MASTER_SSL_CA = \'ca_file_name\'\n  | MASTER_SSL_CAPATH = \'ca_directory_name\'\n  | MASTER_SSL_CERT = \'cert_file_name\'\n  | MASTER_SSL_KEY = \'key_file_name\'\n  | MASTER_SSL_CIPHER = \'cipher_list\'\n  | MASTER_SSL_VERIFY_SERVER_CERT = {0|1}\n  | IGNORE_SERVER_IDS = (server_id_list)\n\nserver_id_list:\n    [server_id [, server_id] ... ]\n\nCHANGE MASTER TO changes the parameters that the slave server uses for\nconnecting to the master server, for reading the master binary log, and\nreading the slave relay log. It also updates the contents of the\nmaster.info and relay-log.info files. To use CHANGE MASTER TO, the\nslave replication threads must be stopped (use STOP SLAVE if\nnecessary).\n\nOptions not specified retain their value, except as indicated in the\nfollowing discussion. Thus, in most cases, there is no need to specify\noptions that do not change. For example, if the password to connect to\nyour MySQL master has changed, you just need to issue these statements\nto tell the slave about the new password:\n\nSTOP SLAVE; -- if replication was running\nCHANGE MASTER TO MASTER_PASSWORD=\'new3cret\';\nSTART SLAVE; -- if you want to restart replication\n\nMASTER_HOST, MASTER_USER, MASTER_PASSWORD, and MASTER_PORT provide\ninformation to the slave about how to connect to its master:\n\no MASTER_HOST and MASTER_PORT are the host name (or IP address) of the\n  master host and its TCP/IP port.\n\n  *Note*: Replication cannot use Unix socket files. You must be able to\n  connect to the master MySQL server using TCP/IP.\n\n  If you specify the MASTER_HOST or MASTER_PORT option, the slave\n  assumes that the master server is different from before (even if the\n  option value is the same as its current value.) In this case, the old\n  values for the master binary log file name and position are\n  considered no longer applicable, so if you do not specify\n  MASTER_LOG_FILE and MASTER_LOG_POS in the statement,\n  MASTER_LOG_FILE=\'\' and MASTER_LOG_POS=4 are silently appended to it.\n\n  Setting MASTER_HOST=\'\' (that is, setting its value explicitly to an\n  empty string) is not the same as not setting MASTER_HOST at all.\n  Setting this option to an empty string causes START SLAVE\n  subsequently to fail. This issue is addressed in MySQL 5.5. (Bug\n  #28796)\n\no MASTER_USER and MASTER_PASSWORD are the user name and password of the\n  account to use for connecting to the master.\n\n  Currently, a password used for a replication slave account is\n  effectively limited to 32 characters in length; the password can be\n  longer, but any excess characters are truncated. This is not due to\n  any limit imposed by the MySQL Server generally, but rather is an\n  issue specific to MySQL Replication. (For more information, see Bug\n  #43439.)\n\n  The text of a running CHANGE MASTER TO statement, including values\n  for MASTER_USER and MASTER_PASSWORD, can be seen in the output of a\n  concurrent SHOW PROCESSLIST statement.\n\nThe MASTER_SSL_xxx options provide information about using SSL for the\nconnection. They correspond to the --ssl-xxx options described in\nhttp://dev.mysql.com/doc/refman/5.1/en/ssl-options.html, and\nhttp://dev.mysql.com/doc/refman/5.1/en/replication-solutions-ssl.html.\nMASTER_SSL_VERIFY_SERVER_CERT was added in MySQL 5.1.18. These options\ncan be changed even on slaves that are compiled without SSL support.\nThey are saved to the master.info file, but are ignored if the slave\ndoes not have SSL support enabled.\n\nMASTER_CONNECT_RETRY specifies how many seconds to wait between connect\nretries. The default is 60. The number of reconnection attempts is\nlimited by the --master-retry-count server option; for more\ninformation, see\nhttp://dev.mysql.com/doc/refman/5.1/en/replication-options.html.\n\nThe next two options (MASTER_BIND and MASTER_HEARTBEAT_PERIOD) are\navailable in MySQL Cluster NDB 6.3 and later, but are not supported in\nmainline MySQL 5.1:\n\nMASTER_BIND is for use on replication slaves having multiple network\ninterfaces, and determines which of the slave\'s network interfaces is\nchosen for connecting to the master.\n\nThe ability to bind a replication slave to specific network interface\nwas added in MySQL Cluster NDB 6.3.4.\n\nMASTER_HEARTBEAT_PERIOD sets the interval in seconds between\nreplication heartbeats. Whenever the master\'s binary log is updated\nwith an event, the waiting period for the next heartbeat is reset.\ninterval is a decimal value having the range 0 to 4294967 seconds and a\nresolution in milliseconds; the smallest nonzero value is 0.001.\nHeartbeats are sent by the master only if there are no unsent events in\nthe binary log file for a period longer than interval.\n\nSetting interval to 0 disables heartbeats altogether. The default value\nfor interval is equal to the value of slave_net_timeout divided by 2.\n\nSetting @@global.slave_net_timeout to a value less than that of the\ncurrent heartbeat interval results in a warning being issued. The\neffect of issuing RESET SLAVE on the heartbeat interval is to reset it\nto the default value.\n\nMASTER_HEARTBEAT_PERIOD was added in MySQL Cluster NDB 6.3.4.\n\nMASTER_LOG_FILE and MASTER_LOG_POS are the coordinates at which the\nslave I/O thread should begin reading from the master the next time the\nthread starts. RELAY_LOG_FILE and RELAY_LOG_POS are the coordinates at\nwhich the slave SQL thread should begin reading from the relay log the\nnext time the thread starts. If you specify either of MASTER_LOG_FILE\nor MASTER_LOG_POS, you cannot specify RELAY_LOG_FILE or RELAY_LOG_POS.\nIf neither of MASTER_LOG_FILE or MASTER_LOG_POS is specified, the slave\nuses the last coordinates of the slave SQL thread before CHANGE MASTER\nTO was issued. This ensures that there is no discontinuity in\nreplication, even if the slave SQL thread was late compared to the\nslave I/O thread, when you merely want to change, say, the password to\nuse.\n\nCHANGE MASTER TO deletes all relay log files and starts a new one,\nunless you specify RELAY_LOG_FILE or RELAY_LOG_POS. In that case, relay\nlog files are kept; the relay_log_purge global variable is set silently\nto 0.\n\nIGNORE_SERVER_IDS was added in MySQL Cluster NDB 6.1.29, MySQL Cluster\nNDB 6.3.31, MySQL Cluster NDB 7.0.11, and MySQL Cluster NDB 7.1.0 (see\nBug #47037). This option takes a comma-separated list of 0 or more\nserver IDs. Events originating from the corresponding servers are\nignored, with the exception of log rotation and deletion events, which\nare still recorded in the relay log.\n\nIn circular replication, the originating server normally acts as the\nterminator of its own events, so that they are not applied more than\nonce. Thus, this option is useful in circular replication when one of\nthe servers in the circle is removed. Suppose that you have a circular\nreplication setup with 4 servers, having server IDs 1, 2, 3, and 4, and\nserver 3 fails. When bridging the gap by starting replication from\nserver 2 to server 4, you can include IGNORE_SERVER_IDS = (3) in the\nCHANGE MASTER TO statement that you issue on server 4 to tell it to use\nserver 2 as its master instead of server 3. Doing so causes it to\nignore and not to propagate any statements that originated with the\nserver that is no longer in use.\n\nIf a CHANGE MASTER TO statement is issued without any IGNORE_SERVER_IDS\noption, any existing list is preserved; RESET SLAVE also has no effect\non the server ID list. To clear the list of ignored servers, it is\nnecessary to use the option with an empty list:\n\nCHANGE MASTER TO IGNORE_SERVER_IDS = ();\n\nIf IGNORE_SERVER_IDS contains the server\'s own ID and the server was\nstarted with the --replicate-same-server-id option enabled, an error\nresults.\n\nBeginning with MySQL 5.1.47, invoking CHANGE MASTER TO causes the\nprevious values for MASTER_HOST, MASTER_PORT, MASTER_LOG_FILE, and\nMASTER_LOG_POS to be written to the error log, along with other\ninformation about the slave\'s state prior to execution.\n\nCHANGE MASTER TO is useful for setting up a slave when you have the\nsnapshot of the master and have recorded the master binary log\ncoordinates corresponding to the time of the snapshot. After loading\nthe snapshot into the slave to synchronize it to the slave, you can run\nCHANGE MASTER TO MASTER_LOG_FILE=\'log_name\', MASTER_LOG_POS=log_pos on\nthe slave to specify the coordinates at which the slave should begin\nreading the master binary log.\n\nThe following example changes the master server the slave uses and\nestablishes the master binary log coordinates from which the slave\nbegins reading. This is used when you want to set up the slave to\nreplicate the master:\n\nCHANGE MASTER TO\n  MASTER_HOST=\'master2.mycompany.com\',\n  MASTER_USER=\'replication\',\n  MASTER_PASSWORD=\'bigs3cret\',\n  MASTER_PORT=3306,\n  MASTER_LOG_FILE=\'master2-bin.001\',\n  MASTER_LOG_POS=4,\n  MASTER_CONNECT_RETRY=10;\n\nThe next example shows an operation that is less frequently employed.\nIt is used when the slave has relay log files that you want it to\nexecute again for some reason. To do this, the master need not be\nreachable. You need only use CHANGE MASTER TO and start the SQL thread\n(START SLAVE SQL_THREAD):\n\nCHANGE MASTER TO\n  RELAY_LOG_FILE=\'slave-relay-bin.006\',\n  RELAY_LOG_POS=4025;\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/change-master-to.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/change-master-to.html'),(187,'DROP DATABASE',40,'Syntax:\nDROP {DATABASE | SCHEMA} [IF EXISTS] db_name\n\nDROP DATABASE drops all tables in the database and deletes the\ndatabase. Be very careful with this statement! To use DROP DATABASE,\nyou need the DROP privilege on the database. DROP SCHEMA is a synonym\nfor DROP DATABASE.\n\n*Important*: When a database is dropped, user privileges on the\ndatabase are not automatically dropped. See [HELP GRANT].\n\nIF EXISTS is used to prevent an error from occurring if the database\ndoes not exist.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-database.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-database.html'),(188,'MBREQUAL',6,'MBREqual(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangles of\nthe two geometries g1 and g2 are the same.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(189,'TIMESTAMP FUNCTION',32,'Syntax:\nTIMESTAMP(expr), TIMESTAMP(expr1,expr2)\n\nWith a single argument, this function returns the date or datetime\nexpression expr as a datetime value. With two arguments, it adds the\ntime expression expr2 to the date or datetime expression expr1 and\nreturns the result as a datetime value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT TIMESTAMP(\'2003-12-31\');\n        -> \'2003-12-31 00:00:00\'\nmysql> SELECT TIMESTAMP(\'2003-12-31 12:00:00\',\'12:00:00\');\n        -> \'2004-01-01 00:00:00\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(190,'PROCEDURE ANALYSE',34,'Syntax:\nANALYSE([max_elements[,max_memory]])\n\nANALYSE() examines the result from a query and returns an analysis of\nthe results that suggests optimal data types for each column that may\nhelp reduce table sizes. To obtain this analysis, append PROCEDURE\nANALYSE to the end of a SELECT statement:\n\nSELECT ... FROM ... WHERE ... PROCEDURE ANALYSE([max_elements,[max_memory]])\n\nFor example:\n\nSELECT col1, col2 FROM table1 PROCEDURE ANALYSE(10, 2000);\n\nThe results show some statistics for the values returned by the query,\nand propose an optimal data type for the columns. This can be helpful\nfor checking your existing tables, or after importing new data. You may\nneed to try different settings for the arguments so that PROCEDURE\nANALYSE() does not suggest the ENUM data type when it is not\nappropriate.\n\nThe arguments are optional and are used as follows:\n\no max_elements (default 256) is the maximum number of distinct values\n  that ANALYSE() notices per column. This is used by ANALYSE() to check\n  whether the optimal data type should be of type ENUM; if there are\n  more than max_elements distinct values, then ENUM is not a suggested\n  type.\n\no max_memory (default 8192) is the maximum amount of memory that\n  ANALYSE() should allocate per column while trying to find all\n  distinct values.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/procedure-analyse.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/procedure-analyse.html'),(191,'HELP_VERSION',9,'This help information was generated from the MySQL 5.1 Reference Manual\non: 2013-11-04 (revision: 36590)\n\nThis information applies to MySQL 5.1 through 5.1.74.\n','',''),(192,'CHARACTER_LENGTH',38,'Syntax:\nCHARACTER_LENGTH(str)\n\nCHARACTER_LENGTH() is a synonym for CHAR_LENGTH().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(193,'SHOW GRANTS',27,'Syntax:\nSHOW GRANTS [FOR user]\n\nThis statement lists the GRANT statement or statements that must be\nissued to duplicate the privileges that are granted to a MySQL user\naccount. The account is named using the same format as for the GRANT\nstatement; for example, \'jeffrey\'@\'localhost\'. If you specify only the\nuser name part of the account name, a host name part of \'%\' is used.\nFor additional information about specifying account names, see [HELP\nGRANT].\n\nmysql> SHOW GRANTS FOR \'root\'@\'localhost\';\n+---------------------------------------------------------------------+\n| Grants for root@localhost                                           |\n+---------------------------------------------------------------------+\n| GRANT ALL PRIVILEGES ON *.* TO \'root\'@\'localhost\' WITH GRANT OPTION |\n+---------------------------------------------------------------------+\n\nTo list the privileges granted to the account that you are using to\nconnect to the server, you can use any of the following statements:\n\nSHOW GRANTS;\nSHOW GRANTS FOR CURRENT_USER;\nSHOW GRANTS FOR CURRENT_USER();\n\nAs of MySQL 5.1.12, if SHOW GRANTS FOR CURRENT_USER (or any of the\nequivalent syntaxes) is used in DEFINER context, such as within a\nstored procedure that is defined with SQL SECURITY DEFINER), the grants\ndisplayed are those of the definer and not the invoker.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-grants.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-grants.html'),(194,'SHOW PRIVILEGES',27,'Syntax:\nSHOW PRIVILEGES\n\nSHOW PRIVILEGES shows the list of system privileges that the MySQL\nserver supports. The exact list of privileges depends on the version of\nyour server.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-privileges.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-privileges.html'),(195,'CREATE TABLESPACE',40,'Syntax:\nCREATE TABLESPACE tablespace_name\n    ADD DATAFILE \'file_name\'\n    USE LOGFILE GROUP logfile_group\n    [EXTENT_SIZE [=] extent_size]\n    [INITIAL_SIZE [=] initial_size]\n    [AUTOEXTEND_SIZE [=] autoextend_size]\n    [MAX_SIZE [=] max_size]\n    [NODEGROUP [=] nodegroup_id]\n    [WAIT]\n    [COMMENT [=] comment_text]\n    ENGINE [=] engine_name\n\nThis statement is used to create a tablespace, which can contain one or\nmore data files, providing storage space for tables. One data file is\ncreated and added to the tablespace using this statement. Additional\ndata files may be added to the tablespace by using the ALTER TABLESPACE\nstatement (see [HELP ALTER TABLESPACE]). For rules covering the naming\nof tablespaces, see\nhttp://dev.mysql.com/doc/refman/5.1/en/identifiers.html.\n\n*Note*: All MySQL Cluster Disk Data objects share the same namespace.\nThis means that each Disk Data object must be uniquely named (and not\nmerely each Disk Data object of a given type). For example, you cannot\nhave a tablespace and a log file group with the same name, or a\ntablespace and a data file with the same name.\n\nPrior to MySQL Cluster NDB 6.2.17, 6.3.23, and 6.4.3, path and file\nnames for data files could not be longer than 128 characters. (Bug\n#31770)\n\nA log file group of one or more UNDO log files must be assigned to the\ntablespace to be created with the USE LOGFILE GROUP clause.\nlogfile_group must be an existing log file group created with CREATE\nLOGFILE GROUP (see [HELP CREATE LOGFILE GROUP]). Multiple tablespaces\nmay use the same log file group for UNDO logging.\n\nThe EXTENT_SIZE sets the size, in bytes, of the extents used by any\nfiles belonging to the tablespace. The default value is 1M. The minimum\nsize is 32K, and theoretical maximum is 2G, although the practical\nmaximum size depends on a number of factors. In most cases, changing\nthe extent size does not have any measurable effect on performance, and\nthe default value is recommended for all but the most unusual\nsituations.\n\nAn extent is a unit of disk space allocation. One extent is filled with\nas much data as that extent can contain before another extent is used.\nIn theory, up to 65,535 (64K) extents may used per data file; however,\nthe recommended maximum is 32,768 (32K). The recommended maximum size\nfor a single data file is 32G---that is, 32K extents x 1 MB per extent.\nIn addition, once an extent is allocated to a given partition, it\ncannot be used to store data from a different partition; an extent\ncannot store data from more than one partition. This means, for example\nthat a tablespace having a single datafile whose INITIAL_SIZE is 256 MB\nand whose EXTENT_SIZE is 128M has just two extents, and so can be used\nto store data from at most two different disk data table partitions.\n\nYou can see how many extents remain free in a given data file by\nquerying the INFORMATION_SCHEMA.FILES table, and so derive an estimate\nfor how much space remains free in the file. For further discussion and\nexamples, see http://dev.mysql.com/doc/refman/5.1/en/files-table.html.\n\nThe INITIAL_SIZE parameter sets the data file\'s total size in bytes.\nOnce the file has been created, its size cannot be changed; however,\nyou can add more data files to the tablespace using ALTER TABLESPACE\n... ADD DATAFILE. See [HELP ALTER TABLESPACE].\n\nINITIAL_SIZE is optional; its default value is 128M.\n\nOn 32-bit systems, the maximum supported value for INITIAL_SIZE is 4G.\n(Bug #29186)\n\nWhen setting EXTENT_SIZE or INITIAL_SIZE (either or both), you may\noptionally follow the number with a one-letter abbreviation for an\norder of magnitude, similar to those used in my.cnf. Generally, this is\none of the letters M (for megabytes) or G (for gigabytes).\n\nINITIAL_SIZE, EXTENT_SIZE, and UNDO_BUFFER_SIZE are subject to rounding\nas follows:\n\no EXTENT_SIZE and UNDO_BUFFER_SIZE are each rounded up to the nearest\n  whole multiple of 32K.\n\no INITIAL_SIZE is rounded down to the nearest whole multiple of 32K.\n\n  For data files, INITIAL_SIZE is subject to further rounding; the\n  result just obtained is rounded up to the nearest whole multiple of\n  EXTENT_SIZE (after any rounding).\n\nThe rounding just described has always (since Disk Data tablespaces\nwere introduced in MySQL 5.1.6) been performed implicitly, but\nbeginning with MySQL Cluster NDB 6.2.19, MySQL Cluster NDB 6.3.32,\nMySQL Cluster NDB 7.0.13, and MySQL Cluster NDB 7.1.2, this rounding is\ndone explicitly, and a warning is issued by the MySQL Server when any\nsuch rounding is performed. The rounded values are also used by the NDB\nkernel for calculating INFORMATION_SCHEMA.FILES column values and other\npurposes. However, to avoid an unexpected result, we suggest that you\nalways use whole multiples of 32K in specifying these options.\n\nAUTOEXTEND_SIZE, MAX_SIZE, NODEGROUP, WAIT, and COMMENT are parsed but\nignored, and so currently have no effect. These options are intended\nfor future expansion.\n\nThe ENGINE parameter determines the storage engine which uses this\ntablespace, with engine_name being the name of the storage engine. In\nMySQL 5.1, engine_name must be one of the values NDB or NDBCLUSTER.\n\nWhen CREATE TABLESPACE is used with ENGINE = NDB, a tablespace and\nassociated data file are created on each Cluster data node. You can\nverify that the data files were created and obtain information about\nthem by querying the INFORMATION_SCHEMA.FILES table. For example:\n\nmysql> SELECT LOGFILE_GROUP_NAME, FILE_NAME, EXTRA\n    -> FROM INFORMATION_SCHEMA.FILES\n    -> WHERE TABLESPACE_NAME = \'newts\' AND FILE_TYPE = \'DATAFILE\';\n+--------------------+-------------+----------------+\n| LOGFILE_GROUP_NAME | FILE_NAME   | EXTRA          |\n+--------------------+-------------+----------------+\n| lg_3               | newdata.dat | CLUSTER_NODE=3 |\n| lg_3               | newdata.dat | CLUSTER_NODE=4 |\n+--------------------+-------------+----------------+\n2 rows in set (0.01 sec)\n\n(See http://dev.mysql.com/doc/refman/5.1/en/files-table.html.)\n\nCREATE TABLESPACE was added in MySQL 5.1.6. In MySQL 5.1, it is useful\nonly with Disk Data storage for MySQL Cluster. See\nhttp://dev.mysql.com/doc/refman/5.1/en/mysql-cluster-disk-data.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-tablespace.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-tablespace.html'),(196,'INSERT FUNCTION',38,'Syntax:\nINSERT(str,pos,len,newstr)\n\nReturns the string str, with the substring beginning at position pos\nand len characters long replaced by the string newstr. Returns the\noriginal string if pos is not within the length of the string. Replaces\nthe rest of the string from position pos if len is not within the\nlength of the rest of the string. Returns NULL if any argument is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT INSERT(\'Quadratic\', 3, 4, \'What\');\n        -> \'QuWhattic\'\nmysql> SELECT INSERT(\'Quadratic\', -1, 4, \'What\');\n        -> \'Quadratic\'\nmysql> SELECT INSERT(\'Quadratic\', 3, 100, \'What\');\n        -> \'QuWhat\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(197,'CRC32',4,'Syntax:\nCRC32(expr)\n\nComputes a cyclic redundancy check value and returns a 32-bit unsigned\nvalue. The result is NULL if the argument is NULL. The argument is\nexpected to be a string and (if possible) is treated as one if it is\nnot.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT CRC32(\'MySQL\');\n        -> 3259397556\nmysql> SELECT CRC32(\'mysql\');\n        -> 2501908538\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(198,'XOR',15,'Syntax:\nXOR\n\nLogical XOR. Returns NULL if either operand is NULL. For non-NULL\noperands, evaluates to 1 if an odd number of operands is nonzero,\notherwise 0 is returned.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/logical-operators.html\n\n','mysql> SELECT 1 XOR 1;\n        -> 0\nmysql> SELECT 1 XOR 0;\n        -> 1\nmysql> SELECT 1 XOR NULL;\n        -> NULL\nmysql> SELECT 1 XOR 1 XOR 1;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/logical-operators.html'),(199,'STARTPOINT',13,'StartPoint(ls)\n\nReturns the Point that is the start point of the LineString value ls.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @ls = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT AsText(StartPoint(GeomFromText(@ls)));\n+---------------------------------------+\n| AsText(StartPoint(GeomFromText(@ls))) |\n+---------------------------------------+\n| POINT(1 1)                            |\n+---------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(200,'GRANT',10,'Syntax:\nGRANT\n    priv_type [(column_list)]\n      [, priv_type [(column_list)]] ...\n    ON [object_type] priv_level\n    TO user_specification [, user_specification] ...\n    [REQUIRE {NONE | ssl_option [[AND] ssl_option] ...}]\n    [WITH with_option ...]\n\nobject_type:\n    TABLE\n  | FUNCTION\n  | PROCEDURE\n\npriv_level:\n    *\n  | *.*\n  | db_name.*\n  | db_name.tbl_name\n  | tbl_name\n  | db_name.routine_name\n\nuser_specification:\n    user [IDENTIFIED BY [PASSWORD] \'password\']\n\nssl_option:\n    SSL\n  | X509\n  | CIPHER \'cipher\'\n  | ISSUER \'issuer\'\n  | SUBJECT \'subject\'\n\nwith_option:\n    GRANT OPTION\n  | MAX_QUERIES_PER_HOUR count\n  | MAX_UPDATES_PER_HOUR count\n  | MAX_CONNECTIONS_PER_HOUR count\n  | MAX_USER_CONNECTIONS count\n\nThe GRANT statement grants privileges to MySQL user accounts. GRANT\nalso serves to specify other account characteristics such as use of\nsecure connections and limits on access to server resources. To use\nGRANT, you must have the GRANT OPTION privilege, and you must have the\nprivileges that you are granting.\n\nNormally, a database administrator first uses CREATE USER to create an\naccount, then GRANT to define its privileges and characteristics. For\nexample:\n\nCREATE USER \'jeffrey\'@\'localhost\' IDENTIFIED BY \'mypass\';\nGRANT ALL ON db1.* TO \'jeffrey\'@\'localhost\';\nGRANT SELECT ON db2.invoice TO \'jeffrey\'@\'localhost\';\nGRANT USAGE ON *.* TO \'jeffrey\'@\'localhost\' WITH MAX_QUERIES_PER_HOUR 90;\n\nHowever, if an account named in a GRANT statement does not already\nexist, GRANT may create it under the conditions described later in the\ndiscussion of the NO_AUTO_CREATE_USER SQL mode.\n\nThe REVOKE statement is related to GRANT and enables administrators to\nremove account privileges. See [HELP REVOKE].\n\nWhen successfully executed from the mysql program, GRANT responds with\nQuery OK, 0 rows affected. To determine what privileges result from the\noperation, use SHOW GRANTS. See [HELP SHOW GRANTS].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/grant.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/grant.html'),(201,'DECLARE VARIABLE',24,'Syntax:\nDECLARE var_name [, var_name] ... type [DEFAULT value]\n\nThis statement declares local variables within stored programs. To\nprovide a default value for a variable, include a DEFAULT clause. The\nvalue can be specified as an expression; it need not be a constant. If\nthe DEFAULT clause is missing, the initial value is NULL.\n\nLocal variables are treated like stored routine parameters with respect\nto data type and overflow checking. See [HELP CREATE PROCEDURE].\n\nVariable declarations must appear before cursor or handler\ndeclarations.\n\nLocal variable names are not case sensitive. Permissible characters and\nquoting rules are the same as for other identifiers, as described in\nhttp://dev.mysql.com/doc/refman/5.1/en/identifiers.html.\n\nThe scope of a local variable is the BEGIN ... END block within which\nit is declared. The variable can be referred to in blocks nested within\nthe declaring block, except those blocks that declare a variable with\nthe same name.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/declare-local-variable.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/declare-local-variable.html'),(202,'MPOLYFROMTEXT',3,'MPolyFromText(wkt[,srid]), MultiPolygonFromText(wkt[,srid])\n\nConstructs a MULTIPOLYGON value using its WKT representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(203,'MBRINTERSECTS',6,'MBRIntersects(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangles of\nthe two geometries g1 and g2 intersect.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(204,'BIT_OR',16,'Syntax:\nBIT_OR(expr)\n\nReturns the bitwise OR of all bits in expr. The calculation is\nperformed with 64-bit (BIGINT) precision.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(205,'YEARWEEK',32,'Syntax:\nYEARWEEK(date), YEARWEEK(date,mode)\n\nReturns year and week for a date. The mode argument works exactly like\nthe mode argument to WEEK(). The year in the result may be different\nfrom the year in the date argument for the first and the last week of\nthe year.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT YEARWEEK(\'1987-01-01\');\n        -> 198653\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(206,'NOT BETWEEN',19,'Syntax:\nexpr NOT BETWEEN min AND max\n\nThis is the same as NOT (expr BETWEEN min AND max).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(207,'IS NOT',19,'Syntax:\nIS NOT boolean_value\n\nTests a value against a boolean value, where boolean_value can be TRUE,\nFALSE, or UNKNOWN.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 1 IS NOT UNKNOWN, 0 IS NOT UNKNOWN, NULL IS NOT UNKNOWN;\n        -> 1, 1, 0\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(208,'LOG10',4,'Syntax:\nLOG10(X)\n\nReturns the base-10 logarithm of X.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT LOG10(2);\n        -> 0.30102999566398\nmysql> SELECT LOG10(100);\n        -> 2\nmysql> SELECT LOG10(-100);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(209,'SQRT',4,'Syntax:\nSQRT(X)\n\nReturns the square root of a nonnegative number X.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT SQRT(4);\n        -> 2\nmysql> SELECT SQRT(20);\n        -> 4.4721359549996\nmysql> SELECT SQRT(-16);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(210,'DECIMAL',23,'DECIMAL[(M[,D])] [UNSIGNED] [ZEROFILL]\n\nA packed \"exact\" fixed-point number. M is the total number of digits\n(the precision) and D is the number of digits after the decimal point\n(the scale). The decimal point and (for negative numbers) the \"-\" sign\nare not counted in M. If D is 0, values have no decimal point or\nfractional part. The maximum number of digits (M) for DECIMAL is 65.\nThe maximum number of supported decimals (D) is 30. If D is omitted,\nthe default is 0. If M is omitted, the default is 10.\n\nUNSIGNED, if specified, disallows negative values.\n\nAll basic calculations (+, -, *, /) with DECIMAL columns are done with\na precision of 65 digits.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(211,'CREATE INDEX',40,'Syntax:\nCREATE [ONLINE|OFFLINE] [UNIQUE|FULLTEXT|SPATIAL] INDEX index_name\n    [index_type]\n    ON tbl_name (index_col_name,...)\n    [index_option] ...\n\nindex_col_name:\n    col_name [(length)] [ASC | DESC]\n\nindex_type:\n    USING {BTREE | HASH}\n\nindex_option:\n    KEY_BLOCK_SIZE [=] value\n  | index_type\n  | WITH PARSER parser_name\n\nCREATE INDEX is mapped to an ALTER TABLE statement to create indexes.\nSee [HELP ALTER TABLE]. CREATE INDEX cannot be used to create a PRIMARY\nKEY; use ALTER TABLE instead. For more information about indexes, see\nhttp://dev.mysql.com/doc/refman/5.1/en/mysql-indexes.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-index.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-index.html'),(212,'CREATE FUNCTION',40,'The CREATE FUNCTION statement is used to create stored functions and\nuser-defined functions (UDFs):\n\no For information about creating stored functions, see [HELP CREATE\n  PROCEDURE].\n\no For information about creating user-defined functions, see [HELP\n  CREATE FUNCTION UDF].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-function.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-function.html'),(213,'ALTER DATABASE',40,'Syntax:\nALTER {DATABASE | SCHEMA} [db_name]\n    alter_specification ...\nALTER {DATABASE | SCHEMA} db_name\n    UPGRADE DATA DIRECTORY NAME\n\nalter_specification:\n    [DEFAULT] CHARACTER SET [=] charset_name\n  | [DEFAULT] COLLATE [=] collation_name\n\nALTER DATABASE enables you to change the overall characteristics of a\ndatabase. These characteristics are stored in the db.opt file in the\ndatabase directory. To use ALTER DATABASE, you need the ALTER privilege\non the database. ALTER SCHEMA is a synonym for ALTER DATABASE.\n\nThe database name can be omitted from the first syntax, in which case\nthe statement applies to the default database.\n\nNational Language Characteristics\n\nThe CHARACTER SET clause changes the default database character set.\nThe COLLATE clause changes the default database collation.\nhttp://dev.mysql.com/doc/refman/5.1/en/charset.html, discusses\ncharacter set and collation names.\n\nYou can see what character sets and collations are available using,\nrespectively, the SHOW CHARACTER SET and SHOW COLLATION statements. See\n[HELP SHOW CHARACTER SET], and [HELP SHOW COLLATION], for more\ninformation.\n\nIf you change the default character set or collation for a database,\nstored routines that use the database defaults must be dropped and\nrecreated so that they use the new defaults. (In a stored routine,\nvariables with character data types use the database defaults if the\ncharacter set or collation are not specified explicitly. See [HELP\nCREATE PROCEDURE].)\n\nUpgrading from Versions Older than MySQL 5.1\n\nThe syntax that includes the UPGRADE DATA DIRECTORY NAME clause was\nadded in MySQL 5.1.23. It updates the name of the directory associated\nwith the database to use the encoding implemented in MySQL 5.1 for\nmapping database names to database directory names (see\nhttp://dev.mysql.com/doc/refman/5.1/en/identifier-mapping.html). This\nclause is for use under these conditions:\n\no It is intended when upgrading MySQL to 5.1 or later from older\n  versions.\n\no It is intended to update a database directory name to the current\n  encoding format if the name contains special characters that need\n  encoding.\n\no The statement is used by mysqlcheck (as invoked by mysql_upgrade).\n\nFor example, if a database in MySQL 5.0 has the name a-b-c, the name\ncontains instances of the - (dash) character. In MySQL 5.0, the\ndatabase directory is also named a-b-c, which is not necessarily safe\nfor all file systems. In MySQL 5.1 and later, the same database name is\nencoded as a@002db@002dc to produce a file system-neutral directory\nname.\n\nWhen a MySQL installation is upgraded to MySQL 5.1 or later from an\nolder version,the server displays a name such as a-b-c (which is in the\nold format) as #mysql50#a-b-c, and you must refer to the name using the\n#mysql50# prefix. Use UPGRADE DATA DIRECTORY NAME in this case to\nexplicitly tell the server to re-encode the database directory name to\nthe current encoding format:\n\nALTER DATABASE `#mysql50#a-b-c` UPGRADE DATA DIRECTORY NAME;\n\nAfter executing this statement, you can refer to the database as a-b-c\nwithout the special #mysql50# prefix.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/alter-database.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/alter-database.html'),(214,'GEOMETRYN',26,'GeometryN(gc,N)\n\nReturns the N-th geometry in the GeometryCollection value gc.\nGeometries are numbered beginning with 1.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @gc = \'GeometryCollection(Point(1 1),LineString(2 2, 3 3))\';\nmysql> SELECT AsText(GeometryN(GeomFromText(@gc),1));\n+----------------------------------------+\n| AsText(GeometryN(GeomFromText(@gc),1)) |\n+----------------------------------------+\n| POINT(1 1)                             |\n+----------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(215,'<<',20,'Syntax:\n<<\n\nShifts a longlong (BIGINT) number to the left.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html\n\n','mysql> SELECT 1 << 2;\n        -> 4\n','http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html'),(216,'SHOW TABLE STATUS',27,'Syntax:\nSHOW TABLE STATUS [{FROM | IN} db_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW TABLE STATUS works likes SHOW TABLES, but provides a lot of\ninformation about each non-TEMPORARY table. You can also get this list\nusing the mysqlshow --status db_name command. The LIKE clause, if\npresent, indicates which table names to match. The WHERE clause can be\ngiven to select rows using more general conditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-table-status.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-table-status.html'),(217,'MD5',12,'Syntax:\nMD5(str)\n\nCalculates an MD5 128-bit checksum for the string. The value is\nreturned as a binary string of 32 hex digits, or NULL if the argument\nwas NULL. The return value can, for example, be used as a hash key. See\nthe notes at the beginning of this section about storing hash values\nefficiently.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','mysql> SELECT MD5(\'testing\');\n        -> \'ae2b1fca515949e5d54fb22b8ed95575\'\n','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(218,'<',19,'Syntax:\n<\n\nLess than:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 2 < 2;\n        -> 0\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(219,'UNIX_TIMESTAMP',32,'Syntax:\nUNIX_TIMESTAMP(), UNIX_TIMESTAMP(date)\n\nIf called with no argument, returns a Unix timestamp (seconds since\n\'1970-01-01 00:00:00\' UTC) as an unsigned integer. If UNIX_TIMESTAMP()\nis called with a date argument, it returns the value of the argument as\nseconds since \'1970-01-01 00:00:00\' UTC. date may be a DATE string, a\nDATETIME string, a TIMESTAMP, or a number in the format YYMMDD or\nYYYYMMDD. The server interprets date as a value in the current time\nzone and converts it to an internal value in UTC. Clients can set their\ntime zone as described in\nhttp://dev.mysql.com/doc/refman/5.1/en/time-zone-support.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT UNIX_TIMESTAMP();\n        -> 1196440210\nmysql> SELECT UNIX_TIMESTAMP(\'2007-11-30 10:30:19\');\n        -> 1196440219\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(220,'DAYOFMONTH',32,'Syntax:\nDAYOFMONTH(date)\n\nReturns the day of the month for date, in the range 1 to 31, or 0 for\ndates such as \'0000-00-00\' or \'2008-00-00\' that have a zero day part.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT DAYOFMONTH(\'2007-02-03\');\n        -> 3\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(221,'ASCII',38,'Syntax:\nASCII(str)\n\nReturns the numeric value of the leftmost character of the string str.\nReturns 0 if str is the empty string. Returns NULL if str is NULL.\nASCII() works for 8-bit characters.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT ASCII(\'2\');\n        -> 50\nmysql> SELECT ASCII(2);\n        -> 50\nmysql> SELECT ASCII(\'dx\');\n        -> 100\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(222,'DIV',4,'Syntax:\nDIV\n\nInteger division. Similar to FLOOR(), but is safe with BIGINT values.\nIncorrect results may occur for noninteger operands that exceed BIGINT\nrange.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html\n\n','mysql> SELECT 5 DIV 2;\n        -> 2\n','http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html'),(223,'RENAME USER',10,'Syntax:\nRENAME USER old_user TO new_user\n    [, old_user TO new_user] ...\n\nThe RENAME USER statement renames existing MySQL accounts. To use it,\nyou must have the global CREATE USER privilege or the UPDATE privilege\nfor the mysql database. An error occurs if any old account does not\nexist or any new account exists. Each account name uses the format\ndescribed in http://dev.mysql.com/doc/refman/5.1/en/account-names.html.\nFor example:\n\nRENAME USER \'jeffrey\'@\'localhost\' TO \'jeff\'@\'127.0.0.1\';\n\nIf you specify only the user name part of the account name, a host name\npart of \'%\' is used.\n\nRENAME USER causes the privileges held by the old user to be those held\nby the new user. However, RENAME USER does not automatically drop or\ninvalidate databases or objects within them that the old user created.\nThis includes stored programs or views for which the DEFINER attribute\nnames the old user. Attempts to access such objects may produce an\nerror if they execute in definer security context. (For information\nabout security context, see\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-programs-security.html.)\n\nThe privilege changes take effect as indicated in\nhttp://dev.mysql.com/doc/refman/5.1/en/privilege-changes.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/rename-user.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/rename-user.html'),(224,'SHOW SLAVE STATUS',27,'Syntax:\nSHOW SLAVE STATUS\n\nThis statement provides status information on essential parameters of\nthe slave threads. It requires either the SUPER or REPLICATION CLIENT\nprivilege.\n\nIf you issue this statement using the mysql client, you can use a \\G\nstatement terminator rather than a semicolon to obtain a more readable\nvertical layout:\n\nmysql> SHOW SLAVE STATUS\\G\n*************************** 1. row ***************************\n               Slave_IO_State: Waiting for master to send event\n                  Master_Host: localhost\n                  Master_User: root\n                  Master_Port: 3306\n                Connect_Retry: 3\n              Master_Log_File: gbichot-bin.005\n          Read_Master_Log_Pos: 79\n               Relay_Log_File: gbichot-relay-bin.005\n                Relay_Log_Pos: 548\n        Relay_Master_Log_File: gbichot-bin.005\n             Slave_IO_Running: Yes\n            Slave_SQL_Running: Yes\n              Replicate_Do_DB:\n          Replicate_Ignore_DB:\n           Replicate_Do_Table:\n       Replicate_Ignore_Table:\n      Replicate_Wild_Do_Table:\n  Replicate_Wild_Ignore_Table:\n                   Last_Errno: 0\n                   Last_Error:\n                 Skip_Counter: 0\n          Exec_Master_Log_Pos: 79\n              Relay_Log_Space: 552\n              Until_Condition: None\n               Until_Log_File:\n                Until_Log_Pos: 0\n           Master_SSL_Allowed: No\n           Master_SSL_CA_File:\n           Master_SSL_CA_Path:\n              Master_SSL_Cert:\n            Master_SSL_Cipher:\n               Master_SSL_Key:\n        Seconds_Behind_Master: 8\nMaster_SSL_Verify_Server_Cert: No\n                Last_IO_Errno: 0\n                Last_IO_Error:\n               Last_SQL_Errno: 0\n               Last_SQL_Error:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-slave-status.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-slave-status.html'),(225,'GEOMETRY',35,'MySQL provides a standard way of creating spatial columns for geometry\ntypes, for example, with CREATE TABLE or ALTER TABLE. Currently,\nspatial columns are supported for MyISAM, InnoDB, NDB, and ARCHIVE\ntables. See also the annotations about spatial indexes under [HELP\nSPATIAL].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-columns.html\n\n','CREATE TABLE geom (g GEOMETRY);\n','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-columns.html'),(226,'NUMPOINTS',13,'NumPoints(ls)\n\nReturns the number of Point objects in the LineString value ls.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @ls = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT NumPoints(GeomFromText(@ls));\n+------------------------------+\n| NumPoints(GeomFromText(@ls)) |\n+------------------------------+\n|                            3 |\n+------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(227,'ALTER LOGFILE GROUP',40,'Syntax:\nALTER LOGFILE GROUP logfile_group\n    ADD UNDOFILE \'file_name\'\n    [INITIAL_SIZE [=] size]\n    [WAIT]\n    ENGINE [=] engine_name\n\nThis statement adds an UNDO file named \'file_name\' to an existing log\nfile group logfile_group. An ALTER LOGFILE GROUP statement has one and\nonly one ADD UNDOFILE clause. No DROP UNDOFILE clause is currently\nsupported.\n\n*Note*: All MySQL Cluster Disk Data objects share the same namespace.\nThis means that each Disk Data object must be uniquely named (and not\nmerely each Disk Data object of a given type). For example, you cannot\nhave a tablespace and an undo log file with the same name, or an undo\nlog file and a data file with the same name.\n\nPrior to MySQL Cluster NDB 6.2.17, 6.3.23, and 6.4.3, path and file\nnames for undo log files could not be longer than 128 characters. (Bug\n#31769)\n\nThe optional INITIAL_SIZE parameter sets the UNDO file\'s initial size\nin bytes; if not specified, the initial size default to 128M (128\nmegabytes). You may optionally follow size with a one-letter\nabbreviation for an order of magnitude, similar to those used in\nmy.cnf. Generally, this is one of the letters M (for megabytes) or G\n(for gigabytes).\n\nOn 32-bit systems, the maximum supported value for INITIAL_SIZE is 4G.\n(Bug #29186)\n\nBeginning with MySQL Cluster NDB 6.2.18, 6.3.24, and 7.0.4, the minimum\npermitted value for INITIAL_SIZE is 1M. (Bug #29574)\n\n*Note*: WAIT is parsed but otherwise ignored. This keyword has no\neffect in MySQL 5.1, MySQL Cluster NDB 6.x, or MySQL Cluster NDB 7.x,\nand is intended for future expansion.\n\nThe ENGINE parameter (required) determines the storage engine which is\nused by this log file group, with engine_name being the name of the\nstorage engine. In MySQL 5.1, MySQL Cluster NDB 6.x, and MySQL Cluster\nNDB 7.x, the only accepted values for engine_name are \"NDBCLUSTER\" and\n\"NDB\". The two values are equivalent.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/alter-logfile-group.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/alter-logfile-group.html'),(228,'&',20,'Syntax:\n&\n\nBitwise AND:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html\n\n','mysql> SELECT 29 & 15;\n        -> 13\n','http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html'),(229,'LOCALTIMESTAMP',32,'Syntax:\nLOCALTIMESTAMP, LOCALTIMESTAMP()\n\nLOCALTIMESTAMP and LOCALTIMESTAMP() are synonyms for NOW().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(230,'ASSIGN-EQUAL',15,'Syntax:\n=\n\nThis operator is used to perform value assignments in two cases,\ndescribed in the next two paragraphs.\n\nWithin a SET statement, = is treated as an assignment operator that\ncauses the user variable on the left hand side of the operator to take\non the value to its right. (In other words, when used in a SET\nstatement, = is treated identically to :=.) The value on the right hand\nside may be a literal value, another variable storing a value, or any\nlegal expression that yields a scalar value, including the result of a\nquery (provided that this value is a scalar value). You can perform\nmultiple assignments in the same SET statement.\n\nIn the SET clause of an UPDATE statement, = also acts as an assignment\noperator; in this case, however, it causes the column named on the left\nhand side of the operator to assume the value given to the right,\nprovided any WHERE conditions that are part of the UPDATE are met. You\ncan make multiple assignments in the same SET clause of an UPDATE\nstatement.\n\nIn any other context, = is treated as a comparison operator.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/assignment-operators.html\n\n','mysql> SELECT @var1, @var2;\n        -> NULL, NULL\nmysql> SELECT @var1 := 1, @var2;\n        -> 1, NULL\nmysql> SELECT @var1, @var2;\n        -> 1, NULL\nmysql> SELECT @var1, @var2 := @var1;\n        -> 1, 1\nmysql> SELECT @var1, @var2;\n        -> 1, 1\n','http://dev.mysql.com/doc/refman/5.1/en/assignment-operators.html'),(231,'CONVERT',38,'Syntax:\nCONVERT(expr,type), CONVERT(expr USING transcoding_name)\n\nThe CONVERT() and CAST() functions take an expression of any type and\nproduce a result value of a specified type.\n\nThe type for the result can be one of the following values:\n\no BINARY[(N)]\n\no CHAR[(N)]\n\no DATE\n\no DATETIME\n\no DECIMAL[(M[,D])]\n\no SIGNED [INTEGER]\n\no TIME\n\no UNSIGNED [INTEGER]\n\nBINARY produces a string with the BINARY data type. See\nhttp://dev.mysql.com/doc/refman/5.1/en/binary-varbinary.html for a\ndescription of how this affects comparisons. If the optional length N\nis given, BINARY(N) causes the cast to use no more than N bytes of the\nargument. Values shorter than N bytes are padded with 0x00 bytes to a\nlength of N.\n\nCHAR(N) causes the cast to use no more than N characters of the\nargument.\n\nCAST() and CONVERT(... USING ...) are standard SQL syntax. The\nnon-USING form of CONVERT() is ODBC syntax.\n\nCONVERT() with USING is used to convert data between different\ncharacter sets. In MySQL, transcoding names are the same as the\ncorresponding character set names. For example, this statement converts\nthe string \'abc\' in the default character set to the corresponding\nstring in the utf8 character set:\n\nSELECT CONVERT(\'abc\' USING utf8);\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/cast-functions.html\n\n','SELECT enum_col FROM tbl_name ORDER BY CAST(enum_col AS CHAR);\n','http://dev.mysql.com/doc/refman/5.1/en/cast-functions.html'),(232,'DROP LOGFILE GROUP',40,'Syntax:\nDROP LOGFILE GROUP logfile_group\n    ENGINE [=] engine_name\n\nThis statement drops the log file group named logfile_group. The log\nfile group must already exist or an error results. (For information on\ncreating log file groups, see [HELP CREATE LOGFILE GROUP].)\n\n*Important*: Before dropping a log file group, you must drop all\ntablespaces that use that log file group for UNDO logging.\n\nThe required ENGINE clause provides the name of the storage engine used\nby the log file group to be dropped. In MySQL 5.1, the only permitted\nvalues for engine_name are NDB and NDBCLUSTER.\n\nDROP LOGFILE GROUP was added in MySQL 5.1.6. In MySQL 5.1, it is useful\nonly with Disk Data storage for MySQL Cluster. See\nhttp://dev.mysql.com/doc/refman/5.1/en/mysql-cluster-disk-data.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-logfile-group.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-logfile-group.html'),(233,'ADDDATE',32,'Syntax:\nADDDATE(date,INTERVAL expr unit), ADDDATE(expr,days)\n\nWhen invoked with the INTERVAL form of the second argument, ADDDATE()\nis a synonym for DATE_ADD(). The related function SUBDATE() is a\nsynonym for DATE_SUB(). For information on the INTERVAL unit argument,\nsee the discussion for DATE_ADD().\n\nmysql> SELECT DATE_ADD(\'2008-01-02\', INTERVAL 31 DAY);\n        -> \'2008-02-02\'\nmysql> SELECT ADDDATE(\'2008-01-02\', INTERVAL 31 DAY);\n        -> \'2008-02-02\'\n\nWhen invoked with the days form of the second argument, MySQL treats it\nas an integer number of days to be added to expr.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT ADDDATE(\'2008-01-02\', 31);\n        -> \'2008-02-02\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(234,'REPEAT LOOP',24,'Syntax:\n[begin_label:] REPEAT\n    statement_list\nUNTIL search_condition\nEND REPEAT [end_label]\n\nThe statement list within a REPEAT statement is repeated until the\nsearch_condition expression is true. Thus, a REPEAT always enters the\nloop at least once. statement_list consists of one or more statements,\neach terminated by a semicolon (;) statement delimiter.\n\nA REPEAT statement can be labeled. For the rules regarding label use,\nsee [HELP labels].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/repeat.html\n\n','mysql> delimiter //\n\nmysql> CREATE PROCEDURE dorepeat(p1 INT)\n    -> BEGIN\n    ->   SET @x = 0;\n    ->   REPEAT\n    ->     SET @x = @x + 1;\n    ->   UNTIL @x > p1 END REPEAT;\n    -> END\n    -> //\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> CALL dorepeat(1000)//\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT @x//\n+------+\n| @x   |\n+------+\n| 1001 |\n+------+\n1 row in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.1/en/repeat.html'),(235,'ALTER FUNCTION',40,'Syntax:\nALTER FUNCTION func_name [characteristic ...]\n\ncharacteristic:\n    COMMENT \'string\'\n  | LANGUAGE SQL\n  | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }\n  | SQL SECURITY { DEFINER | INVOKER }\n\nThis statement can be used to change the characteristics of a stored\nfunction. More than one change may be specified in an ALTER FUNCTION\nstatement. However, you cannot change the parameters or body of a\nstored function using this statement; to make such changes, you must\ndrop and re-create the function using DROP FUNCTION and CREATE\nFUNCTION.\n\nYou must have the ALTER ROUTINE privilege for the function. (That\nprivilege is granted automatically to the function creator.) If binary\nlogging is enabled, the ALTER FUNCTION statement might also require the\nSUPER privilege, as described in\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-programs-logging.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/alter-function.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/alter-function.html'),(236,'SMALLINT',23,'SMALLINT[(M)] [UNSIGNED] [ZEROFILL]\n\nA small integer. The signed range is -32768 to 32767. The unsigned\nrange is 0 to 65535.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(237,'DOUBLE PRECISION',23,'DOUBLE PRECISION[(M,D)] [UNSIGNED] [ZEROFILL], REAL[(M,D)] [UNSIGNED]\n[ZEROFILL]\n\nThese types are synonyms for DOUBLE. Exception: If the REAL_AS_FLOAT\nSQL mode is enabled, REAL is a synonym for FLOAT rather than DOUBLE.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(238,'ORD',38,'Syntax:\nORD(str)\n\nIf the leftmost character of the string str is a multi-byte character,\nreturns the code for that character, calculated from the numeric values\nof its constituent bytes using this formula:\n\n  (1st byte code)\n+ (2nd byte code * 256)\n+ (3rd byte code * 2562) ...\n\nIf the leftmost character is not a multi-byte character, ORD() returns\nthe same value as the ASCII() function.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT ORD(\'2\');\n        -> 50\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(239,'DEALLOCATE PREPARE',8,'Syntax:\n{DEALLOCATE | DROP} PREPARE stmt_name\n\nTo deallocate a prepared statement produced with PREPARE, use a\nDEALLOCATE PREPARE statement that refers to the prepared statement\nname. Attempting to execute a prepared statement after deallocating it\nresults in an error.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/deallocate-prepare.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/deallocate-prepare.html'),(240,'ENVELOPE',37,'Envelope(g)\n\nReturns the Minimum Bounding Rectangle (MBR) for the geometry value g.\nThe result is returned as a Polygon value.\n\nThe polygon is defined by the corner points of the bounding box:\n\nPOLYGON((MINX MINY, MAXX MINY, MAXX MAXY, MINX MAXY, MINX MINY))\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SELECT AsText(Envelope(GeomFromText(\'LineString(1 1,2 2)\')));\n+-------------------------------------------------------+\n| AsText(Envelope(GeomFromText(\'LineString(1 1,2 2)\'))) |\n+-------------------------------------------------------+\n| POLYGON((1 1,2 1,2 2,1 2,1 1))                        |\n+-------------------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(241,'IS_FREE_LOCK',14,'Syntax:\nIS_FREE_LOCK(str)\n\nChecks whether the lock named str is free to use (that is, not locked).\nReturns 1 if the lock is free (no one is using the lock), 0 if the lock\nis in use, and NULL if an error occurs (such as an incorrect argument).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(242,'TOUCHES',31,'Touches(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 spatially touches g2. Two\ngeometries spatially touch if the interiors of the geometries do not\nintersect, but the boundary of one of the geometries intersects either\nthe boundary or the interior of the other.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(243,'INET_ATON',14,'Syntax:\nINET_ATON(expr)\n\nGiven the dotted-quad representation of an IPv4 network address as a\nstring, returns an integer that represents the numeric value of the\naddress in network byte order (big endian). INET_ATON() returns NULL if\nit does not understand its argument.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','mysql> SELECT INET_ATON(\'10.0.5.9\');\n        -> 167773449\n','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(244,'UNCOMPRESS',12,'Syntax:\nUNCOMPRESS(string_to_uncompress)\n\nUncompresses a string compressed by the COMPRESS() function. If the\nargument is not a compressed value, the result is NULL. This function\nrequires MySQL to have been compiled with a compression library such as\nzlib. Otherwise, the return value is always NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','mysql> SELECT UNCOMPRESS(COMPRESS(\'any string\'));\n        -> \'any string\'\nmysql> SELECT UNCOMPRESS(\'any string\');\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(245,'AUTO_INCREMENT',23,'The AUTO_INCREMENT attribute can be used to generate a unique identity\nfor new rows:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/example-auto-increment.html\n\n','CREATE TABLE animals (\n     id MEDIUMINT NOT NULL AUTO_INCREMENT,\n     name CHAR(30) NOT NULL,\n     PRIMARY KEY (id)\n) ENGINE=INNODB;\n\nINSERT INTO animals (name) VALUES\n    (\'dog\'),(\'cat\'),(\'penguin\'),\n    (\'lax\'),(\'whale\'),(\'ostrich\');\n\nSELECT * FROM animals;\n','http://dev.mysql.com/doc/refman/5.1/en/example-auto-increment.html'),(246,'ISSIMPLE',37,'IsSimple(g)\n\nIn MySQL 5.1, this function is a placeholder that always returns 0.\n\nThe description of each instantiable geometric class given earlier in\nthe chapter includes the specific conditions that cause an instance of\nthat class to be classified as not simple. (See [HELP Geometry\nhierarchy].)\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(247,'- BINARY',4,'Syntax:\n-\n\nSubtraction:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html\n\n','mysql> SELECT 3-5;\n        -> -2\n','http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html'),(248,'GEOMCOLLFROMTEXT',3,'GeomCollFromText(wkt[,srid]), GeometryCollectionFromText(wkt[,srid])\n\nConstructs a GEOMETRYCOLLECTION value using its WKT representation and\nSRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(249,'WKT DEFINITION',3,'The Well-Known Text (WKT) representation of Geometry is designed to\nexchange geometry data in ASCII form. For a Backus-Naur grammar that\nspecifies the formal production rules for writing WKT values, see the\nOpenGIS specification document referenced in\nhttp://dev.mysql.com/doc/refman/5.1/en/spatial-extensions.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/gis-wkt-format.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/gis-wkt-format.html'),(250,'CURRENT_TIME',32,'Syntax:\nCURRENT_TIME, CURRENT_TIME()\n\nCURRENT_TIME and CURRENT_TIME() are synonyms for CURTIME().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(251,'REVOKE',10,'Syntax:\nREVOKE\n    priv_type [(column_list)]\n      [, priv_type [(column_list)]] ...\n    ON [object_type] priv_level\n    FROM user [, user] ...\n\nREVOKE ALL PRIVILEGES, GRANT OPTION\n    FROM user [, user] ...\n\nThe REVOKE statement enables system administrators to revoke privileges\nfrom MySQL accounts. Each account name uses the format described in\nhttp://dev.mysql.com/doc/refman/5.1/en/account-names.html. For example:\n\nREVOKE INSERT ON *.* FROM \'jeffrey\'@\'localhost\';\n\nIf you specify only the user name part of the account name, a host name\npart of \'%\' is used.\n\nFor details on the levels at which privileges exist, the permissible\npriv_type and priv_level values, and the syntax for specifying users\nand passwords, see [HELP GRANT]\n\nTo use the first REVOKE syntax, you must have the GRANT OPTION\nprivilege, and you must have the privileges that you are revoking.\n\nTo revoke all privileges, use the second syntax, which drops all\nglobal, database, table, column, and routine privileges for the named\nuser or users:\n\nREVOKE ALL PRIVILEGES, GRANT OPTION FROM user [, user] ...\n\nTo use this REVOKE syntax, you must have the global CREATE USER\nprivilege or the UPDATE privilege for the mysql database.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/revoke.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/revoke.html'),(252,'LAST_INSERT_ID',17,'Syntax:\nLAST_INSERT_ID(), LAST_INSERT_ID(expr)\n\nFor MySQL 5.1.12 and later, with no argument, LAST_INSERT_ID() returns\na 64-bit value representing the first automatically generated value\nsuccessfully inserted for an AUTO_INCREMENT column as a result of the\nmost recently executed INSERT statement. The value has a type of BIGINT\nUNSIGNED as of MySQL 5.1.67, BIGINT (signed) before that. The value of\nLAST_INSERT_ID() remains unchanged if no rows are successfully\ninserted.\n\nWith an argument, LAST_INSERT_ID() returns an unsigned integer as of\nMySQL 5.1.67, a signed integer before that.\n\nFor example, after inserting a row that generates an AUTO_INCREMENT\nvalue, you can get the value like this:\n\nmysql> SELECT LAST_INSERT_ID();\n        -> 195\n\nIn MySQL 5.1.11 and earlier, LAST_INSERT_ID() (with no argument)\nreturns the first automatically generated value if any rows were\nsuccessfully inserted or updated. This means that the returned value\ncould be a value that was not successfully inserted into the table. If\nno rows were successfully inserted, LAST_INSERT_ID() returns 0.\n\nThe value of LAST_INSERT_ID() will be consistent across all MySQL\nversions if all rows in the INSERT or UPDATE statement were successful.\n\nif a table contains an AUTO_INCREMENT column and INSERT ... ON\nDUPLICATE KEY UPDATE updates (rather than inserts) a row, the value of\nLAST_INSERT_ID() is not meaningful prior to MySQL 5.1.12. For a\nworkaround, see\nhttp://dev.mysql.com/doc/refman/5.1/en/insert-on-duplicate.html.\n\nThe currently executing statement does not affect the value of\nLAST_INSERT_ID(). Suppose that you generate an AUTO_INCREMENT value\nwith one statement, and then refer to LAST_INSERT_ID() in a\nmultiple-row INSERT statement that inserts rows into a table with its\nown AUTO_INCREMENT column. The value of LAST_INSERT_ID() will remain\nstable in the second statement; its value for the second and later rows\nis not affected by the earlier row insertions. (However, if you mix\nreferences to LAST_INSERT_ID() and LAST_INSERT_ID(expr), the effect is\nundefined.)\n\nIf the previous statement returned an error, the value of\nLAST_INSERT_ID() is undefined. For transactional tables, if the\nstatement is rolled back due to an error, the value of LAST_INSERT_ID()\nis left undefined. For manual ROLLBACK, the value of LAST_INSERT_ID()\nis not restored to that before the transaction; it remains as it was at\nthe point of the ROLLBACK.\n\nPrior to MySQL 5.1.73, this function was not replicated correctly if\nreplication filtering rules were in use. (Bug #17234370, Bug #69861)\n\nWithin the body of a stored routine (procedure or function) or a\ntrigger, the value of LAST_INSERT_ID() changes the same way as for\nstatements executed outside the body of these kinds of objects. The\neffect of a stored routine or trigger upon the value of\nLAST_INSERT_ID() that is seen by following statements depends on the\nkind of routine:\n\no If a stored procedure executes statements that change the value of\n  LAST_INSERT_ID(), the changed value is seen by statements that follow\n  the procedure call.\n\no For stored functions and triggers that change the value, the value is\n  restored when the function or trigger ends, so following statements\n  will not see a changed value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(253,'LAST_DAY',32,'Syntax:\nLAST_DAY(date)\n\nTakes a date or datetime value and returns the corresponding value for\nthe last day of the month. Returns NULL if the argument is invalid.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT LAST_DAY(\'2003-02-05\');\n        -> \'2003-02-28\'\nmysql> SELECT LAST_DAY(\'2004-02-05\');\n        -> \'2004-02-29\'\nmysql> SELECT LAST_DAY(\'2004-01-01 01:01:01\');\n        -> \'2004-01-31\'\nmysql> SELECT LAST_DAY(\'2003-03-32\');\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(254,'MEDIUMINT',23,'MEDIUMINT[(M)] [UNSIGNED] [ZEROFILL]\n\nA medium-sized integer. The signed range is -8388608 to 8388607. The\nunsigned range is 0 to 16777215.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(255,'FLOOR',4,'Syntax:\nFLOOR(X)\n\nReturns the largest integer value not greater than X.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT FLOOR(1.23);\n        -> 1\nmysql> SELECT FLOOR(-1.23);\n        -> -2\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(256,'RTRIM',38,'Syntax:\nRTRIM(str)\n\nReturns the string str with trailing space characters removed.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT RTRIM(\'barbar   \');\n        -> \'barbar\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(257,'EXPLAIN',29,'Syntax:\n{EXPLAIN | DESCRIBE | DESC}\n    tbl_name [col_name | wild]\n\n{EXPLAIN | DESCRIBE | DESC}\n    [explain_type] SELECT select_options\n\nexplain_type: {EXTENDED | PARTITIONS}\n\nThe DESCRIBE and EXPLAIN statements are synonyms. In practice, the\nDESCRIBE keyword is more often used to obtain information about table\nstructure, whereas EXPLAIN is used to obtain a query execution plan\n(that is, an explanation of how MySQL would execute a query). The\nfollowing discussion uses the DESCRIBE and EXPLAIN keywords in\naccordance with those uses, but the MySQL parser treats them as\ncompletely synonymous.\n\nObtaining Table Structure Information\n\nDESCRIBE provides information about the columns in a table:\n\nmysql> DESCRIBE City;\n+------------+----------+------+-----+---------+----------------+\n| Field      | Type     | Null | Key | Default | Extra          |\n+------------+----------+------+-----+---------+----------------+\n| Id         | int(11)  | NO   | PRI | NULL    | auto_increment |\n| Name       | char(35) | NO   |     |         |                |\n| Country    | char(3)  | NO   | UNI |         |                |\n| District   | char(20) | YES  | MUL |         |                |\n| Population | int(11)  | NO   |     | 0       |                |\n+------------+----------+------+-----+---------+----------------+\n\nDESCRIBE is a shortcut for SHOW COLUMNS. These statements also display\ninformation for views. The description for SHOW COLUMNS provides more\ninformation about the output columns. See [HELP SHOW COLUMNS].\n\nBy default, DESCRIBE displays information about all columns in the\ntable. col_name, if given, is the name of a column in the table. In\nthis case, the statement displays information only for the named\ncolumn. wild, if given, is a pattern string. It can contain the SQL \"%\"\nand \"_\" wildcard characters. In this case, the statement displays\noutput only for the columns with names matching the string. There is no\nneed to enclose the string within quotation marks unless it contains\nspaces or other special characters.\n\nThe DESCRIBE statement is provided for compatibility with Oracle.\n\nThe SHOW CREATE TABLE, SHOW TABLE STATUS, and SHOW INDEX statements\nalso provide information about tables. See [HELP SHOW].\n\nObtaining Execution Plan Information\n\nThe EXPLAIN statement provides information about how MySQL executes\nstatements:\n\no When you precede a SELECT statement with the keyword EXPLAIN, MySQL\n  displays information from the optimizer about the statement execution\n  plan. That is, MySQL explains how it would process the statement,\n  including information about how tables are joined and in which order.\n  For information about using EXPLAIN to obtain execution plan\n  information, see\n  http://dev.mysql.com/doc/refman/5.1/en/explain-output.html.\n\no EXPLAIN EXTENDED can be used to obtain additional execution plan\n  information. See\n  http://dev.mysql.com/doc/refman/5.1/en/explain-extended.html.\n\no As of MySQL 5.1.5, EXPLAIN PARTITIONS is useful for examining queries\n  involving partitioned tables. See\n  http://dev.mysql.com/doc/refman/5.1/en/partitioning-info.html.\n\nWith the help of EXPLAIN, you can see where you should add indexes to\ntables so that the statement executes faster by using indexes to find\nrows. You can also use EXPLAIN to check whether the optimizer joins the\ntables in an optimal order. To give a hint to the optimizer to use a\njoin order corresponding to the order in which the tables are named in\na SELECT statement, begin the statement with SELECT STRAIGHT_JOIN\nrather than just SELECT. (See\nhttp://dev.mysql.com/doc/refman/5.1/en/select.html.)\n\nIf you have a problem with indexes not being used when you believe that\nthey should be, run ANALYZE TABLE to update table statistics, such as\ncardinality of keys, that can affect the choices the optimizer makes.\nSee [HELP ANALYZE TABLE].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/explain.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/explain.html'),(258,'DEGREES',4,'Syntax:\nDEGREES(X)\n\nReturns the argument X, converted from radians to degrees.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT DEGREES(PI());\n        -> 180\nmysql> SELECT DEGREES(PI() / 2);\n        -> 90\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(259,'VARCHAR',23,'[NATIONAL] VARCHAR(M) [CHARACTER SET charset_name] [COLLATE\ncollation_name]\n\nA variable-length string. M represents the maximum column length in\ncharacters. The range of M is 0 to 65,535. The effective maximum length\nof a VARCHAR is subject to the maximum row size (65,535 bytes, which is\nshared among all columns) and the character set used. For example, utf8\ncharacters can require up to three bytes per character, so a VARCHAR\ncolumn that uses the utf8 character set can be declared to be a maximum\nof 21,844 characters. See\nhttp://dev.mysql.com/doc/refman/5.1/en/column-count-limit.html.\n\nMySQL stores VARCHAR values as a 1-byte or 2-byte length prefix plus\ndata. The length prefix indicates the number of bytes in the value. A\nVARCHAR column uses one length byte if values require no more than 255\nbytes, two length bytes if values may require more than 255 bytes.\n\n*Note*: MySQL 5.1 follows the standard SQL specification, and does not\nremove trailing spaces from VARCHAR values.\n\nVARCHAR is shorthand for CHARACTER VARYING. NATIONAL VARCHAR is the\nstandard SQL way to define that a VARCHAR column should use some\npredefined character set. MySQL 4.1 and up uses utf8 as this predefined\ncharacter set.\nhttp://dev.mysql.com/doc/refman/5.1/en/charset-national.html. NVARCHAR\nis shorthand for NATIONAL VARCHAR.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(260,'UNHEX',38,'Syntax:\n\nUNHEX(str)\n\nFor a string argument str, UNHEX(str) performs the inverse operation of\nHEX(str). That is, it interprets each pair of characters in the\nargument as a hexadecimal number and converts it to the character\nrepresented by the number. The return value is a binary string.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT UNHEX(\'4D7953514C\');\n        -> \'MySQL\'\nmysql> SELECT 0x4D7953514C;\n        -> \'MySQL\'\nmysql> SELECT UNHEX(HEX(\'string\'));\n        -> \'string\'\nmysql> SELECT HEX(UNHEX(\'1267\'));\n        -> \'1267\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(261,'- UNARY',4,'Syntax:\n-\n\nUnary minus. This operator changes the sign of the operand.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html\n\n','mysql> SELECT - 2;\n        -> -2\n','http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html'),(262,'STD',16,'Syntax:\nSTD(expr)\n\nReturns the population standard deviation of expr. This is an extension\nto standard SQL. The standard SQL function STDDEV_POP() can be used\ninstead.\n\nThis function returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(263,'COS',4,'Syntax:\nCOS(X)\n\nReturns the cosine of X, where X is given in radians.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT COS(PI());\n        -> -1\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(264,'DATE FUNCTION',32,'Syntax:\nDATE(expr)\n\nExtracts the date part of the date or datetime expression expr.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT DATE(\'2003-12-31 01:02:03\');\n        -> \'2003-12-31\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(265,'DROP TRIGGER',40,'Syntax:\nDROP TRIGGER [IF EXISTS] [schema_name.]trigger_name\n\nThis statement drops a trigger. The schema (database) name is optional.\nIf the schema is omitted, the trigger is dropped from the default\nschema. DROP TRIGGER requires the TRIGGER privilege for the table\nassociated with the trigger. (This statement requires the SUPER\nprivilege prior to MySQL 5.1.6.)\n\nUse IF EXISTS to prevent an error from occurring for a trigger that\ndoes not exist. A NOTE is generated for a nonexistent trigger when\nusing IF EXISTS. See [HELP SHOW WARNINGS]. The IF EXISTS clause was\nadded in MySQL 5.1.14.\n\nTriggers for a table are also dropped if you drop the table.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-trigger.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-trigger.html'),(266,'RESET MASTER',8,'Syntax:\nRESET MASTER\n\nDeletes all binary log files listed in the index file, resets the\nbinary log index file to be empty, and creates a new binary log file.\nThis statement is intended to be used only when the master is started\nfor the first time.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/reset-master.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/reset-master.html'),(267,'TAN',4,'Syntax:\nTAN(X)\n\nReturns the tangent of X, where X is given in radians.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT TAN(PI());\n        -> -1.2246063538224e-16\nmysql> SELECT TAN(PI()+1);\n        -> 1.5574077246549\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(268,'PI',4,'Syntax:\nPI()\n\nReturns the value of π (pi). The default number of decimal places\ndisplayed is seven, but MySQL uses the full double-precision value\ninternally.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT PI();\n        -> 3.141593\nmysql> SELECT PI()+0.000000000000000000;\n        -> 3.141592653589793116\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(269,'WEEKOFYEAR',32,'Syntax:\nWEEKOFYEAR(date)\n\nReturns the calendar week of the date as a number in the range from 1\nto 53. WEEKOFYEAR() is a compatibility function that is equivalent to\nWEEK(date,3).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT WEEKOFYEAR(\'2008-02-20\');\n        -> 8\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(270,'/',4,'Syntax:\n/\n\nDivision:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html\n\n','mysql> SELECT 3/5;\n        -> 0.60\n','http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html'),(271,'PURGE BINARY LOGS',8,'Syntax:\nPURGE { BINARY | MASTER } LOGS\n    { TO \'log_name\' | BEFORE datetime_expr }\n\nThe binary log is a set of files that contain information about data\nmodifications made by the MySQL server. The log consists of a set of\nbinary log files, plus an index file (see\nhttp://dev.mysql.com/doc/refman/5.1/en/binary-log.html).\n\nThe PURGE BINARY LOGS statement deletes all the binary log files listed\nin the log index file prior to the specified log file name or date.\nBINARY and MASTER are synonyms. Deleted log files also are removed from\nthe list recorded in the index file, so that the given log file becomes\nthe first in the list.\n\nThis statement has no effect if the server was not started with the\n--log-bin option to enable binary logging.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/purge-binary-logs.html\n\n','PURGE BINARY LOGS TO \'mysql-bin.010\';\nPURGE BINARY LOGS BEFORE \'2008-04-02 22:46:26\';\n','http://dev.mysql.com/doc/refman/5.1/en/purge-binary-logs.html'),(272,'STDDEV_SAMP',16,'Syntax:\nSTDDEV_SAMP(expr)\n\nReturns the sample standard deviation of expr (the square root of\nVAR_SAMP().\n\nSTDDEV_SAMP() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(273,'SCHEMA',17,'Syntax:\nSCHEMA()\n\nThis function is a synonym for DATABASE().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(274,'MLINEFROMWKB',33,'MLineFromWKB(wkb[,srid]), MultiLineStringFromWKB(wkb[,srid])\n\nConstructs a MULTILINESTRING value using its WKB representation and\nSRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(275,'LOG2',4,'Syntax:\nLOG2(X)\n\nReturns the base-2 logarithm of X.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT LOG2(65536);\n        -> 16\nmysql> SELECT LOG2(-100);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(276,'SUBTIME',32,'Syntax:\nSUBTIME(expr1,expr2)\n\nSUBTIME() returns expr1 - expr2 expressed as a value in the same format\nas expr1. expr1 is a time or datetime expression, and expr2 is a time\nexpression.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT SUBTIME(\'2007-12-31 23:59:59.999999\',\'1 1:1:1.000002\');\n        -> \'2007-12-30 22:58:58.999997\'\nmysql> SELECT SUBTIME(\'01:00:00.999999\', \'02:00:00.999998\');\n        -> \'-00:59:59.999999\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(277,'UNCOMPRESSED_LENGTH',12,'Syntax:\nUNCOMPRESSED_LENGTH(compressed_string)\n\nReturns the length that the compressed string had before being\ncompressed.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','mysql> SELECT UNCOMPRESSED_LENGTH(COMPRESS(REPEAT(\'a\',30)));\n        -> 30\n','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(278,'DROP TABLE',40,'Syntax:\nDROP [TEMPORARY] TABLE [IF EXISTS]\n    tbl_name [, tbl_name] ...\n    [RESTRICT | CASCADE]\n\nDROP TABLE removes one or more tables. You must have the DROP privilege\nfor each table. All table data and the table definition are removed, so\nbe careful with this statement! If any of the tables named in the\nargument list do not exist, MySQL returns an error indicating by name\nwhich nonexisting tables it was unable to drop, but it also drops all\nof the tables in the list that do exist.\n\n*Important*: When a table is dropped, user privileges on the table are\nnot automatically dropped. See [HELP GRANT].\n\nNote that for a partitioned table, DROP TABLE permanently removes the\ntable definition, all of its partitions, and all of the data which was\nstored in those partitions. It also removes the partitioning definition\n(.par) file associated with the dropped table.\n\nUse IF EXISTS to prevent an error from occurring for tables that do not\nexist. A NOTE is generated for each nonexistent table when using IF\nEXISTS. See [HELP SHOW WARNINGS].\n\nRESTRICT and CASCADE are permitted to make porting easier. In MySQL\n5.1, they do nothing.\n\n*Note*: DROP TABLE automatically commits the current active\ntransaction, unless you use the TEMPORARY keyword.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-table.html'),(279,'POW',4,'Syntax:\nPOW(X,Y)\n\nReturns the value of X raised to the power of Y.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT POW(2,2);\n        -> 4\nmysql> SELECT POW(2,-2);\n        -> 0.25\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(280,'SHOW CREATE TABLE',27,'Syntax:\nSHOW CREATE TABLE tbl_name\n\nShows the CREATE TABLE statement that creates the named table. To use\nthis statement, you must have some privilege for the table. This\nstatement also works with views.\nSHOW CREATE TABLE quotes table and column names according to the value\nof the sql_quote_show_create option. See\nhttp://dev.mysql.com/doc/refman/5.1/en/server-system-variables.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-create-table.html\n\n','mysql> SHOW CREATE TABLE t\\G\n*************************** 1. row ***************************\n       Table: t\nCreate Table: CREATE TABLE t (\n  id INT(11) default NULL auto_increment,\n  s char(60) default NULL,\n  PRIMARY KEY (id)\n) ENGINE=MyISAM\n','http://dev.mysql.com/doc/refman/5.1/en/show-create-table.html'),(281,'DUAL',28,'You are permitted to specify DUAL as a dummy table name in situations\nwhere no tables are referenced:\n\nmysql> SELECT 1 + 1 FROM DUAL;\n        -> 2\n\nDUAL is purely for the convenience of people who require that all\nSELECT statements should have FROM and possibly other clauses. MySQL\nmay ignore the clauses. MySQL does not require FROM DUAL if no tables\nare referenced.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/select.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/select.html'),(282,'INSTR',38,'Syntax:\nINSTR(str,substr)\n\nReturns the position of the first occurrence of substring substr in\nstring str. This is the same as the two-argument form of LOCATE(),\nexcept that the order of the arguments is reversed.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT INSTR(\'foobarbar\', \'bar\');\n        -> 4\nmysql> SELECT INSTR(\'xbar\', \'foobar\');\n        -> 0\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(283,'NOW',32,'Syntax:\nNOW()\n\nReturns the current date and time as a value in \'YYYY-MM-DD HH:MM:SS\'\nor YYYYMMDDHHMMSS.uuuuuu format, depending on whether the function is\nused in a string or numeric context. The value is expressed in the\ncurrent time zone.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT NOW();\n        -> \'2007-12-15 23:50:26\'\nmysql> SELECT NOW() + 0;\n        -> 20071215235026.000000\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(284,'SHOW ENGINES',27,'Syntax:\nSHOW [STORAGE] ENGINES\n\nSHOW ENGINES displays status information about the server\'s storage\nengines. This is particularly useful for checking whether a storage\nengine is supported, or to see what the default engine is. SHOW TABLE\nTYPES is a synonym, but is deprecated and is removed in MySQL 5.5.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-engines.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-engines.html'),(285,'>=',19,'Syntax:\n>=\n\nGreater than or equal:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 2 >= 2;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(286,'EXP',4,'Syntax:\nEXP(X)\n\nReturns the value of e (the base of natural logarithms) raised to the\npower of X. The inverse of this function is LOG() (using a single\nargument only) or LN().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT EXP(2);\n        -> 7.3890560989307\nmysql> SELECT EXP(-2);\n        -> 0.13533528323661\nmysql> SELECT EXP(0);\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(287,'LONGBLOB',23,'LONGBLOB\n\nA BLOB column with a maximum length of 4,294,967,295 or 4GB (232 - 1)\nbytes. The effective maximum length of LONGBLOB columns depends on the\nconfigured maximum packet size in the client/server protocol and\navailable memory. Each LONGBLOB value is stored using a 4-byte length\nprefix that indicates the number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(288,'POINTN',13,'PointN(ls,N)\n\nReturns the N-th Point in the Linestring value ls. Points are numbered\nbeginning with 1.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @ls = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT AsText(PointN(GeomFromText(@ls),2));\n+-------------------------------------+\n| AsText(PointN(GeomFromText(@ls),2)) |\n+-------------------------------------+\n| POINT(2 2)                          |\n+-------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(289,'YEAR DATA TYPE',23,'YEAR[(2|4)]\n\nA year in two-digit or four-digit format. The default is four-digit\nformat. YEAR(2) or YEAR(4) differ in display format, but have the same\nrange of values. In four-digit format, values display as 1901 to 2155,\nand 0000. In two-digit format, values display as 70 to 69, representing\nyears from 1970 to 2069. MySQL displays YEAR values in YYYY or\nYYformat, but permits assignment of values to YEAR columns using either\nstrings or numbers.\n\n*Note*: The YEAR(2) data type has certain issues that you should\nconsider before choosing to use it. As of MySQL 5.1.65, YEAR(2) is\ndeprecated. For more information, see\nhttp://dev.mysql.com/doc/refman/5.1/en/migrating-to-year4.html.\n\nFor additional information about YEAR display format and interpretation\nof input values, see http://dev.mysql.com/doc/refman/5.1/en/year.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-type-overview.html'),(290,'SUM',16,'Syntax:\nSUM([DISTINCT] expr)\n\nReturns the sum of expr. If the return set has no rows, SUM() returns\nNULL. The DISTINCT keyword can be used to sum only the distinct values\nof expr.\n\nSUM() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(291,'OCT',38,'Syntax:\nOCT(N)\n\nReturns a string representation of the octal value of N, where N is a\nlonglong (BIGINT) number. This is equivalent to CONV(N,10,8). Returns\nNULL if N is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT OCT(12);\n        -> \'14\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(292,'SYSDATE',32,'Syntax:\nSYSDATE()\n\nReturns the current date and time as a value in \'YYYY-MM-DD HH:MM:SS\'\nor YYYYMMDDHHMMSS.uuuuuu format, depending on whether the function is\nused in a string or numeric context.\n\nSYSDATE() returns the time at which it executes. This differs from the\nbehavior for NOW(), which returns a constant time that indicates the\ntime at which the statement began to execute. (Within a stored function\nor trigger, NOW() returns the time at which the function or triggering\nstatement began to execute.)\n\nmysql> SELECT NOW(), SLEEP(2), NOW();\n+---------------------+----------+---------------------+\n| NOW()               | SLEEP(2) | NOW()               |\n+---------------------+----------+---------------------+\n| 2006-04-12 13:47:36 |        0 | 2006-04-12 13:47:36 |\n+---------------------+----------+---------------------+\n\nmysql> SELECT SYSDATE(), SLEEP(2), SYSDATE();\n+---------------------+----------+---------------------+\n| SYSDATE()           | SLEEP(2) | SYSDATE()           |\n+---------------------+----------+---------------------+\n| 2006-04-12 13:47:44 |        0 | 2006-04-12 13:47:46 |\n+---------------------+----------+---------------------+\n\nIn addition, the SET TIMESTAMP statement affects the value returned by\nNOW() but not by SYSDATE(). This means that timestamp settings in the\nbinary log have no effect on invocations of SYSDATE().\n\nBecause SYSDATE() can return different values even within the same\nstatement, and is not affected by SET TIMESTAMP, it is nondeterministic\nand therefore unsafe for replication if statement-based binary logging\nis used. If that is a problem, you can use row-based logging.\n\nAlternatively, you can use the --sysdate-is-now option to cause\nSYSDATE() to be an alias for NOW(). This works if the option is used on\nboth the master and the slave.\n\nThe nondeterministic nature of SYSDATE() also means that indexes cannot\nbe used for evaluating expressions that refer to it.\n\nBeginning with MySQL 5.1.42, a warning is logged if you use this\nfunction when binlog_format is set to STATEMENT. (Bug #47995)\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(293,'UNINSTALL PLUGIN',5,'Syntax:\nUNINSTALL PLUGIN plugin_name\n\nThis statement removes an installed server plugin. It requires the\nDELETE privilege for the mysql.plugin table.\n\nplugin_name must be the name of some plugin that is listed in the\nmysql.plugin table. The server executes the plugin\'s deinitialization\nfunction and removes the row for the plugin from the mysql.plugin\ntable, so that subsequent server restarts will not load and initialize\nthe plugin. UNINSTALL PLUGIN does not remove the plugin\'s shared\nlibrary file.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/uninstall-plugin.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/uninstall-plugin.html'),(294,'ASBINARY',33,'AsBinary(g), AsWKB(g)\n\nConverts a value in internal geometry format to its WKB representation\nand returns the binary result.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-to-convert-geometries-between-formats.html\n\n','SELECT AsBinary(g) FROM geom;\n','http://dev.mysql.com/doc/refman/5.1/en/functions-to-convert-geometries-between-formats.html'),(295,'REPEAT FUNCTION',38,'Syntax:\nREPEAT(str,count)\n\nReturns a string consisting of the string str repeated count times. If\ncount is less than 1, returns an empty string. Returns NULL if str or\ncount are NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT REPEAT(\'MySQL\', 3);\n        -> \'MySQLMySQLMySQL\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(296,'SHOW TABLES',27,'Syntax:\nSHOW [FULL] TABLES [{FROM | IN} db_name]\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW TABLES lists the non-TEMPORARY tables in a given database. You can\nalso get this list using the mysqlshow db_name command. The LIKE\nclause, if present, indicates which table names to match. The WHERE\nclause can be given to select rows using more general conditions, as\ndiscussed in http://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\n\nMatching performed by the LIKE clause is dependent on the setting of\nthe lower_case_table_names system variable.\n\nThis statement also lists any views in the database. The FULL modifier\nis supported such that SHOW FULL TABLES displays a second output\ncolumn. Values for the second column are BASE TABLE for a table and\nVIEW for a view.\n\nIf you have no privileges for a base table or view, it does not show up\nin the output from SHOW TABLES or mysqlshow db_name.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-tables.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-tables.html'),(297,'MAKEDATE',32,'Syntax:\nMAKEDATE(year,dayofyear)\n\nReturns a date, given year and day-of-year values. dayofyear must be\ngreater than 0 or the result is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT MAKEDATE(2011,31), MAKEDATE(2011,32);\n        -> \'2011-01-31\', \'2011-02-01\'\nmysql> SELECT MAKEDATE(2011,365), MAKEDATE(2014,365);\n        -> \'2011-12-31\', \'2014-12-31\'\nmysql> SELECT MAKEDATE(2011,0);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(298,'BINARY OPERATOR',38,'Syntax:\nBINARY\n\nThe BINARY operator casts the string following it to a binary string.\nThis is an easy way to force a column comparison to be done byte by\nbyte rather than character by character. This causes the comparison to\nbe case sensitive even if the column is not defined as BINARY or BLOB.\nBINARY also causes trailing spaces to be significant.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/cast-functions.html\n\n','mysql> SELECT \'a\' = \'A\';\n        -> 1\nmysql> SELECT BINARY \'a\' = \'A\';\n        -> 0\nmysql> SELECT \'a\' = \'a \';\n        -> 1\nmysql> SELECT BINARY \'a\' = \'a \';\n        -> 0\n','http://dev.mysql.com/doc/refman/5.1/en/cast-functions.html'),(299,'MBROVERLAPS',6,'MBROverlaps(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangles of\nthe two geometries g1 and g2 overlap. The term spatially overlaps is\nused if two geometries intersect and their intersection results in a\ngeometry of the same dimension but not equal to either of the given\ngeometries.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(300,'SOUNDEX',38,'Syntax:\nSOUNDEX(str)\n\nReturns a soundex string from str. Two strings that sound almost the\nsame should have identical soundex strings. A standard soundex string\nis four characters long, but the SOUNDEX() function returns an\narbitrarily long string. You can use SUBSTRING() on the result to get a\nstandard soundex string. All nonalphabetic characters in str are\nignored. All international alphabetic characters outside the A-Z range\nare treated as vowels.\n\n*Important*: When using SOUNDEX(), you should be aware of the following\nlimitations:\n\no This function, as currently implemented, is intended to work well\n  with strings that are in the English language only. Strings in other\n  languages may not produce reliable results.\n\no This function is not guaranteed to provide consistent results with\n  strings that use multi-byte character sets, including utf-8.\n\n  We hope to remove these limitations in a future release. See Bug\n  #22638 for more information.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT SOUNDEX(\'Hello\');\n        -> \'H400\'\nmysql> SELECT SOUNDEX(\'Quadratically\');\n        -> \'Q36324\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(301,'MBRTOUCHES',6,'MBRTouches(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangles of\nthe two geometries g1 and g2 touch. Two geometries spatially touch if\nthe interiors of the geometries do not intersect, but the boundary of\none of the geometries intersects either the boundary or the interior of\nthe other.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(302,'DROP EVENT',40,'Syntax:\nDROP EVENT [IF EXISTS] event_name\n\nThis statement drops the event named event_name. The event immediately\nceases being active, and is deleted completely from the server.\n\nIf the event does not exist, the error ERROR 1517 (HY000): Unknown\nevent \'event_name\' results. You can override this and cause the\nstatement to generate a warning for nonexistent events instead using IF\nEXISTS.\n\nBeginning with MySQL 5.1.12, this statement requires the EVENT\nprivilege for the schema to which the event to be dropped belongs. (In\nMySQL 5.1.11 and earlier, an event could be dropped only by its\ndefiner, or by a user having the SUPER privilege.)\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-event.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-event.html'),(303,'INSERT SELECT',28,'Syntax:\nINSERT [LOW_PRIORITY | HIGH_PRIORITY] [IGNORE]\n    [INTO] tbl_name [(col_name,...)]\n    SELECT ...\n    [ ON DUPLICATE KEY UPDATE col_name=expr, ... ]\n\nWith INSERT ... SELECT, you can quickly insert many rows into a table\nfrom one or many tables. For example:\n\nINSERT INTO tbl_temp2 (fld_id)\n  SELECT tbl_temp1.fld_order_id\n  FROM tbl_temp1 WHERE tbl_temp1.fld_order_id > 100;\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/insert-select.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/insert-select.html'),(304,'CREATE PROCEDURE',40,'Syntax:\nCREATE\n    [DEFINER = { user | CURRENT_USER }]\n    PROCEDURE sp_name ([proc_parameter[,...]])\n    [characteristic ...] routine_body\n\nCREATE\n    [DEFINER = { user | CURRENT_USER }]\n    FUNCTION sp_name ([func_parameter[,...]])\n    RETURNS type\n    [characteristic ...] routine_body\n\nproc_parameter:\n    [ IN | OUT | INOUT ] param_name type\n\nfunc_parameter:\n    param_name type\n\ntype:\n    Any valid MySQL data type\n\ncharacteristic:\n    COMMENT \'string\'\n  | LANGUAGE SQL\n  | [NOT] DETERMINISTIC\n  | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }\n  | SQL SECURITY { DEFINER | INVOKER }\n\nroutine_body:\n    Valid SQL routine statement\n\nThese statements create stored routines. By default, a routine is\nassociated with the default database. To associate the routine\nexplicitly with a given database, specify the name as db_name.sp_name\nwhen you create it.\n\nThe CREATE FUNCTION statement is also used in MySQL to support UDFs\n(user-defined functions). See\nhttp://dev.mysql.com/doc/refman/5.1/en/adding-functions.html. A UDF can\nbe regarded as an external stored function. Stored functions share\ntheir namespace with UDFs. See\nhttp://dev.mysql.com/doc/refman/5.1/en/function-resolution.html, for\nthe rules describing how the server interprets references to different\nkinds of functions.\n\nTo invoke a stored procedure, use the CALL statement (see [HELP CALL]).\nTo invoke a stored function, refer to it in an expression. The function\nreturns a value during expression evaluation.\n\nCREATE PROCEDURE and CREATE FUNCTION require the CREATE ROUTINE\nprivilege. They might also require the SUPER privilege, depending on\nthe DEFINER value, as described later in this section. If binary\nlogging is enabled, CREATE FUNCTION might require the SUPER privilege,\nas described in\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-programs-logging.html.\n\nBy default, MySQL automatically grants the ALTER ROUTINE and EXECUTE\nprivileges to the routine creator. This behavior can be changed by\ndisabling the automatic_sp_privileges system variable. See\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-routines-privileges.html.\n\nThe DEFINER and SQL SECURITY clauses specify the security context to be\nused when checking access privileges at routine execution time, as\ndescribed later in this section.\n\nIf the routine name is the same as the name of a built-in SQL function,\na syntax error occurs unless you use a space between the name and the\nfollowing parenthesis when defining the routine or invoking it later.\nFor this reason, avoid using the names of existing SQL functions for\nyour own stored routines.\n\nThe IGNORE_SPACE SQL mode applies to built-in functions, not to stored\nroutines. It is always permissible to have spaces after a stored\nroutine name, regardless of whether IGNORE_SPACE is enabled.\n\nThe parameter list enclosed within parentheses must always be present.\nIf there are no parameters, an empty parameter list of () should be\nused. Parameter names are not case sensitive.\n\nEach parameter is an IN parameter by default. To specify otherwise for\na parameter, use the keyword OUT or INOUT before the parameter name.\n\n*Note*: Specifying a parameter as IN, OUT, or INOUT is valid only for a\nPROCEDURE. For a FUNCTION, parameters are always regarded as IN\nparameters.\n\nAn IN parameter passes a value into a procedure. The procedure might\nmodify the value, but the modification is not visible to the caller\nwhen the procedure returns. An OUT parameter passes a value from the\nprocedure back to the caller. Its initial value is NULL within the\nprocedure, and its value is visible to the caller when the procedure\nreturns. An INOUT parameter is initialized by the caller, can be\nmodified by the procedure, and any change made by the procedure is\nvisible to the caller when the procedure returns.\n\nFor each OUT or INOUT parameter, pass a user-defined variable in the\nCALL statement that invokes the procedure so that you can obtain its\nvalue when the procedure returns. If you are calling the procedure from\nwithin another stored procedure or function, you can also pass a\nroutine parameter or local routine variable as an IN or INOUT\nparameter.\n\nRoutine parameters cannot be referenced in statements prepared within\nthe routine; see\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-program-restrictions.html\n.\n\nThe following example shows a simple stored procedure that uses an OUT\nparameter:\n\nmysql> delimiter //\n\nmysql> CREATE PROCEDURE simpleproc (OUT param1 INT)\n    -> BEGIN\n    ->   SELECT COUNT(*) INTO param1 FROM t;\n    -> END//\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> delimiter ;\n\nmysql> CALL simpleproc(@a);\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT @a;\n+------+\n| @a   |\n+------+\n| 3    |\n+------+\n1 row in set (0.00 sec)\n\nThe example uses the mysql client delimiter command to change the\nstatement delimiter from ; to // while the procedure is being defined.\nThis enables the ; delimiter used in the procedure body to be passed\nthrough to the server rather than being interpreted by mysql itself.\nSee\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-programs-defining.html.\n\nThe RETURNS clause may be specified only for a FUNCTION, for which it\nis mandatory. It indicates the return type of the function, and the\nfunction body must contain a RETURN value statement. If the RETURN\nstatement returns a value of a different type, the value is coerced to\nthe proper type. For example, if a function specifies an ENUM or SET\nvalue in the RETURNS clause, but the RETURN statement returns an\ninteger, the value returned from the function is the string for the\ncorresponding ENUM member of set of SET members.\n\nThe following example function takes a parameter, performs an operation\nusing an SQL function, and returns the result. In this case, it is\nunnecessary to use delimiter because the function definition contains\nno internal ; statement delimiters:\n\nmysql> CREATE FUNCTION hello (s CHAR(20))\nmysql> RETURNS CHAR(50) DETERMINISTIC\n    -> RETURN CONCAT(\'Hello, \',s,\'!\');\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT hello(\'world\');\n+----------------+\n| hello(\'world\') |\n+----------------+\n| Hello, world!  |\n+----------------+\n1 row in set (0.00 sec)\n\nParameter types and function return types can be declared to use any\nvalid data type, except that the COLLATE attribute cannot be used.\n\nThe routine_body consists of a valid SQL routine statement. This can be\na simple statement such as SELECT or INSERT, or a compound statement\nwritten using BEGIN and END. Compound statements can contain\ndeclarations, loops, and other control structure statements. The syntax\nfor these statements is described in\nhttp://dev.mysql.com/doc/refman/5.1/en/sql-syntax-compound-statements.h\ntml.\n\nMySQL permits routines to contain DDL statements, such as CREATE and\nDROP. MySQL also permits stored procedures (but not stored functions)\nto contain SQL transaction statements such as COMMIT. Stored functions\nmay not contain statements that perform explicit or implicit commit or\nrollback. Support for these statements is not required by the SQL\nstandard, which states that each DBMS vendor may decide whether to\npermit them.\n\nStatements that return a result set can be used within a stored\nprocedure but not within a stored function. This prohibition includes\nSELECT statements that do not have an INTO var_list clause and other\nstatements such as SHOW, EXPLAIN, and CHECK TABLE. For statements that\ncan be determined at function definition time to return a result set, a\nNot allowed to return a result set from a function error occurs\n(ER_SP_NO_RETSET). For statements that can be determined only at\nruntime to return a result set, a PROCEDURE %s can\'t return a result\nset in the given context error occurs (ER_SP_BADSELECT).\n\nUSE statements within stored routines are not permitted. When a routine\nis invoked, an implicit USE db_name is performed (and undone when the\nroutine terminates). This causes the routine to have the given default\ndatabase while it executes. References to objects in databases other\nthan the routine default database should be qualified with the\nappropriate database name.\n\nFor additional information about statements that are not permitted in\nstored routines, see\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-program-restrictions.html\n.\n\nFor information about invoking stored procedures from within programs\nwritten in a language that has a MySQL interface, see [HELP CALL].\n\nMySQL stores the sql_mode system variable setting in effect when a\nroutine is created or altered, and always executes the routine with\nthis setting in force, regardless of the current server SQL mode when\nthe routine begins executing.\n\nThe switch from the SQL mode of the invoker to that of the routine\noccurs after evaluation of arguments and assignment of the resulting\nvalues to routine parameters. If you define a routine in strict SQL\nmode but invoke it in nonstrict mode, assignment of arguments to\nroutine parameters does not take place in strict mode. If you require\nthat expressions passed to a routine be assigned in strict SQL mode,\nyou should invoke the routine with strict mode in effect.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-procedure.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-procedure.html'),(305,'VARBINARY',23,'VARBINARY(M)\n\nThe VARBINARY type is similar to the VARCHAR type, but stores binary\nbyte strings rather than nonbinary character strings. M represents the\nmaximum column length in bytes.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(306,'LOAD INDEX',27,'Syntax:\nLOAD INDEX INTO CACHE\n  tbl_index_list [, tbl_index_list] ...\n\ntbl_index_list:\n  tbl_name\n    [[INDEX|KEY] (index_name[, index_name] ...)]\n    [IGNORE LEAVES]\n\nThe LOAD INDEX INTO CACHE statement preloads a table index into the key\ncache to which it has been assigned by an explicit CACHE INDEX\nstatement, or into the default key cache otherwise. LOAD INDEX INTO\nCACHE is used only for MyISAM tables. It is not supported for tables\nhaving user-defined partitioning (see\nhttp://dev.mysql.com/doc/refman/5.1/en/partitioning-limitations.html.)\n\nThe IGNORE LEAVES modifier causes only blocks for the nonleaf nodes of\nthe index to be preloaded.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/load-index.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/load-index.html'),(307,'UNION',28,'Syntax:\nSELECT ...\nUNION [ALL | DISTINCT] SELECT ...\n[UNION [ALL | DISTINCT] SELECT ...]\n\nUNION is used to combine the result from multiple SELECT statements\ninto a single result set.\n\nThe column names from the first SELECT statement are used as the column\nnames for the results returned. Selected columns listed in\ncorresponding positions of each SELECT statement should have the same\ndata type. (For example, the first column selected by the first\nstatement should have the same type as the first column selected by the\nother statements.)\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/union.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/union.html'),(308,'TO_DAYS',32,'Syntax:\nTO_DAYS(date)\n\nGiven a date date, returns a day number (the number of days since year\n0).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT TO_DAYS(950501);\n        -> 728779\nmysql> SELECT TO_DAYS(\'2007-10-07\');\n        -> 733321\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(309,'NOT REGEXP',38,'Syntax:\nexpr NOT REGEXP pat, expr NOT RLIKE pat\n\nThis is the same as NOT (expr REGEXP pat).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/regexp.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/regexp.html'),(310,'SHOW INDEX',27,'Syntax:\nSHOW {INDEX | INDEXES | KEYS}\n    {FROM | IN} tbl_name\n    [{FROM | IN} db_name]\n    [WHERE expr]\n\nSHOW INDEX returns table index information. The format resembles that\nof the SQLStatistics call in ODBC.\nYou can use db_name.tbl_name as an alternative to the tbl_name FROM\ndb_name syntax. These two statements are equivalent:\n\nSHOW INDEX FROM mytable FROM mydb;\nSHOW INDEX FROM mydb.mytable;\n\nThe WHERE clause can be given to select rows using more general\nconditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\n\nYou can also list a table\'s indexes with the mysqlshow -k db_name\ntbl_name command.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-index.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-index.html'),(311,'SHOW CREATE DATABASE',27,'Syntax:\nSHOW CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name\n\nShows the CREATE DATABASE statement that creates the named database. If\nthe SHOW statement includes an IF NOT EXISTS clause, the output too\nincludes such a clause. SHOW CREATE SCHEMA is a synonym for SHOW CREATE\nDATABASE.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-create-database.html\n\n','mysql> SHOW CREATE DATABASE test\\G\n*************************** 1. row ***************************\n       Database: test\nCreate Database: CREATE DATABASE `test`\n                 /*!40100 DEFAULT CHARACTER SET latin1 */\n\nmysql> SHOW CREATE SCHEMA test\\G\n*************************** 1. row ***************************\n       Database: test\nCreate Database: CREATE DATABASE `test`\n                 /*!40100 DEFAULT CHARACTER SET latin1 */\n','http://dev.mysql.com/doc/refman/5.1/en/show-create-database.html'),(312,'LEAVE',24,'Syntax:\nLEAVE label\n\nThis statement is used to exit the flow control construct that has the\ngiven label. If the label is for the outermost stored program block,\nLEAVE exits the program.\n\nLEAVE can be used within BEGIN ... END or loop constructs (LOOP,\nREPEAT, WHILE).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/leave.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/leave.html'),(313,'NOT IN',19,'Syntax:\nexpr NOT IN (value,...)\n\nThis is the same as NOT (expr IN (value,...)).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(314,'!',15,'Syntax:\nNOT, !\n\nLogical NOT. Evaluates to 1 if the operand is 0, to 0 if the operand is\nnonzero, and NOT NULL returns NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/logical-operators.html\n\n','mysql> SELECT NOT 10;\n        -> 0\nmysql> SELECT NOT 0;\n        -> 1\nmysql> SELECT NOT NULL;\n        -> NULL\nmysql> SELECT ! (1+1);\n        -> 0\nmysql> SELECT ! 1+1;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/logical-operators.html'),(315,'DECLARE HANDLER',24,'Syntax:\nDECLARE handler_action HANDLER\n    FOR condition_value [, condition_value] ...\n    statement\n\nhandler_action:\n    CONTINUE\n  | EXIT\n  | UNDO\n\ncondition_value:\n    mysql_error_code\n  | SQLSTATE [VALUE] sqlstate_value\n  | condition_name\n  | SQLWARNING\n  | NOT FOUND\n  | SQLEXCEPTION\n\nThe DECLARE ... HANDLER statement specifies a handler that deals with\none or more conditions. If one of these conditions occurs, the\nspecified statement executes. statement can be a simple statement such\nas SET var_name = value, or a compound statement written using BEGIN\nand END (see [HELP BEGIN END]).\n\nHandler declarations must appear after variable or condition\ndeclarations.\n\nThe handler_action value indicates what action the handler takes after\nexecution of the handler statement:\n\no CONTINUE: Execution of the current program continues.\n\no EXIT: Execution terminates for the BEGIN ... END compound statement\n  in which the handler is declared. This is true even if the condition\n  occurs in an inner block.\n\no UNDO: Not supported.\n\nThe condition_value for DECLARE ... HANDLER indicates the specific\ncondition or class of conditions that activates the handler:\n\no A MySQL error code (a number) or an SQLSTATE value (a 5-character\n  string literal). You should not use MySQL error code 0 or SQLSTATE\n  values that begin with \'00\', because those indicate success rather\n  than an error condition. For a list of MySQL error codes and SQLSTATE\n  values, see\n  http://dev.mysql.com/doc/refman/5.1/en/error-messages-server.html.\n\no A condition name previously specified with DECLARE ... CONDITION. A\n  condition name can be associated with a MySQL error code or SQLSTATE\n  value. See [HELP DECLARE CONDITION].\n\no SQLWARNING is shorthand for the class of SQLSTATE values that begin\n  with \'01\'.\n\no NOT FOUND is shorthand for the class of SQLSTATE values that begin\n  with \'02\'. This is relevant within the context of cursors and is used\n  to control what happens when a cursor reaches the end of a data set.\n  If no more rows are available, a No Data condition occurs with\n  SQLSTATE value \'02000\'. To detect this condition, you can set up a\n  handler for it (or for a NOT FOUND condition). For an example, see\n  http://dev.mysql.com/doc/refman/5.1/en/cursors.html. This condition\n  also occurs for SELECT ... INTO var_list statements that retrieve no\n  rows.\n\no SQLEXCEPTION is shorthand for the class of SQLSTATE values that do\n  not begin with \'00\', \'01\', or \'02\'.\n\nIf a condition occurs for which no handler has been declared, the\naction taken depends on the condition class:\n\no For SQLEXCEPTION conditions, the stored program terminates at the\n  statement that raised the condition, as if there were an EXIT\n  handler. If the program was called by another stored program, the\n  calling program handles the condition using the handler selection\n  rules applied to its own handlers.\n\no For SQLWARNING or NOT FOUND conditions, the program continues\n  executing, as if there were a CONTINUE handler.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/declare-handler.html\n\n','mysql> CREATE TABLE test.t (s1 INT, PRIMARY KEY (s1));\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> delimiter //\n\nmysql> CREATE PROCEDURE handlerdemo ()\n    -> BEGIN\n    ->   DECLARE CONTINUE HANDLER FOR SQLSTATE \'23000\' SET @x2 = 1;\n    ->   SET @x = 1;\n    ->   INSERT INTO test.t VALUES (1);\n    ->   SET @x = 2;\n    ->   INSERT INTO test.t VALUES (1);\n    ->   SET @x = 3;\n    -> END;\n    -> //\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> CALL handlerdemo()//\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT @x//\n    +------+\n    | @x   |\n    +------+\n    | 3    |\n    +------+\n    1 row in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.1/en/declare-handler.html'),(316,'DOUBLE',23,'DOUBLE[(M,D)] [UNSIGNED] [ZEROFILL]\n\nA normal-size (double-precision) floating-point number. Permissible\nvalues are -1.7976931348623157E+308 to -2.2250738585072014E-308, 0, and\n2.2250738585072014E-308 to 1.7976931348623157E+308. These are the\ntheoretical limits, based on the IEEE standard. The actual range might\nbe slightly smaller depending on your hardware or operating system.\n\nM is the total number of digits and D is the number of digits following\nthe decimal point. If M and D are omitted, values are stored to the\nlimits permitted by the hardware. A double-precision floating-point\nnumber is accurate to approximately 15 decimal places.\n\nUNSIGNED, if specified, disallows negative values.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(317,'TIME',23,'TIME\n\nA time. The range is \'-838:59:59\' to \'838:59:59\'. MySQL displays TIME\nvalues in \'HH:MM:SS\' format, but permits assignment of values to TIME\ncolumns using either strings or numbers.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-type-overview.html'),(318,'&&',15,'Syntax:\nAND, &&\n\nLogical AND. Evaluates to 1 if all operands are nonzero and not NULL,\nto 0 if one or more operands are 0, otherwise NULL is returned.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/logical-operators.html\n\n','mysql> SELECT 1 && 1;\n        -> 1\nmysql> SELECT 1 && 0;\n        -> 0\nmysql> SELECT 1 && NULL;\n        -> NULL\nmysql> SELECT 0 && NULL;\n        -> 0\nmysql> SELECT NULL && 0;\n        -> 0\n','http://dev.mysql.com/doc/refman/5.1/en/logical-operators.html'),(319,'X',11,'X(p)\n\nReturns the X-coordinate value for the Point object p as a\ndouble-precision number.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SELECT X(POINT(56.7, 53.34));\n+-----------------------+\n| X(POINT(56.7, 53.34)) |\n+-----------------------+\n|                  56.7 |\n+-----------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(320,'SYSTEM_USER',17,'Syntax:\nSYSTEM_USER()\n\nSYSTEM_USER() is a synonym for USER().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(321,'FOUND_ROWS',17,'Syntax:\nFOUND_ROWS()\n\nA SELECT statement may include a LIMIT clause to restrict the number of\nrows the server returns to the client. In some cases, it is desirable\nto know how many rows the statement would have returned without the\nLIMIT, but without running the statement again. To obtain this row\ncount, include a SQL_CALC_FOUND_ROWS option in the SELECT statement,\nand then invoke FOUND_ROWS() afterward:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> SELECT SQL_CALC_FOUND_ROWS * FROM tbl_name\n    -> WHERE id > 100 LIMIT 10;\nmysql> SELECT FOUND_ROWS();\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(322,'CROSSES',31,'Crosses(g1,g2)\n\nReturns 1 if g1 spatially crosses g2. Returns NULL if g1 is a Polygon\nor a MultiPolygon, or if g2 is a Point or a MultiPoint. Otherwise,\nreturns 0.\n\nThe term spatially crosses denotes a spatial relation between two given\ngeometries that has the following properties:\n\no The two geometries intersect\n\no Their intersection results in a geometry that has a dimension that is\n  one less than the maximum dimension of the two given geometries\n\no Their intersection is not equal to either of the two given geometries\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(323,'TRUNCATE TABLE',40,'Syntax:\nTRUNCATE [TABLE] tbl_name\n\nTRUNCATE TABLE empties a table completely. It requires the DROP\nprivilege as of MySQL 5.1.16. (Before 5.1.16, it requires the DELETE\nprivilege).\n\nLogically, TRUNCATE TABLE is equivalent to a DELETE statement that\ndeletes all rows, but there are practical differences under some\ncircumstances.\n\nFor an InnoDB table:\n\no If there are no FOREIGN KEY constraints, InnoDB performs fast\n  truncation by dropping the original table and creating an empty one\n  with the same definition, which is much faster than deleting rows one\n  by one.\n\no When you use this fast truncation technique with the\n  innodb_file_per_table option enabled, the operating system can reuse\n  the freed disk space. For users of the InnoDB Plugin, the space is\n  reclaimed automatically, as described in TRUNCATE TABLE Reclaims\n  Space\n  (http://dev.mysql.com/doc/refman/5.5/en/innodb-other-changes-truncate\n  .html). If you do not have the InnoDB Plugin installed, issue the\n  OPTIMIZE TABLE statement to free the disk space for the table.\n\no If there are any FOREIGN KEY constraints that reference the table,\n  InnoDB processes TRUNCATE TABLE by deleting rows one by one,\n  processing the constraints as it proceeds. If the FOREIGN KEY\n  constraint specifies DELETE CASCADE, rows from the child (referenced)\n  table are deleted, and the truncated table becomes empty. If the\n  FOREIGN KEY constraint does not specify CASCADE, the TRUNCATE TABLE\n  statement deletes rows one by one and stops if it encounters a parent\n  row that is referenced by the child, returning this error:\n\nERROR 1451 (23000): Cannot delete or update a parent row: a foreign\nkey constraint fails (`test`.`child`, CONSTRAINT `child_ibfk_1`\nFOREIGN KEY (`parent_id`) REFERENCES `parent` (`id`))\n\n  *Note*: In MySQL 5.5 and higher, TRUNCATE TABLE is not allowed for\n  InnoDB tables referenced by foreign keys. For ease of upgrading,\n  rewrite such statements to use DELETE instead.\n\no The AUTO_INCREMENT counter is reset to zero by TRUNCATE TABLE,\n  regardless of whether there is a FOREIGN KEY constraint.\n\nThis is the same as a DELETE statement with no WHERE clause.\n\nThe count of rows affected by TRUNCATE TABLE is accurate only when it\nis mapped to a DELETE statement.\n\nFor other storage engines, TRUNCATE TABLE differs from DELETE in the\nfollowing ways in MySQL 5.1:\n\no Truncate operations drop and re-create the table, which is much\n  faster than deleting rows one by one, particularly for large tables.\n\no Truncate operations cause an implicit commit.\n\no Truncation operations cannot be performed if the session holds an\n  active table lock.\n\no Truncation operations do not return a meaningful value for the number\n  of deleted rows. The usual result is \"0 rows affected,\" which should\n  be interpreted as \"no information.\"\n\no As long as the table format file tbl_name.frm is valid, the table can\n  be re-created as an empty table with TRUNCATE TABLE, even if the data\n  or index files have become corrupted.\n\no The table handler does not remember the last used AUTO_INCREMENT\n  value, but starts counting from the beginning. This is true even for\n  MyISAM and InnoDB, which normally do not reuse sequence values.\n\no When used with partitioned tables, TRUNCATE TABLE preserves the\n  partitioning; that is, the data and index files are dropped and\n  re-created, while the partition definitions (.par) file is\n  unaffected.\n\no Since truncation of a table does not make any use of DELETE, the\n  TRUNCATE TABLE statement does not invoke ON DELETE triggers.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/truncate-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/truncate-table.html'),(324,'BIT_XOR',16,'Syntax:\nBIT_XOR(expr)\n\nReturns the bitwise XOR of all bits in expr. The calculation is\nperformed with 64-bit (BIGINT) precision.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(325,'CURRENT_DATE',32,'Syntax:\nCURRENT_DATE, CURRENT_DATE()\n\nCURRENT_DATE and CURRENT_DATE() are synonyms for CURDATE().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(326,'START SLAVE',8,'Syntax:\nSTART SLAVE [thread_types]\n\nSTART SLAVE [SQL_THREAD] UNTIL\n    MASTER_LOG_FILE = \'log_name\', MASTER_LOG_POS = log_pos\n\nSTART SLAVE [SQL_THREAD] UNTIL\n    RELAY_LOG_FILE = \'log_name\', RELAY_LOG_POS = log_pos\n\nthread_types:\n    [thread_type [, thread_type] ... ]\n\nthread_type: IO_THREAD | SQL_THREAD\n\nSTART SLAVE with no thread_type options starts both of the slave\nthreads. The I/O thread reads events from the master server and stores\nthem in the relay log. The SQL thread reads events from the relay log\nand executes them. START SLAVE requires the SUPER privilege.\n\nIf START SLAVE succeeds in starting the slave threads, it returns\nwithout any error. However, even in that case, it might be that the\nslave threads start and then later stop (for example, because they do\nnot manage to connect to the master or read its binary log, or some\nother problem). START SLAVE does not warn you about this. You must\ncheck the slave\'s error log for error messages generated by the slave\nthreads, or check that they are running satisfactorily with SHOW SLAVE\nSTATUS.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/start-slave.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/start-slave.html'),(327,'AREA',2,'Area(poly)\n\nReturns as a double-precision number the area of the Polygon value\npoly, as measured in its spatial reference system.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @poly = \'Polygon((0 0,0 3,3 0,0 0),(1 1,1 2,2 1,1 1))\';\nmysql> SELECT Area(GeomFromText(@poly));\n+---------------------------+\n| Area(GeomFromText(@poly)) |\n+---------------------------+\n|                         4 |\n+---------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(328,'FLUSH',27,'Syntax:\nFLUSH [NO_WRITE_TO_BINLOG | LOCAL]\n    flush_option [, flush_option] ...\n\nThe FLUSH statement has several variant forms that clear or reload\nvarious internal caches, flush tables, or acquire locks. To execute\nFLUSH, you must have the RELOAD privilege.\n\nBy default, the server writes FLUSH statements to the binary log so\nthat they replicate to replication slaves. To suppress logging, specify\nthe optional NO_WRITE_TO_BINLOG keyword or its alias LOCAL.\n\n*Note*: FLUSH LOGS, FLUSH MASTER, FLUSH SLAVE, and FLUSH TABLES WITH\nREAD LOCK are not written to the binary log in any case because they\nwould cause problems if replicated to a slave.\n\nSending a SIGHUP signal to the server causes several flush operations\nto occur that are similar to various forms of the FLUSH statement. See\nhttp://dev.mysql.com/doc/refman/5.1/en/server-signal-response.html.\n\nThe FLUSH statement causes an implicit commit. See\nhttp://dev.mysql.com/doc/refman/5.1/en/implicit-commit.html.\n\nThe RESET statement is similar to FLUSH. See [HELP RESET], for\ninformation about using the RESET statement with replication.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/flush.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/flush.html'),(329,'BEGIN END',24,'Syntax:\n[begin_label:] BEGIN\n    [statement_list]\nEND [end_label]\n\nBEGIN ... END syntax is used for writing compound statements, which can\nappear within stored programs (stored procedures and functions,\ntriggers, and events). A compound statement can contain multiple\nstatements, enclosed by the BEGIN and END keywords. statement_list\nrepresents a list of one or more statements, each terminated by a\nsemicolon (;) statement delimiter. The statement_list itself is\noptional, so the empty compound statement (BEGIN END) is legal.\n\nBEGIN ... END blocks can be nested.\n\nUse of multiple statements requires that a client is able to send\nstatement strings containing the ; statement delimiter. In the mysql\ncommand-line client, this is handled with the delimiter command.\nChanging the ; end-of-statement delimiter (for example, to //) permit ;\nto be used in a program body. For an example, see\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-programs-defining.html.\n\nA BEGIN ... END block can be labeled. See [HELP labels].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/begin-end.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/begin-end.html'),(330,'SHOW PROCEDURE STATUS',27,'Syntax:\nSHOW PROCEDURE STATUS\n    [LIKE \'pattern\' | WHERE expr]\n\nThis statement is a MySQL extension. It returns characteristics of a\nstored procedure, such as the database, name, type, creator, creation\nand modification dates, and character set information. A similar\nstatement, SHOW FUNCTION STATUS, displays information about stored\nfunctions (see [HELP SHOW FUNCTION STATUS]).\n\nThe LIKE clause, if present, indicates which procedure or function\nnames to match. The WHERE clause can be given to select rows using more\ngeneral conditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-procedure-status.html\n\n','mysql> SHOW PROCEDURE STATUS LIKE \'sp1\'\\G\n*************************** 1. row ***************************\n                  Db: test\n                Name: sp1\n                Type: PROCEDURE\n             Definer: testuser@localhost\n            Modified: 2004-08-03 15:29:37\n             Created: 2004-08-03 15:29:37\n       Security_type: DEFINER\n             Comment:\ncharacter_set_client: latin1\ncollation_connection: latin1_swedish_ci\n  Database Collation: latin1_swedish_ci\n','http://dev.mysql.com/doc/refman/5.1/en/show-procedure-status.html'),(331,'SHOW WARNINGS',27,'Syntax:\nSHOW WARNINGS [LIMIT [offset,] row_count]\nSHOW COUNT(*) WARNINGS\n\nSHOW WARNINGS is a diagnostic statement that displays information about\nthe conditions (errors, warnings, and notes) resulting from executing a\nstatement in the current session. Warnings are generated for DML\nstatements such as INSERT, UPDATE, and LOAD DATA INFILE as well as DDL\nstatements such as CREATE TABLE and ALTER TABLE.\n\nThe LIMIT clause has the same syntax as for the SELECT statement. See\nhttp://dev.mysql.com/doc/refman/5.1/en/select.html.\n\nSHOW WARNINGS is also used following EXPLAIN EXTENDED, to display the\nextra information generated by EXPLAIN when the EXTENDED keyword is\nused. See http://dev.mysql.com/doc/refman/5.1/en/explain-extended.html.\n\nSHOW WARNINGS displays information about the conditions resulting from\nthe most recent statement in the current session that generated\nmessages. It shows nothing if the most recent statement used a table\nand generated no messages. (That is, statements that use a table but\ngenerate no messages clear the message list.) Statements that do not\nuse tables and do not generate messages have no effect on the message\nlist.\n\nThe SHOW COUNT(*) WARNINGS diagnostic statement displays the total\nnumber of errors, warnings, and notes. You can also retrieve this\nnumber from the warning_count system variable:\n\nSHOW COUNT(*) WARNINGS;\nSELECT @@warning_count;\n\nA related diagnostic statement, SHOW ERRORS, shows only error\nconditions (it excludes warnings and notes), and SHOW COUNT(*) ERRORS\nstatement displays the total number of errors. See [HELP SHOW ERRORS].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-warnings.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-warnings.html'),(332,'DROP USER',10,'Syntax:\nDROP USER user [, user] ...\n\nThe DROP USER statement removes one or more MySQL accounts and their\nprivileges. It removes privilege rows for the account from all grant\ntables. To use this statement, you must have the global CREATE USER\nprivilege or the DELETE privilege for the mysql database. Each account\nname uses the format described in\nhttp://dev.mysql.com/doc/refman/5.1/en/account-names.html. For example:\n\nDROP USER \'jeffrey\'@\'localhost\';\n\nIf you specify only the user name part of the account name, a host name\npart of \'%\' is used.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-user.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-user.html'),(333,'STDDEV_POP',16,'Syntax:\nSTDDEV_POP(expr)\n\nReturns the population standard deviation of expr (the square root of\nVAR_POP()). You can also use STD() or STDDEV(), which are equivalent\nbut not standard SQL.\n\nSTDDEV_POP() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(334,'SHOW CHARACTER SET',27,'Syntax:\nSHOW CHARACTER SET\n    [LIKE \'pattern\' | WHERE expr]\n\nThe SHOW CHARACTER SET statement shows all available character sets.\nThe LIKE clause, if present, indicates which character set names to\nmatch. The WHERE clause can be given to select rows using more general\nconditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html. For example:\n\nmysql> SHOW CHARACTER SET LIKE \'latin%\';\n+---------+-----------------------------+-------------------+--------+\n| Charset | Description                 | Default collation | Maxlen |\n+---------+-----------------------------+-------------------+--------+\n| latin1  | cp1252 West European        | latin1_swedish_ci |      1 |\n| latin2  | ISO 8859-2 Central European | latin2_general_ci |      1 |\n| latin5  | ISO 8859-9 Turkish          | latin5_turkish_ci |      1 |\n| latin7  | ISO 8859-13 Baltic          | latin7_general_ci |      1 |\n+---------+-----------------------------+-------------------+--------+\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-character-set.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-character-set.html'),(335,'SUBSTRING',38,'Syntax:\nSUBSTRING(str,pos), SUBSTRING(str FROM pos), SUBSTRING(str,pos,len),\nSUBSTRING(str FROM pos FOR len)\n\nThe forms without a len argument return a substring from string str\nstarting at position pos. The forms with a len argument return a\nsubstring len characters long from string str, starting at position\npos. The forms that use FROM are standard SQL syntax. It is also\npossible to use a negative value for pos. In this case, the beginning\nof the substring is pos characters from the end of the string, rather\nthan the beginning. A negative value may be used for pos in any of the\nforms of this function.\n\nFor all forms of SUBSTRING(), the position of the first character in\nthe string from which the substring is to be extracted is reckoned as\n1.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT SUBSTRING(\'Quadratically\',5);\n        -> \'ratically\'\nmysql> SELECT SUBSTRING(\'foobarbar\' FROM 4);\n        -> \'barbar\'\nmysql> SELECT SUBSTRING(\'Quadratically\',5,6);\n        -> \'ratica\'\nmysql> SELECT SUBSTRING(\'Sakila\', -3);\n        -> \'ila\'\nmysql> SELECT SUBSTRING(\'Sakila\', -5, 3);\n        -> \'aki\'\nmysql> SELECT SUBSTRING(\'Sakila\' FROM -4 FOR 2);\n        -> \'ki\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(336,'ISEMPTY',37,'IsEmpty(g)\n\nThis function is a placeholder that returns 0 for any valid geometry\nvalue, 1 for any invalid geometry value or NULL.\n\nMySQL does not support GIS EMPTY values such as POINT EMPTY.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(337,'SHOW FUNCTION STATUS',27,'Syntax:\nSHOW FUNCTION STATUS\n    [LIKE \'pattern\' | WHERE expr]\n\nThis statement is similar to SHOW PROCEDURE STATUS but for stored\nfunctions. See [HELP SHOW PROCEDURE STATUS].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-function-status.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-function-status.html'),(338,'LTRIM',38,'Syntax:\nLTRIM(str)\n\nReturns the string str with leading space characters removed.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT LTRIM(\'  barbar\');\n        -> \'barbar\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(339,'INTERSECTS',31,'Intersects(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 spatially intersects g2.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(340,'CALL',28,'Syntax:\nCALL sp_name([parameter[,...]])\nCALL sp_name[()]\n\nThe CALL statement invokes a stored procedure that was defined\npreviously with CREATE PROCEDURE.\n\nAs of MySQL 5.1.13, stored procedures that take no arguments can be\ninvoked without parentheses. That is, CALL p() and CALL p are\nequivalent.\n\nCALL can pass back values to its caller using parameters that are\ndeclared as OUT or INOUT parameters. When the procedure returns, a\nclient program can also obtain the number of rows affected for the\nfinal statement executed within the routine: At the SQL level, call the\nROW_COUNT() function; from the C API, call the mysql_affected_rows()\nfunction.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/call.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/call.html'),(341,'MBRDISJOINT',6,'MBRDisjoint(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangles of\nthe two geometries g1 and g2 are disjoint (do not intersect).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(342,'VALUES',14,'Syntax:\nVALUES(col_name)\n\nIn an INSERT ... ON DUPLICATE KEY UPDATE statement, you can use the\nVALUES(col_name) function in the UPDATE clause to refer to column\nvalues from the INSERT portion of the statement. In other words,\nVALUES(col_name) in the UPDATE clause refers to the value of col_name\nthat would be inserted, had no duplicate-key conflict occurred. This\nfunction is especially useful in multiple-row inserts. The VALUES()\nfunction is meaningful only in the ON DUPLICATE KEY UPDATE clause of\nINSERT statements and returns NULL otherwise. See\nhttp://dev.mysql.com/doc/refman/5.1/en/insert-on-duplicate.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','mysql> INSERT INTO table (a,b,c) VALUES (1,2,3),(4,5,6)\n    -> ON DUPLICATE KEY UPDATE c=VALUES(a)+VALUES(b);\n','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(343,'SUBSTRING_INDEX',38,'Syntax:\nSUBSTRING_INDEX(str,delim,count)\n\nReturns the substring from string str before count occurrences of the\ndelimiter delim. If count is positive, everything to the left of the\nfinal delimiter (counting from the left) is returned. If count is\nnegative, everything to the right of the final delimiter (counting from\nthe right) is returned. SUBSTRING_INDEX() performs a case-sensitive\nmatch when searching for delim.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT SUBSTRING_INDEX(\'www.mysql.com\', \'.\', 2);\n        -> \'www.mysql\'\nmysql> SELECT SUBSTRING_INDEX(\'www.mysql.com\', \'.\', -2);\n        -> \'mysql.com\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(344,'ENCODE',12,'Syntax:\nENCODE(str,pass_str)\n\nEncrypt str using pass_str as the password. The result is a binary\nstring of the same length as str. To decrypt the result, use DECODE().\n\nThe ENCODE() function should no longer be used. If you still need to\nuse ENCODE(), a salt value must be used with it to reduce risk. For\nexample:\n\nENCODE(\'plaintext\', CONCAT(\'my_random_salt\',\'my_secret_password\'))\n\nA new random salt value must be used whenever a password is updated.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(345,'LOOP',24,'Syntax:\n[begin_label:] LOOP\n    statement_list\nEND LOOP [end_label]\n\nLOOP implements a simple loop construct, enabling repeated execution of\nthe statement list, which consists of one or more statements, each\nterminated by a semicolon (;) statement delimiter. The statements\nwithin the loop are repeated until the loop is terminated. Usually,\nthis is accomplished with a LEAVE statement. Within a stored function,\nRETURN can also be used, which exits the function entirely.\n\nNeglecting to include a loop-termination statement results in an\ninfinite loop.\n\nA LOOP statement can be labeled. For the rules regarding label use, see\n[HELP labels].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/loop.html\n\n','CREATE PROCEDURE doiterate(p1 INT)\nBEGIN\n  label1: LOOP\n    SET p1 = p1 + 1;\n    IF p1 < 10 THEN\n      ITERATE label1;\n    END IF;\n    LEAVE label1;\n  END LOOP label1;\n  SET @x = p1;\nEND;\n','http://dev.mysql.com/doc/refman/5.1/en/loop.html'),(346,'TRUNCATE',4,'Syntax:\nTRUNCATE(X,D)\n\nReturns the number X, truncated to D decimal places. If D is 0, the\nresult has no decimal point or fractional part. D can be negative to\ncause D digits left of the decimal point of the value X to become zero.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT TRUNCATE(1.223,1);\n        -> 1.2\nmysql> SELECT TRUNCATE(1.999,1);\n        -> 1.9\nmysql> SELECT TRUNCATE(1.999,0);\n        -> 1\nmysql> SELECT TRUNCATE(-1.999,1);\n        -> -1.9\nmysql> SELECT TRUNCATE(122,-2);\n       -> 100\nmysql> SELECT TRUNCATE(10.28*100,0);\n       -> 1028\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(347,'TIMESTAMPADD',32,'Syntax:\nTIMESTAMPADD(unit,interval,datetime_expr)\n\nAdds the integer expression interval to the date or datetime expression\ndatetime_expr. The unit for interval is given by the unit argument,\nwhich should be one of the following values: FRAC_SECOND\n(microseconds), SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, or\nYEAR.\n\nBeginning with MySQL 5.1.24, it is possible to use MICROSECOND in place\nof FRAC_SECOND with this function, and FRAC_SECOND is deprecated.\nFRAC_SECOND is removed in MySQL 5.5.\n\nThe unit value may be specified using one of keywords as shown, or with\na prefix of SQL_TSI_. For example, DAY and SQL_TSI_DAY both are legal.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT TIMESTAMPADD(MINUTE,1,\'2003-01-02\');\n        -> \'2003-01-02 00:01:00\'\nmysql> SELECT TIMESTAMPADD(WEEK,1,\'2003-01-02\');\n        -> \'2003-01-09\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(348,'SHOW',27,'SHOW has many forms that provide information about databases, tables,\ncolumns, or status information about the server. This section describes\nthose following:\n\nSHOW AUTHORS\nSHOW {BINARY | MASTER} LOGS\nSHOW BINLOG EVENTS [IN \'log_name\'] [FROM pos] [LIMIT [offset,] row_count]\nSHOW CHARACTER SET [like_or_where]\nSHOW COLLATION [like_or_where]\nSHOW [FULL] COLUMNS FROM tbl_name [FROM db_name] [like_or_where]\nSHOW CONTRIBUTORS\nSHOW CREATE DATABASE db_name\nSHOW CREATE EVENT event_name\nSHOW CREATE FUNCTION func_name\nSHOW CREATE PROCEDURE proc_name\nSHOW CREATE TABLE tbl_name\nSHOW CREATE TRIGGER trigger_name\nSHOW CREATE VIEW view_name\nSHOW DATABASES [like_or_where]\nSHOW ENGINE engine_name {STATUS | MUTEX}\nSHOW [STORAGE] ENGINES\nSHOW ERRORS [LIMIT [offset,] row_count]\nSHOW EVENTS\nSHOW FUNCTION CODE func_name\nSHOW FUNCTION STATUS [like_or_where]\nSHOW GRANTS FOR user\nSHOW INDEX FROM tbl_name [FROM db_name]\nSHOW INNODB STATUS\nSHOW MASTER STATUS\nSHOW OPEN TABLES [FROM db_name] [like_or_where]\nSHOW PLUGINS\nSHOW PROCEDURE CODE proc_name\nSHOW PROCEDURE STATUS [like_or_where]\nSHOW PRIVILEGES\nSHOW [FULL] PROCESSLIST\nSHOW PROFILE [types] [FOR QUERY n] [OFFSET n] [LIMIT n]\nSHOW PROFILES\nSHOW SCHEDULER STATUS\nSHOW SLAVE HOSTS\nSHOW SLAVE STATUS\nSHOW [GLOBAL | SESSION] STATUS [like_or_where]\nSHOW TABLE STATUS [FROM db_name] [like_or_where]\nSHOW [FULL] TABLES [FROM db_name] [like_or_where]\nSHOW TRIGGERS [FROM db_name] [like_or_where]\nSHOW [GLOBAL | SESSION] VARIABLES [like_or_where]\nSHOW WARNINGS [LIMIT [offset,] row_count]\n\nlike_or_where:\n    LIKE \'pattern\'\n  | WHERE expr\n\nIf the syntax for a given SHOW statement includes a LIKE \'pattern\'\npart, \'pattern\' is a string that can contain the SQL \"%\" and \"_\"\nwildcard characters. The pattern is useful for restricting statement\noutput to matching values.\n\nSeveral SHOW statements also accept a WHERE clause that provides more\nflexibility in specifying which rows to display. See\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show.html'),(349,'GREATEST',19,'Syntax:\nGREATEST(value1,value2,...)\n\nWith two or more arguments, returns the largest (maximum-valued)\nargument. The arguments are compared using the same rules as for\nLEAST().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT GREATEST(2,0);\n        -> 2\nmysql> SELECT GREATEST(34.0,3.0,5.0,767.0);\n        -> 767.0\nmysql> SELECT GREATEST(\'B\',\'A\',\'C\');\n        -> \'C\'\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(350,'SHOW VARIABLES',27,'Syntax:\nSHOW [GLOBAL | SESSION] VARIABLES\n    [LIKE \'pattern\' | WHERE expr]\n\nSHOW VARIABLES shows the values of MySQL system variables. This\ninformation also can be obtained using the mysqladmin variables\ncommand. The LIKE clause, if present, indicates which variable names to\nmatch. The WHERE clause can be given to select rows using more general\nconditions, as discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html. This\nstatement does not require any privilege. It requires only the ability\nto connect to the server.\n\nWith the GLOBAL modifier, SHOW VARIABLES displays the values that are\nused for new connections to MySQL. If a variable has no global value,\nthe session value is displayed. With SESSION, SHOW VARIABLES displays\nthe values that are in effect for the current connection. If no\nmodifier is present, the default is SESSION. LOCAL is a synonym for\nSESSION.\nWith a LIKE clause, the statement displays only rows for those\nvariables with names that match the pattern. To obtain the row for a\nspecific variable, use a LIKE clause as shown:\n\nSHOW VARIABLES LIKE \'max_join_size\';\nSHOW SESSION VARIABLES LIKE \'max_join_size\';\n\nTo get a list of variables whose name match a pattern, use the \"%\"\nwildcard character in a LIKE clause:\n\nSHOW VARIABLES LIKE \'%size%\';\nSHOW GLOBAL VARIABLES LIKE \'%size%\';\n\nWildcard characters can be used in any position within the pattern to\nbe matched. Strictly speaking, because \"_\" is a wildcard that matches\nany single character, you should escape it as \"\\_\" to match it\nliterally. In practice, this is rarely necessary.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-variables.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-variables.html'),(351,'BINLOG',27,'Syntax:\nBINLOG \'str\'\n\nBINLOG is an internal-use statement. It is generated by the mysqlbinlog\nprogram as the printable representation of certain events in binary log\nfiles. (See http://dev.mysql.com/doc/refman/5.1/en/mysqlbinlog.html.)\nThe \'str\' value is a base 64-encoded string the that server decodes to\ndetermine the data change indicated by the corresponding event. This\nstatement requires the SUPER privilege. It was added in MySQL 5.1.5.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/binlog.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/binlog.html'),(352,'BIT_AND',16,'Syntax:\nBIT_AND(expr)\n\nReturns the bitwise AND of all bits in expr. The calculation is\nperformed with 64-bit (BIGINT) precision.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(353,'SECOND',32,'Syntax:\nSECOND(time)\n\nReturns the second for time, in the range 0 to 59.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT SECOND(\'10:05:03\');\n        -> 3\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(354,'ATAN2',4,'Syntax:\nATAN(Y,X), ATAN2(Y,X)\n\nReturns the arc tangent of the two variables X and Y. It is similar to\ncalculating the arc tangent of Y / X, except that the signs of both\narguments are used to determine the quadrant of the result.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT ATAN(-2,2);\n        -> -0.78539816339745\nmysql> SELECT ATAN2(PI(),0);\n        -> 1.5707963267949\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(355,'MBRCONTAINS',6,'MBRContains(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangle of g1\ncontains the Minimum Bounding Rectangle of g2. This tests the opposite\nrelationship as MBRWithin().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','mysql> SET @g1 = GeomFromText(\'Polygon((0 0,0 3,3 3,3 0,0 0))\');\nmysql> SET @g2 = GeomFromText(\'Point(1 1)\');\nmysql> SELECT MBRContains(@g1,@g2), MBRContains(@g2,@g1);\n----------------------+----------------------+\n| MBRContains(@g1,@g2) | MBRContains(@g2,@g1) |\n+----------------------+----------------------+\n|                    1 |                    0 |\n+----------------------+----------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(356,'HOUR',32,'Syntax:\nHOUR(time)\n\nReturns the hour for time. The range of the return value is 0 to 23 for\ntime-of-day values. However, the range of TIME values actually is much\nlarger, so HOUR can return values greater than 23.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT HOUR(\'10:05:03\');\n        -> 10\nmysql> SELECT HOUR(\'272:59:59\');\n        -> 272\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(357,'SELECT',28,'Syntax:\nSELECT\n    [ALL | DISTINCT | DISTINCTROW ]\n      [HIGH_PRIORITY]\n      [STRAIGHT_JOIN]\n      [SQL_SMALL_RESULT] [SQL_BIG_RESULT] [SQL_BUFFER_RESULT]\n      [SQL_CACHE | SQL_NO_CACHE] [SQL_CALC_FOUND_ROWS]\n    select_expr [, select_expr ...]\n    [FROM table_references\n    [WHERE where_condition]\n    [GROUP BY {col_name | expr | position}\n      [ASC | DESC], ... [WITH ROLLUP]]\n    [HAVING where_condition]\n    [ORDER BY {col_name | expr | position}\n      [ASC | DESC], ...]\n    [LIMIT {[offset,] row_count | row_count OFFSET offset}]\n    [PROCEDURE procedure_name(argument_list)]\n    [INTO OUTFILE \'file_name\'\n        [CHARACTER SET charset_name]\n        export_options\n      | INTO DUMPFILE \'file_name\'\n      | INTO var_name [, var_name]]\n    [FOR UPDATE | LOCK IN SHARE MODE]]\n\nSELECT is used to retrieve rows selected from one or more tables, and\ncan include UNION statements and subqueries. See [HELP UNION], and\nhttp://dev.mysql.com/doc/refman/5.1/en/subqueries.html.\n\nThe most commonly used clauses of SELECT statements are these:\n\no Each select_expr indicates a column that you want to retrieve. There\n  must be at least one select_expr.\n\no table_references indicates the table or tables from which to retrieve\n  rows. Its syntax is described in [HELP JOIN].\n\no The WHERE clause, if given, indicates the condition or conditions\n  that rows must satisfy to be selected. where_condition is an\n  expression that evaluates to true for each row to be selected. The\n  statement selects all rows if there is no WHERE clause.\n\n  In the WHERE expression, you can use any of the functions and\n  operators that MySQL supports, except for aggregate (summary)\n  functions. See\n  http://dev.mysql.com/doc/refman/5.1/en/expressions.html, and\n  http://dev.mysql.com/doc/refman/5.1/en/functions.html.\n\nSELECT can also be used to retrieve rows computed without reference to\nany table.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/select.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/select.html'),(358,'COT',4,'Syntax:\nCOT(X)\n\nReturns the cotangent of X.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT COT(12);\n        -> -1.5726734063977\nmysql> SELECT COT(0);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(359,'SHOW CREATE EVENT',27,'Syntax:\nSHOW CREATE EVENT event_name\n\nThis statement displays the CREATE EVENT statement needed to re-create\na given event. It requires the EVENT privilege for the database from\nwhich the event is to be shown. For example (using the same event\ne_daily defined and then altered in [HELP SHOW EVENTS]):\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-create-event.html\n\n','mysql> SHOW CREATE EVENT test.e_daily\\G\n*************************** 1. row ***************************\n               Event: e_daily\n            sql_mode:\n           time_zone: SYSTEM\n        Create Event: CREATE EVENT `e_daily`\n                        ON SCHEDULE EVERY 1 DAY\n                        STARTS CURRENT_TIMESTAMP + INTERVAL 6 HOUR\n                        ON COMPLETION NOT PRESERVE\n                        ENABLE\n                        COMMENT \'Saves total number of sessions then\n                                clears the table each day\'\n                        DO BEGIN\n                          INSERT INTO site_activity.totals (time, total)\n                            SELECT CURRENT_TIMESTAMP, COUNT(*)\n                            FROM site_activity.sessions;\n                          DELETE FROM site_activity.sessions;\n                        END\ncharacter_set_client: latin1\ncollation_connection: latin1_swedish_ci\n  Database Collation: latin1_swedish_ci\n','http://dev.mysql.com/doc/refman/5.1/en/show-create-event.html'),(360,'BACKUP TABLE',21,'Syntax:\nBACKUP TABLE tbl_name [, tbl_name] ... TO \'/path/to/backup/directory\'\n\n*Note*: This statement is deprecated and is removed in MySQL 5.5. As an\nalternative, mysqldump or mysqlhotcopy can be used instead.\n\nBACKUP TABLE copies to the backup directory the minimum number of table\nfiles needed to restore the table, after flushing any buffered changes\nto disk. The statement works only for MyISAM tables. It copies the .frm\ndefinition and .MYD data files. The .MYI index file can be rebuilt from\nthose two files. The directory should be specified as a full path name.\nTo restore the table, use RESTORE TABLE.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/backup-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/backup-table.html'),(361,'LOAD_FILE',38,'Syntax:\nLOAD_FILE(file_name)\n\nReads the file and returns the file contents as a string. To use this\nfunction, the file must be located on the server host, you must specify\nthe full path name to the file, and you must have the FILE privilege.\nThe file must be readable by all and its size less than\nmax_allowed_packet bytes. If the secure_file_priv system variable is\nset to a nonempty directory name, the file to be loaded must be located\nin that directory.\n\nIf the file does not exist or cannot be read because one of the\npreceding conditions is not satisfied, the function returns NULL.\n\nAs of MySQL 5.1.6, the character_set_filesystem system variable\ncontrols interpretation of file names that are given as literal\nstrings.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> UPDATE t\n            SET blob_col=LOAD_FILE(\'/tmp/picture\')\n            WHERE id=1;\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(362,'LOAD TABLE FROM MASTER',8,'Syntax:\nLOAD TABLE tbl_name FROM MASTER\n\nThis feature is deprecated and should be avoided. It is subject to\nremoval in a future version of MySQL.\n\nSince the current implementation of LOAD DATA FROM MASTER and LOAD\nTABLE FROM MASTER is very limited, these statements are deprecated as\nof MySQL 4.1 and removed in MySQL 5.5.\n\nThe recommended alternative solution to using LOAD DATA FROM MASTER or\nLOAD TABLE FROM MASTER is using mysqldump or mysqlhotcopy. The latter\nrequires Perl and two Perl modules (DBI and DBD:mysql) and works for\nMyISAM and ARCHIVE tables only. With mysqldump, you can create SQL\ndumps on the master and pipe (or copy) these to a mysql client on the\nslave. This has the advantage of working for all storage engines, but\ncan be quite slow, since it works using SELECT.\n\nTransfers a copy of the table from the master to the slave. This\nstatement is implemented mainly debugging LOAD DATA FROM MASTER\noperations. To use LOAD TABLE, the account used for connecting to the\nmaster server must have the RELOAD and SUPER privileges on the master\nand the SELECT privilege for the master table to load. On the slave\nside, the user that issues LOAD TABLE FROM MASTER must have privileges\nfor dropping and creating the table.\n\nThe conditions for LOAD DATA FROM MASTER apply here as well. For\nexample, LOAD TABLE FROM MASTER works only for MyISAM tables. The\ntimeout notes for LOAD DATA FROM MASTER apply as well.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/load-table-from-master.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/load-table-from-master.html'),(363,'POINTFROMTEXT',3,'PointFromText(wkt[,srid])\n\nConstructs a POINT value using its WKT representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(364,'GROUP_CONCAT',16,'Syntax:\nGROUP_CONCAT(expr)\n\nThis function returns a string result with the concatenated non-NULL\nvalues from a group. It returns NULL if there are no non-NULL values.\nThe full syntax is as follows:\n\nGROUP_CONCAT([DISTINCT] expr [,expr ...]\n             [ORDER BY {unsigned_integer | col_name | expr}\n                 [ASC | DESC] [,col_name ...]]\n             [SEPARATOR str_val])\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','mysql> SELECT student_name,\n    ->     GROUP_CONCAT(test_score)\n    ->     FROM student\n    ->     GROUP BY student_name;\n','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(365,'DATE_FORMAT',32,'Syntax:\nDATE_FORMAT(date,format)\n\nFormats the date value according to the format string.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT DATE_FORMAT(\'2009-10-04 22:23:00\', \'%W %M %Y\');\n        -> \'Sunday October 2009\'\nmysql> SELECT DATE_FORMAT(\'2007-10-04 22:23:00\', \'%H:%i:%s\');\n        -> \'22:23:00\'\nmysql> SELECT DATE_FORMAT(\'1900-10-04 22:23:00\',\n    ->                 \'%D %y %a %d %m %b %j\');\n        -> \'4th 00 Thu 04 10 Oct 277\'\nmysql> SELECT DATE_FORMAT(\'1997-10-04 22:23:00\',\n    ->                 \'%H %k %I %r %T %S %w\');\n        -> \'22 22 10 10:23:00 PM 22:23:00 00 6\'\nmysql> SELECT DATE_FORMAT(\'1999-01-01\', \'%X %V\');\n        -> \'1998 52\'\nmysql> SELECT DATE_FORMAT(\'2006-06-00\', \'%d\');\n        -> \'00\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(366,'BENCHMARK',17,'Syntax:\nBENCHMARK(count,expr)\n\nThe BENCHMARK() function executes the expression expr repeatedly count\ntimes. It may be used to time how quickly MySQL processes the\nexpression. The result value is always 0. The intended use is from\nwithin the mysql client, which reports query execution times:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> SELECT BENCHMARK(1000000,ENCODE(\'hello\',\'goodbye\'));\n+----------------------------------------------+\n| BENCHMARK(1000000,ENCODE(\'hello\',\'goodbye\')) |\n+----------------------------------------------+\n|                                            0 |\n+----------------------------------------------+\n1 row in set (4.74 sec)\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(367,'YEAR',32,'Syntax:\nYEAR(date)\n\nReturns the year for date, in the range 1000 to 9999, or 0 for the\n\"zero\" date.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT YEAR(\'1987-01-01\');\n        -> 1987\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(368,'SHOW ENGINE',27,'Syntax:\nSHOW ENGINE engine_name {STATUS | MUTEX}\n\nSHOW ENGINE displays operational information about a storage engine. It\nrequires the PROCESS privilege. The following statements currently are\nsupported:\n\nSHOW ENGINE INNODB STATUS\nSHOW ENGINE INNODB MUTEX\nSHOW ENGINE {NDB | NDBCLUSTER} STATUS\n\nOlder (and now deprecated) synonyms are SHOW INNODB STATUS for SHOW\nENGINE INNODB STATUS and SHOW MUTEX STATUS for SHOW ENGINE INNODB\nMUTEX. SHOW INNODB STATUS and SHOW MUTEX STATUS are removed in MySQL\n5.5.\n\nIn MySQL 5.0, SHOW ENGINE INNODB MUTEX is invoked as SHOW MUTEX STATUS.\nThe latter statement displays similar information but in a somewhat\ndifferent output format.\n\nSHOW ENGINE BDB LOGS formerly displayed status information about BDB\nlog files. As of MySQL 5.1.12, the BDB storage engine is not supported,\nand this statement produces a warning.\n\nSHOW ENGINE INNODB STATUS displays extensive information from the\nstandard InnoDB Monitor about the state of the InnoDB storage engine.\nFor information about the standard monitor and other InnoDB Monitors\nthat provide information about InnoDB processing, see\nhttp://dev.mysql.com/doc/refman/5.1/en/innodb-monitors.html.\n\nSHOW ENGINE INNODB MUTEX displays InnoDB mutex statistics. From MySQL\n5.1.2 to 5.1.14, the statement displays the following output fields:\n\no Type\n\n  Always InnoDB.\n\no Name\n\n  The mutex name and the source file where it is implemented. Example:\n  &pool->mutex:mem0pool.c\n\n  The mutex name indicates its purpose. For example, the log_sys mutex\n  is used by the InnoDB logging subsystem and indicates how intensive\n  logging activity is. The buf_pool mutex protects the InnoDB buffer\n  pool.\n\no Status\n\n  The mutex status. The fields contains several values:\n\n  o count indicates how many times the mutex was requested.\n\n  o spin_waits indicates how many times the spinlock had to run.\n\n  o spin_rounds indicates the number of spinlock rounds. (spin_rounds\n    divided by spin_waits provides the average round count.)\n\n  o os_waits indicates the number of operating system waits. This\n    occurs when the spinlock did not work (the mutex was not locked\n    during the spinlock and it was necessary to yield to the operating\n    system and wait).\n\n  o os_yields indicates the number of times a the thread trying to lock\n    a mutex gave up its timeslice and yielded to the operating system\n    (on the presumption that permitting other threads to run will free\n    the mutex so that it can be locked).\n\n  o os_wait_times indicates the amount of time (in ms) spent in\n    operating system waits, if the timed_mutexes system variable is 1\n    (ON). If timed_mutexes is 0 (OFF), timing is disabled, so\n    os_wait_times is 0. timed_mutexes is off by default.\n\nFrom MySQL 5.1.15 on, the statement displays the following output\nfields:\n\no Type\n\n  Always InnoDB.\n\no Name\n\n  The source file where the mutex is implemented, and the line number\n  in the file where the mutex is created. The line number may change\n  depending on your version of MySQL.\n\no Status\n\n  This field displays the same values as previously described (count,\n  spin_waits, spin_rounds, os_waits, os_yields, os_wait_times), but\n  only if UNIV_DEBUG was defined at MySQL compilation time (for\n  example, in include/univ.i in the InnoDB part of the MySQL source\n  tree). If UNIV_DEBUG was not defined, the statement displays only the\n  os_waits value. In the latter case (without UNIV_DEBUG), the\n  information on which the output is based is insufficient to\n  distinguish regular mutexes and mutexes that protect rw-locks (which\n  permit multiple readers or a single writer). Consequently, the output\n  may appear to contain multiple rows for the same mutex.\n\nInformation from this statement can be used to diagnose system\nproblems. For example, large values of spin_waits and spin_rounds may\nindicate scalability problems.\n\nIf the server has the NDBCLUSTER storage engine enabled, SHOW ENGINE\nNDB STATUS displays cluster status information such as the number of\nconnected data nodes, the cluster connectstring, and cluster binlog\nepochs, as well as counts of various Cluster API objects created by the\nMySQL Server when connected to the cluster. Sample output from this\nstatement is shown here:\n\nmysql> SHOW ENGINE NDB STATUS;\n+------------+-----------------------+--------------------------------------------------+\n| Type       | Name                  | Status                                           |\n+------------+-----------------------+--------------------------------------------------+\n| ndbcluster | connection            | cluster_node_id=7,\n  connected_host=192.168.0.103, connected_port=1186, number_of_data_nodes=4,\n  number_of_ready_data_nodes=3, connect_count=0                                         |\n| ndbcluster | NdbTransaction        | created=6, free=0, sizeof=212                    |\n| ndbcluster | NdbOperation          | created=8, free=8, sizeof=660                    |\n| ndbcluster | NdbIndexScanOperation | created=1, free=1, sizeof=744                    |\n| ndbcluster | NdbIndexOperation     | created=0, free=0, sizeof=664                    |\n| ndbcluster | NdbRecAttr            | created=1285, free=1285, sizeof=60               |\n| ndbcluster | NdbApiSignal          | created=16, free=16, sizeof=136                  |\n| ndbcluster | NdbLabel              | created=0, free=0, sizeof=196                    |\n| ndbcluster | NdbBranch             | created=0, free=0, sizeof=24                     |\n| ndbcluster | NdbSubroutine         | created=0, free=0, sizeof=68                     |\n| ndbcluster | NdbCall               | created=0, free=0, sizeof=16                     |\n| ndbcluster | NdbBlob               | created=1, free=1, sizeof=264                    |\n| ndbcluster | NdbReceiver           | created=4, free=0, sizeof=68                     |\n| ndbcluster | binlog                | latest_epoch=155467, latest_trans_epoch=148126,\n  latest_received_binlog_epoch=0, latest_handled_binlog_epoch=0,\n  latest_applied_binlog_epoch=0                                                         |\n+------------+-----------------------+--------------------------------------------------+\n\nThe rows with connection and binlog in the Name column were added to\nthe output of this statement in MySQL 5.1. The Status column in each of\nthese rows provides information about the MySQL server\'s connection to\nthe cluster and about the cluster binary log\'s status, respectively.\nThe Status information is in the form of comma-delimited set of\nname/value pairs.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-engine.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-engine.html'),(369,'NAME_CONST',14,'Syntax:\nNAME_CONST(name,value)\n\nReturns the given value. When used to produce a result set column,\nNAME_CONST() causes the column to have the given name. The arguments\nshould be constants.\n\nmysql> SELECT NAME_CONST(\'myname\', 14);\n+--------+\n| myname |\n+--------+\n|     14 |\n+--------+\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(370,'RELEASE_LOCK',14,'Syntax:\nRELEASE_LOCK(str)\n\nReleases the lock named by the string str that was obtained with\nGET_LOCK(). Returns 1 if the lock was released, 0 if the lock was not\nestablished by this thread (in which case the lock is not released),\nand NULL if the named lock did not exist. The lock does not exist if it\nwas never obtained by a call to GET_LOCK() or if it has previously been\nreleased.\n\nThe DO statement is convenient to use with RELEASE_LOCK(). See [HELP\nDO].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(371,'IS NULL',19,'Syntax:\nIS NULL\n\nTests whether a value is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 1 IS NULL, 0 IS NULL, NULL IS NULL;\n        -> 0, 0, 1\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(372,'CONVERT_TZ',32,'Syntax:\nCONVERT_TZ(dt,from_tz,to_tz)\n\nCONVERT_TZ() converts a datetime value dt from the time zone given by\nfrom_tz to the time zone given by to_tz and returns the resulting\nvalue. Time zones are specified as described in\nhttp://dev.mysql.com/doc/refman/5.1/en/time-zone-support.html. This\nfunction returns NULL if the arguments are invalid.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT CONVERT_TZ(\'2004-01-01 12:00:00\',\'GMT\',\'MET\');\n        -> \'2004-01-01 13:00:00\'\nmysql> SELECT CONVERT_TZ(\'2004-01-01 12:00:00\',\'+00:00\',\'+10:00\');\n        -> \'2004-01-01 22:00:00\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(373,'TIME_TO_SEC',32,'Syntax:\nTIME_TO_SEC(time)\n\nReturns the time argument, converted to seconds.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT TIME_TO_SEC(\'22:23:00\');\n        -> 80580\nmysql> SELECT TIME_TO_SEC(\'00:39:38\');\n        -> 2378\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(374,'WEEKDAY',32,'Syntax:\nWEEKDAY(date)\n\nReturns the weekday index for date (0 = Monday, 1 = Tuesday, ... 6 =\nSunday).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT WEEKDAY(\'2008-02-03 22:23:00\');\n        -> 6\nmysql> SELECT WEEKDAY(\'2007-11-06\');\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(375,'EXPORT_SET',38,'Syntax:\nEXPORT_SET(bits,on,off[,separator[,number_of_bits]])\n\nReturns a string such that for every bit set in the value bits, you get\nan on string and for every bit not set in the value, you get an off\nstring. Bits in bits are examined from right to left (from low-order to\nhigh-order bits). Strings are added to the result from left to right,\nseparated by the separator string (the default being the comma\ncharacter \",\"). The number of bits examined is given by number_of_bits,\nwhich has a default of 64 if not specified. number_of_bits is silently\nclipped to 64 if larger than 64. It is treated as an unsigned integer,\nso a value of -1 is effectively the same as 64.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT EXPORT_SET(5,\'Y\',\'N\',\',\',4);\n        -> \'Y,N,Y,N\'\nmysql> SELECT EXPORT_SET(6,\'1\',\'0\',\',\',10);\n        -> \'0,1,1,0,0,0,0,0,0,0\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(376,'ALTER SERVER',40,'Syntax:\nALTER SERVER  server_name\n    OPTIONS (option [, option] ...)\n\nAlters the server information for server_name, adjusting any of the\noptions permitted in the CREATE SERVER statement. The corresponding\nfields in the mysql.servers table are updated accordingly. This\nstatement requires the SUPER privilege.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/alter-server.html\n\n','ALTER SERVER s OPTIONS (USER \'sally\');\n','http://dev.mysql.com/doc/refman/5.1/en/alter-server.html'),(377,'TIME FUNCTION',32,'Syntax:\nTIME(expr)\n\nExtracts the time part of the time or datetime expression expr and\nreturns it as a string.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT TIME(\'2003-12-31 01:02:03\');\n        -> \'01:02:03\'\nmysql> SELECT TIME(\'2003-12-31 01:02:03.000123\');\n        -> \'01:02:03.000123\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(378,'DATE_ADD',32,'Syntax:\nDATE_ADD(date,INTERVAL expr unit), DATE_SUB(date,INTERVAL expr unit)\n\nThese functions perform date arithmetic. The date argument specifies\nthe starting date or datetime value. expr is an expression specifying\nthe interval value to be added or subtracted from the starting date.\nexpr is a string; it may start with a \"-\" for negative intervals. unit\nis a keyword indicating the units in which the expression should be\ninterpreted.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT \'2008-12-31 23:59:59\' + INTERVAL 1 SECOND;\n        -> \'2009-01-01 00:00:00\'\nmysql> SELECT INTERVAL 1 DAY + \'2008-12-31\';\n        -> \'2009-01-01\'\nmysql> SELECT \'2005-01-01\' - INTERVAL 1 SECOND;\n        -> \'2004-12-31 23:59:59\'\nmysql> SELECT DATE_ADD(\'2000-12-31 23:59:59\',\n    ->                 INTERVAL 1 SECOND);\n        -> \'2001-01-01 00:00:00\'\nmysql> SELECT DATE_ADD(\'2010-12-31 23:59:59\',\n    ->                 INTERVAL 1 DAY);\n        -> \'2011-01-01 23:59:59\'\nmysql> SELECT DATE_ADD(\'2100-12-31 23:59:59\',\n    ->                 INTERVAL \'1:1\' MINUTE_SECOND);\n        -> \'2101-01-01 00:01:00\'\nmysql> SELECT DATE_SUB(\'2005-01-01 00:00:00\',\n    ->                 INTERVAL \'1 1:1:1\' DAY_SECOND);\n        -> \'2004-12-30 22:58:59\'\nmysql> SELECT DATE_ADD(\'1900-01-01 00:00:00\',\n    ->                 INTERVAL \'-1 10\' DAY_HOUR);\n        -> \'1899-12-30 14:00:00\'\nmysql> SELECT DATE_SUB(\'1998-01-02\', INTERVAL 31 DAY);\n        -> \'1997-12-02\'\nmysql> SELECT DATE_ADD(\'1992-12-31 23:59:59.000002\',\n    ->            INTERVAL \'1.999999\' SECOND_MICROSECOND);\n        -> \'1993-01-01 00:00:01.000001\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(379,'CAST',38,'Syntax:\nCAST(expr AS type)\n\nThe CAST() function takes an expression of any type and produces a\nresult value of a specified type, similar to CONVERT(). See the\ndescription of CONVERT() for more information.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/cast-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/cast-functions.html'),(380,'SOUNDS LIKE',38,'Syntax:\nexpr1 SOUNDS LIKE expr2\n\nThis is the same as SOUNDEX(expr1) = SOUNDEX(expr2).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(381,'PERIOD_DIFF',32,'Syntax:\nPERIOD_DIFF(P1,P2)\n\nReturns the number of months between periods P1 and P2. P1 and P2\nshould be in the format YYMM or YYYYMM. Note that the period arguments\nP1 and P2 are not date values.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT PERIOD_DIFF(200802,200703);\n        -> 11\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(382,'LIKE',38,'Syntax:\nexpr LIKE pat [ESCAPE \'escape_char\']\n\nPattern matching using SQL simple regular expression comparison.\nReturns 1 (TRUE) or 0 (FALSE). If either expr or pat is NULL, the\nresult is NULL.\n\nThe pattern need not be a literal string. For example, it can be\nspecified as a string expression or table column.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-comparison-functions.html\n\n','mysql> SELECT \'David!\' LIKE \'David_\';\n        -> 1\nmysql> SELECT \'David!\' LIKE \'%D%v%\';\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/string-comparison-functions.html'),(383,'MULTIPOINT',25,'MultiPoint(pt1,pt2,...)\n\nConstructs a MultiPoint value using Point or WKB Point arguments.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(384,'>>',20,'Syntax:\n>>\n\nShifts a longlong (BIGINT) number to the right.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html\n\n','mysql> SELECT 4 >> 2;\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html'),(385,'FETCH',24,'Syntax:\nFETCH [[NEXT] FROM] cursor_name INTO var_name [, var_name] ...\n\nThis statement fetches the next row for the SELECT statement associated\nwith the specified cursor (which must be open), and advances the cursor\npointer. If a row exists, the fetched columns are stored in the named\nvariables. The number of columns retrieved by the SELECT statement must\nmatch the number of output variables specified in the FETCH statement.\n\nIf no more rows are available, a No Data condition occurs with SQLSTATE\nvalue \'02000\'. To detect this condition, you can set up a handler for\nit (or for a NOT FOUND condition). For an example, see\nhttp://dev.mysql.com/doc/refman/5.1/en/cursors.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/fetch.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/fetch.html'),(386,'AVG',16,'Syntax:\nAVG([DISTINCT] expr)\n\nReturns the average value of expr. The DISTINCT option can be used to\nreturn the average of the distinct values of expr.\n\nAVG() returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','mysql> SELECT student_name, AVG(test_score)\n    ->        FROM student\n    ->        GROUP BY student_name;\n','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(387,'TRUE FALSE',30,'The constants TRUE and FALSE evaluate to 1 and 0, respectively. The\nconstant names can be written in any lettercase.\n\nmysql> SELECT TRUE, true, FALSE, false;\n        -> 1, 1, 0, 0\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/boolean-literals.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/boolean-literals.html'),(388,'MBRWITHIN',6,'MBRWithin(g1,g2)\n\nReturns 1 or 0 to indicate whether the Minimum Bounding Rectangle of g1\nis within the Minimum Bounding Rectangle of g2. This tests the opposite\nrelationship as MBRContains().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','mysql> SET @g1 = GeomFromText(\'Polygon((0 0,0 3,3 3,3 0,0 0))\');\nmysql> SET @g2 = GeomFromText(\'Polygon((0 0,0 5,5 5,5 0,0 0))\');\nmysql> SELECT MBRWithin(@g1,@g2), MBRWithin(@g2,@g1);\n+--------------------+--------------------+\n| MBRWithin(@g1,@g2) | MBRWithin(@g2,@g1) |\n+--------------------+--------------------+\n|                  1 |                  0 |\n+--------------------+--------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(389,'SESSION_USER',17,'Syntax:\nSESSION_USER()\n\nSESSION_USER() is a synonym for USER().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(390,'IN',19,'Syntax:\nexpr IN (value,...)\n\nReturns 1 if expr is equal to any of the values in the IN list, else\nreturns 0. If all values are constants, they are evaluated according to\nthe type of expr and sorted. The search for the item then is done using\na binary search. This means IN is very quick if the IN value list\nconsists entirely of constants. Otherwise, type conversion takes place\naccording to the rules described in\nhttp://dev.mysql.com/doc/refman/5.1/en/type-conversion.html, but\napplied to all the arguments.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 2 IN (0,3,5,7);\n        -> 0\nmysql> SELECT \'wefwf\' IN (\'wee\',\'wefwf\',\'weg\');\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(391,'QUOTE',38,'Syntax:\nQUOTE(str)\n\nQuotes a string to produce a result that can be used as a properly\nescaped data value in an SQL statement. The string is returned enclosed\nby single quotation marks and with each instance of backslash (\"\\\"),\nsingle quote (\"\'\"), ASCII NUL, and Control+Z preceded by a backslash.\nIf the argument is NULL, the return value is the word \"NULL\" without\nenclosing single quotation marks.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT QUOTE(\'Don\\\'t!\');\n        -> \'Don\\\'t!\'\nmysql> SELECT QUOTE(NULL);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(392,'HELP COMMAND',27,'Syntax:\nmysql> help search_string\n\nIf you provide an argument to the help command, mysql uses it as a\nsearch string to access server-side help from the contents of the MySQL\nReference Manual. The proper operation of this command requires that\nthe help tables in the mysql database be initialized with help topic\ninformation (see\nhttp://dev.mysql.com/doc/refman/5.1/en/server-side-help-support.html).\n\nIf there is no match for the search string, the search fails:\n\nmysql> help me\n\nNothing found\nPlease try to run \'help contents\' for a list of all accessible topics\n\nUse help contents to see a list of the help categories:\n\nmysql> help contents\nYou asked for help about help category: \"Contents\"\nFor more information, type \'help <item>\', where <item> is one of the\nfollowing categories:\n   Account Management\n   Administration\n   Data Definition\n   Data Manipulation\n   Data Types\n   Functions\n   Functions and Modifiers for Use with GROUP BY\n   Geographic Features\n   Language Structure\n   Plugins\n   Storage Engines\n   Stored Routines\n   Table Maintenance\n   Transactions\n   Triggers\n\nIf the search string matches multiple items, mysql shows a list of\nmatching topics:\n\nmysql> help logs\nMany help items for your request exist.\nTo make a more specific request, please type \'help <item>\',\nwhere <item> is one of the following topics:\n   SHOW\n   SHOW BINARY LOGS\n   SHOW ENGINE\n   SHOW LOGS\n\nUse a topic as the search string to see the help entry for that topic:\n\nmysql> help show binary logs\nName: \'SHOW BINARY LOGS\'\nDescription:\nSyntax:\nSHOW BINARY LOGS\nSHOW MASTER LOGS\n\nLists the binary log files on the server. This statement is used as\npart of the procedure described in [purge-binary-logs], that shows how\nto determine which logs can be purged.\n\nmysql> SHOW BINARY LOGS;\n+---------------+-----------+\n| Log_name      | File_size |\n+---------------+-----------+\n| binlog.000015 |    724935 |\n| binlog.000016 |    733481 |\n+---------------+-----------+\n\nThe search string can contain the the wildcard characters \"%\" and \"_\".\nThese have the same meaning as for pattern-matching operations\nperformed with the LIKE operator. For example, HELP rep% returns a list\nof topics that begin with rep:\n\nmysql> HELP rep%\nMany help items for your request exist.\nTo make a more specific request, please type \'help <item>\',\nwhere <item> is one of the following\ntopics:\n   REPAIR TABLE\n   REPEAT FUNCTION\n   REPEAT LOOP\n   REPLACE\n   REPLACE FUNCTION\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mysql-server-side-help.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/mysql-server-side-help.html'),(393,'QUARTER',32,'Syntax:\nQUARTER(date)\n\nReturns the quarter of the year for date, in the range 1 to 4.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT QUARTER(\'2008-04-01\');\n        -> 2\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(394,'POSITION',38,'Syntax:\nPOSITION(substr IN str)\n\nPOSITION(substr IN str) is a synonym for LOCATE(substr,str).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(395,'SHOW CREATE FUNCTION',27,'Syntax:\nSHOW CREATE FUNCTION func_name\n\nThis statement is similar to SHOW CREATE PROCEDURE but for stored\nfunctions. See [HELP SHOW CREATE PROCEDURE].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-create-function.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-create-function.html'),(396,'IS_USED_LOCK',14,'Syntax:\nIS_USED_LOCK(str)\n\nChecks whether the lock named str is in use (that is, locked). If so,\nit returns the connection identifier of the client that holds the lock.\nOtherwise, it returns NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(397,'POLYFROMTEXT',3,'PolyFromText(wkt[,srid]), PolygonFromText(wkt[,srid])\n\nConstructs a POLYGON value using its WKT representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(398,'DES_ENCRYPT',12,'Syntax:\nDES_ENCRYPT(str[,{key_num|key_str}])\n\nEncrypts the string with the given key using the Triple-DES algorithm.\n\nThis function works only if MySQL has been configured with SSL support.\nSee http://dev.mysql.com/doc/refman/5.1/en/ssl-connections.html.\n\nThe encryption key to use is chosen based on the second argument to\nDES_ENCRYPT(), if one was given. With no argument, the first key from\nthe DES key file is used. With a key_num argument, the given key number\n(0 to 9) from the DES key file is used. With a key_str argument, the\ngiven key string is used to encrypt str.\n\nThe key file can be specified with the --des-key-file server option.\n\nThe return string is a binary string where the first character is\nCHAR(128 | key_num). If an error occurs, DES_ENCRYPT() returns NULL.\n\nThe 128 is added to make it easier to recognize an encrypted key. If\nyou use a string key, key_num is 127.\n\nThe string length for the result is given by this formula:\n\nnew_len = orig_len + (8 - (orig_len % 8)) + 1\n\nEach line in the DES key file has the following format:\n\nkey_num des_key_str\n\nEach key_num value must be a number in the range from 0 to 9. Lines in\nthe file may be in any order. des_key_str is the string that is used to\nencrypt the message. There should be at least one space between the\nnumber and the key. The first key is the default key that is used if\nyou do not specify any key argument to DES_ENCRYPT().\n\nYou can tell MySQL to read new key values from the key file with the\nFLUSH DES_KEY_FILE statement. This requires the RELOAD privilege.\n\nOne benefit of having a set of default keys is that it gives\napplications a way to check for the existence of encrypted column\nvalues, without giving the end user the right to decrypt those values.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','mysql> SELECT customer_address FROM customer_table \n     > WHERE crypted_credit_card = DES_ENCRYPT(\'credit_card_number\');\n','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(399,'CEIL',4,'Syntax:\nCEIL(X)\n\nCEIL() is a synonym for CEILING().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(400,'LENGTH',38,'Syntax:\nLENGTH(str)\n\nReturns the length of the string str, measured in bytes. A multi-byte\ncharacter counts as multiple bytes. This means that for a string\ncontaining five 2-byte characters, LENGTH() returns 10, whereas\nCHAR_LENGTH() returns 5.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT LENGTH(\'text\');\n        -> 4\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(401,'STR_TO_DATE',32,'Syntax:\nSTR_TO_DATE(str,format)\n\nThis is the inverse of the DATE_FORMAT() function. It takes a string\nstr and a format string format. STR_TO_DATE() returns a DATETIME value\nif the format string contains both date and time parts, or a DATE or\nTIME value if the string contains only date or time parts. If the date,\ntime, or datetime value extracted from str is illegal, STR_TO_DATE()\nreturns NULL and produces a warning.\n\nThe server scans str attempting to match format to it. The format\nstring can contain literal characters and format specifiers beginning\nwith %. Literal characters in format must match literally in str.\nFormat specifiers in format must match a date or time part in str. For\nthe specifiers that can be used in format, see the DATE_FORMAT()\nfunction description.\n\nmysql> SELECT STR_TO_DATE(\'01,5,2013\',\'%d,%m,%Y\');\n        -> \'2013-05-01\'\nmysql> SELECT STR_TO_DATE(\'May 1, 2013\',\'%M %d,%Y\');\n        -> \'2013-05-01\'\n\nScanning starts at the beginning of str and fails if format is found\nnot to match. Extra characters at the end of str are ignored.\n\nmysql> SELECT STR_TO_DATE(\'a09:30:17\',\'a%h:%i:%s\');\n        -> \'09:30:17\'\nmysql> SELECT STR_TO_DATE(\'a09:30:17\',\'%h:%i:%s\');\n        -> NULL\nmysql> SELECT STR_TO_DATE(\'09:30:17a\',\'%h:%i:%s\');\n        -> \'09:30:17\'\n\nUnspecified date or time parts have a value of 0, so incompletely\nspecified values in str produce a result with some or all parts set to\n0:\n\nmysql> SELECT STR_TO_DATE(\'abc\',\'abc\');\n        -> \'0000-00-00\'\nmysql> SELECT STR_TO_DATE(\'9\',\'%m\');\n        -> \'0000-09-00\'\nmysql> SELECT STR_TO_DATE(\'9\',\'%s\');\n        -> \'00:00:09\'\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(402,'Y',11,'Y(p)\n\nReturns the Y-coordinate value for the Point object p as a\ndouble-precision number.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SELECT Y(POINT(56.7, 53.34));\n+-----------------------+\n| Y(POINT(56.7, 53.34)) |\n+-----------------------+\n|                 53.34 |\n+-----------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(403,'SHOW INNODB STATUS',27,'Syntax:\nSHOW INNODB STATUS\n\nIn MySQL 5.1, this is a deprecated synonym for SHOW ENGINE INNODB\nSTATUS. See [HELP SHOW ENGINE]. SHOW INNODB STATUS is removed in MySQL\n5.5.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-innodb-status.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-innodb-status.html'),(404,'CHECKSUM TABLE',21,'Syntax:\nCHECKSUM TABLE tbl_name [, tbl_name] ... [ QUICK | EXTENDED ]\n\nCHECKSUM TABLE reports a table checksum.\n\nWith QUICK, the live table checksum is reported if it is available, or\nNULL otherwise. This is very fast. A live checksum is enabled by\nspecifying the CHECKSUM=1 table option when you create the table;\ncurrently, this is supported only for MyISAM tables. See [HELP CREATE\nTABLE].\n\nWith EXTENDED, the entire table is read row by row and the checksum is\ncalculated. This can be very slow for large tables.\n\nIf neither QUICK nor EXTENDED is specified, MySQL returns a live\nchecksum if the table storage engine supports it and scans the table\notherwise.\n\nFor a nonexistent table, CHECKSUM TABLE returns NULL and generates a\nwarning.\n\nIn MySQL 5.1, CHECKSUM TABLE returns 0 for partitioned tables unless\nyou include the EXTENDED option. This issue is resolved in MySQL 5.6.\n(Bug #11933226, Bug #60681)\n\nThe checksum value depends on the table row format. If the row format\nchanges, the checksum also changes. For example, the storage format for\nVARCHAR changed between MySQL 4.1 and 5.0, so if a 4.1 table is\nupgraded to MySQL 5.0, the checksum value may change.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/checksum-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/checksum-table.html'),(405,'NUMINTERIORRINGS',2,'NumInteriorRings(poly)\n\nReturns the number of interior rings in the Polygon value poly.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @poly =\n    -> \'Polygon((0 0,0 3,3 3,3 0,0 0),(1 1,1 2,2 2,2 1,1 1))\';\nmysql> SELECT NumInteriorRings(GeomFromText(@poly));\n+---------------------------------------+\n| NumInteriorRings(GeomFromText(@poly)) |\n+---------------------------------------+\n|                                     1 |\n+---------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(406,'INTERIORRINGN',2,'InteriorRingN(poly,N)\n\nReturns the N-th interior ring for the Polygon value poly as a\nLineString. Rings are numbered beginning with 1.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @poly =\n    -> \'Polygon((0 0,0 3,3 3,3 0,0 0),(1 1,1 2,2 2,2 1,1 1))\';\nmysql> SELECT AsText(InteriorRingN(GeomFromText(@poly),1));\n+----------------------------------------------+\n| AsText(InteriorRingN(GeomFromText(@poly),1)) |\n+----------------------------------------------+\n| LINESTRING(1 1,1 2,2 2,2 1,1 1)              |\n+----------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(407,'UTC_TIME',32,'Syntax:\nUTC_TIME, UTC_TIME()\n\nReturns the current UTC time as a value in \'HH:MM:SS\' or HHMMSS.uuuuuu\nformat, depending on whether the function is used in a string or\nnumeric context.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT UTC_TIME(), UTC_TIME() + 0;\n        -> \'18:07:53\', 180753.000000\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(408,'DROP FUNCTION',40,'The DROP FUNCTION statement is used to drop stored functions and\nuser-defined functions (UDFs):\n\no For information about dropping stored functions, see [HELP DROP\n  PROCEDURE].\n\no For information about dropping user-defined functions, see [HELP DROP\n  FUNCTION UDF].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-function.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-function.html'),(409,'ALTER EVENT',40,'Syntax:\nALTER\n    [DEFINER = { user | CURRENT_USER }]\n    EVENT event_name\n    [ON SCHEDULE schedule]\n    [ON COMPLETION [NOT] PRESERVE]\n    [RENAME TO new_event_name]\n    [ENABLE | DISABLE | DISABLE ON SLAVE]\n    [COMMENT \'comment\']\n    [DO event_body]\n\nThe ALTER EVENT statement changes one or more of the characteristics of\nan existing event without the need to drop and recreate it. The syntax\nfor each of the DEFINER, ON SCHEDULE, ON COMPLETION, COMMENT, ENABLE /\nDISABLE, and DO clauses is exactly the same as when used with CREATE\nEVENT. (See [HELP CREATE EVENT].)\n\nSupport for the DEFINER clause was added in MySQL 5.1.17.\n\nBeginning with MySQL 5.1.12, this statement requires the EVENT\nprivilege. When a user executes a successful ALTER EVENT statement,\nthat user becomes the definer for the affected event.\n\n(In MySQL 5.1.11 and earlier, an event could be altered only by its\ndefiner, or by a user having the SUPER privilege.)\n\nALTER EVENT works only with an existing event:\n\nmysql> ALTER EVENT no_such_event \n     >     ON SCHEDULE \n     >       EVERY \'2:3\' DAY_HOUR;\nERROR 1517 (HY000): Unknown event \'no_such_event\'\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/alter-event.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/alter-event.html'),(410,'STDDEV',16,'Syntax:\nSTDDEV(expr)\n\nReturns the population standard deviation of expr. This function is\nprovided for compatibility with Oracle. The standard SQL function\nSTDDEV_POP() can be used instead.\n\nThis function returns NULL if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(411,'DATE_SUB',32,'Syntax:\nDATE_SUB(date,INTERVAL expr unit)\n\nSee the description for DATE_ADD().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(412,'PERIOD_ADD',32,'Syntax:\nPERIOD_ADD(P,N)\n\nAdds N months to period P (in the format YYMM or YYYYMM). Returns a\nvalue in the format YYYYMM. Note that the period argument P is not a\ndate value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT PERIOD_ADD(200801,2);\n        -> 200803\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(413,'|',20,'Syntax:\n|\n\nBitwise OR:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html\n\n','mysql> SELECT 29 | 15;\n        -> 31\n','http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html'),(414,'GEOMFROMTEXT',3,'GeomFromText(wkt[,srid]), GeometryFromText(wkt[,srid])\n\nConstructs a geometry value of any type using its WKT representation\nand SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(415,'UUID_SHORT',14,'Syntax:\nUUID_SHORT()\n\nReturns a \"short\" universal identifier as a 64-bit unsigned integer\n(rather than a string-form 128-bit identifier as returned by the UUID()\nfunction).\n\nThe value of UUID_SHORT() is guaranteed to be unique if the following\nconditions hold:\n\no The server_id of the current host is unique among your set of master\n  and slave servers\n\no server_id is between 0 and 255\n\no You do not set back your system time for your server between mysqld\n  restarts\n\no You do not invoke UUID_SHORT() on average more than 16 million times\n  per second between mysqld restarts\n\nThe UUID_SHORT() return value is constructed this way:\n\n  (server_id & 255) << 56\n+ (server_startup_time_in_seconds << 24)\n+ incremented_variable++;\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','mysql> SELECT UUID_SHORT();\n        -> 92395783831158784\n','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(416,'RIGHT',38,'Syntax:\nRIGHT(str,len)\n\nReturns the rightmost len characters from the string str, or NULL if\nany argument is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT RIGHT(\'foobarbar\', 4);\n        -> \'rbar\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(417,'DATEDIFF',32,'Syntax:\nDATEDIFF(expr1,expr2)\n\nDATEDIFF() returns expr1 - expr2 expressed as a value in days from one\ndate to the other. expr1 and expr2 are date or date-and-time\nexpressions. Only the date parts of the values are used in the\ncalculation.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT DATEDIFF(\'2007-12-31 23:59:59\',\'2007-12-30\');\n        -> 1\nmysql> SELECT DATEDIFF(\'2010-11-30 23:59:59\',\'2010-12-31\');\n        -> -31\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(418,'DROP TABLESPACE',40,'Syntax:\nDROP TABLESPACE tablespace_name\n    ENGINE [=] engine_name\n\nThis statement drops a tablespace that was previously created using\nCREATE TABLESPACE (see [HELP CREATE TABLESPACE]).\n\n*Important*: The tablespace to be dropped must not contain any data\nfiles; in other words, before you can drop a tablespace, you must first\ndrop each of its data files using ALTER TABLESPACE ... DROP DATAFILE\n(see [HELP ALTER TABLESPACE]).\n\nThe ENGINE clause (required) specifies the storage engine used by the\ntablespace. In MySQL 5.1, the only accepted values for engine_name are\nNDB and NDBCLUSTER.\n\nDROP TABLESPACE was added in MySQL 5.1.6. In MySQL 5.1, it is useful\nonly with Disk Data storage for MySQL Cluster. See\nhttp://dev.mysql.com/doc/refman/5.1/en/mysql-cluster-disk-data.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-tablespace.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-tablespace.html'),(419,'DROP PROCEDURE',40,'Syntax:\nDROP {PROCEDURE | FUNCTION} [IF EXISTS] sp_name\n\nThis statement is used to drop a stored procedure or function. That is,\nthe specified routine is removed from the server. You must have the\nALTER ROUTINE privilege for the routine. (If the\nautomatic_sp_privileges system variable is enabled, that privilege and\nEXECUTE are granted automatically to the routine creator when the\nroutine is created and dropped from the creator when the routine is\ndropped. See\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-routines-privileges.html.\n)\n\nThe IF EXISTS clause is a MySQL extension. It prevents an error from\noccurring if the procedure or function does not exist. A warning is\nproduced that can be viewed with SHOW WARNINGS.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/drop-procedure.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/drop-procedure.html'),(420,'CHECK TABLE',21,'Syntax:\nCHECK TABLE tbl_name [, tbl_name] ... [option] ...\n\noption = {FOR UPGRADE | QUICK | FAST | MEDIUM | EXTENDED | CHANGED}\n\nCHECK TABLE checks a table or tables for errors. CHECK TABLE works for\nInnoDB, MyISAM, and ARCHIVE tables. Starting with MySQL 5.1.9, CHECK\nTABLE is also valid for CSV tables, see\nhttp://dev.mysql.com/doc/refman/5.1/en/csv-storage-engine.html. For\nMyISAM tables, the key statistics are updated as well.\n\nCHECK TABLE can also check views for problems, such as tables that are\nreferenced in the view definition that no longer exist.\n\nBeginning with MySQL 5.1.27, CHECK TABLE is also supported for\npartitioned tables. Also beginning with MySQL 5.1.27, you can use ALTER\nTABLE ... CHECK PARTITION to check one or more partitions; for more\ninformation, see [HELP ALTER TABLE], and\nhttp://dev.mysql.com/doc/refman/5.1/en/partitioning-maintenance.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/check-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/check-table.html'),(421,'BIN',38,'Syntax:\nBIN(N)\n\nReturns a string representation of the binary value of N, where N is a\nlonglong (BIGINT) number. This is equivalent to CONV(N,10,2). Returns\nNULL if N is NULL.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT BIN(12);\n        -> \'1100\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(422,'INSTALL PLUGIN',5,'Syntax:\nINSTALL PLUGIN plugin_name SONAME \'shared_library_name\'\n\nThis statement installs a server plugin. It requires the INSERT\nprivilege for the mysql.plugin table.\n\nplugin_name is the name of the plugin as defined in the plugin\ndescriptor structure contained in the library file (see\nhttp://dev.mysql.com/doc/refman/5.1/en/plugin-data-structures.html).\nPlugin names are not case sensitive. For maximal compatibility, plugin\nnames should be limited to ASCII letters, digits, and underscore\nbecause they are used in C source files, shell command lines, M4 and\nBourne shell scripts, and SQL environments.\n\nshared_library_name is the name of the shared library that contains the\nplugin code. The name includes the file name extension (for example,\nlibmyplugin.so, libmyplugin.dll, or libmyplugin.dylib).\n\nThe shared library must be located in the plugin directory (the\ndirectory named by the plugin_dir system variable). The library must be\nin the plugin directory itself, not in a subdirectory. By default,\nplugin_dir is the plugin directory under the directory named by the\npkglibdir configuration variable, but it can be changed by setting the\nvalue of plugin_dir at server startup. For example, set its value in a\nmy.cnf file:\n\n[mysqld]\nplugin_dir=/path/to/plugin/directory\n\nIf the value of plugin_dir is a relative path name, it is taken to be\nrelative to the MySQL base directory (the value of the basedir system\nvariable).\n\nINSTALL PLUGIN loads and initializes the plugin code to make the plugin\navailable for use. A plugin is initialized by executing its\ninitialization function, which handles any setup that the plugin must\nperform before it can be used. When the server shuts down, it executes\nthe deinitialization function for each plugin that is loaded so that\nthe plugin has a change to perform any final cleanup.\n\nINSTALL PLUGIN also registers the plugin by adding a line that\nindicates the plugin name and library file name to the mysql.plugin\ntable. At server startup, the server loads and initializes any plugin\nthat is listed in the mysql.plugin table. This means that a plugin is\ninstalled with INSTALL PLUGIN only once, not every time the server\nstarts. Plugin loading at startup does not occur if the server is\nstarted with the --skip-grant-tables option.\n\nA plugin library can contain multiple plugins. For each of them to be\ninstalled, use a separate INSTALL PLUGIN statement. Each statement\nnames a different plugin, but all of them specify the same library\nname.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/install-plugin.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/install-plugin.html'),(423,'DECLARE CURSOR',24,'Syntax:\nDECLARE cursor_name CURSOR FOR select_statement\n\nThis statement declares a cursor and associates it with a SELECT\nstatement that retrieves the rows to be traversed by the cursor. To\nfetch the rows later, use a FETCH statement. The number of columns\nretrieved by the SELECT statement must match the number of output\nvariables specified in the FETCH statement.\n\nThe SELECT statement cannot have an INTO clause.\n\nCursor declarations must appear before handler declarations and after\nvariable and condition declarations.\n\nA stored program may contain multiple cursor declarations, but each\ncursor declared in a given block must have a unique name. For an\nexample, see http://dev.mysql.com/doc/refman/5.1/en/cursors.html.\n\nFor information available through SHOW statements, it is possible in\nmany cases to obtain equivalent information by using a cursor with an\nINFORMATION_SCHEMA table.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/declare-cursor.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/declare-cursor.html'),(424,'LOAD DATA',28,'Syntax:\nLOAD DATA [LOW_PRIORITY | CONCURRENT] [LOCAL] INFILE \'file_name\'\n    [REPLACE | IGNORE]\n    INTO TABLE tbl_name\n    [CHARACTER SET charset_name]\n    [{FIELDS | COLUMNS}\n        [TERMINATED BY \'string\']\n        [[OPTIONALLY] ENCLOSED BY \'char\']\n        [ESCAPED BY \'char\']\n    ]\n    [LINES\n        [STARTING BY \'string\']\n        [TERMINATED BY \'string\']\n    ]\n    [IGNORE number LINES]\n    [(col_name_or_user_var,...)]\n    [SET col_name = expr,...]\n\nThe LOAD DATA INFILE statement reads rows from a text file into a table\nat a very high speed. LOAD DATA INFILE is the complement of SELECT ...\nINTO OUTFILE. (See\nhttp://dev.mysql.com/doc/refman/5.1/en/select-into.html.) To write data\nfrom a table to a file, use SELECT ... INTO OUTFILE. To read the file\nback into a table, use LOAD DATA INFILE. The syntax of the FIELDS and\nLINES clauses is the same for both statements. Both clauses are\noptional, but FIELDS must precede LINES if both are specified.\n\nYou can also load data files by using the mysqlimport utility; it\noperates by sending a LOAD DATA INFILE statement to the server. The\n--local option causes mysqlimport to read data files from the client\nhost. You can specify the --compress option to get better performance\nover slow networks if the client and server support the compressed\nprotocol. See http://dev.mysql.com/doc/refman/5.1/en/mysqlimport.html.\n\nFor more information about the efficiency of INSERT versus LOAD DATA\nINFILE and speeding up LOAD DATA INFILE, see\nhttp://dev.mysql.com/doc/refman/5.1/en/insert-speed.html.\n\nThe file name must be given as a literal string. On Windows, specify\nbackslashes in path names as forward slashes or doubled backslashes. As\nof MySQL 5.1.6, the character_set_filesystem system variable controls\nthe interpretation of the file name.\n\nThe character set indicated by the character_set_database system\nvariable is used to interpret the information in the file. SET NAMES\nand the setting of character_set_client do not affect interpretation of\ninput. If the contents of the input file use a character set that\ndiffers from the default, it is usually preferable to specify the\ncharacter set of the file by using the CHARACTER SET clause, which is\navailable as of MySQL 5.1.17. A character set of binary specifies \"no\nconversion.\"\n\nLOAD DATA INFILE interprets all fields in the file as having the same\ncharacter set, regardless of the data types of the columns into which\nfield values are loaded. For proper interpretation of file contents,\nyou must ensure that it was written with the correct character set. For\nexample, if you write a data file with mysqldump -T or by issuing a\nSELECT ... INTO OUTFILE statement in mysql, be sure to use a\n--default-character-set option so that output is written in the\ncharacter set to be used when the file is loaded with LOAD DATA INFILE.\n\n*Note*: It is not possible to load data files that use the ucs2\ncharacter set.\n\nIf you use LOW_PRIORITY, execution of the LOAD DATA statement is\ndelayed until no other clients are reading from the table. This affects\nonly storage engines that use only table-level locking (such as MyISAM,\nMEMORY, and MERGE).\n\nIf you specify CONCURRENT with a MyISAM table that satisfies the\ncondition for concurrent inserts (that is, it contains no free blocks\nin the middle), other threads can retrieve data from the table while\nLOAD DATA is executing. This option affects the performance of LOAD\nDATA a bit, even if no other thread is using the table at the same\ntime.\n\nWith row-based replication, CONCURRENT is replicated regardless of\nMySQL version. With statement-based replication CONCURRENT is not\nreplicated prior to MySQL 5.1.43 (see Bug #34628). For more\ninformation, see\nhttp://dev.mysql.com/doc/refman/5.1/en/replication-features-load-data.h\ntml.\n\n*Note*: Prior to MySQL 5.1.23, LOAD DATA performed very poorly when\nimporting into partitioned tables. The statement now uses buffering to\nimprove performance; however, the buffer uses 130KB memory per\npartition to achieve this. (Bug #26527)\n\nThe LOCAL keyword affects expected location of the file and error\nhandling, as described later. LOCAL works only if your server and your\nclient both have been configured to permit it. For example, if mysqld\nwas started with --local-infile=0, LOCAL does not work. See\nhttp://dev.mysql.com/doc/refman/5.1/en/load-data-local.html.\n\nThe LOCAL keyword affects where the file is expected to be found:\n\no If LOCAL is specified, the file is read by the client program on the\n  client host and sent to the server. The file can be given as a full\n  path name to specify its exact location. If given as a relative path\n  name, the name is interpreted relative to the directory in which the\n  client program was started.\n\n  When using LOCAL with LOAD DATA, a copy of the file is created in the\n  server\'s temporary directory. This is not the directory determined by\n  the value of tmpdir or slave_load_tmpdir, but rather the operating\n  system\'s temporary directory, and is not configurable in the MySQL\n  Server. (Typically the system temporary directory is /tmp on Linux\n  systems and C:\\WINDOWS\\TEMP on Windows.) Lack of sufficient space for\n  the copy in this directory can cause the LOAD DATA LOCAL statement to\n  fail.\n\no If LOCAL is not specified, the file must be located on the server\n  host and is read directly by the server. The server uses the\n  following rules to locate the file:\n\n  o If the file name is an absolute path name, the server uses it as\n    given.\n\n  o If the file name is a relative path name with one or more leading\n    components, the server searches for the file relative to the\n    server\'s data directory.\n\n  o If a file name with no leading components is given, the server\n    looks for the file in the database directory of the default\n    database.\n\nIn the non-LOCAL case, these rules mean that a file named as\n./myfile.txt is read from the server\'s data directory, whereas the file\nnamed as myfile.txt is read from the database directory of the default\ndatabase. For example, if db1 is the default database, the following\nLOAD DATA statement reads the file data.txt from the database directory\nfor db1, even though the statement explicitly loads the file into a\ntable in the db2 database:\n\nLOAD DATA INFILE \'data.txt\' INTO TABLE db2.my_table;\n\n*Note*: A regression in MySQL 5.1.40 caused the database referenced in\na fully qualified table name to be ignored by LOAD DATA when using\nreplication with either STATEMENT or MIXED as the binary logging\nformat; this could lead to problems if the table was not in the current\ndatabase. As a workaround, you can specify the correct database with\nthe USE statement prior to executing LOAD DATA. If necessary, you can\nreset the default database with a second USE statement following the\nLOAD DATA statement. This issue was fixed in MySQL 5.1.41. (Bug #48297)\n\nFor security reasons, when reading text files located on the server,\nthe files must either reside in the database directory or be readable\nby all. Also, to use LOAD DATA INFILE on server files, you must have\nthe FILE privilege. See\nhttp://dev.mysql.com/doc/refman/5.1/en/privileges-provided.html. For\nnon-LOCAL load operations, if the secure_file_priv system variable is\nset to a nonempty directory name, the file to be loaded must be located\nin that directory.\n\nUsing LOCAL is a bit slower than letting the server access the files\ndirectly, because the contents of the file must be sent over the\nconnection by the client to the server. On the other hand, you do not\nneed the FILE privilege to load local files.\n\nLOCAL also affects error handling:\n\no With LOAD DATA INFILE, data-interpretation and duplicate-key errors\n  terminate the operation.\n\no With LOAD DATA LOCAL INFILE, data-interpretation and duplicate-key\n  errors become warnings and the operation continues because the server\n  has no way to stop transmission of the file in the middle of the\n  operation. For duplicate-key errors, this is the same as if IGNORE is\n  specified. IGNORE is explained further later in this section.\n\nThe REPLACE and IGNORE keywords control handling of input rows that\nduplicate existing rows on unique key values:\n\no If you specify REPLACE, input rows replace existing rows. In other\n  words, rows that have the same value for a primary key or unique\n  index as an existing row. See [HELP REPLACE].\n\no If you specify IGNORE, input rows that duplicate an existing row on a\n  unique key value are skipped.\n\no If you do not specify either option, the behavior depends on whether\n  the LOCAL keyword is specified. Without LOCAL, an error occurs when a\n  duplicate key value is found, and the rest of the text file is\n  ignored. With LOCAL, the default behavior is the same as if IGNORE is\n  specified; this is because the server has no way to stop transmission\n  of the file in the middle of the operation.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/load-data.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/load-data.html'),(425,'MULTILINESTRING',25,'MultiLineString(ls1,ls2,...)\n\nConstructs a MultiLineString value using LineString or WKB LineString\narguments.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(426,'LOCALTIME',32,'Syntax:\nLOCALTIME, LOCALTIME()\n\nLOCALTIME and LOCALTIME() are synonyms for NOW().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(427,'MPOINTFROMTEXT',3,'MPointFromText(wkt[,srid]), MultiPointFromText(wkt[,srid])\n\nConstructs a MULTIPOINT value using its WKT representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(428,'BLOB',23,'BLOB[(M)]\n\nA BLOB column with a maximum length of 65,535 (216 - 1) bytes. Each\nBLOB value is stored using a 2-byte length prefix that indicates the\nnumber of bytes in the value.\n\nAn optional length M can be given for this type. If this is done, MySQL\ncreates the column as the smallest BLOB type large enough to hold\nvalues M bytes long.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(429,'SHA1',12,'Syntax:\nSHA1(str), SHA(str)\n\nCalculates an SHA-1 160-bit checksum for the string, as described in\nRFC 3174 (Secure Hash Algorithm). The value is returned as a binary\nstring of 40 hex digits, or NULL if the argument was NULL. One of the\npossible uses for this function is as a hash key. See the notes at the\nbeginning of this section about storing hash values efficiently. You\ncan also use SHA1() as a cryptographic function for storing passwords.\nSHA() is synonymous with SHA1().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','mysql> SELECT SHA1(\'abc\');\n        -> \'a9993e364706816aba3e25717850c26c9cd0d89d\'\n','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(430,'SUBSTR',38,'Syntax:\nSUBSTR(str,pos), SUBSTR(str FROM pos), SUBSTR(str,pos,len), SUBSTR(str\nFROM pos FOR len)\n\nSUBSTR() is a synonym for SUBSTRING().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(431,'PASSWORD',12,'Syntax:\nPASSWORD(str)\n\nCalculates and returns a hashed password string from the plaintext\npassword str and returns a binary string, or NULL if the argument is\nNULL. This function is the SQL interface to the algorithm used by the\nserver to encrypt MySQL passwords for storage in the mysql.user grant\ntable.\n\nThe old_passwords system variable controls the password hashing method\nused by PASSWORD() (as well as for the IDENTIFIED BY clause of the\nCREATE USER and GRANT statements).\n\nThe value determines whether or not to use \"old\" native MySQL password\nhashing. A value of 0 (or OFF) causes passwords to be encrypted using\nthe format available from MySQL 4.1 on. A value of 1 (or ON) causes\npassword encryption to use the older pre-4.1 format.\n\nIf old_passwords=1, PASSWORD(\'str\') returns the same value as\nOLD_PASSWORD(\'str\'). The latter function is not affected by the value\nof old_passwords.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','mysql> SET old_passwords = 0;\nmysql> SELECT PASSWORD(\'mypass\');\n+-------------------------------------------+\n| PASSWORD(\'mypass\')                        |\n+-------------------------------------------+\n| *6C8989366EAF75BB670AD8EA7A7FC1176A95CEF4 |\n+-------------------------------------------+\n\nmysql> SET old_passwords = 1;\nmysql> SELECT PASSWORD(\'mypass\');\n+--------------------+\n| PASSWORD(\'mypass\') |\n+--------------------+\n| 6f8c114b58f2ce9e   |\n+--------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(432,'CHAR',23,'[NATIONAL] CHAR[(M)] [CHARACTER SET charset_name] [COLLATE\ncollation_name]\n\nA fixed-length string that is always right-padded with spaces to the\nspecified length when stored. M represents the column length in\ncharacters. The range of M is 0 to 255. If M is omitted, the length is\n1.\n\n*Note*: Trailing spaces are removed when CHAR values are retrieved\nunless the PAD_CHAR_TO_FULL_LENGTH SQL mode is enabled.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(433,'UTC_DATE',32,'Syntax:\nUTC_DATE, UTC_DATE()\n\nReturns the current UTC date as a value in \'YYYY-MM-DD\' or YYYYMMDD\nformat, depending on whether the function is used in a string or\nnumeric context.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT UTC_DATE(), UTC_DATE() + 0;\n        -> \'2003-08-14\', 20030814\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(434,'DIMENSION',37,'Dimension(g)\n\nReturns the inherent dimension of the geometry value g. The result can\nbe -1, 0, 1, or 2. The meaning of these values is given in\nhttp://dev.mysql.com/doc/refman/5.1/en/gis-class-geometry.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SELECT Dimension(GeomFromText(\'LineString(1 1,2 2)\'));\n+------------------------------------------------+\n| Dimension(GeomFromText(\'LineString(1 1,2 2)\')) |\n+------------------------------------------------+\n|                                              1 |\n+------------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(435,'COUNT DISTINCT',16,'Syntax:\nCOUNT(DISTINCT expr,[expr...])\n\nReturns a count of the number of rows with different non-NULL expr\nvalues.\n\nCOUNT(DISTINCT) returns 0 if there were no matching rows.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html\n\n','mysql> SELECT COUNT(DISTINCT results) FROM student;\n','http://dev.mysql.com/doc/refman/5.1/en/group-by-functions.html'),(436,'BIT',23,'BIT[(M)]\n\nA bit-field type. M indicates the number of bits per value, from 1 to\n64. The default is 1 if M is omitted.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(437,'XA',8,'Syntax:\nXA {START|BEGIN} xid [JOIN|RESUME]\n\nXA END xid [SUSPEND [FOR MIGRATE]]\n\nXA PREPARE xid\n\nXA COMMIT xid [ONE PHASE]\n\nXA ROLLBACK xid\n\nXA RECOVER\n\nFor XA START, the JOIN and RESUME clauses are not supported.\n\nFor XA END the SUSPEND [FOR MIGRATE] clause is not supported.\n\nEach XA statement begins with the XA keyword, and most of them require\nan xid value. An xid is an XA transaction identifier. It indicates\nwhich transaction the statement applies to. xid values are supplied by\nthe client, or generated by the MySQL server. An xid value has from one\nto three parts:\n\nxid: gtrid [, bqual [, formatID ]]\n\ngtrid is a global transaction identifier, bqual is a branch qualifier,\nand formatID is a number that identifies the format used by the gtrid\nand bqual values. As indicated by the syntax, bqual and formatID are\noptional. The default bqual value is \'\' if not given. The default\nformatID value is 1 if not given.\n\ngtrid and bqual must be string literals, each up to 64 bytes (not\ncharacters) long. gtrid and bqual can be specified in several ways. You\ncan use a quoted string (\'ab\'), hex string (0x6162, X\'ab\'), or bit\nvalue (b\'nnnn\').\n\nformatID is an unsigned integer.\n\nThe gtrid and bqual values are interpreted in bytes by the MySQL\nserver\'s underlying XA support routines. However, while an SQL\nstatement containing an XA statement is being parsed, the server works\nwith some specific character set. To be safe, write gtrid and bqual as\nhex strings.\n\nxid values typically are generated by the Transaction Manager. Values\ngenerated by one TM must be different from values generated by other\nTMs. A given TM must be able to recognize its own xid values in a list\nof values returned by the XA RECOVER statement.\n\nXA START xid starts an XA transaction with the given xid value. Each XA\ntransaction must have a unique xid value, so the value must not\ncurrently be used by another XA transaction. Uniqueness is assessed\nusing the gtrid and bqual values. All following XA statements for the\nXA transaction must be specified using the same xid value as that given\nin the XA START statement. If you use any of those statements but\nspecify an xid value that does not correspond to some existing XA\ntransaction, an error occurs.\n\nOne or more XA transactions can be part of the same global transaction.\nAll XA transactions within a given global transaction must use the same\ngtrid value in the xid value. For this reason, gtrid values must be\nglobally unique so that there is no ambiguity about which global\ntransaction a given XA transaction is part of. The bqual part of the\nxid value must be different for each XA transaction within a global\ntransaction. (The requirement that bqual values be different is a\nlimitation of the current MySQL XA implementation. It is not part of\nthe XA specification.)\n\nThe XA RECOVER statement returns information for those XA transactions\non the MySQL server that are in the PREPARED state. (See\nhttp://dev.mysql.com/doc/refman/5.1/en/xa-states.html.) The output\nincludes a row for each such XA transaction on the server, regardless\nof which client started it.\n\nXA RECOVER output rows look like this (for an example xid value\nconsisting of the parts \'abc\', \'def\', and 7):\n\nmysql> XA RECOVER;\n+----------+--------------+--------------+--------+\n| formatID | gtrid_length | bqual_length | data   |\n+----------+--------------+--------------+--------+\n|        7 |            3 |            3 | abcdef |\n+----------+--------------+--------------+--------+\n\nThe output columns have the following meanings:\n\no formatID is the formatID part of the transaction xid\n\no gtrid_length is the length in bytes of the gtrid part of the xid\n\no bqual_length is the length in bytes of the bqual part of the xid\n\no data is the concatenation of the gtrid and bqual parts of the xid\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/xa-statements.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/xa-statements.html'),(438,'EQUALS',31,'Equals(g1,g2)\n\nReturns 1 or 0 to indicate whether g1 is spatially equal to g2.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/functions-for-testing-spatial-relations-between-geometric-objects.html'),(439,'SHOW CREATE VIEW',27,'Syntax:\nSHOW CREATE VIEW view_name\n\nThis statement shows the CREATE VIEW statement that creates the named\nview.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-create-view.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-create-view.html'),(440,'INTERVAL',19,'Syntax:\nINTERVAL(N,N1,N2,N3,...)\n\nReturns 0 if N < N1, 1 if N < N2 and so on or -1 if N is NULL. All\narguments are treated as integers. It is required that N1 < N2 < N3 <\n... < Nn for this function to work correctly. This is because a binary\nsearch is used (very fast).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT INTERVAL(23, 1, 15, 17, 30, 44, 200);\n        -> 3\nmysql> SELECT INTERVAL(10, 1, 10, 100, 1000);\n        -> 2\nmysql> SELECT INTERVAL(22, 23, 30, 44, 200);\n        -> 0\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(441,'FROM_DAYS',32,'Syntax:\nFROM_DAYS(N)\n\nGiven a day number N, returns a DATE value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT FROM_DAYS(730669);\n        -> \'2007-07-03\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(442,'ALTER PROCEDURE',40,'Syntax:\nALTER PROCEDURE proc_name [characteristic ...]\n\ncharacteristic:\n    COMMENT \'string\'\n  | LANGUAGE SQL\n  | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }\n  | SQL SECURITY { DEFINER | INVOKER }\n\nThis statement can be used to change the characteristics of a stored\nprocedure. More than one change may be specified in an ALTER PROCEDURE\nstatement. However, you cannot change the parameters or body of a\nstored procedure using this statement; to make such changes, you must\ndrop and re-create the procedure using DROP PROCEDURE and CREATE\nPROCEDURE.\n\nYou must have the ALTER ROUTINE privilege for the procedure. By\ndefault, that privilege is granted automatically to the procedure\ncreator. This behavior can be changed by disabling the\nautomatic_sp_privileges system variable. See\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-routines-privileges.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/alter-procedure.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/alter-procedure.html'),(443,'BIT_COUNT',20,'Syntax:\nBIT_COUNT(N)\n\nReturns the number of bits that are set in the argument N.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html\n\n','mysql> SELECT BIT_COUNT(29), BIT_COUNT(b\'101010\');\n        -> 4, 3\n','http://dev.mysql.com/doc/refman/5.1/en/bit-functions.html'),(444,'OCTET_LENGTH',38,'Syntax:\nOCTET_LENGTH(str)\n\nOCTET_LENGTH() is a synonym for LENGTH().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(445,'UTC_TIMESTAMP',32,'Syntax:\nUTC_TIMESTAMP, UTC_TIMESTAMP()\n\nReturns the current UTC date and time as a value in \'YYYY-MM-DD\nHH:MM:SS\' or YYYYMMDDHHMMSS.uuuuuu format, depending on whether the\nfunction is used in a string or numeric context.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT UTC_TIMESTAMP(), UTC_TIMESTAMP() + 0;\n        -> \'2003-08-14 18:08:04\', 20030814180804.000000\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(446,'AES_ENCRYPT',12,'Syntax:\nAES_ENCRYPT(str,key_str)\n\nAES_ENCRYPT() and AES_DECRYPT() implement encryption and decryption of\ndata using the official AES (Advanced Encryption Standard) algorithm,\npreviously known as \"Rijndael.\" The AES standard allows various key\nsizes. These functions implement AES with a 128-bit key length, but you\ncan extend them to 256 bits by modifying the source. The key length is\na trade off between performance and security.\n\nAES_ENCRYPT() encrypts the string str using a key key_str and returns a\nbinary string containing the encrypted output. AES_DECRYPT() decrypts\nthe encrypted string crypt_str using a key key_str and returns the\noriginal plaintext string. If either argument is NULL, the results of\nthese functions are also NULL.\n\nThe str and crypt_str arguments can be any length, and padding is\nautomatically added to str so it is a multiple of a block as required\nby block-based algorithms such as AES. This padding is automatically\nremoved by the AES_DECRYPT() function. The length of crypt_str can be\ncalculated using this formula:\n\n16 * (trunc(string_length / 16) + 1)\n\nThe most secure way to pass a key to the key_str argument is to create\na truly random 128-bit value and pass it as a binary value. For\nexample:\n\nINSERT INTO t\nVALUES (1,AES_ENCRYPT(\'text\',UNHEX(\'F3229A0B371ED2D9441B830D21A390C3\')));\n\nA passphrase can be used to generate an AES key by hashing the\npassphrase. For example:\n\nINSERT INTO t VALUES (1,AES_ENCRYPT(\'text\', SHA1(\'My secret passphrase\')));\n\nDo not pass a password or passphrase directly to crypt_str, hash it\nfirst. Previous versions of this documentation suggested the former\napproach, but it is no longer recommended as the examples shown here\nare more secure.\n\nIf AES_DECRYPT() detects invalid data or incorrect padding, it returns\nNULL. However, it is possible for AES_DECRYPT() to return a non-NULL\nvalue (possibly garbage) if the input data or the key is invalid.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(447,'+',4,'Syntax:\n+\n\nAddition:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html\n\n','mysql> SELECT 3+5;\n        -> 8\n','http://dev.mysql.com/doc/refman/5.1/en/arithmetic-functions.html'),(448,'INET_NTOA',14,'Syntax:\nINET_NTOA(expr)\n\nGiven a numeric IPv4 network address in network byte order, returns the\ndotted-quad representation of the address as a binary string.\nINET_NTOA() returns NULL if it does not understand its argument.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html\n\n','mysql> SELECT INET_NTOA(167773449);\n        -> \'10.0.5.9\'\n','http://dev.mysql.com/doc/refman/5.1/en/miscellaneous-functions.html'),(449,'ACOS',4,'Syntax:\nACOS(X)\n\nReturns the arc cosine of X, that is, the value whose cosine is X.\nReturns NULL if X is not in the range -1 to 1.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT ACOS(1);\n        -> 0\nmysql> SELECT ACOS(1.0001);\n        -> NULL\nmysql> SELECT ACOS(0);\n        -> 1.5707963267949\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(450,'ISOLATION',8,'Syntax:\nSET [GLOBAL | SESSION] TRANSACTION ISOLATION LEVEL\n  {\n       REPEATABLE READ\n     | READ COMMITTED\n     | READ UNCOMMITTED\n     | SERIALIZABLE\n   }\n\nThis statement sets the transaction isolation level, used for\noperations on InnoDB tables.\n\nScope of the Isolation Level\n\nYou can set the isolation level globally, for the current session, or\nfor the next transaction:\n\no With the GLOBAL keyword, the statement sets the default transaction\n  level globally for all subsequent sessions. Existing sessions are\n  unaffected.\n\no With the SESSION keyword, the statement sets the default transaction\n  level for all subsequent transactions performed within the current\n  session.\n\no Without any SESSION or GLOBAL keyword, the statement sets the\n  isolation level for the next (not started) transaction performed\n  within the current session.\n\nA change to the global default isolation level requires the SUPER\nprivilege. Any session is free to change its session isolation level\n(even in the middle of a transaction), or the isolation level for its\nnext transaction.\n\nSET TRANSACTION ISOLATION LEVEL without GLOBAL or SESSION is not\npermitted while there is an active transaction:\n\nmysql> START TRANSACTION;\nQuery OK, 0 rows affected (0.02 sec)\n\nmysql> SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;\nERROR 1568 (25001): Transaction isolation level can\'t be changed\nwhile a transaction is in progress\n\nTo set the global default isolation level at server startup, use the\n--transaction-isolation=level option to mysqld on the command line or\nin an option file. Values of level for this option use dashes rather\nthan spaces, so the permissible values are READ-UNCOMMITTED,\nREAD-COMMITTED, REPEATABLE-READ, or SERIALIZABLE. For example, to set\nthe default isolation level to REPEATABLE READ, use these lines in the\n[mysqld] section of an option file:\n\n[mysqld]\ntransaction-isolation = REPEATABLE-READ\n\nIt is possible to check or set the global and session transaction\nisolation levels at runtime by using the tx_isolation system variable:\n\nSELECT @@GLOBAL.tx_isolation, @@tx_isolation;\nSET GLOBAL tx_isolation=\'REPEATABLE-READ\';\nSET SESSION tx_isolation=\'SERIALIZABLE\';\n\nDetails and Usage of Isolation Levels\n\nInnoDB supports each of the transaction isolation levels described here\nusing different locking strategies. You can enforce a high degree of\nconsistency with the default REPEATABLE READ level, for operations on\ncrucial data where ACID compliance is important. Or you can relax the\nconsistency rules with READ COMMITTED or even READ UNCOMMITTED, in\nsituations such as bulk reporting where precise consistency and\nrepeatable results are less important than minimizing the amount of\noverhead for locking. SERIALIZABLE enforces even stricter rules than\nREPEATABLE READ, and is used mainly in specialized situations, such as\nwith XA transactions and for troubleshooting issues with concurrency\nand deadlocks.\n\nFor full information about how these isolation levels work with InnoDB\ntransactions, see\nhttp://dev.mysql.com/doc/refman/5.1/en/innodb-transaction-model.html.\nIn particular, for additional information about InnoDB record-level\nlocks and how it uses them to execute various types of statements, see\nhttp://dev.mysql.com/doc/refman/5.1/en/innodb-record-level-locks.html\nand http://dev.mysql.com/doc/refman/5.1/en/innodb-locks-set.html.\n\nThe following list describes how MySQL supports the different\ntransaction levels. The list goes from the most commonly used level to\nthe least used.\n\no REPEATABLE READ\n\n  This is the default isolation level for InnoDB. For consistent reads,\n  there is an important difference from the READ COMMITTED isolation\n  level: All consistent reads within the same transaction read the\n  snapshot established by the first read. This convention means that if\n  you issue several plain (nonlocking) SELECT statements within the\n  same transaction, these SELECT statements are consistent also with\n  respect to each other. See\n  http://dev.mysql.com/doc/refman/5.1/en/innodb-consistent-read.html.\n\n  For locking reads (SELECT with FOR UPDATE or LOCK IN SHARE MODE),\n  UPDATE, and DELETE statements, locking depends on whether the\n  statement uses a unique index with a unique search condition, or a\n  range-type search condition. For a unique index with a unique search\n  condition, InnoDB locks only the index record found, not the gap\n  before it. For other search conditions, InnoDB locks the index range\n  scanned, using gap locks or next-key (gap plus index-record) locks to\n  block insertions by other sessions into the gaps covered by the\n  range.\n\no READ COMMITTED\n\n  A somewhat Oracle-like isolation level with respect to consistent\n  (nonlocking) reads: Each consistent read, even within the same\n  transaction, sets and reads its own fresh snapshot. See\n  http://dev.mysql.com/doc/refman/5.1/en/innodb-consistent-read.html.\n\n  For locking reads (SELECT with FOR UPDATE or LOCK IN SHARE MODE),\n  UPDATE statements, and DELETE statements, InnoDB locks only index\n  records, not the gaps before them, and thus permits the free\n  insertion of new records next to locked records.\n\n  *Note*: In MySQL 5.1, when READ COMMITTED isolation level is used or\n  the innodb_locks_unsafe_for_binlog system variable is enabled, there\n  is no InnoDB gap locking except for foreign-key constraint checking\n  and duplicate-key checking. Also, record locks for nonmatching rows\n  are released after MySQL has evaluated the WHERE condition. As of\n  MySQL 5.1, if you use READ COMMITTED or enable\n  innodb_locks_unsafe_for_binlog, you must use row-based binary\n  logging.\n\no READ UNCOMMITTED\n\n  SELECT statements are performed in a nonlocking fashion, but a\n  possible earlier version of a row might be used. Thus, using this\n  isolation level, such reads are not consistent. This is also called a\n  \"dirty read.\" Otherwise, this isolation level works like READ\n  COMMITTED.\n\no SERIALIZABLE\n\n  This level is like REPEATABLE READ, but InnoDB implicitly converts\n  all plain SELECT statements to SELECT ... LOCK IN SHARE MODE if\n  autocommit is disabled. If autocommit is enabled, the SELECT is its\n  own transaction. It therefore is known to be read only and can be\n  serialized if performed as a consistent (nonlocking) read and need\n  not block for other transactions. (To force a plain SELECT to block\n  if other transactions have modified the selected rows, disable\n  autocommit.)\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/set-transaction.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/set-transaction.html'),(451,'CEILING',4,'Syntax:\nCEILING(X)\n\nReturns the smallest integer value not less than X.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT CEILING(1.23);\n        -> 2\nmysql> SELECT CEILING(-1.23);\n        -> -1\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(452,'SIN',4,'Syntax:\nSIN(X)\n\nReturns the sine of X, where X is given in radians.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT SIN(PI());\n        -> 1.2246063538224e-16\nmysql> SELECT ROUND(SIN(PI()));\n        -> 0\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(453,'DAYOFWEEK',32,'Syntax:\nDAYOFWEEK(date)\n\nReturns the weekday index for date (1 = Sunday, 2 = Monday, ..., 7 =\nSaturday). These index values correspond to the ODBC standard.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT DAYOFWEEK(\'2007-02-03\');\n        -> 7\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(454,'SHOW PROCESSLIST',27,'Syntax:\nSHOW [FULL] PROCESSLIST\n\nSHOW PROCESSLIST shows you which threads are running. You can also get\nthis information from the INFORMATION_SCHEMA PROCESSLIST table or the\nmysqladmin processlist command. If you have the PROCESS privilege, you\ncan see all threads. Otherwise, you can see only your own threads (that\nis, threads associated with the MySQL account that you are using). If\nyou do not use the FULL keyword, only the first 100 characters of each\nstatement are shown in the Info field.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-processlist.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-processlist.html'),(455,'LINEFROMWKB',33,'LineFromWKB(wkb[,srid]), LineStringFromWKB(wkb[,srid])\n\nConstructs a LINESTRING value using its WKB representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(456,'GEOMETRYTYPE',37,'GeometryType(g)\n\nReturns as a binary string the name of the geometry type of which the\ngeometry instance g is a member. The name corresponds to one of the\ninstantiable Geometry subclasses.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SELECT GeometryType(GeomFromText(\'POINT(1 1)\'));\n+------------------------------------------+\n| GeometryType(GeomFromText(\'POINT(1 1)\')) |\n+------------------------------------------+\n| POINT                                    |\n+------------------------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(457,'CREATE VIEW',40,'Syntax:\nCREATE\n    [OR REPLACE]\n    [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]\n    [DEFINER = { user | CURRENT_USER }]\n    [SQL SECURITY { DEFINER | INVOKER }]\n    VIEW view_name [(column_list)]\n    AS select_statement\n    [WITH [CASCADED | LOCAL] CHECK OPTION]\n\nThe CREATE VIEW statement creates a new view, or replaces an existing\none if the OR REPLACE clause is given. If the view does not exist,\nCREATE OR REPLACE VIEW is the same as CREATE VIEW. If the view does\nexist, CREATE OR REPLACE VIEW is the same as ALTER VIEW.\n\nThe select_statement is a SELECT statement that provides the definition\nof the view. (When you select from the view, you select in effect using\nthe SELECT statement.) select_statement can select from base tables or\nother views.\n\nThe view definition is \"frozen\" at creation time, so changes to the\nunderlying tables afterward do not affect the view definition. For\nexample, if a view is defined as SELECT * on a table, new columns added\nto the table later do not become part of the view.\n\nThe ALGORITHM clause affects how MySQL processes the view. The DEFINER\nand SQL SECURITY clauses specify the security context to be used when\nchecking access privileges at view invocation time. The WITH CHECK\nOPTION clause can be given to constrain inserts or updates to rows in\ntables referenced by the view. These clauses are described later in\nthis section.\n\nThe CREATE VIEW statement requires the CREATE VIEW privilege for the\nview, and some privilege for each column selected by the SELECT\nstatement. For columns used elsewhere in the SELECT statement you must\nhave the SELECT privilege. If the OR REPLACE clause is present, you\nmust also have the DROP privilege for the view. CREATE VIEW might also\nrequire the SUPER privilege, depending on the DEFINER value, as\ndescribed later in this section.\n\nWhen a view is referenced, privilege checking occurs as described later\nin this section.\n\nA view belongs to a database. By default, a new view is created in the\ndefault database. To create the view explicitly in a given database,\nspecify the name as db_name.view_name when you create it:\n\nmysql> CREATE VIEW test.v AS SELECT * FROM t;\n\nWithin a database, base tables and views share the same namespace, so a\nbase table and a view cannot have the same name.\n\nColumns retrieved by the SELECT statement can be simple references to\ntable columns. They can also be expressions that use functions,\nconstant values, operators, and so forth.\n\nViews must have unique column names with no duplicates, just like base\ntables. By default, the names of the columns retrieved by the SELECT\nstatement are used for the view column names. To define explicit names\nfor the view columns, the optional column_list clause can be given as a\nlist of comma-separated identifiers. The number of names in column_list\nmust be the same as the number of columns retrieved by the SELECT\nstatement.\n\n*Note*: Prior to MySQL 5.1.29, when you modify an existing view, the\nserver saves a backup of the current view definition under the view\ndatabase directory, in a subdirectory named arc. The backup file for a\nview v is named v.frm-00001. If you alter the view again, the next\nbackup is named v.frm-00002. The three latest view backup definitions\nare stored. Backed up view definitions are not preserved by mysqldump,\nor any other such programs, but you can retain them using a file copy\noperation. However, they are not needed for anything but to provide you\nwith a backup of your previous view definition. It is safe to remove\nthese backup definitions, but only while mysqld is not running. If you\ndelete the arc subdirectory or its files while mysqld is running, an\nerror occurs the next time you try to alter the view: mysql> ALTER VIEW\nv AS SELECT * FROM t; ERROR 6 (HY000): Error on delete of\n\'.\\test\\arc/v.frm-0004\' (Errcode: 2)\n\nUnqualified table or view names in the SELECT statement are interpreted\nwith respect to the default database. A view can refer to tables or\nviews in other databases by qualifying the table or view name with the\nproper database name.\n\nA view can be created from many kinds of SELECT statements. It can\nrefer to base tables or other views. It can use joins, UNION, and\nsubqueries. The SELECT need not even refer to any tables. The following\nexample defines a view that selects two columns from another table, as\nwell as an expression calculated from those columns:\n\nmysql> CREATE TABLE t (qty INT, price INT);\nmysql> INSERT INTO t VALUES(3, 50);\nmysql> CREATE VIEW v AS SELECT qty, price, qty*price AS value FROM t;\nmysql> SELECT * FROM v;\n+------+-------+-------+\n| qty  | price | value |\n+------+-------+-------+\n|    3 |    50 |   150 |\n+------+-------+-------+\n\nA view definition is subject to the following restrictions:\n\no The SELECT statement cannot contain a subquery in the FROM clause.\n\no The SELECT statement cannot refer to system or user variables.\n\no Within a stored program, the definition cannot refer to program\n  parameters or local variables.\n\no The SELECT statement cannot refer to prepared statement parameters.\n\no Any table or view referred to in the definition must exist. However,\n  after a view has been created, it is possible to drop a table or view\n  that the definition refers to. In this case, use of the view results\n  in an error. To check a view definition for problems of this kind,\n  use the CHECK TABLE statement.\n\no The definition cannot refer to a TEMPORARY table, and you cannot\n  create a TEMPORARY view.\n\no Any tables named in the view definition must exist at definition\n  time.\n\no You cannot associate a trigger with a view.\n\no As of MySQL 5.1.23, aliases for column names in the SELECT statement\n  are checked against the maximum column length of 64 characters (not\n  the maximum alias length of 256 characters).\n\nORDER BY is permitted in a view definition, but it is ignored if you\nselect from a view using a statement that has its own ORDER BY.\n\nFor other options or clauses in the definition, they are added to the\noptions or clauses of the statement that references the view, but the\neffect is undefined. For example, if a view definition includes a LIMIT\nclause, and you select from the view using a statement that has its own\nLIMIT clause, it is undefined which limit applies. This same principle\napplies to options such as ALL, DISTINCT, or SQL_SMALL_RESULT that\nfollow the SELECT keyword, and to clauses such as INTO, FOR UPDATE,\nLOCK IN SHARE MODE, and PROCEDURE.\n\nIf you create a view and then change the query processing environment\nby changing system variables, that may affect the results that you get\nfrom the view:\n\nmysql> CREATE VIEW v (mycol) AS SELECT \'abc\';\nQuery OK, 0 rows affected (0.01 sec)\n\nmysql> SET sql_mode = \'\';\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT \"mycol\" FROM v;\n+-------+\n| mycol |\n+-------+\n| mycol |\n+-------+\n1 row in set (0.01 sec)\n\nmysql> SET sql_mode = \'ANSI_QUOTES\';\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SELECT \"mycol\" FROM v;\n+-------+\n| mycol |\n+-------+\n| abc   |\n+-------+\n1 row in set (0.00 sec)\n\nThe DEFINER and SQL SECURITY clauses determine which MySQL account to\nuse when checking access privileges for the view when a statement is\nexecuted that references the view. These clauses were added in MySQL\n5.1.2. The valid SQL SECURITY characteristic values are DEFINER and\nINVOKER. These indicate that the required privileges must be held by\nthe user who defined or invoked the view, respectively. The default SQL\nSECURITY value is DEFINER.\n\nIf a user value is given for the DEFINER clause, it should be a MySQL\naccount specified as \'user_name\'@\'host_name\' (the same format used in\nthe GRANT statement), CURRENT_USER, or CURRENT_USER(). The default\nDEFINER value is the user who executes the CREATE VIEW statement. This\nis the same as specifying DEFINER = CURRENT_USER explicitly.\n\nIf you specify the DEFINER clause, these rules determine the valid\nDEFINER user values:\n\no If you do not have the SUPER privilege, the only valid user value is\n  your own account, either specified literally or by using\n  CURRENT_USER. You cannot set the definer to some other account.\n\no If you have the SUPER privilege, you can specify any syntactically\n  valid account name. If the account does not actually exist, a warning\n  is generated.\n\no Although it is possible to create a view with a nonexistent DEFINER\n  account, an error occurs when the view is referenced if the SQL\n  SECURITY value is DEFINER but the definer account does not exist.\n\nFor more information about view security, see\nhttp://dev.mysql.com/doc/refman/5.1/en/stored-programs-security.html.\n\nWithin a view definition, CURRENT_USER returns the view\'s DEFINER value\nby default as of MySQL 5.1.12. For older versions, and for views\ndefined with the SQL SECURITY INVOKER characteristic, CURRENT_USER\nreturns the account for the view\'s invoker. For information about user\nauditing within views, see\nhttp://dev.mysql.com/doc/refman/5.1/en/account-activity-auditing.html.\n\nWithin a stored routine that is defined with the SQL SECURITY DEFINER\ncharacteristic, CURRENT_USER returns the routine\'s DEFINER value. This\nalso affects a view defined within such a routine, if the view\ndefinition contains a DEFINER value of CURRENT_USER.\n\nAs of MySQL 5.1.2 (when the DEFINER and SQL SECURITY clauses were\nimplemented), view privileges are checked like this:\n\no At view definition time, the view creator must have the privileges\n  needed to use the top-level objects accessed by the view. For\n  example, if the view definition refers to table columns, the creator\n  must have some privilege for each column in the select list of the\n  definition, and the SELECT privilege for each column used elsewhere\n  in the definition. If the definition refers to a stored function,\n  only the privileges needed to invoke the function can be checked. The\n  privileges required at function invocation time can be checked only\n  as it executes: For different invocations, different execution paths\n  within the function might be taken.\n\no The user who references a view must have appropriate privileges to\n  access it (SELECT to select from it, INSERT to insert into it, and so\n  forth.)\n\no When a view has been referenced, privileges for objects accessed by\n  the view are checked against the privileges held by the view DEFINER\n  account or invoker, depending on whether the SQL SECURITY\n  characteristic is DEFINER or INVOKER, respectively.\n\no If reference to a view causes execution of a stored function,\n  privilege checking for statements executed within the function depend\n  on whether the function SQL SECURITY characteristic is DEFINER or\n  INVOKER. If the security characteristic is DEFINER, the function runs\n  with the privileges of the DEFINER account. If the characteristic is\n  INVOKER, the function runs with the privileges determined by the\n  view\'s SQL SECURITY characteristic.\n\nPrior to MySQL 5.1.2 (before the DEFINER and SQL SECURITY clauses were\nimplemented), privileges required for objects used in a view are\nchecked at view creation time.\n\nExample: A view might depend on a stored function, and that function\nmight invoke other stored routines. For example, the following view\ninvokes a stored function f():\n\nCREATE VIEW v AS SELECT * FROM t WHERE t.id = f(t.name);\n\nSuppose that f() contains a statement such as this:\n\nIF name IS NULL then\n  CALL p1();\nELSE\n  CALL p2();\nEND IF;\n\nThe privileges required for executing statements within f() need to be\nchecked when f() executes. This might mean that privileges are needed\nfor p1() or p2(), depending on the execution path within f(). Those\nprivileges must be checked at runtime, and the user who must possess\nthe privileges is determined by the SQL SECURITY values of the view v\nand the function f().\n\nThe DEFINER and SQL SECURITY clauses for views are extensions to\nstandard SQL. In standard SQL, views are handled using the rules for\nSQL SECURITY DEFINER. The standard says that the definer of the view,\nwhich is the same as the owner of the view\'s schema, gets applicable\nprivileges on the view (for example, SELECT) and may grant them. MySQL\nhas no concept of a schema \"owner\", so MySQL adds a clause to identify\nthe definer. The DEFINER clause is an extension where the intent is to\nhave what the standard has; that is, a permanent record of who defined\nthe view. This is why the default DEFINER value is the account of the\nview creator.\n\nIf you invoke a view that was created before MySQL 5.1.2, it is treated\nas though it was created with a SQL SECURITY DEFINER characteristic and\nwith a DEFINER value that is the same as your account. However, because\nthe actual definer is unknown, MySQL issues a warning. To eliminate the\nwarning, it is sufficient to re-create the view so that the view\ndefinition includes a DEFINER clause.\n\nThe optional ALGORITHM clause is a MySQL extension to standard SQL. It\naffects how MySQL processes the view. ALGORITHM takes three values:\nMERGE, TEMPTABLE, or UNDEFINED. The default algorithm is UNDEFINED if\nno ALGORITHM clause is present. For more information, see\nhttp://dev.mysql.com/doc/refman/5.1/en/view-algorithms.html.\n\nSome views are updatable. That is, you can use them in statements such\nas UPDATE, DELETE, or INSERT to update the contents of the underlying\ntable. For a view to be updatable, there must be a one-to-one\nrelationship between the rows in the view and the rows in the\nunderlying table. There are also certain other constructs that make a\nview nonupdatable.\n\nThe WITH CHECK OPTION clause can be given for an updatable view to\nprevent inserts or updates to rows except those for which the WHERE\nclause in the select_statement is true.\n\nIn a WITH CHECK OPTION clause for an updatable view, the LOCAL and\nCASCADED keywords determine the scope of check testing when the view is\ndefined in terms of another view. The LOCAL keyword restricts the CHECK\nOPTION only to the view being defined. CASCADED causes the checks for\nunderlying views to be evaluated as well. When neither keyword is\ngiven, the default is CASCADED.\n\nFor more information about updatable views and the WITH CHECK OPTION\nclause, see\nhttp://dev.mysql.com/doc/refman/5.1/en/view-updatability.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-view.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-view.html'),(458,'TRIM',38,'Syntax:\nTRIM([{BOTH | LEADING | TRAILING} [remstr] FROM] str), TRIM([remstr\nFROM] str)\n\nReturns the string str with all remstr prefixes or suffixes removed. If\nnone of the specifiers BOTH, LEADING, or TRAILING is given, BOTH is\nassumed. remstr is optional and, if not specified, spaces are removed.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT TRIM(\'  bar   \');\n        -> \'bar\'\nmysql> SELECT TRIM(LEADING \'x\' FROM \'xxxbarxxx\');\n        -> \'barxxx\'\nmysql> SELECT TRIM(BOTH \'x\' FROM \'xxxbarxxx\');\n        -> \'bar\'\nmysql> SELECT TRIM(TRAILING \'xyz\' FROM \'barxxyz\');\n        -> \'barx\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(459,'IS',19,'Syntax:\nIS boolean_value\n\nTests a value against a boolean value, where boolean_value can be TRUE,\nFALSE, or UNKNOWN.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 1 IS TRUE, 0 IS FALSE, NULL IS UNKNOWN;\n        -> 1, 1, 1\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(460,'GET_FORMAT',32,'Syntax:\nGET_FORMAT({DATE|TIME|DATETIME}, {\'EUR\'|\'USA\'|\'JIS\'|\'ISO\'|\'INTERNAL\'})\n\nReturns a format string. This function is useful in combination with\nthe DATE_FORMAT() and the STR_TO_DATE() functions.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT DATE_FORMAT(\'2003-10-03\',GET_FORMAT(DATE,\'EUR\'));\n        -> \'03.10.2003\'\nmysql> SELECT STR_TO_DATE(\'10.31.2003\',GET_FORMAT(DATE,\'USA\'));\n        -> \'2003-10-31\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(461,'TINYBLOB',23,'TINYBLOB\n\nA BLOB column with a maximum length of 255 (28 - 1) bytes. Each\nTINYBLOB value is stored using a 1-byte length prefix that indicates\nthe number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(462,'SAVEPOINT',8,'Syntax:\nSAVEPOINT identifier\nROLLBACK [WORK] TO [SAVEPOINT] identifier\nRELEASE SAVEPOINT identifier\n\nInnoDB supports the SQL statements SAVEPOINT, ROLLBACK TO SAVEPOINT,\nRELEASE SAVEPOINT and the optional WORK keyword for ROLLBACK.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/savepoint.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/savepoint.html'),(463,'USER',17,'Syntax:\nUSER()\n\nReturns the current MySQL user name and host name as a string in the\nutf8 character set.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> SELECT USER();\n        -> \'davida@localhost\'\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(464,'LABELS',24,'Syntax:\n[begin_label:] BEGIN\n    [statement_list]\nEND [end_label]\n\n[begin_label:] LOOP\n    statement_list\nEND LOOP [end_label]\n\n[begin_label:] REPEAT\n    statement_list\nUNTIL search_condition\nEND REPEAT [end_label]\n\n[begin_label:] WHILE search_condition DO\n    statement_list\nEND WHILE [end_label]\n\nLabels are permitted for BEGIN ... END blocks and for the LOOP, REPEAT,\nand WHILE statements. Label use for those statements follows these\nrules:\n\no begin_label must be followed by a colon.\n\no begin_label can be given without end_label. If end_label is present,\n  it must be the same as begin_label.\n\no end_label cannot be given without begin_label.\n\no Labels at the same nesting level must be distinct.\n\no Labels can be up to 16 characters long.\n\nTo refer to a label within the labeled construct, use an ITERATE or\nLEAVE statement. The following example uses those statements to\ncontinue iterating or terminate the loop:\n\nCREATE PROCEDURE doiterate(p1 INT)\nBEGIN\n  label1: LOOP\n    SET p1 = p1 + 1;\n    IF p1 < 10 THEN ITERATE label1; END IF;\n    LEAVE label1;\n  END LOOP label1;\nEND;\n\nThe scope of a block label does not include the code for handlers\ndeclared within the block. For details, see [HELP DECLARE HANDLER].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/statement-labels.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/statement-labels.html'),(465,'ALTER TABLE',40,'Syntax:\nALTER [ONLINE | OFFLINE] [IGNORE] TABLE tbl_name\n    [alter_specification [, alter_specification] ...]\n    [partition_options]\n\nalter_specification:\n    table_options\n  | ADD [COLUMN] col_name column_definition\n        [FIRST | AFTER col_name ]\n  | ADD [COLUMN] (col_name column_definition,...)\n  | ADD {INDEX|KEY} [index_name]\n        [index_type] (index_col_name,...) [index_option] ...\n  | ADD [CONSTRAINT [symbol]] PRIMARY KEY\n        [index_type] (index_col_name,...) [index_option] ...\n  | ADD [CONSTRAINT [symbol]]\n        UNIQUE [INDEX|KEY] [index_name]\n        [index_type] (index_col_name,...) [index_option] ...\n  | ADD FULLTEXT [INDEX|KEY] [index_name]\n        (index_col_name,...) [index_option] ...\n  | ADD SPATIAL [INDEX|KEY] [index_name]\n        (index_col_name,...) [index_option] ...\n  | ADD [CONSTRAINT [symbol]]\n        FOREIGN KEY [index_name] (index_col_name,...)\n        reference_definition\n  | ALTER [COLUMN] col_name {SET DEFAULT literal | DROP DEFAULT}\n  | CHANGE [COLUMN] old_col_name new_col_name column_definition\n        [FIRST|AFTER col_name]\n  | MODIFY [COLUMN] col_name column_definition\n        [FIRST | AFTER col_name]\n  | DROP [COLUMN] col_name\n  | DROP PRIMARY KEY\n  | DROP {INDEX|KEY} index_name\n  | DROP FOREIGN KEY fk_symbol\n  | DISABLE KEYS\n  | ENABLE KEYS\n  | RENAME [TO|AS] new_tbl_name\n  | ORDER BY col_name [, col_name] ...\n  | CONVERT TO CHARACTER SET charset_name [COLLATE collation_name]\n  | [DEFAULT] CHARACTER SET [=] charset_name [COLLATE [=] collation_name]\n  | DISCARD TABLESPACE\n  | IMPORT TABLESPACE\n  | ADD PARTITION (partition_definition)\n  | DROP PARTITION partition_names\n  | COALESCE PARTITION number\n  | REORGANIZE PARTITION [partition_names INTO (partition_definitions)]\n  | ANALYZE PARTITION {partition_names | ALL}\n  | CHECK PARTITION {partition_names | ALL}\n  | OPTIMIZE PARTITION {partition_names | ALL}\n  | REBUILD PARTITION {partition_names | ALL}\n  | REPAIR PARTITION {partition_names | ALL}\n  | PARTITION BY partitioning_expression\n  | REMOVE PARTITIONING\n\nindex_col_name:\n    col_name [(length)] [ASC | DESC]\n\nindex_type:\n    USING {BTREE | HASH}\n\nindex_option:\n    KEY_BLOCK_SIZE [=] value\n  | index_type\n  | WITH PARSER parser_name\n\ntable_options:\n    table_option [[,] table_option] ...  (see CREATE TABLE options)\n\npartition_options:\n    (see CREATE TABLE options)\n\nALTER TABLE changes the structure of a table. For example, you can add\nor delete columns, create or destroy indexes, change the type of\nexisting columns, or rename columns or the table itself. You can also\nchange characteristics such as the storage engine used for the table or\nthe table comment.\n\nA number of partitioning-related extensions to ALTER TABLE were added\nin MySQL 5.1.5. These can be used with partitioned tables for\nrepartitioning, for adding, dropping, merging, and splitting\npartitions, and for performing partitioning maintenance. It is possible\nfor an ALTER TABLE statement to contain a PARTITION BY or REMOVE\nPARTITIONING clause in an addition to other alter specifications, but\nthe PARTITION BY or REMOVE PARTITIONING clause must be specified last\nafter any other specifications. The ADD PARTITION, DROP PARTITION,\nCOALESCE PARTITION, REORGANIZE PARTITION, ANALYZE PARTITION, CHECK\nPARTITION, and REPAIR PARTITION options cannot be combined with other\nalter specifications in a single ALTER TABLE, since the options just\nlisted act on individual partitions. For more information, see\nhttp://dev.mysql.com/doc/refman/5.1/en/alter-table-partition-operations\n.html.\n\nFollowing the table name, specify the alterations to be made. If none\nare given, ALTER TABLE does nothing.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/alter-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/alter-table.html'),(466,'MPOINTFROMWKB',33,'MPointFromWKB(wkb[,srid]), MultiPointFromWKB(wkb[,srid])\n\nConstructs a MULTIPOINT value using its WKB representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(467,'CHAR BYTE',23,'The CHAR BYTE data type is an alias for the BINARY data type. This is a\ncompatibility feature.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(468,'REPAIR TABLE',21,'Syntax:\nREPAIR [NO_WRITE_TO_BINLOG | LOCAL] TABLE\n    tbl_name [, tbl_name] ...\n    [QUICK] [EXTENDED] [USE_FRM]\n\nREPAIR TABLE repairs a possibly corrupted table. By default, it has the\nsame effect as myisamchk --recover tbl_name. REPAIR TABLE works for\nMyISAM and for ARCHIVE tables. Starting with MySQL 5.1.9, REPAIR is\nalso valid for CSV tables. See\nhttp://dev.mysql.com/doc/refman/5.1/en/myisam-storage-engine.html, and\nhttp://dev.mysql.com/doc/refman/5.1/en/archive-storage-engine.html, and\nhttp://dev.mysql.com/doc/refman/5.1/en/csv-storage-engine.html\n\nThis statement requires SELECT and INSERT privileges for the table.\n\nBeginning with MySQL 5.1.27, REPAIR TABLE is also supported for\npartitioned tables. However, the USE_FRM option cannot be used with\nthis statement on a partitioned table.\n\nAlso beginning with MySQL 5.1.27, you can use ALTER TABLE ... REPAIR\nPARTITION to repair one or more partitions; for more information, see\n[HELP ALTER TABLE], and\nhttp://dev.mysql.com/doc/refman/5.1/en/partitioning-maintenance.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/repair-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/repair-table.html'),(469,'MERGE',18,'The MERGE storage engine, also known as the MRG_MyISAM engine, is a\ncollection of identical MyISAM tables that can be used as one.\n\"Identical\" means that all tables have identical column and index\ninformation. You cannot merge MyISAM tables in which the columns are\nlisted in a different order, do not have exactly the same columns, or\nhave the indexes in different order. However, any or all of the MyISAM\ntables can be compressed with myisampack. See\nhttp://dev.mysql.com/doc/refman/5.1/en/myisampack.html. Differences in\ntable options such as AVG_ROW_LENGTH, MAX_ROWS, or PACK_KEYS do not\nmatter.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/merge-storage-engine.html\n\n','mysql> CREATE TABLE t1 (\n    ->    a INT NOT NULL AUTO_INCREMENT PRIMARY KEY,\n    ->    message CHAR(20)) ENGINE=MyISAM;\nmysql> CREATE TABLE t2 (\n    ->    a INT NOT NULL AUTO_INCREMENT PRIMARY KEY,\n    ->    message CHAR(20)) ENGINE=MyISAM;\nmysql> INSERT INTO t1 (message) VALUES (\'Testing\'),(\'table\'),(\'t1\');\nmysql> INSERT INTO t2 (message) VALUES (\'Testing\'),(\'table\'),(\'t2\');\nmysql> CREATE TABLE total (\n    ->    a INT NOT NULL AUTO_INCREMENT,\n    ->    message CHAR(20), INDEX(a))\n    ->    ENGINE=MERGE UNION=(t1,t2) INSERT_METHOD=LAST;\n','http://dev.mysql.com/doc/refman/5.1/en/merge-storage-engine.html'),(470,'CREATE TABLE',40,'Syntax:\nCREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name\n    (create_definition,...)\n    [table_options]\n    [partition_options]\n\nOr:\n\nCREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name\n    [(create_definition,...)]\n    [table_options]\n    [partition_options]\n    select_statement\n\nOr:\n\nCREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name\n    { LIKE old_tbl_name | (LIKE old_tbl_name) }\n\ncreate_definition:\n    col_name column_definition\n  | [CONSTRAINT [symbol]] PRIMARY KEY [index_type] (index_col_name,...)\n      [index_option] ...\n  | {INDEX|KEY} [index_name] [index_type] (index_col_name,...)\n      [index_option] ...\n  | [CONSTRAINT [symbol]] UNIQUE [INDEX|KEY]\n      [index_name] [index_type] (index_col_name,...)\n      [index_option] ...\n  | {FULLTEXT|SPATIAL} [INDEX|KEY] [index_name] (index_col_name,...)\n      [index_option] ...\n  | [CONSTRAINT [symbol]] FOREIGN KEY\n      [index_name] (index_col_name,...) reference_definition\n  | CHECK (expr)\n\ncolumn_definition:\n    data_type [NOT NULL | NULL] [DEFAULT default_value]\n      [AUTO_INCREMENT] [UNIQUE [KEY] | [PRIMARY] KEY]\n      [COMMENT \'string\']\n      [COLUMN_FORMAT {FIXED|DYNAMIC|DEFAULT}]\n      [STORAGE {DISK|MEMORY|DEFAULT}]\n      [reference_definition]\n\ndata_type:\n    BIT[(length)]\n  | TINYINT[(length)] [UNSIGNED] [ZEROFILL]\n  | SMALLINT[(length)] [UNSIGNED] [ZEROFILL]\n  | MEDIUMINT[(length)] [UNSIGNED] [ZEROFILL]\n  | INT[(length)] [UNSIGNED] [ZEROFILL]\n  | INTEGER[(length)] [UNSIGNED] [ZEROFILL]\n  | BIGINT[(length)] [UNSIGNED] [ZEROFILL]\n  | REAL[(length,decimals)] [UNSIGNED] [ZEROFILL]\n  | DOUBLE[(length,decimals)] [UNSIGNED] [ZEROFILL]\n  | FLOAT[(length,decimals)] [UNSIGNED] [ZEROFILL]\n  | DECIMAL[(length[,decimals])] [UNSIGNED] [ZEROFILL]\n  | NUMERIC[(length[,decimals])] [UNSIGNED] [ZEROFILL]\n  | DATE\n  | TIME\n  | TIMESTAMP\n  | DATETIME\n  | YEAR\n  | CHAR[(length)]\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | VARCHAR(length)\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | BINARY[(length)]\n  | VARBINARY(length)\n  | TINYBLOB\n  | BLOB\n  | MEDIUMBLOB\n  | LONGBLOB\n  | TINYTEXT [BINARY]\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | TEXT [BINARY]\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | MEDIUMTEXT [BINARY]\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | LONGTEXT [BINARY]\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | ENUM(value1,value2,value3,...)\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | SET(value1,value2,value3,...)\n      [CHARACTER SET charset_name] [COLLATE collation_name]\n  | spatial_type\n\nindex_col_name:\n    col_name [(length)] [ASC | DESC]\n\nindex_type:\n    USING {BTREE | HASH}\n\nindex_option:\n    KEY_BLOCK_SIZE [=] value\n  | index_type\n  | WITH PARSER parser_name\n\nreference_definition:\n    REFERENCES tbl_name (index_col_name,...)\n      [MATCH FULL | MATCH PARTIAL | MATCH SIMPLE]\n      [ON DELETE reference_option]\n      [ON UPDATE reference_option]\n\nreference_option:\n    RESTRICT | CASCADE | SET NULL | NO ACTION\n\ntable_options:\n    table_option [[,] table_option] ...\n\ntable_option:\n    ENGINE [=] engine_name\n  | AUTO_INCREMENT [=] value\n  | AVG_ROW_LENGTH [=] value\n  | [DEFAULT] CHARACTER SET [=] charset_name\n  | CHECKSUM [=] {0 | 1}\n  | [DEFAULT] COLLATE [=] collation_name\n  | COMMENT [=] \'string\'\n  | CONNECTION [=] \'connect_string\'\n  | DATA DIRECTORY [=] \'absolute path to directory\'\n  | DELAY_KEY_WRITE [=] {0 | 1}\n  | INDEX DIRECTORY [=] \'absolute path to directory\'\n  | INSERT_METHOD [=] { NO | FIRST | LAST }\n  | KEY_BLOCK_SIZE [=] value\n  | MAX_ROWS [=] value\n  | MIN_ROWS [=] value\n  | PACK_KEYS [=] {0 | 1 | DEFAULT}\n  | PASSWORD [=] \'string\'\n  | ROW_FORMAT [=] {DEFAULT|DYNAMIC|FIXED|COMPRESSED|REDUNDANT|COMPACT}\n  | TABLESPACE tablespace_name [STORAGE {DISK|MEMORY|DEFAULT}]\n  | UNION [=] (tbl_name[,tbl_name]...)\n\npartition_options:\n    PARTITION BY\n        { [LINEAR] HASH(expr)\n        | [LINEAR] KEY(column_list)\n        | RANGE(expr)\n        | LIST(expr) }\n    [PARTITIONS num]\n    [SUBPARTITION BY\n        { [LINEAR] HASH(expr)\n        | [LINEAR] KEY(column_list) }\n      [SUBPARTITIONS num]\n    ]\n    [(partition_definition [, partition_definition] ...)]\n\npartition_definition:\n    PARTITION partition_name\n        [VALUES \n            {LESS THAN {(expr) | MAXVALUE} \n            | \n            IN (value_list)}]\n        [[STORAGE] ENGINE [=] engine_name]\n        [COMMENT [=] \'comment_text\' ]\n        [DATA DIRECTORY [=] \'data_dir\']\n        [INDEX DIRECTORY [=] \'index_dir\']\n        [MAX_ROWS [=] max_number_of_rows]\n        [MIN_ROWS [=] min_number_of_rows]\n        [TABLESPACE [=] tablespace_name]\n        [NODEGROUP [=] node_group_id]\n        [(subpartition_definition [, subpartition_definition] ...)]\n\nsubpartition_definition:\n    SUBPARTITION logical_name\n        [[STORAGE] ENGINE [=] engine_name]\n        [COMMENT [=] \'comment_text\' ]\n        [DATA DIRECTORY [=] \'data_dir\']\n        [INDEX DIRECTORY [=] \'index_dir\']\n        [MAX_ROWS [=] max_number_of_rows]\n        [MIN_ROWS [=] min_number_of_rows]\n        [TABLESPACE [=] tablespace_name]\n        [NODEGROUP [=] node_group_id]\n\nselect_statement:\n    [IGNORE | REPLACE] [AS] SELECT ...   (Some valid select statement)\n\nCREATE TABLE creates a table with the given name. You must have the\nCREATE privilege for the table.\n\nRules for permissible table names are given in\nhttp://dev.mysql.com/doc/refman/5.1/en/identifiers.html. By default,\nthe table is created in the default database. An error occurs if the\ntable exists, if there is no default database, or if the database does\nnot exist.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/create-table.html'),(471,'>',19,'Syntax:\n>\n\nGreater than:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT 2 > 2;\n        -> 0\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(472,'ANALYZE TABLE',21,'Syntax:\nANALYZE [NO_WRITE_TO_BINLOG | LOCAL] TABLE\n    tbl_name [, tbl_name] ...\n\nANALYZE TABLE analyzes and stores the key distribution for a table.\nDuring the analysis, the table is locked with a read lock for InnoDB\nand MyISAM. This statement works with InnoDB, NDB, and MyISAM tables.\nFor MyISAM tables, this statement is equivalent to using myisamchk\n--analyze.\n\nFor more information on how the analysis works within InnoDB, see\nhttp://dev.mysql.com/doc/refman/5.1/en/innodb-restrictions.html.\n\nMySQL uses the stored key distribution to decide the order in which\ntables should be joined when you perform a join on something other than\na constant. In addition, key distributions can be used when deciding\nwhich indexes to use for a specific table within a query.\n\nThis statement requires SELECT and INSERT privileges for the table.\n\nBeginning with MySQL 5.1.27, ANALYZE TABLE is also supported for\npartitioned tables. Also beginning with MySQL 5.1.27, you can use ALTER\nTABLE ... ANALYZE PARTITION to analyze one or more partitions; for more\ninformation, see [HELP ALTER TABLE], and\nhttp://dev.mysql.com/doc/refman/5.1/en/partitioning-maintenance.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/analyze-table.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/analyze-table.html'),(473,'MICROSECOND',32,'Syntax:\nMICROSECOND(expr)\n\nReturns the microseconds from the time or datetime expression expr as a\nnumber in the range from 0 to 999999.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT MICROSECOND(\'12:00:00.123456\');\n        -> 123456\nmysql> SELECT MICROSECOND(\'2009-12-31 23:59:59.000010\');\n        -> 10\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(474,'CONSTRAINT',40,'MySQL supports foreign keys, which let you cross-reference related data\nacross tables, and foreign key constraints\n(http://dev.mysql.com/doc/refman/5.5/en/glossary.html#glos_foreign_key_\nconstraint), which help keep this spread-out data consistent. The\nessential syntax for a foreign key constraint definition in a CREATE\nTABLE or ALTER TABLE statement looks like this:\n\n[CONSTRAINT [symbol]] FOREIGN KEY\n    [index_name] (index_col_name, ...)\n    REFERENCES tbl_name (index_col_name,...)\n    [ON DELETE reference_option]\n    [ON UPDATE reference_option]\n\nreference_option:\n    RESTRICT | CASCADE | SET NULL | NO ACTION\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-table-foreign-keys.html\n\n','CREATE TABLE product (\n    category INT NOT NULL, id INT NOT NULL,\n    price DECIMAL,\n    PRIMARY KEY(category, id)\n)   ENGINE=INNODB;\n\nCREATE TABLE customer (\n    id INT NOT NULL,\n    PRIMARY KEY (id)\n)   ENGINE=INNODB;\n\nCREATE TABLE product_order (\n    no INT NOT NULL AUTO_INCREMENT,\n    product_category INT NOT NULL,\n    product_id INT NOT NULL,\n    customer_id INT NOT NULL,\n\n    PRIMARY KEY(no),\n    INDEX (product_category, product_id),\n    INDEX (customer_id),\n\n    FOREIGN KEY (product_category, product_id)\n      REFERENCES product(category, id)\n      ON UPDATE CASCADE ON DELETE RESTRICT,\n\n    FOREIGN KEY (customer_id)\n      REFERENCES customer(id)\n)   ENGINE=INNODB;\n','http://dev.mysql.com/doc/refman/5.1/en/create-table-foreign-keys.html'),(475,'CREATE SERVER',40,'Syntax:\nCREATE SERVER server_name\n    FOREIGN DATA WRAPPER wrapper_name\n    OPTIONS (option [, option] ...)\n\noption:\n  { HOST character-literal\n  | DATABASE character-literal\n  | USER character-literal\n  | PASSWORD character-literal\n  | SOCKET character-literal\n  | OWNER character-literal\n  | PORT numeric-literal }\n\nThis statement creates the definition of a server for use with the\nFEDERATED storage engine. The CREATE SERVER statement creates a new row\nin the servers table in the mysql database. This statement requires the\nSUPER privilege.\n\nThe server_name should be a unique reference to the server. Server\ndefinitions are global within the scope of the server, it is not\npossible to qualify the server definition to a specific database.\nserver_name has a maximum length of 64 characters (names longer than 64\ncharacters are silently truncated), and is case insensitive. You may\nspecify the name as a quoted string.\n\nThe wrapper_name should be mysql, and may be quoted with single\nquotation marks. Other values for wrapper_name are not currently\nsupported.\n\nFor each option you must specify either a character literal or numeric\nliteral. Character literals are UTF-8, support a maximum length of 64\ncharacters and default to a blank (empty) string. String literals are\nsilently truncated to 64 characters. Numeric literals must be a number\nbetween 0 and 9999, default value is 0.\n\n*Note*: The OWNER option is currently not applied, and has no effect on\nthe ownership or operation of the server connection that is created.\n\nThe CREATE SERVER statement creates an entry in the mysql.servers table\nthat can later be used with the CREATE TABLE statement when creating a\nFEDERATED table. The options that you specify will be used to populate\nthe columns in the mysql.servers table. The table columns are\nServer_name, Host, Db, Username, Password, Port and Socket.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/create-server.html\n\n','CREATE SERVER s\nFOREIGN DATA WRAPPER mysql\nOPTIONS (USER \'Remote\', HOST \'192.168.1.106\', DATABASE \'test\');\n','http://dev.mysql.com/doc/refman/5.1/en/create-server.html'),(476,'FIELD',38,'Syntax:\nFIELD(str,str1,str2,str3,...)\n\nReturns the index (position) of str in the str1, str2, str3, ... list.\nReturns 0 if str is not found.\n\nIf all arguments to FIELD() are strings, all arguments are compared as\nstrings. If all arguments are numbers, they are compared as numbers.\nOtherwise, the arguments are compared as double.\n\nIf str is NULL, the return value is 0 because NULL fails equality\ncomparison with any value. FIELD() is the complement of ELT().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT FIELD(\'ej\', \'Hej\', \'ej\', \'Heja\', \'hej\', \'foo\');\n        -> 2\nmysql> SELECT FIELD(\'fo\', \'Hej\', \'ej\', \'Heja\', \'hej\', \'foo\');\n        -> 0\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(477,'MAKETIME',32,'Syntax:\nMAKETIME(hour,minute,second)\n\nReturns a time value calculated from the hour, minute, and second\narguments.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT MAKETIME(12,15,30);\n        -> \'12:15:30\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(478,'CURDATE',32,'Syntax:\nCURDATE()\n\nReturns the current date as a value in \'YYYY-MM-DD\' or YYYYMMDD format,\ndepending on whether the function is used in a string or numeric\ncontext.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT CURDATE();\n        -> \'2008-06-13\'\nmysql> SELECT CURDATE() + 0;\n        -> 20080613\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(479,'SET PASSWORD',10,'Syntax:\nSET PASSWORD [FOR user] =\n    {\n        PASSWORD(\'cleartext password\')\n      | OLD_PASSWORD(\'cleartext password\')\n      | \'encrypted password\'\n    }\n\nThe SET PASSWORD statement assigns a password to an existing MySQL user\naccount. In MySQL 5.1 and later, when the read_only system variable is\nenabled, the SUPER privilege is required to use SET PASSWORD, in\naddition to whatever other privileges might be required.\n\nIf the password is specified using the PASSWORD() or OLD_PASSWORD()\nfunction, the cleartext (unencrypted) password should be given as the\nargument to the function, which hashes the password and returns the\nencrypted password string. If the password is specified without using\neither function, it should be the already encrypted password value as a\nliteral string. In all cases, the encrypted password string must be in\nthe format required by the authentication method used for the account.\n\nWith no FOR user clause, this statement sets the password for the\ncurrent user. (To see which account the server authenticated you as,\ninvoke the CURRENT_USER() function.) Any client who successfully\nconnects to the server using a nonanonymous account can change the\npassword for that account.\n\nWith a FOR user clause, this statement sets the password for the named\nuser. You must have the UPDATE privilege for the mysql database to do\nthis. The user account name uses the format described in\nhttp://dev.mysql.com/doc/refman/5.1/en/account-names.html. The user\nvalue should be given as \'user_name\'@\'host_name\', where \'user_name\' and\n\'host_name\' are exactly as listed in the User and Host columns of the\nmysql.user table row. (If you specify only a user name, a host name of\n\'%\' is used.) For example, to set the password for an account with User\nand Host column values of \'bob\' and \'%.example.org\', write the\nstatement like this:\n\nSET PASSWORD FOR \'bob\'@\'%.example.org\' = PASSWORD(\'cleartext password\');\n\nThat is equivalent to the following statements:\n\nUPDATE mysql.user SET Password=PASSWORD(\'cleartext password\')\n  WHERE User=\'bob\' AND Host=\'%.example.org\';\nFLUSH PRIVILEGES;\n\nAnother way to set the password is to use GRANT:\n\nGRANT USAGE ON *.* TO \'bob\'@\'%.example.org\' IDENTIFIED BY \'cleartext password\';\n\nThe old_passwords system variable value determines the hashing method\nused by PASSWORD(). If you specify the password using that function and\nSET PASSWORD rejects the password as not being in the correct format,\nit may be necessary to set old_passwords to change the hashing method.\nFor descriptions of the permitted values, see\nhttp://dev.mysql.com/doc/refman/5.1/en/server-system-variables.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/set-password.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/set-password.html'),(480,'ALTER TABLESPACE',40,'Syntax:\nALTER TABLESPACE tablespace_name\n    {ADD|DROP} DATAFILE \'file_name\'\n    [INITIAL_SIZE [=] size]\n    [WAIT]\n    ENGINE [=] engine_name\n\nThis statement can be used either to add a new data file, or to drop a\ndata file from a tablespace.\n\nThe ADD DATAFILE variant enables you to specify an initial size using\nan INITIAL_SIZE clause, where size is measured in bytes; the default\nvalue is 128M (128 megabytes). You may optionally follow this integer\nvalue with a one-letter abbreviation for an order of magnitude, similar\nto those used in my.cnf. Generally, this is one of the letters M (for\nmegabytes) or G (for gigabytes).\n\n*Note*: All MySQL Cluster Disk Data objects share the same namespace.\nThis means that each Disk Data object must be uniquely named (and not\nmerely each Disk Data object of a given type). For example, you cannot\nhave a tablespace and an data file with the same name, or an undo log\nfile and a with the same name.\n\nPrior to MySQL Cluster NDB 6.2.17, 6.3.23, and 6.4.3, path and file\nnames for data files could not be longer than 128 characters. (Bug\n#31770)\n\nOn 32-bit systems, the maximum supported value for INITIAL_SIZE is 4G.\n(Bug #29186)\n\nINITIAL_SIZE is rounded as for CREATE TABLESPACE. Beginning with MySQL\nCluster NDB 6.2.19, MySQL Cluster NDB 6.3.32, MySQL Cluster NDB 7.0.13,\nand MySQL Cluster NDB 7.1.2, this rounding is done explicitly (also as\nwith CREATE TABLESPACE).\n\nOnce a data file has been created, its size cannot be changed; however,\nyou can add more data files to the tablespace using additional ALTER\nTABLESPACE ... ADD DATAFILE statements.\n\nUsing DROP DATAFILE with ALTER TABLESPACE drops the data file\n\'file_name\' from the tablespace. You cannot drop a data file from a\ntablespace which is in use by any table; in other words, the data file\nmust be empty (no extents used). See\nhttp://dev.mysql.com/doc/refman/5.1/en/mysql-cluster-disk-data-objects.\nhtml. In addition, any data file to be dropped must previously have\nbeen added to the tablespace with CREATE TABLESPACE or ALTER\nTABLESPACE.\n\nBoth ALTER TABLESPACE ... ADD DATAFILE and ALTER TABLESPACE ... DROP\nDATAFILE require an ENGINE clause which specifies the storage engine\nused by the tablespace. In MySQL 5.1, the only accepted values for\nengine_name are NDB and NDBCLUSTER.\n\nWAIT is parsed but otherwise ignored, and so has no effect in MySQL\n5.1. It is intended for future expansion.\n\nWhen ALTER TABLESPACE ... ADD DATAFILE is used with ENGINE = NDB, a\ndata file is created on each Cluster data node. You can verify that the\ndata files were created and obtain information about them by querying\nthe INFORMATION_SCHEMA.FILES table. For example, the following query\nshows all data files belonging to the tablespace named newts:\n\nmysql> SELECT LOGFILE_GROUP_NAME, FILE_NAME, EXTRA\n    -> FROM INFORMATION_SCHEMA.FILES\n    -> WHERE TABLESPACE_NAME = \'newts\' AND FILE_TYPE = \'DATAFILE\';\n+--------------------+--------------+----------------+\n| LOGFILE_GROUP_NAME | FILE_NAME    | EXTRA          |\n+--------------------+--------------+----------------+\n| lg_3               | newdata.dat  | CLUSTER_NODE=3 |\n| lg_3               | newdata.dat  | CLUSTER_NODE=4 |\n| lg_3               | newdata2.dat | CLUSTER_NODE=3 |\n| lg_3               | newdata2.dat | CLUSTER_NODE=4 |\n+--------------------+--------------+----------------+\n2 rows in set (0.03 sec)\n\nSee http://dev.mysql.com/doc/refman/5.1/en/files-table.html.\n\nALTER TABLESPACE was added in MySQL 5.1.6. In MySQL 5.1, it is useful\nonly with Disk Data storage for MySQL Cluster. See\nhttp://dev.mysql.com/doc/refman/5.1/en/mysql-cluster-disk-data.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/alter-tablespace.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/alter-tablespace.html'),(481,'IF FUNCTION',7,'Syntax:\nIF(expr1,expr2,expr3)\n\nIf expr1 is TRUE (expr1 <> 0 and expr1 <> NULL) then IF() returns\nexpr2; otherwise it returns expr3. IF() returns a numeric or string\nvalue, depending on the context in which it is used.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/control-flow-functions.html\n\n','mysql> SELECT IF(1>2,2,3);\n        -> 3\nmysql> SELECT IF(1<2,\'yes\',\'no\');\n        -> \'yes\'\nmysql> SELECT IF(STRCMP(\'test\',\'test1\'),\'no\',\'yes\');\n        -> \'no\'\n','http://dev.mysql.com/doc/refman/5.1/en/control-flow-functions.html'),(482,'ENUM',23,'ENUM(\'value1\',\'value2\',...) [CHARACTER SET charset_name] [COLLATE\ncollation_name]\n\nAn enumeration. A string object that can have only one value, chosen\nfrom the list of values \'value1\', \'value2\', ..., NULL or the special \'\'\nerror value. ENUM values are represented internally as integers.\n\nAn ENUM column can have a maximum of 65,535 distinct elements. (The\npractical limit is less than 3000.) A table can have no more than 255\nunique element list definitions among its ENUM and SET columns\nconsidered as a group. For more information on these limits, see\nhttp://dev.mysql.com/doc/refman/5.1/en/limits-frm-file.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(483,'DATABASE',17,'Syntax:\nDATABASE()\n\nReturns the default (current) database name as a string in the utf8\ncharacter set. If there is no default database, DATABASE() returns\nNULL. Within a stored routine, the default database is the database\nthat the routine is associated with, which is not necessarily the same\nas the database that is the default in the calling context.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> SELECT DATABASE();\n        -> \'test\'\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(484,'POINTFROMWKB',33,'PointFromWKB(wkb[,srid])\n\nConstructs a POINT value using its WKB representation and SRID.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/creating-spatial-values.html'),(485,'POWER',4,'Syntax:\nPOWER(X,Y)\n\nThis is a synonym for POW().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(486,'ATAN',4,'Syntax:\nATAN(X)\n\nReturns the arc tangent of X, that is, the value whose tangent is X.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT ATAN(2);\n        -> 1.1071487177941\nmysql> SELECT ATAN(-2);\n        -> -1.1071487177941\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(487,'STRCMP',38,'Syntax:\nSTRCMP(expr1,expr2)\n\nSTRCMP() returns 0 if the strings are the same, -1 if the first\nargument is smaller than the second according to the current sort\norder, and 1 otherwise.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-comparison-functions.html\n\n','mysql> SELECT STRCMP(\'text\', \'text2\');\n        -> -1\nmysql> SELECT STRCMP(\'text2\', \'text\');\n        -> 1\nmysql> SELECT STRCMP(\'text\', \'text\');\n        -> 0\n','http://dev.mysql.com/doc/refman/5.1/en/string-comparison-functions.html'),(488,'INSERT DELAYED',28,'Syntax:\nINSERT DELAYED ...\n\nThe DELAYED option for the INSERT statement is a MySQL extension to\nstandard SQL that is very useful if you have clients that cannot or\nneed not wait for the INSERT to complete. This is a common situation\nwhen you use MySQL for logging and you also periodically run SELECT and\nUPDATE statements that take a long time to complete.\n\nWhen a client uses INSERT DELAYED, it gets an okay from the server at\nonce, and the row is queued to be inserted when the table is not in use\nby any other thread.\n\nAnother major benefit of using INSERT DELAYED is that inserts from many\nclients are bundled together and written in one block. This is much\nfaster than performing many separate inserts.\n\nNote that INSERT DELAYED is slower than a normal INSERT if the table is\nnot otherwise in use. There is also the additional overhead for the\nserver to handle a separate thread for each table for which there are\ndelayed rows. This means that you should use INSERT DELAYED only when\nyou are really sure that you need it.\n\nThe queued rows are held only in memory until they are inserted into\nthe table. This means that if you terminate mysqld forcibly (for\nexample, with kill -9) or if mysqld dies unexpectedly, any queued rows\nthat have not been written to disk are lost.\n\nThere are some constraints on the use of DELAYED:\n\no INSERT DELAYED works only with MyISAM, MEMORY, ARCHIVE, and (as of\n  MySQL 5.1.19) BLACKHOLE tables. For engines that do not support\n  DELAYED, an error occurs.\n\no An error occurs for INSERT DELAYED if used with a table that has been\n  locked with LOCK TABLES because the insert must be handled by a\n  separate thread, not by the session that holds the lock.\n\no For MyISAM tables, if there are no free blocks in the middle of the\n  data file, concurrent SELECT and INSERT statements are supported.\n  Under these circumstances, you very seldom need to use INSERT DELAYED\n  with MyISAM.\n\no INSERT DELAYED should be used only for INSERT statements that specify\n  value lists. The server ignores DELAYED for INSERT ... SELECT or\n  INSERT ... ON DUPLICATE KEY UPDATE statements.\n\no Because the INSERT DELAYED statement returns immediately, before the\n  rows are inserted, you cannot use LAST_INSERT_ID() to get the\n  AUTO_INCREMENT value that the statement might generate.\n\no DELAYED rows are not visible to SELECT statements until they actually\n  have been inserted.\n\no INSERT DELAYED is treated as a normal INSERT if the statement inserts\n  multiple rows and binary logging is enabled and the global logging\n  format is to use statement-based logging (binlog_format is set to\n  STATEMENT). This restriction does not apply to row-based binary\n  logging.\n\no DELAYED is ignored on slave replication servers, so that INSERT\n  DELAYED is treated as a normal INSERT on slaves. This is because\n  DELAYED could cause the slave to have different data than the master.\n\no Pending INSERT DELAYED statements are lost if a table is write locked\n  and ALTER TABLE is used to modify the table structure.\n\no INSERT DELAYED is not supported for views.\n\no INSERT DELAYED is not supported for partitioned tables.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/insert-delayed.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/insert-delayed.html'),(489,'SHOW PROFILE',27,'Syntax:\nSHOW PROFILE [type [, type] ... ]\n    [FOR QUERY n]\n    [LIMIT row_count [OFFSET offset]]\n\ntype:\n    ALL\n  | BLOCK IO\n  | CONTEXT SWITCHES\n  | CPU\n  | IPC\n  | MEMORY\n  | PAGE FAULTS\n  | SOURCE\n  | SWAPS\n\nThe SHOW PROFILE and SHOW PROFILES statements display profiling\ninformation that indicates resource usage for statements executed\nduring the course of the current session.\n\nProfiling is controlled by the profiling session variable, which has a\ndefault value of 0 (OFF). Profiling is enabled by setting profiling to\n1 or ON:\n\nmysql> SET profiling = 1;\n\nSHOW PROFILES displays a list of the most recent statements sent to the\nserver. The size of the list is controlled by the\nprofiling_history_size session variable, which has a default value of\n15. The maximum value is 100. Setting the value to 0 has the practical\neffect of disabling profiling.\n\nAll statements are profiled except SHOW PROFILE and SHOW PROFILES, so\nyou will find neither of those statements in the profile list.\nMalformed statements are profiled. For example, SHOW PROFILING is an\nillegal statement, and a syntax error occurs if you try to execute it,\nbut it will show up in the profiling list.\n\nSHOW PROFILE displays detailed information about a single statement.\nWithout the FOR QUERY n clause, the output pertains to the most\nrecently executed statement. If FOR QUERY n is included, SHOW PROFILE\ndisplays information for statement n. The values of n correspond to the\nQuery_ID values displayed by SHOW PROFILES.\n\nThe LIMIT row_count clause may be given to limit the output to\nrow_count rows. If LIMIT is given, OFFSET offset may be added to begin\nthe output offset rows into the full set of rows.\n\nBy default, SHOW PROFILE displays Status and Duration columns. The\nStatus values are like the State values displayed by SHOW PROCESSLIST,\nalthough there might be some minor differences in interpretion for the\ntwo statements for some status values (see\nhttp://dev.mysql.com/doc/refman/5.1/en/thread-information.html).\n\nOptional type values may be specified to display specific additional\ntypes of information:\n\no ALL displays all information\n\no BLOCK IO displays counts for block input and output operations\n\no CONTEXT SWITCHES displays counts for voluntary and involuntary\n  context switches\n\no CPU displays user and system CPU usage times\n\no IPC displays counts for messages sent and received\n\no MEMORY is not currently implemented\n\no PAGE FAULTS displays counts for major and minor page faults\n\no SOURCE displays the names of functions from the source code, together\n  with the name and line number of the file in which the function\n  occurs\n\no SWAPS displays swap counts\n\nProfiling is enabled per session. When a session ends, its profiling\ninformation is lost.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-profile.html\n\n','mysql> SELECT @@profiling;\n+-------------+\n| @@profiling |\n+-------------+\n|           0 |\n+-------------+\n1 row in set (0.00 sec)\n\nmysql> SET profiling = 1;\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> DROP TABLE IF EXISTS t1;\nQuery OK, 0 rows affected, 1 warning (0.00 sec)\n\nmysql> CREATE TABLE T1 (id INT);\nQuery OK, 0 rows affected (0.01 sec)\n\nmysql> SHOW PROFILES;\n+----------+----------+--------------------------+\n| Query_ID | Duration | Query                    |\n+----------+----------+--------------------------+\n|        0 | 0.000088 | SET PROFILING = 1        |\n|        1 | 0.000136 | DROP TABLE IF EXISTS t1  |\n|        2 | 0.011947 | CREATE TABLE t1 (id INT) |\n+----------+----------+--------------------------+\n3 rows in set (0.00 sec)\n\nmysql> SHOW PROFILE;\n+----------------------+----------+\n| Status               | Duration |\n+----------------------+----------+\n| checking permissions | 0.000040 |\n| creating table       | 0.000056 |\n| After create         | 0.011363 |\n| query end            | 0.000375 |\n| freeing items        | 0.000089 |\n| logging slow query   | 0.000019 |\n| cleaning up          | 0.000005 |\n+----------------------+----------+\n7 rows in set (0.00 sec)\n\nmysql> SHOW PROFILE FOR QUERY 1;\n+--------------------+----------+\n| Status             | Duration |\n+--------------------+----------+\n| query end          | 0.000107 |\n| freeing items      | 0.000008 |\n| logging slow query | 0.000015 |\n| cleaning up        | 0.000006 |\n+--------------------+----------+\n4 rows in set (0.00 sec)\n\nmysql> SHOW PROFILE CPU FOR QUERY 2;\n+----------------------+----------+----------+------------+\n| Status               | Duration | CPU_user | CPU_system |\n+----------------------+----------+----------+------------+\n| checking permissions | 0.000040 | 0.000038 |   0.000002 |\n| creating table       | 0.000056 | 0.000028 |   0.000028 |\n| After create         | 0.011363 | 0.000217 |   0.001571 |\n| query end            | 0.000375 | 0.000013 |   0.000028 |\n| freeing items        | 0.000089 | 0.000010 |   0.000014 |\n| logging slow query   | 0.000019 | 0.000009 |   0.000010 |\n| cleaning up          | 0.000005 | 0.000003 |   0.000002 |\n+----------------------+----------+----------+------------+\n7 rows in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.1/en/show-profile.html'),(490,'SHOW PROCEDURE CODE',27,'Syntax:\nSHOW PROCEDURE CODE proc_name\n\nThis statement is a MySQL extension that is available only for servers\nthat have been built with debugging support. It displays a\nrepresentation of the internal implementation of the named stored\nprocedure. A similar statement, SHOW FUNCTION CODE, displays\ninformation about stored functions (see [HELP SHOW FUNCTION CODE]).\n\nBoth statements require that you be the owner of the routine or have\nSELECT access to the mysql.proc table.\n\nIf the named routine is available, each statement produces a result\nset. Each row in the result set corresponds to one \"instruction\" in the\nroutine. The first column is Pos, which is an ordinal number beginning\nwith 0. The second column is Instruction, which contains an SQL\nstatement (usually changed from the original source), or a directive\nwhich has meaning only to the stored-routine handler.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-procedure-code.html\n\n','mysql> DELIMITER //\nmysql> CREATE PROCEDURE p1 ()\n    -> BEGIN\n    ->   DECLARE fanta INT DEFAULT 55;\n    ->   DROP TABLE t2;\n    ->   LOOP\n    ->     INSERT INTO t3 VALUES (fanta);\n    ->     END LOOP;\n    ->   END//\nQuery OK, 0 rows affected (0.00 sec)\n\nmysql> SHOW PROCEDURE CODE p1//\n+-----+----------------------------------------+\n| Pos | Instruction                            |\n+-----+----------------------------------------+\n|   0 | set fanta@0 55                         |\n|   1 | stmt 9 \"DROP TABLE t2\"                 |\n|   2 | stmt 5 \"INSERT INTO t3 VALUES (fanta)\" |\n|   3 | jump 2                                 |\n+-----+----------------------------------------+\n4 rows in set (0.00 sec)\n','http://dev.mysql.com/doc/refman/5.1/en/show-procedure-code.html'),(491,'MEDIUMTEXT',23,'MEDIUMTEXT [CHARACTER SET charset_name] [COLLATE collation_name]\n\nA TEXT column with a maximum length of 16,777,215 (224 - 1) characters.\nThe effective maximum length is less if the value contains multi-byte\ncharacters. Each MEDIUMTEXT value is stored using a 3-byte length\nprefix that indicates the number of bytes in the value.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/string-type-overview.html'),(492,'LN',4,'Syntax:\nLN(X)\n\nReturns the natural logarithm of X; that is, the base-e logarithm of X.\nIf X is less than or equal to 0, then NULL is returned.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT LN(2);\n        -> 0.69314718055995\nmysql> SELECT LN(-2);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(493,'RETURN',24,'Syntax:\nRETURN expr\n\nThe RETURN statement terminates execution of a stored function and\nreturns the value expr to the function caller. There must be at least\none RETURN statement in a stored function. There may be more than one\nif the function has multiple exit points.\n\nThis statement is not used in stored procedures, triggers, or events.\nThe LEAVE statement can be used to exit a stored program of those\ntypes.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/return.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/return.html'),(494,'SHOW COLLATION',27,'Syntax:\nSHOW COLLATION\n    [LIKE \'pattern\' | WHERE expr]\n\nThis statement lists collations supported by the server. By default,\nthe output from SHOW COLLATION includes all available collations. The\nLIKE clause, if present, indicates which collation names to match. The\nWHERE clause can be given to select rows using more general conditions,\nas discussed in\nhttp://dev.mysql.com/doc/refman/5.1/en/extended-show.html. For example:\n\nmysql> SHOW COLLATION LIKE \'latin1%\';\n+-------------------+---------+----+---------+----------+---------+\n| Collation         | Charset | Id | Default | Compiled | Sortlen |\n+-------------------+---------+----+---------+----------+---------+\n| latin1_german1_ci | latin1  |  5 |         |          |       0 |\n| latin1_swedish_ci | latin1  |  8 | Yes     | Yes      |       0 |\n| latin1_danish_ci  | latin1  | 15 |         |          |       0 |\n| latin1_german2_ci | latin1  | 31 |         | Yes      |       2 |\n| latin1_bin        | latin1  | 47 |         | Yes      |       0 |\n| latin1_general_ci | latin1  | 48 |         |          |       0 |\n| latin1_general_cs | latin1  | 49 |         |          |       0 |\n| latin1_spanish_ci | latin1  | 94 |         |          |       0 |\n+-------------------+---------+----+---------+----------+---------+\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/show-collation.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/show-collation.html'),(495,'LOG',4,'Syntax:\nLOG(X), LOG(B,X)\n\nIf called with one parameter, this function returns the natural\nlogarithm of X. If X is less than or equal to 0, then NULL is returned.\n\nThe inverse of this function (when called with a single argument) is\nthe EXP() function.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT LOG(2);\n        -> 0.69314718055995\nmysql> SELECT LOG(-2);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(496,'SET SQL_LOG_BIN',8,'Syntax:\nSET sql_log_bin = {0|1}\n\nDisables or enables binary logging for the current session (sql_log_bin\nis a session variable) if the client has the SUPER privilege. The\nstatement fails with an error if the client does not have that\nprivilege.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/set-sql-log-bin.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/set-sql-log-bin.html'),(497,'!=',19,'Syntax:\n<>, !=\n\nNot equal:\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT \'.01\' <> \'0.01\';\n        -> 1\nmysql> SELECT .01 <> \'0.01\';\n        -> 0\nmysql> SELECT \'zapp\' <> \'zappp\';\n        -> 1\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(498,'WHILE',24,'Syntax:\n[begin_label:] WHILE search_condition DO\n    statement_list\nEND WHILE [end_label]\n\nThe statement list within a WHILE statement is repeated as long as the\nsearch_condition expression is true. statement_list consists of one or\nmore SQL statements, each terminated by a semicolon (;) statement\ndelimiter.\n\nA WHILE statement can be labeled. For the rules regarding label use,\nsee [HELP labels].\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/while.html\n\n','CREATE PROCEDURE dowhile()\nBEGIN\n  DECLARE v1 INT DEFAULT 5;\n\n  WHILE v1 > 0 DO\n    ...\n    SET v1 = v1 - 1;\n  END WHILE;\nEND;\n','http://dev.mysql.com/doc/refman/5.1/en/while.html'),(499,'AES_DECRYPT',12,'Syntax:\nAES_DECRYPT(crypt_str,key_str)\n\nThis function decrypts data using the official AES (Advanced Encryption\nStandard) algorithm. For more information, see the description of\nAES_ENCRYPT().\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/encryption-functions.html'),(500,'DAYNAME',32,'Syntax:\nDAYNAME(date)\n\nReturns the name of the weekday for date. As of MySQL 5.1.12, the\nlanguage used for the name is controlled by the value of the\nlc_time_names system variable\n(http://dev.mysql.com/doc/refman/5.1/en/locale-support.html).\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html\n\n','mysql> SELECT DAYNAME(\'2007-02-03\');\n        -> \'Saturday\'\n','http://dev.mysql.com/doc/refman/5.1/en/date-and-time-functions.html'),(501,'COERCIBILITY',17,'Syntax:\nCOERCIBILITY(str)\n\nReturns the collation coercibility value of the string argument.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> SELECT COERCIBILITY(\'abc\' COLLATE latin1_swedish_ci);\n        -> 0\nmysql> SELECT COERCIBILITY(USER());\n        -> 3\nmysql> SELECT COERCIBILITY(\'abc\');\n        -> 4\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(502,'INT',23,'INT[(M)] [UNSIGNED] [ZEROFILL]\n\nA normal-size integer. The signed range is -2147483648 to 2147483647.\nThe unsigned range is 0 to 4294967295.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html\n\n','','http://dev.mysql.com/doc/refman/5.1/en/numeric-type-overview.html'),(503,'GLENGTH',13,'GLength(ls)\n\nReturns as a double-precision number the length of the LineString value\nls in its associated spatial reference.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html\n\n','mysql> SET @ls = \'LineString(1 1,2 2,3 3)\';\nmysql> SELECT GLength(GeomFromText(@ls));\n+----------------------------+\n| GLength(GeomFromText(@ls)) |\n+----------------------------+\n|            2.8284271247462 |\n+----------------------------+\n','http://dev.mysql.com/doc/refman/5.1/en/geometry-property-functions.html'),(504,'RADIANS',4,'Syntax:\nRADIANS(X)\n\nReturns the argument X, converted from degrees to radians. (Note that\nπ radians equals 180 degrees.)\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html\n\n','mysql> SELECT RADIANS(90);\n        -> 1.5707963267949\n','http://dev.mysql.com/doc/refman/5.1/en/mathematical-functions.html'),(505,'COLLATION',17,'Syntax:\nCOLLATION(str)\n\nReturns the collation of the string argument.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> SELECT COLLATION(\'abc\');\n        -> \'latin1_swedish_ci\'\nmysql> SELECT COLLATION(_utf8\'abc\');\n        -> \'utf8_general_ci\'\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(506,'COALESCE',19,'Syntax:\nCOALESCE(value,...)\n\nReturns the first non-NULL value in the list, or NULL if there are no\nnon-NULL values.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html\n\n','mysql> SELECT COALESCE(NULL,1);\n        -> 1\nmysql> SELECT COALESCE(NULL,NULL,NULL);\n        -> NULL\n','http://dev.mysql.com/doc/refman/5.1/en/comparison-operators.html'),(507,'VERSION',17,'Syntax:\nVERSION()\n\nReturns a string that indicates the MySQL server version. The string\nuses the utf8 character set. The value might have a suffix in addition\nto the version number. See the description of the version system\nvariable in\nhttp://dev.mysql.com/doc/refman/5.1/en/server-system-variables.html.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/information-functions.html\n\n','mysql> SELECT VERSION();\n        -> \'5.1.74-standard\'\n','http://dev.mysql.com/doc/refman/5.1/en/information-functions.html'),(508,'MAKE_SET',38,'Syntax:\nMAKE_SET(bits,str1,str2,...)\n\nReturns a set value (a string containing substrings separated by \",\"\ncharacters) consisting of the strings that have the corresponding bit\nin bits set. str1 corresponds to bit 0, str2 to bit 1, and so on. NULL\nvalues in str1, str2, ... are not appended to the result.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT MAKE_SET(1,\'a\',\'b\',\'c\');\n        -> \'a\'\nmysql> SELECT MAKE_SET(1 | 4,\'hello\',\'nice\',\'world\');\n        -> \'hello,world\'\nmysql> SELECT MAKE_SET(1 | 4,\'hello\',\'nice\',NULL,\'world\');\n        -> \'hello\'\nmysql> SELECT MAKE_SET(0,\'a\',\'b\',\'c\');\n        -> \'\'\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html'),(509,'FIND_IN_SET',38,'Syntax:\nFIND_IN_SET(str,strlist)\n\nReturns a value in the range of 1 to N if the string str is in the\nstring list strlist consisting of N substrings. A string list is a\nstring composed of substrings separated by \",\" characters. If the first\nargument is a constant string and the second is a column of type SET,\nthe FIND_IN_SET() function is optimized to use bit arithmetic. Returns\n0 if str is not in strlist or if strlist is the empty string. Returns\nNULL if either argument is NULL. This function does not work properly\nif the first argument contains a comma (\",\") character.\n\nURL: http://dev.mysql.com/doc/refman/5.1/en/string-functions.html\n\n','mysql> SELECT FIND_IN_SET(\'b\',\'a,b,c,d\');\n        -> 2\n','http://dev.mysql.com/doc/refman/5.1/en/string-functions.html');
/*!40000 ALTER TABLE `help_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Host`,`Db`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Host privileges;  Merged with database privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host`
--

LOCK TABLES `host` WRITE;
/*!40000 ALTER TABLE `host` DISABLE KEYS */;
/*!40000 ALTER TABLE `host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ndb_binlog_index`
--

DROP TABLE IF EXISTS `ndb_binlog_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ndb_binlog_index` (
  `Position` bigint(20) unsigned NOT NULL,
  `File` varchar(255) NOT NULL,
  `epoch` bigint(20) unsigned NOT NULL,
  `inserts` bigint(20) unsigned NOT NULL,
  `updates` bigint(20) unsigned NOT NULL,
  `deletes` bigint(20) unsigned NOT NULL,
  `schemaops` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`epoch`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ndb_binlog_index`
--

LOCK TABLES `ndb_binlog_index` WRITE;
/*!40000 ALTER TABLE `ndb_binlog_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `ndb_binlog_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin` (
  `name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `dl` char(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='MySQL plugins';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin`
--

LOCK TABLES `plugin` WRITE;
/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proc`
--

DROP TABLE IF EXISTS `proc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proc` (
  `db` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` char(64) NOT NULL DEFAULT '',
  `type` enum('FUNCTION','PROCEDURE') NOT NULL,
  `specific_name` char(64) NOT NULL DEFAULT '',
  `language` enum('SQL') NOT NULL DEFAULT 'SQL',
  `sql_data_access` enum('CONTAINS_SQL','NO_SQL','READS_SQL_DATA','MODIFIES_SQL_DATA') NOT NULL DEFAULT 'CONTAINS_SQL',
  `is_deterministic` enum('YES','NO') NOT NULL DEFAULT 'NO',
  `security_type` enum('INVOKER','DEFINER') NOT NULL DEFAULT 'DEFINER',
  `param_list` blob NOT NULL,
  `returns` longblob NOT NULL,
  `body` longblob NOT NULL,
  `definer` char(77) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE','NO_ENGINE_SUBSTITUTION','PAD_CHAR_TO_FULL_LENGTH') NOT NULL DEFAULT '',
  `comment` char(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `character_set_client` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `collation_connection` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `db_collation` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `body_utf8` longblob,
  PRIMARY KEY (`db`,`name`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stored Procedures';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proc`
--

LOCK TABLES `proc` WRITE;
/*!40000 ALTER TABLE `proc` DISABLE KEYS */;
/*!40000 ALTER TABLE `proc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procs_priv`
--

DROP TABLE IF EXISTS `procs_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procs_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Routine_name` char(64) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `Routine_type` enum('FUNCTION','PROCEDURE') COLLATE utf8_bin NOT NULL,
  `Grantor` char(77) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Proc_priv` set('Execute','Alter Routine','Grant') CHARACTER SET utf8 NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Host`,`Db`,`User`,`Routine_name`,`Routine_type`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Procedure privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procs_priv`
--

LOCK TABLES `procs_priv` WRITE;
/*!40000 ALTER TABLE `procs_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `procs_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servers`
--

DROP TABLE IF EXISTS `servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `Server_name` char(64) NOT NULL DEFAULT '',
  `Host` char(64) NOT NULL DEFAULT '',
  `Db` char(64) NOT NULL DEFAULT '',
  `Username` char(64) NOT NULL DEFAULT '',
  `Password` char(64) NOT NULL DEFAULT '',
  `Port` int(4) NOT NULL DEFAULT '0',
  `Socket` char(64) NOT NULL DEFAULT '',
  `Wrapper` char(64) NOT NULL DEFAULT '',
  `Owner` char(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`Server_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='MySQL Foreign Servers table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servers`
--

LOCK TABLES `servers` WRITE;
/*!40000 ALTER TABLE `servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables_priv`
--

DROP TABLE IF EXISTS `tables_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tables_priv` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Db` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Table_name` char(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Grantor` char(77) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Table_priv` set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter','Create View','Show view','Trigger') CHARACTER SET utf8 NOT NULL DEFAULT '',
  `Column_priv` set('Select','Insert','Update','References') CHARACTER SET utf8 NOT NULL DEFAULT '',
  PRIMARY KEY (`Host`,`Db`,`User`,`Table_name`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables_priv`
--

LOCK TABLES `tables_priv` WRITE;
/*!40000 ALTER TABLE `tables_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `tables_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone`
--

DROP TABLE IF EXISTS `time_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone` (
  `Time_zone_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Use_leap_seconds` enum('Y','N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`Time_zone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone`
--

LOCK TABLES `time_zone` WRITE;
/*!40000 ALTER TABLE `time_zone` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_leap_second`
--

DROP TABLE IF EXISTS `time_zone_leap_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_leap_second` (
  `Transition_time` bigint(20) NOT NULL,
  `Correction` int(11) NOT NULL,
  PRIMARY KEY (`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Leap seconds information for time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_leap_second`
--

LOCK TABLES `time_zone_leap_second` WRITE;
/*!40000 ALTER TABLE `time_zone_leap_second` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_leap_second` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_name`
--

DROP TABLE IF EXISTS `time_zone_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_name` (
  `Name` char(64) NOT NULL,
  `Time_zone_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_name`
--

LOCK TABLES `time_zone_name` WRITE;
/*!40000 ALTER TABLE `time_zone_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_transition`
--

DROP TABLE IF EXISTS `time_zone_transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_transition` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_time` bigint(20) NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Time_zone_id`,`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transitions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_transition`
--

LOCK TABLES `time_zone_transition` WRITE;
/*!40000 ALTER TABLE `time_zone_transition` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_transition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_zone_transition_type`
--

DROP TABLE IF EXISTS `time_zone_transition_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_transition_type` (
  `Time_zone_id` int(10) unsigned NOT NULL,
  `Transition_type_id` int(10) unsigned NOT NULL,
  `Offset` int(11) NOT NULL DEFAULT '0',
  `Is_DST` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Abbreviation` char(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`Time_zone_id`,`Transition_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transition types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_zone_transition_type`
--

LOCK TABLES `time_zone_transition_type` WRITE;
/*!40000 ALTER TABLE `time_zone_transition_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_zone_transition_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `Host` char(60) COLLATE utf8_bin NOT NULL DEFAULT '',
  `User` char(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `Password` char(41) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `Select_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Insert_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Update_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Delete_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Drop_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Reload_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Shutdown_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Process_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `File_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Grant_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `References_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Index_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_db_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Super_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_tmp_table_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Lock_tables_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Execute_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Repl_slave_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Repl_client_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Show_view_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Alter_routine_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Create_user_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Event_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `Trigger_priv` enum('N','Y') CHARACTER SET utf8 NOT NULL DEFAULT 'N',
  `ssl_type` enum('','ANY','X509','SPECIFIED') CHARACTER SET utf8 NOT NULL DEFAULT '',
  `ssl_cipher` blob NOT NULL,
  `x509_issuer` blob NOT NULL,
  `x509_subject` blob NOT NULL,
  `max_questions` int(11) unsigned NOT NULL DEFAULT '0',
  `max_updates` int(11) unsigned NOT NULL DEFAULT '0',
  `max_connections` int(11) unsigned NOT NULL DEFAULT '0',
  `max_user_connections` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Host`,`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and global privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('localhost','root','*E74858DB86EBA20BC33D0AECAE8A8108C56B17FA','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0),('127.0.0.1','root','','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0),('openstack-controller','root','*E74858DB86EBA20BC33D0AECAE8A8108C56B17FA','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0),('localhost','nova','*0BE3B501084D35F4C66DD3AC4569EAE5EA738212','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('%','nova','*0BE3B501084D35F4C66DD3AC4569EAE5EA738212','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('localhost','neutron','*2BF1709B510068A2EA039818644ED187BF2A5E94','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('%','neutron','*2BF1709B510068A2EA039818644ED187BF2A5E94','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('localhost','keystone','*936E8F7AB2E21B47F6C9A7E5D9FE14DBA2255E5A','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('%','keystone','*936E8F7AB2E21B47F6C9A7E5D9FE14DBA2255E5A','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('localhost','glance','*CC67CAF178CB9A07D756302E0BBFA3B0165DFD49','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('%','glance','*CC67CAF178CB9A07D756302E0BBFA3B0165DFD49','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('localhost','heat','*A66A61361D3CEE79B12E90931345A1E4BAE1B0B0','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0),('%','heat','*A66A61361D3CEE79B12E90931345A1E4BAE1B0B0','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mysql'
--

--
-- Table structure for table `general_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `general_log` (
  `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_host` mediumtext NOT NULL,
  `thread_id` int(11) NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `command_type` varchar(64) NOT NULL,
  `argument` mediumtext NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='General log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `slow_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `slow_log` (
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_host` mediumtext NOT NULL,
  `query_time` time NOT NULL,
  `lock_time` time NOT NULL,
  `rows_sent` int(11) NOT NULL,
  `rows_examined` int(11) NOT NULL,
  `db` varchar(512) NOT NULL,
  `last_insert_id` int(11) NOT NULL,
  `insert_id` int(11) NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `sql_text` mediumtext NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='Slow log';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `neutron`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `neutron` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `neutron`;

--
-- Table structure for table `agents`
--

DROP TABLE IF EXISTS `agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agents` (
  `id` varchar(36) NOT NULL,
  `agent_type` varchar(255) NOT NULL,
  `binary` varchar(255) NOT NULL,
  `topic` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `started_at` datetime NOT NULL,
  `heartbeat_timestamp` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `configurations` varchar(4095) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_agents0agent_type0host` (`agent_type`,`host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agents`
--

LOCK TABLES `agents` WRITE;
/*!40000 ALTER TABLE `agents` DISABLE KEYS */;
INSERT INTO `agents` VALUES ('5f6bdcd5-52b6-43e7-a24f-fcad25d5d0e7','Open vSwitch agent','neutron-openvswitch-agent','N/A','compute3.novalocal',1,'2016-06-20 15:14:46','2016-06-20 15:14:46','2016-06-20 15:17:46',NULL,'{\"tunnel_types\": [], \"tunneling_ip\": \"\", \"bridge_mappings\": {\"physnet1\": \"br-eth1\"}, \"l2_population\": false, \"devices\": 0}'),('6cac852f-09f2-45d6-ad70-27a923220a85','Open vSwitch agent','neutron-openvswitch-agent','N/A','networking-node.novalocal',1,'2016-06-20 15:14:42','2016-06-20 15:14:42','2016-06-20 15:17:42',NULL,'{\"tunnel_types\": [], \"tunneling_ip\": \"\", \"bridge_mappings\": {}, \"l2_population\": false, \"devices\": 0}'),('948ed60b-2870-4b7e-a27c-9377ff483cd4','DHCP agent','neutron-dhcp-agent','dhcp_agent','networking-node.novalocal',1,'2016-06-20 15:14:42','2016-06-20 15:14:42','2016-06-20 15:17:43',NULL,'{\"subnets\": 0, \"use_namespaces\": true, \"dhcp_lease_duration\": 86400, \"dhcp_driver\": \"neutron.agent.linux.dhcp.Dnsmasq\", \"networks\": 0, \"ports\": 0}'),('9dbf8e38-4df1-436d-bab9-bfe00c4cf8be','Open vSwitch agent','neutron-openvswitch-agent','N/A','compute2.novalocal',1,'2016-06-20 15:14:43','2016-06-20 15:14:43','2016-06-20 15:17:43',NULL,'{\"tunnel_types\": [], \"tunneling_ip\": \"\", \"bridge_mappings\": {\"physnet1\": \"br-eth1\"}, \"l2_population\": false, \"devices\": 0}'),('d090ea6f-c153-4ec6-9cc4-db835a3f0fd9','Metadata agent','neutron-metadata-agent','N/A','networking-node.novalocal',1,'2016-06-20 15:14:52','2016-06-20 15:14:52','2016-06-20 15:17:52',NULL,'{\"nova_metadata_ip\": \"127.0.0.1\", \"nova_metadata_port\": 8775, \"metadata_proxy_socket\": \"/var/lib/neutron/metadata_proxy\"}'),('d51ab7cd-7239-477e-90e3-5539dd9980d6','Open vSwitch agent','neutron-openvswitch-agent','N/A','compute1.novalocal',1,'2016-06-20 15:14:46','2016-06-20 15:14:46','2016-06-20 15:17:46',NULL,'{\"tunnel_types\": [], \"tunneling_ip\": \"\", \"bridge_mappings\": {\"physnet1\": \"br-eth1\"}, \"l2_population\": false, \"devices\": 0}');
/*!40000 ALTER TABLE `agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('5ac1c354a051');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allowedaddresspairs`
--

DROP TABLE IF EXISTS `allowedaddresspairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allowedaddresspairs` (
  `port_id` varchar(36) NOT NULL,
  `mac_address` varchar(32) NOT NULL,
  `ip_address` varchar(64) NOT NULL,
  PRIMARY KEY (`port_id`,`mac_address`,`ip_address`),
  CONSTRAINT `allowedaddresspairs_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allowedaddresspairs`
--

LOCK TABLES `allowedaddresspairs` WRITE;
/*!40000 ALTER TABLE `allowedaddresspairs` DISABLE KEYS */;
/*!40000 ALTER TABLE `allowedaddresspairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arista_provisioned_nets`
--

DROP TABLE IF EXISTS `arista_provisioned_nets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arista_provisioned_nets` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `network_id` varchar(36) DEFAULT NULL,
  `segmentation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arista_provisioned_nets`
--

LOCK TABLES `arista_provisioned_nets` WRITE;
/*!40000 ALTER TABLE `arista_provisioned_nets` DISABLE KEYS */;
/*!40000 ALTER TABLE `arista_provisioned_nets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arista_provisioned_tenants`
--

DROP TABLE IF EXISTS `arista_provisioned_tenants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arista_provisioned_tenants` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arista_provisioned_tenants`
--

LOCK TABLES `arista_provisioned_tenants` WRITE;
/*!40000 ALTER TABLE `arista_provisioned_tenants` DISABLE KEYS */;
/*!40000 ALTER TABLE `arista_provisioned_tenants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arista_provisioned_vms`
--

DROP TABLE IF EXISTS `arista_provisioned_vms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arista_provisioned_vms` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `vm_id` varchar(255) DEFAULT NULL,
  `host_id` varchar(255) DEFAULT NULL,
  `port_id` varchar(36) DEFAULT NULL,
  `network_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arista_provisioned_vms`
--

LOCK TABLES `arista_provisioned_vms` WRITE;
/*!40000 ALTER TABLE `arista_provisioned_vms` DISABLE KEYS */;
/*!40000 ALTER TABLE `arista_provisioned_vms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_csr_identifier_map`
--

DROP TABLE IF EXISTS `cisco_csr_identifier_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_csr_identifier_map` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `ipsec_site_conn_id` varchar(64) NOT NULL,
  `csr_tunnel_id` int(11) NOT NULL,
  `csr_ike_policy_id` int(11) NOT NULL,
  `csr_ipsec_policy_id` int(11) NOT NULL,
  PRIMARY KEY (`ipsec_site_conn_id`),
  CONSTRAINT `cisco_csr_identifier_map_ibfk_1` FOREIGN KEY (`ipsec_site_conn_id`) REFERENCES `ipsec_site_connections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_csr_identifier_map`
--

LOCK TABLES `cisco_csr_identifier_map` WRITE;
/*!40000 ALTER TABLE `cisco_csr_identifier_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_csr_identifier_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_credentials`
--

DROP TABLE IF EXISTS `cisco_ml2_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_credentials` (
  `credential_id` varchar(255) DEFAULT NULL,
  `tenant_id` varchar(255) NOT NULL,
  `credential_name` varchar(255) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tenant_id`,`credential_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_credentials`
--

LOCK TABLES `cisco_ml2_credentials` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_nexusport_bindings`
--

DROP TABLE IF EXISTS `cisco_ml2_nexusport_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_nexusport_bindings` (
  `binding_id` int(11) NOT NULL AUTO_INCREMENT,
  `port_id` varchar(255) DEFAULT NULL,
  `vlan_id` int(11) NOT NULL,
  `switch_ip` varchar(255) DEFAULT NULL,
  `instance_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`binding_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_nexusport_bindings`
--

LOCK TABLES `cisco_ml2_nexusport_bindings` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_nexusport_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_nexusport_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consistencyhashes`
--

DROP TABLE IF EXISTS `consistencyhashes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consistencyhashes` (
  `hash_id` varchar(255) NOT NULL,
  `hash` varchar(255) NOT NULL,
  PRIMARY KEY (`hash_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consistencyhashes`
--

LOCK TABLES `consistencyhashes` WRITE;
/*!40000 ALTER TABLE `consistencyhashes` DISABLE KEYS */;
/*!40000 ALTER TABLE `consistencyhashes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dnsnameservers`
--

DROP TABLE IF EXISTS `dnsnameservers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dnsnameservers` (
  `address` varchar(128) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  PRIMARY KEY (`address`,`subnet_id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `dnsnameservers_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dnsnameservers`
--

LOCK TABLES `dnsnameservers` WRITE;
/*!40000 ALTER TABLE `dnsnameservers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dnsnameservers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `externalnetworks`
--

DROP TABLE IF EXISTS `externalnetworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `externalnetworks` (
  `network_id` varchar(36) NOT NULL,
  PRIMARY KEY (`network_id`),
  CONSTRAINT `externalnetworks_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `externalnetworks`
--

LOCK TABLES `externalnetworks` WRITE;
/*!40000 ALTER TABLE `externalnetworks` DISABLE KEYS */;
/*!40000 ALTER TABLE `externalnetworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extradhcpopts`
--

DROP TABLE IF EXISTS `extradhcpopts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extradhcpopts` (
  `id` varchar(36) NOT NULL,
  `port_id` varchar(36) NOT NULL,
  `opt_name` varchar(64) NOT NULL,
  `opt_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_portid_optname` (`port_id`,`opt_name`),
  CONSTRAINT `extradhcpopts_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extradhcpopts`
--

LOCK TABLES `extradhcpopts` WRITE;
/*!40000 ALTER TABLE `extradhcpopts` DISABLE KEYS */;
/*!40000 ALTER TABLE `extradhcpopts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firewall_policies`
--

DROP TABLE IF EXISTS `firewall_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firewall_policies` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `audited` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firewall_policies`
--

LOCK TABLES `firewall_policies` WRITE;
/*!40000 ALTER TABLE `firewall_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `firewall_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firewall_rules`
--

DROP TABLE IF EXISTS `firewall_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firewall_rules` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `firewall_policy_id` varchar(36) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `protocol` varchar(24) DEFAULT NULL,
  `ip_version` int(11) NOT NULL,
  `source_ip_address` varchar(46) DEFAULT NULL,
  `destination_ip_address` varchar(46) DEFAULT NULL,
  `source_port_range_min` int(11) DEFAULT NULL,
  `source_port_range_max` int(11) DEFAULT NULL,
  `destination_port_range_min` int(11) DEFAULT NULL,
  `destination_port_range_max` int(11) DEFAULT NULL,
  `action` enum('allow','deny') DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `firewall_rules_ibfk_1` (`firewall_policy_id`),
  CONSTRAINT `firewall_rules_ibfk_1` FOREIGN KEY (`firewall_policy_id`) REFERENCES `firewall_policies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firewall_rules`
--

LOCK TABLES `firewall_rules` WRITE;
/*!40000 ALTER TABLE `firewall_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `firewall_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firewalls`
--

DROP TABLE IF EXISTS `firewalls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firewalls` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `admin_state_up` tinyint(1) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `firewall_policy_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `firewalls_ibfk_1` (`firewall_policy_id`),
  CONSTRAINT `firewalls_ibfk_1` FOREIGN KEY (`firewall_policy_id`) REFERENCES `firewall_policies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firewalls`
--

LOCK TABLES `firewalls` WRITE;
/*!40000 ALTER TABLE `firewalls` DISABLE KEYS */;
/*!40000 ALTER TABLE `firewalls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floatingips`
--

DROP TABLE IF EXISTS `floatingips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `floatingips` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `floating_ip_address` varchar(64) NOT NULL,
  `floating_network_id` varchar(36) NOT NULL,
  `floating_port_id` varchar(36) NOT NULL,
  `fixed_port_id` varchar(36) DEFAULT NULL,
  `fixed_ip_address` varchar(64) DEFAULT NULL,
  `router_id` varchar(36) DEFAULT NULL,
  `last_known_router_id` varchar(36) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fixed_port_id` (`fixed_port_id`),
  KEY `floating_port_id` (`floating_port_id`),
  KEY `router_id` (`router_id`),
  CONSTRAINT `floatingips_ibfk_1` FOREIGN KEY (`fixed_port_id`) REFERENCES `ports` (`id`),
  CONSTRAINT `floatingips_ibfk_2` FOREIGN KEY (`floating_port_id`) REFERENCES `ports` (`id`),
  CONSTRAINT `floatingips_ibfk_3` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floatingips`
--

LOCK TABLES `floatingips` WRITE;
/*!40000 ALTER TABLE `floatingips` DISABLE KEYS */;
/*!40000 ALTER TABLE `floatingips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ikepolicies`
--

DROP TABLE IF EXISTS `ikepolicies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ikepolicies` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `auth_algorithm` enum('sha1') NOT NULL,
  `encryption_algorithm` enum('3des','aes-128','aes-256','aes-192') NOT NULL,
  `phase1_negotiation_mode` enum('main') NOT NULL,
  `lifetime_units` enum('seconds','kilobytes') NOT NULL,
  `lifetime_value` int(11) NOT NULL,
  `ike_version` enum('v1','v2') NOT NULL,
  `pfs` enum('group2','group5','group14') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ikepolicies`
--

LOCK TABLES `ikepolicies` WRITE;
/*!40000 ALTER TABLE `ikepolicies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ikepolicies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipallocationpools`
--

DROP TABLE IF EXISTS `ipallocationpools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipallocationpools` (
  `id` varchar(36) NOT NULL,
  `subnet_id` varchar(36) DEFAULT NULL,
  `first_ip` varchar(64) NOT NULL,
  `last_ip` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `ipallocationpools_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipallocationpools`
--

LOCK TABLES `ipallocationpools` WRITE;
/*!40000 ALTER TABLE `ipallocationpools` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipallocationpools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipallocations`
--

DROP TABLE IF EXISTS `ipallocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipallocations` (
  `port_id` varchar(36) DEFAULT NULL,
  `ip_address` varchar(64) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  PRIMARY KEY (`ip_address`,`subnet_id`,`network_id`),
  KEY `network_id` (`network_id`),
  KEY `port_id` (`port_id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `ipallocations_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipallocations_ibfk_2` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipallocations_ibfk_3` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipallocations`
--

LOCK TABLES `ipallocations` WRITE;
/*!40000 ALTER TABLE `ipallocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipallocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipavailabilityranges`
--

DROP TABLE IF EXISTS `ipavailabilityranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipavailabilityranges` (
  `allocation_pool_id` varchar(36) NOT NULL,
  `first_ip` varchar(64) NOT NULL,
  `last_ip` varchar(64) NOT NULL,
  PRIMARY KEY (`allocation_pool_id`,`first_ip`,`last_ip`),
  CONSTRAINT `ipavailabilityranges_ibfk_1` FOREIGN KEY (`allocation_pool_id`) REFERENCES `ipallocationpools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipavailabilityranges`
--

LOCK TABLES `ipavailabilityranges` WRITE;
/*!40000 ALTER TABLE `ipavailabilityranges` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipavailabilityranges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipsec_site_connections`
--

DROP TABLE IF EXISTS `ipsec_site_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipsec_site_connections` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `peer_address` varchar(255) DEFAULT NULL,
  `peer_id` varchar(255) NOT NULL,
  `route_mode` varchar(8) NOT NULL,
  `mtu` int(11) NOT NULL,
  `initiator` enum('bi-directional','response-only') NOT NULL,
  `auth_mode` varchar(16) NOT NULL,
  `psk` varchar(255) NOT NULL,
  `dpd_action` enum('hold','clear','restart','disabled','restart-by-peer') NOT NULL,
  `dpd_interval` int(11) NOT NULL,
  `dpd_timeout` int(11) NOT NULL,
  `status` varchar(16) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `vpnservice_id` varchar(36) NOT NULL,
  `ipsecpolicy_id` varchar(36) NOT NULL,
  `ikepolicy_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ikepolicy_id` (`ikepolicy_id`),
  KEY `ipsecpolicy_id` (`ipsecpolicy_id`),
  KEY `vpnservice_id` (`vpnservice_id`),
  CONSTRAINT `ipsec_site_connections_ibfk_1` FOREIGN KEY (`ikepolicy_id`) REFERENCES `ikepolicies` (`id`),
  CONSTRAINT `ipsec_site_connections_ibfk_2` FOREIGN KEY (`ipsecpolicy_id`) REFERENCES `ipsecpolicies` (`id`),
  CONSTRAINT `ipsec_site_connections_ibfk_3` FOREIGN KEY (`vpnservice_id`) REFERENCES `vpnservices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipsec_site_connections`
--

LOCK TABLES `ipsec_site_connections` WRITE;
/*!40000 ALTER TABLE `ipsec_site_connections` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipsec_site_connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipsecpeercidrs`
--

DROP TABLE IF EXISTS `ipsecpeercidrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipsecpeercidrs` (
  `cidr` varchar(32) NOT NULL,
  `ipsec_site_connection_id` varchar(36) NOT NULL,
  PRIMARY KEY (`cidr`,`ipsec_site_connection_id`),
  KEY `ipsec_site_connection_id` (`ipsec_site_connection_id`),
  CONSTRAINT `ipsecpeercidrs_ibfk_1` FOREIGN KEY (`ipsec_site_connection_id`) REFERENCES `ipsec_site_connections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipsecpeercidrs`
--

LOCK TABLES `ipsecpeercidrs` WRITE;
/*!40000 ALTER TABLE `ipsecpeercidrs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipsecpeercidrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipsecpolicies`
--

DROP TABLE IF EXISTS `ipsecpolicies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipsecpolicies` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `transform_protocol` enum('esp','ah','ah-esp') NOT NULL,
  `auth_algorithm` enum('sha1') NOT NULL,
  `encryption_algorithm` enum('3des','aes-128','aes-256','aes-192') NOT NULL,
  `encapsulation_mode` enum('tunnel','transport') NOT NULL,
  `lifetime_units` enum('seconds','kilobytes') NOT NULL,
  `lifetime_value` int(11) NOT NULL,
  `pfs` enum('group2','group5','group14') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipsecpolicies`
--

LOCK TABLES `ipsecpolicies` WRITE;
/*!40000 ALTER TABLE `ipsecpolicies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipsecpolicies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meteringlabelrules`
--

DROP TABLE IF EXISTS `meteringlabelrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meteringlabelrules` (
  `id` varchar(36) NOT NULL,
  `direction` enum('ingress','egress') DEFAULT NULL,
  `remote_ip_prefix` varchar(64) DEFAULT NULL,
  `metering_label_id` varchar(36) NOT NULL,
  `excluded` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `meteringlabelrules_ibfk_1` (`metering_label_id`),
  CONSTRAINT `meteringlabelrules_ibfk_1` FOREIGN KEY (`metering_label_id`) REFERENCES `meteringlabels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meteringlabelrules`
--

LOCK TABLES `meteringlabelrules` WRITE;
/*!40000 ALTER TABLE `meteringlabelrules` DISABLE KEYS */;
/*!40000 ALTER TABLE `meteringlabelrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meteringlabels`
--

DROP TABLE IF EXISTS `meteringlabels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meteringlabels` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meteringlabels`
--

LOCK TABLES `meteringlabels` WRITE;
/*!40000 ALTER TABLE `meteringlabels` DISABLE KEYS */;
/*!40000 ALTER TABLE `meteringlabels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_brocadenetworks`
--

DROP TABLE IF EXISTS `ml2_brocadenetworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_brocadenetworks` (
  `id` varchar(36) NOT NULL,
  `vlan` varchar(10) DEFAULT NULL,
  `segment_id` varchar(36) DEFAULT NULL,
  `network_type` varchar(10) DEFAULT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_brocadenetworks`
--

LOCK TABLES `ml2_brocadenetworks` WRITE;
/*!40000 ALTER TABLE `ml2_brocadenetworks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_brocadenetworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_brocadeports`
--

DROP TABLE IF EXISTS `ml2_brocadeports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_brocadeports` (
  `id` varchar(36) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  `admin_state_up` tinyint(1) DEFAULT NULL,
  `physical_interface` varchar(36) DEFAULT NULL,
  `vlan_id` varchar(36) DEFAULT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_brocadeports`
--

LOCK TABLES `ml2_brocadeports` WRITE;
/*!40000 ALTER TABLE `ml2_brocadeports` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_brocadeports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_flat_allocations`
--

DROP TABLE IF EXISTS `ml2_flat_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_flat_allocations` (
  `physical_network` varchar(64) NOT NULL,
  PRIMARY KEY (`physical_network`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_flat_allocations`
--

LOCK TABLES `ml2_flat_allocations` WRITE;
/*!40000 ALTER TABLE `ml2_flat_allocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_flat_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_gre_allocations`
--

DROP TABLE IF EXISTS `ml2_gre_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_gre_allocations` (
  `gre_id` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL,
  PRIMARY KEY (`gre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_gre_allocations`
--

LOCK TABLES `ml2_gre_allocations` WRITE;
/*!40000 ALTER TABLE `ml2_gre_allocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_gre_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_gre_endpoints`
--

DROP TABLE IF EXISTS `ml2_gre_endpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_gre_endpoints` (
  `ip_address` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_gre_endpoints`
--

LOCK TABLES `ml2_gre_endpoints` WRITE;
/*!40000 ALTER TABLE `ml2_gre_endpoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_gre_endpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_network_segments`
--

DROP TABLE IF EXISTS `ml2_network_segments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_network_segments` (
  `id` varchar(36) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  `network_type` varchar(32) NOT NULL,
  `physical_network` varchar(64) DEFAULT NULL,
  `segmentation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `network_id` (`network_id`),
  CONSTRAINT `ml2_network_segments_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_network_segments`
--

LOCK TABLES `ml2_network_segments` WRITE;
/*!40000 ALTER TABLE `ml2_network_segments` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_network_segments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_port_bindings`
--

DROP TABLE IF EXISTS `ml2_port_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_port_bindings` (
  `port_id` varchar(36) NOT NULL,
  `host` varchar(255) NOT NULL,
  `vif_type` varchar(64) NOT NULL,
  `driver` varchar(64) DEFAULT NULL,
  `segment` varchar(36) DEFAULT NULL,
  `vnic_type` varchar(64) NOT NULL DEFAULT 'normal',
  `vif_details` varchar(4095) NOT NULL DEFAULT '',
  `profile` varchar(4095) NOT NULL DEFAULT '',
  PRIMARY KEY (`port_id`),
  KEY `segment` (`segment`),
  CONSTRAINT `ml2_port_bindings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ml2_port_bindings_ibfk_2` FOREIGN KEY (`segment`) REFERENCES `ml2_network_segments` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_port_bindings`
--

LOCK TABLES `ml2_port_bindings` WRITE;
/*!40000 ALTER TABLE `ml2_port_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_port_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_vlan_allocations`
--

DROP TABLE IF EXISTS `ml2_vlan_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_vlan_allocations` (
  `physical_network` varchar(64) NOT NULL,
  `vlan_id` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL,
  PRIMARY KEY (`physical_network`,`vlan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_vlan_allocations`
--

LOCK TABLES `ml2_vlan_allocations` WRITE;
/*!40000 ALTER TABLE `ml2_vlan_allocations` DISABLE KEYS */;
INSERT INTO `ml2_vlan_allocations` VALUES ('physnet1',1000,0),('physnet1',1001,0),('physnet1',1002,0),('physnet1',1003,0),('physnet1',1004,0),('physnet1',1005,0),('physnet1',1006,0),('physnet1',1007,0),('physnet1',1008,0),('physnet1',1009,0),('physnet1',1010,0),('physnet1',1011,0),('physnet1',1012,0),('physnet1',1013,0),('physnet1',1014,0),('physnet1',1015,0),('physnet1',1016,0),('physnet1',1017,0),('physnet1',1018,0),('physnet1',1019,0),('physnet1',1020,0),('physnet1',1021,0),('physnet1',1022,0),('physnet1',1023,0),('physnet1',1024,0),('physnet1',1025,0),('physnet1',1026,0),('physnet1',1027,0),('physnet1',1028,0),('physnet1',1029,0),('physnet1',1030,0),('physnet1',1031,0),('physnet1',1032,0),('physnet1',1033,0),('physnet1',1034,0),('physnet1',1035,0),('physnet1',1036,0),('physnet1',1037,0),('physnet1',1038,0),('physnet1',1039,0),('physnet1',1040,0),('physnet1',1041,0),('physnet1',1042,0),('physnet1',1043,0),('physnet1',1044,0),('physnet1',1045,0),('physnet1',1046,0),('physnet1',1047,0),('physnet1',1048,0),('physnet1',1049,0),('physnet1',1050,0),('physnet1',1051,0),('physnet1',1052,0),('physnet1',1053,0),('physnet1',1054,0),('physnet1',1055,0),('physnet1',1056,0),('physnet1',1057,0),('physnet1',1058,0),('physnet1',1059,0),('physnet1',1060,0),('physnet1',1061,0),('physnet1',1062,0),('physnet1',1063,0),('physnet1',1064,0),('physnet1',1065,0),('physnet1',1066,0),('physnet1',1067,0),('physnet1',1068,0),('physnet1',1069,0),('physnet1',1070,0),('physnet1',1071,0),('physnet1',1072,0),('physnet1',1073,0),('physnet1',1074,0),('physnet1',1075,0),('physnet1',1076,0),('physnet1',1077,0),('physnet1',1078,0),('physnet1',1079,0),('physnet1',1080,0),('physnet1',1081,0),('physnet1',1082,0),('physnet1',1083,0),('physnet1',1084,0),('physnet1',1085,0),('physnet1',1086,0),('physnet1',1087,0),('physnet1',1088,0),('physnet1',1089,0),('physnet1',1090,0),('physnet1',1091,0),('physnet1',1092,0),('physnet1',1093,0),('physnet1',1094,0),('physnet1',1095,0),('physnet1',1096,0),('physnet1',1097,0),('physnet1',1098,0),('physnet1',1099,0),('physnet1',1100,0),('physnet1',1101,0),('physnet1',1102,0),('physnet1',1103,0),('physnet1',1104,0),('physnet1',1105,0),('physnet1',1106,0),('physnet1',1107,0),('physnet1',1108,0),('physnet1',1109,0),('physnet1',1110,0),('physnet1',1111,0),('physnet1',1112,0),('physnet1',1113,0),('physnet1',1114,0),('physnet1',1115,0),('physnet1',1116,0),('physnet1',1117,0),('physnet1',1118,0),('physnet1',1119,0),('physnet1',1120,0),('physnet1',1121,0),('physnet1',1122,0),('physnet1',1123,0),('physnet1',1124,0),('physnet1',1125,0),('physnet1',1126,0),('physnet1',1127,0),('physnet1',1128,0),('physnet1',1129,0),('physnet1',1130,0),('physnet1',1131,0),('physnet1',1132,0),('physnet1',1133,0),('physnet1',1134,0),('physnet1',1135,0),('physnet1',1136,0),('physnet1',1137,0),('physnet1',1138,0),('physnet1',1139,0),('physnet1',1140,0),('physnet1',1141,0),('physnet1',1142,0),('physnet1',1143,0),('physnet1',1144,0),('physnet1',1145,0),('physnet1',1146,0),('physnet1',1147,0),('physnet1',1148,0),('physnet1',1149,0),('physnet1',1150,0),('physnet1',1151,0),('physnet1',1152,0),('physnet1',1153,0),('physnet1',1154,0),('physnet1',1155,0),('physnet1',1156,0),('physnet1',1157,0),('physnet1',1158,0),('physnet1',1159,0),('physnet1',1160,0),('physnet1',1161,0),('physnet1',1162,0),('physnet1',1163,0),('physnet1',1164,0),('physnet1',1165,0),('physnet1',1166,0),('physnet1',1167,0),('physnet1',1168,0),('physnet1',1169,0),('physnet1',1170,0),('physnet1',1171,0),('physnet1',1172,0),('physnet1',1173,0),('physnet1',1174,0),('physnet1',1175,0),('physnet1',1176,0),('physnet1',1177,0),('physnet1',1178,0),('physnet1',1179,0),('physnet1',1180,0),('physnet1',1181,0),('physnet1',1182,0),('physnet1',1183,0),('physnet1',1184,0),('physnet1',1185,0),('physnet1',1186,0),('physnet1',1187,0),('physnet1',1188,0),('physnet1',1189,0),('physnet1',1190,0),('physnet1',1191,0),('physnet1',1192,0),('physnet1',1193,0),('physnet1',1194,0),('physnet1',1195,0),('physnet1',1196,0),('physnet1',1197,0),('physnet1',1198,0),('physnet1',1199,0),('physnet1',1200,0),('physnet1',1201,0),('physnet1',1202,0),('physnet1',1203,0),('physnet1',1204,0),('physnet1',1205,0),('physnet1',1206,0),('physnet1',1207,0),('physnet1',1208,0),('physnet1',1209,0),('physnet1',1210,0),('physnet1',1211,0),('physnet1',1212,0),('physnet1',1213,0),('physnet1',1214,0),('physnet1',1215,0),('physnet1',1216,0),('physnet1',1217,0),('physnet1',1218,0),('physnet1',1219,0),('physnet1',1220,0),('physnet1',1221,0),('physnet1',1222,0),('physnet1',1223,0),('physnet1',1224,0),('physnet1',1225,0),('physnet1',1226,0),('physnet1',1227,0),('physnet1',1228,0),('physnet1',1229,0),('physnet1',1230,0),('physnet1',1231,0),('physnet1',1232,0),('physnet1',1233,0),('physnet1',1234,0),('physnet1',1235,0),('physnet1',1236,0),('physnet1',1237,0),('physnet1',1238,0),('physnet1',1239,0),('physnet1',1240,0),('physnet1',1241,0),('physnet1',1242,0),('physnet1',1243,0),('physnet1',1244,0),('physnet1',1245,0),('physnet1',1246,0),('physnet1',1247,0),('physnet1',1248,0),('physnet1',1249,0),('physnet1',1250,0),('physnet1',1251,0),('physnet1',1252,0),('physnet1',1253,0),('physnet1',1254,0),('physnet1',1255,0),('physnet1',1256,0),('physnet1',1257,0),('physnet1',1258,0),('physnet1',1259,0),('physnet1',1260,0),('physnet1',1261,0),('physnet1',1262,0),('physnet1',1263,0),('physnet1',1264,0),('physnet1',1265,0),('physnet1',1266,0),('physnet1',1267,0),('physnet1',1268,0),('physnet1',1269,0),('physnet1',1270,0),('physnet1',1271,0),('physnet1',1272,0),('physnet1',1273,0),('physnet1',1274,0),('physnet1',1275,0),('physnet1',1276,0),('physnet1',1277,0),('physnet1',1278,0),('physnet1',1279,0),('physnet1',1280,0),('physnet1',1281,0),('physnet1',1282,0),('physnet1',1283,0),('physnet1',1284,0),('physnet1',1285,0),('physnet1',1286,0),('physnet1',1287,0),('physnet1',1288,0),('physnet1',1289,0),('physnet1',1290,0),('physnet1',1291,0),('physnet1',1292,0),('physnet1',1293,0),('physnet1',1294,0),('physnet1',1295,0),('physnet1',1296,0),('physnet1',1297,0),('physnet1',1298,0),('physnet1',1299,0),('physnet1',1300,0),('physnet1',1301,0),('physnet1',1302,0),('physnet1',1303,0),('physnet1',1304,0),('physnet1',1305,0),('physnet1',1306,0),('physnet1',1307,0),('physnet1',1308,0),('physnet1',1309,0),('physnet1',1310,0),('physnet1',1311,0),('physnet1',1312,0),('physnet1',1313,0),('physnet1',1314,0),('physnet1',1315,0),('physnet1',1316,0),('physnet1',1317,0),('physnet1',1318,0),('physnet1',1319,0),('physnet1',1320,0),('physnet1',1321,0),('physnet1',1322,0),('physnet1',1323,0),('physnet1',1324,0),('physnet1',1325,0),('physnet1',1326,0),('physnet1',1327,0),('physnet1',1328,0),('physnet1',1329,0),('physnet1',1330,0),('physnet1',1331,0),('physnet1',1332,0),('physnet1',1333,0),('physnet1',1334,0),('physnet1',1335,0),('physnet1',1336,0),('physnet1',1337,0),('physnet1',1338,0),('physnet1',1339,0),('physnet1',1340,0),('physnet1',1341,0),('physnet1',1342,0),('physnet1',1343,0),('physnet1',1344,0),('physnet1',1345,0),('physnet1',1346,0),('physnet1',1347,0),('physnet1',1348,0),('physnet1',1349,0),('physnet1',1350,0),('physnet1',1351,0),('physnet1',1352,0),('physnet1',1353,0),('physnet1',1354,0),('physnet1',1355,0),('physnet1',1356,0),('physnet1',1357,0),('physnet1',1358,0),('physnet1',1359,0),('physnet1',1360,0),('physnet1',1361,0),('physnet1',1362,0),('physnet1',1363,0),('physnet1',1364,0),('physnet1',1365,0),('physnet1',1366,0),('physnet1',1367,0),('physnet1',1368,0),('physnet1',1369,0),('physnet1',1370,0),('physnet1',1371,0),('physnet1',1372,0),('physnet1',1373,0),('physnet1',1374,0),('physnet1',1375,0),('physnet1',1376,0),('physnet1',1377,0),('physnet1',1378,0),('physnet1',1379,0),('physnet1',1380,0),('physnet1',1381,0),('physnet1',1382,0),('physnet1',1383,0),('physnet1',1384,0),('physnet1',1385,0),('physnet1',1386,0),('physnet1',1387,0),('physnet1',1388,0),('physnet1',1389,0),('physnet1',1390,0),('physnet1',1391,0),('physnet1',1392,0),('physnet1',1393,0),('physnet1',1394,0),('physnet1',1395,0),('physnet1',1396,0),('physnet1',1397,0),('physnet1',1398,0),('physnet1',1399,0),('physnet1',1400,0),('physnet1',1401,0),('physnet1',1402,0),('physnet1',1403,0),('physnet1',1404,0),('physnet1',1405,0),('physnet1',1406,0),('physnet1',1407,0),('physnet1',1408,0),('physnet1',1409,0),('physnet1',1410,0),('physnet1',1411,0),('physnet1',1412,0),('physnet1',1413,0),('physnet1',1414,0),('physnet1',1415,0),('physnet1',1416,0),('physnet1',1417,0),('physnet1',1418,0),('physnet1',1419,0),('physnet1',1420,0),('physnet1',1421,0),('physnet1',1422,0),('physnet1',1423,0),('physnet1',1424,0),('physnet1',1425,0),('physnet1',1426,0),('physnet1',1427,0),('physnet1',1428,0),('physnet1',1429,0),('physnet1',1430,0),('physnet1',1431,0),('physnet1',1432,0),('physnet1',1433,0),('physnet1',1434,0),('physnet1',1435,0),('physnet1',1436,0),('physnet1',1437,0),('physnet1',1438,0),('physnet1',1439,0),('physnet1',1440,0),('physnet1',1441,0),('physnet1',1442,0),('physnet1',1443,0),('physnet1',1444,0),('physnet1',1445,0),('physnet1',1446,0),('physnet1',1447,0),('physnet1',1448,0),('physnet1',1449,0),('physnet1',1450,0),('physnet1',1451,0),('physnet1',1452,0),('physnet1',1453,0),('physnet1',1454,0),('physnet1',1455,0),('physnet1',1456,0),('physnet1',1457,0),('physnet1',1458,0),('physnet1',1459,0),('physnet1',1460,0),('physnet1',1461,0),('physnet1',1462,0),('physnet1',1463,0),('physnet1',1464,0),('physnet1',1465,0),('physnet1',1466,0),('physnet1',1467,0),('physnet1',1468,0),('physnet1',1469,0),('physnet1',1470,0),('physnet1',1471,0),('physnet1',1472,0),('physnet1',1473,0),('physnet1',1474,0),('physnet1',1475,0),('physnet1',1476,0),('physnet1',1477,0),('physnet1',1478,0),('physnet1',1479,0),('physnet1',1480,0),('physnet1',1481,0),('physnet1',1482,0),('physnet1',1483,0),('physnet1',1484,0),('physnet1',1485,0),('physnet1',1486,0),('physnet1',1487,0),('physnet1',1488,0),('physnet1',1489,0),('physnet1',1490,0),('physnet1',1491,0),('physnet1',1492,0),('physnet1',1493,0),('physnet1',1494,0),('physnet1',1495,0),('physnet1',1496,0),('physnet1',1497,0),('physnet1',1498,0),('physnet1',1499,0),('physnet1',1500,0),('physnet1',1501,0),('physnet1',1502,0),('physnet1',1503,0),('physnet1',1504,0),('physnet1',1505,0),('physnet1',1506,0),('physnet1',1507,0),('physnet1',1508,0),('physnet1',1509,0),('physnet1',1510,0),('physnet1',1511,0),('physnet1',1512,0),('physnet1',1513,0),('physnet1',1514,0),('physnet1',1515,0),('physnet1',1516,0),('physnet1',1517,0),('physnet1',1518,0),('physnet1',1519,0),('physnet1',1520,0),('physnet1',1521,0),('physnet1',1522,0),('physnet1',1523,0),('physnet1',1524,0),('physnet1',1525,0),('physnet1',1526,0),('physnet1',1527,0),('physnet1',1528,0),('physnet1',1529,0),('physnet1',1530,0),('physnet1',1531,0),('physnet1',1532,0),('physnet1',1533,0),('physnet1',1534,0),('physnet1',1535,0),('physnet1',1536,0),('physnet1',1537,0),('physnet1',1538,0),('physnet1',1539,0),('physnet1',1540,0),('physnet1',1541,0),('physnet1',1542,0),('physnet1',1543,0),('physnet1',1544,0),('physnet1',1545,0),('physnet1',1546,0),('physnet1',1547,0),('physnet1',1548,0),('physnet1',1549,0),('physnet1',1550,0),('physnet1',1551,0),('physnet1',1552,0),('physnet1',1553,0),('physnet1',1554,0),('physnet1',1555,0),('physnet1',1556,0),('physnet1',1557,0),('physnet1',1558,0),('physnet1',1559,0),('physnet1',1560,0),('physnet1',1561,0),('physnet1',1562,0),('physnet1',1563,0),('physnet1',1564,0),('physnet1',1565,0),('physnet1',1566,0),('physnet1',1567,0),('physnet1',1568,0),('physnet1',1569,0),('physnet1',1570,0),('physnet1',1571,0),('physnet1',1572,0),('physnet1',1573,0),('physnet1',1574,0),('physnet1',1575,0),('physnet1',1576,0),('physnet1',1577,0),('physnet1',1578,0),('physnet1',1579,0),('physnet1',1580,0),('physnet1',1581,0),('physnet1',1582,0),('physnet1',1583,0),('physnet1',1584,0),('physnet1',1585,0),('physnet1',1586,0),('physnet1',1587,0),('physnet1',1588,0),('physnet1',1589,0),('physnet1',1590,0),('physnet1',1591,0),('physnet1',1592,0),('physnet1',1593,0),('physnet1',1594,0),('physnet1',1595,0),('physnet1',1596,0),('physnet1',1597,0),('physnet1',1598,0),('physnet1',1599,0),('physnet1',1600,0),('physnet1',1601,0),('physnet1',1602,0),('physnet1',1603,0),('physnet1',1604,0),('physnet1',1605,0),('physnet1',1606,0),('physnet1',1607,0),('physnet1',1608,0),('physnet1',1609,0),('physnet1',1610,0),('physnet1',1611,0),('physnet1',1612,0),('physnet1',1613,0),('physnet1',1614,0),('physnet1',1615,0),('physnet1',1616,0),('physnet1',1617,0),('physnet1',1618,0),('physnet1',1619,0),('physnet1',1620,0),('physnet1',1621,0),('physnet1',1622,0),('physnet1',1623,0),('physnet1',1624,0),('physnet1',1625,0),('physnet1',1626,0),('physnet1',1627,0),('physnet1',1628,0),('physnet1',1629,0),('physnet1',1630,0),('physnet1',1631,0),('physnet1',1632,0),('physnet1',1633,0),('physnet1',1634,0),('physnet1',1635,0),('physnet1',1636,0),('physnet1',1637,0),('physnet1',1638,0),('physnet1',1639,0),('physnet1',1640,0),('physnet1',1641,0),('physnet1',1642,0),('physnet1',1643,0),('physnet1',1644,0),('physnet1',1645,0),('physnet1',1646,0),('physnet1',1647,0),('physnet1',1648,0),('physnet1',1649,0),('physnet1',1650,0),('physnet1',1651,0),('physnet1',1652,0),('physnet1',1653,0),('physnet1',1654,0),('physnet1',1655,0),('physnet1',1656,0),('physnet1',1657,0),('physnet1',1658,0),('physnet1',1659,0),('physnet1',1660,0),('physnet1',1661,0),('physnet1',1662,0),('physnet1',1663,0),('physnet1',1664,0),('physnet1',1665,0),('physnet1',1666,0),('physnet1',1667,0),('physnet1',1668,0),('physnet1',1669,0),('physnet1',1670,0),('physnet1',1671,0),('physnet1',1672,0),('physnet1',1673,0),('physnet1',1674,0),('physnet1',1675,0),('physnet1',1676,0),('physnet1',1677,0),('physnet1',1678,0),('physnet1',1679,0),('physnet1',1680,0),('physnet1',1681,0),('physnet1',1682,0),('physnet1',1683,0),('physnet1',1684,0),('physnet1',1685,0),('physnet1',1686,0),('physnet1',1687,0),('physnet1',1688,0),('physnet1',1689,0),('physnet1',1690,0),('physnet1',1691,0),('physnet1',1692,0),('physnet1',1693,0),('physnet1',1694,0),('physnet1',1695,0),('physnet1',1696,0),('physnet1',1697,0),('physnet1',1698,0),('physnet1',1699,0),('physnet1',1700,0),('physnet1',1701,0),('physnet1',1702,0),('physnet1',1703,0),('physnet1',1704,0),('physnet1',1705,0),('physnet1',1706,0),('physnet1',1707,0),('physnet1',1708,0),('physnet1',1709,0),('physnet1',1710,0),('physnet1',1711,0),('physnet1',1712,0),('physnet1',1713,0),('physnet1',1714,0),('physnet1',1715,0),('physnet1',1716,0),('physnet1',1717,0),('physnet1',1718,0),('physnet1',1719,0),('physnet1',1720,0),('physnet1',1721,0),('physnet1',1722,0),('physnet1',1723,0),('physnet1',1724,0),('physnet1',1725,0),('physnet1',1726,0),('physnet1',1727,0),('physnet1',1728,0),('physnet1',1729,0),('physnet1',1730,0),('physnet1',1731,0),('physnet1',1732,0),('physnet1',1733,0),('physnet1',1734,0),('physnet1',1735,0),('physnet1',1736,0),('physnet1',1737,0),('physnet1',1738,0),('physnet1',1739,0),('physnet1',1740,0),('physnet1',1741,0),('physnet1',1742,0),('physnet1',1743,0),('physnet1',1744,0),('physnet1',1745,0),('physnet1',1746,0),('physnet1',1747,0),('physnet1',1748,0),('physnet1',1749,0),('physnet1',1750,0),('physnet1',1751,0),('physnet1',1752,0),('physnet1',1753,0),('physnet1',1754,0),('physnet1',1755,0),('physnet1',1756,0),('physnet1',1757,0),('physnet1',1758,0),('physnet1',1759,0),('physnet1',1760,0),('physnet1',1761,0),('physnet1',1762,0),('physnet1',1763,0),('physnet1',1764,0),('physnet1',1765,0),('physnet1',1766,0),('physnet1',1767,0),('physnet1',1768,0),('physnet1',1769,0),('physnet1',1770,0),('physnet1',1771,0),('physnet1',1772,0),('physnet1',1773,0),('physnet1',1774,0),('physnet1',1775,0),('physnet1',1776,0),('physnet1',1777,0),('physnet1',1778,0),('physnet1',1779,0),('physnet1',1780,0),('physnet1',1781,0),('physnet1',1782,0),('physnet1',1783,0),('physnet1',1784,0),('physnet1',1785,0),('physnet1',1786,0),('physnet1',1787,0),('physnet1',1788,0),('physnet1',1789,0),('physnet1',1790,0),('physnet1',1791,0),('physnet1',1792,0),('physnet1',1793,0),('physnet1',1794,0),('physnet1',1795,0),('physnet1',1796,0),('physnet1',1797,0),('physnet1',1798,0),('physnet1',1799,0),('physnet1',1800,0),('physnet1',1801,0),('physnet1',1802,0),('physnet1',1803,0),('physnet1',1804,0),('physnet1',1805,0),('physnet1',1806,0),('physnet1',1807,0),('physnet1',1808,0),('physnet1',1809,0),('physnet1',1810,0),('physnet1',1811,0),('physnet1',1812,0),('physnet1',1813,0),('physnet1',1814,0),('physnet1',1815,0),('physnet1',1816,0),('physnet1',1817,0),('physnet1',1818,0),('physnet1',1819,0),('physnet1',1820,0),('physnet1',1821,0),('physnet1',1822,0),('physnet1',1823,0),('physnet1',1824,0),('physnet1',1825,0),('physnet1',1826,0),('physnet1',1827,0),('physnet1',1828,0),('physnet1',1829,0),('physnet1',1830,0),('physnet1',1831,0),('physnet1',1832,0),('physnet1',1833,0),('physnet1',1834,0),('physnet1',1835,0),('physnet1',1836,0),('physnet1',1837,0),('physnet1',1838,0),('physnet1',1839,0),('physnet1',1840,0),('physnet1',1841,0),('physnet1',1842,0),('physnet1',1843,0),('physnet1',1844,0),('physnet1',1845,0),('physnet1',1846,0),('physnet1',1847,0),('physnet1',1848,0),('physnet1',1849,0),('physnet1',1850,0),('physnet1',1851,0),('physnet1',1852,0),('physnet1',1853,0),('physnet1',1854,0),('physnet1',1855,0),('physnet1',1856,0),('physnet1',1857,0),('physnet1',1858,0),('physnet1',1859,0),('physnet1',1860,0),('physnet1',1861,0),('physnet1',1862,0),('physnet1',1863,0),('physnet1',1864,0),('physnet1',1865,0),('physnet1',1866,0),('physnet1',1867,0),('physnet1',1868,0),('physnet1',1869,0),('physnet1',1870,0),('physnet1',1871,0),('physnet1',1872,0),('physnet1',1873,0),('physnet1',1874,0),('physnet1',1875,0),('physnet1',1876,0),('physnet1',1877,0),('physnet1',1878,0),('physnet1',1879,0),('physnet1',1880,0),('physnet1',1881,0),('physnet1',1882,0),('physnet1',1883,0),('physnet1',1884,0),('physnet1',1885,0),('physnet1',1886,0),('physnet1',1887,0),('physnet1',1888,0),('physnet1',1889,0),('physnet1',1890,0),('physnet1',1891,0),('physnet1',1892,0),('physnet1',1893,0),('physnet1',1894,0),('physnet1',1895,0),('physnet1',1896,0),('physnet1',1897,0),('physnet1',1898,0),('physnet1',1899,0),('physnet1',1900,0),('physnet1',1901,0),('physnet1',1902,0),('physnet1',1903,0),('physnet1',1904,0),('physnet1',1905,0),('physnet1',1906,0),('physnet1',1907,0),('physnet1',1908,0),('physnet1',1909,0),('physnet1',1910,0),('physnet1',1911,0),('physnet1',1912,0),('physnet1',1913,0),('physnet1',1914,0),('physnet1',1915,0),('physnet1',1916,0),('physnet1',1917,0),('physnet1',1918,0),('physnet1',1919,0),('physnet1',1920,0),('physnet1',1921,0),('physnet1',1922,0),('physnet1',1923,0),('physnet1',1924,0),('physnet1',1925,0),('physnet1',1926,0),('physnet1',1927,0),('physnet1',1928,0),('physnet1',1929,0),('physnet1',1930,0),('physnet1',1931,0),('physnet1',1932,0),('physnet1',1933,0),('physnet1',1934,0),('physnet1',1935,0),('physnet1',1936,0),('physnet1',1937,0),('physnet1',1938,0),('physnet1',1939,0),('physnet1',1940,0),('physnet1',1941,0),('physnet1',1942,0),('physnet1',1943,0),('physnet1',1944,0),('physnet1',1945,0),('physnet1',1946,0),('physnet1',1947,0),('physnet1',1948,0),('physnet1',1949,0),('physnet1',1950,0),('physnet1',1951,0),('physnet1',1952,0),('physnet1',1953,0),('physnet1',1954,0),('physnet1',1955,0),('physnet1',1956,0),('physnet1',1957,0),('physnet1',1958,0),('physnet1',1959,0),('physnet1',1960,0),('physnet1',1961,0),('physnet1',1962,0),('physnet1',1963,0),('physnet1',1964,0),('physnet1',1965,0),('physnet1',1966,0),('physnet1',1967,0),('physnet1',1968,0),('physnet1',1969,0),('physnet1',1970,0),('physnet1',1971,0),('physnet1',1972,0),('physnet1',1973,0),('physnet1',1974,0),('physnet1',1975,0),('physnet1',1976,0),('physnet1',1977,0),('physnet1',1978,0),('physnet1',1979,0),('physnet1',1980,0),('physnet1',1981,0),('physnet1',1982,0),('physnet1',1983,0),('physnet1',1984,0),('physnet1',1985,0),('physnet1',1986,0),('physnet1',1987,0),('physnet1',1988,0),('physnet1',1989,0),('physnet1',1990,0),('physnet1',1991,0),('physnet1',1992,0),('physnet1',1993,0),('physnet1',1994,0),('physnet1',1995,0),('physnet1',1996,0),('physnet1',1997,0),('physnet1',1998,0),('physnet1',1999,0),('physnet1',2000,0),('physnet1',2001,0),('physnet1',2002,0),('physnet1',2003,0),('physnet1',2004,0),('physnet1',2005,0),('physnet1',2006,0),('physnet1',2007,0),('physnet1',2008,0),('physnet1',2009,0),('physnet1',2010,0),('physnet1',2011,0),('physnet1',2012,0),('physnet1',2013,0),('physnet1',2014,0),('physnet1',2015,0),('physnet1',2016,0),('physnet1',2017,0),('physnet1',2018,0),('physnet1',2019,0),('physnet1',2020,0),('physnet1',2021,0),('physnet1',2022,0),('physnet1',2023,0),('physnet1',2024,0),('physnet1',2025,0),('physnet1',2026,0),('physnet1',2027,0),('physnet1',2028,0),('physnet1',2029,0),('physnet1',2030,0),('physnet1',2031,0),('physnet1',2032,0),('physnet1',2033,0),('physnet1',2034,0),('physnet1',2035,0),('physnet1',2036,0),('physnet1',2037,0),('physnet1',2038,0),('physnet1',2039,0),('physnet1',2040,0),('physnet1',2041,0),('physnet1',2042,0),('physnet1',2043,0),('physnet1',2044,0),('physnet1',2045,0),('physnet1',2046,0),('physnet1',2047,0),('physnet1',2048,0),('physnet1',2049,0),('physnet1',2050,0),('physnet1',2051,0),('physnet1',2052,0),('physnet1',2053,0),('physnet1',2054,0),('physnet1',2055,0),('physnet1',2056,0),('physnet1',2057,0),('physnet1',2058,0),('physnet1',2059,0),('physnet1',2060,0),('physnet1',2061,0),('physnet1',2062,0),('physnet1',2063,0),('physnet1',2064,0),('physnet1',2065,0),('physnet1',2066,0),('physnet1',2067,0),('physnet1',2068,0),('physnet1',2069,0),('physnet1',2070,0),('physnet1',2071,0),('physnet1',2072,0),('physnet1',2073,0),('physnet1',2074,0),('physnet1',2075,0),('physnet1',2076,0),('physnet1',2077,0),('physnet1',2078,0),('physnet1',2079,0),('physnet1',2080,0),('physnet1',2081,0),('physnet1',2082,0),('physnet1',2083,0),('physnet1',2084,0),('physnet1',2085,0),('physnet1',2086,0),('physnet1',2087,0),('physnet1',2088,0),('physnet1',2089,0),('physnet1',2090,0),('physnet1',2091,0),('physnet1',2092,0),('physnet1',2093,0),('physnet1',2094,0),('physnet1',2095,0),('physnet1',2096,0),('physnet1',2097,0),('physnet1',2098,0),('physnet1',2099,0),('physnet1',2100,0),('physnet1',2101,0),('physnet1',2102,0),('physnet1',2103,0),('physnet1',2104,0),('physnet1',2105,0),('physnet1',2106,0),('physnet1',2107,0),('physnet1',2108,0),('physnet1',2109,0),('physnet1',2110,0),('physnet1',2111,0),('physnet1',2112,0),('physnet1',2113,0),('physnet1',2114,0),('physnet1',2115,0),('physnet1',2116,0),('physnet1',2117,0),('physnet1',2118,0),('physnet1',2119,0),('physnet1',2120,0),('physnet1',2121,0),('physnet1',2122,0),('physnet1',2123,0),('physnet1',2124,0),('physnet1',2125,0),('physnet1',2126,0),('physnet1',2127,0),('physnet1',2128,0),('physnet1',2129,0),('physnet1',2130,0),('physnet1',2131,0),('physnet1',2132,0),('physnet1',2133,0),('physnet1',2134,0),('physnet1',2135,0),('physnet1',2136,0),('physnet1',2137,0),('physnet1',2138,0),('physnet1',2139,0),('physnet1',2140,0),('physnet1',2141,0),('physnet1',2142,0),('physnet1',2143,0),('physnet1',2144,0),('physnet1',2145,0),('physnet1',2146,0),('physnet1',2147,0),('physnet1',2148,0),('physnet1',2149,0),('physnet1',2150,0),('physnet1',2151,0),('physnet1',2152,0),('physnet1',2153,0),('physnet1',2154,0),('physnet1',2155,0),('physnet1',2156,0),('physnet1',2157,0),('physnet1',2158,0),('physnet1',2159,0),('physnet1',2160,0),('physnet1',2161,0),('physnet1',2162,0),('physnet1',2163,0),('physnet1',2164,0),('physnet1',2165,0),('physnet1',2166,0),('physnet1',2167,0),('physnet1',2168,0),('physnet1',2169,0),('physnet1',2170,0),('physnet1',2171,0),('physnet1',2172,0),('physnet1',2173,0),('physnet1',2174,0),('physnet1',2175,0),('physnet1',2176,0),('physnet1',2177,0),('physnet1',2178,0),('physnet1',2179,0),('physnet1',2180,0),('physnet1',2181,0),('physnet1',2182,0),('physnet1',2183,0),('physnet1',2184,0),('physnet1',2185,0),('physnet1',2186,0),('physnet1',2187,0),('physnet1',2188,0),('physnet1',2189,0),('physnet1',2190,0),('physnet1',2191,0),('physnet1',2192,0),('physnet1',2193,0),('physnet1',2194,0),('physnet1',2195,0),('physnet1',2196,0),('physnet1',2197,0),('physnet1',2198,0),('physnet1',2199,0),('physnet1',2200,0),('physnet1',2201,0),('physnet1',2202,0),('physnet1',2203,0),('physnet1',2204,0),('physnet1',2205,0),('physnet1',2206,0),('physnet1',2207,0),('physnet1',2208,0),('physnet1',2209,0),('physnet1',2210,0),('physnet1',2211,0),('physnet1',2212,0),('physnet1',2213,0),('physnet1',2214,0),('physnet1',2215,0),('physnet1',2216,0),('physnet1',2217,0),('physnet1',2218,0),('physnet1',2219,0),('physnet1',2220,0),('physnet1',2221,0),('physnet1',2222,0),('physnet1',2223,0),('physnet1',2224,0),('physnet1',2225,0),('physnet1',2226,0),('physnet1',2227,0),('physnet1',2228,0),('physnet1',2229,0),('physnet1',2230,0),('physnet1',2231,0),('physnet1',2232,0),('physnet1',2233,0),('physnet1',2234,0),('physnet1',2235,0),('physnet1',2236,0),('physnet1',2237,0),('physnet1',2238,0),('physnet1',2239,0),('physnet1',2240,0),('physnet1',2241,0),('physnet1',2242,0),('physnet1',2243,0),('physnet1',2244,0),('physnet1',2245,0),('physnet1',2246,0),('physnet1',2247,0),('physnet1',2248,0),('physnet1',2249,0),('physnet1',2250,0),('physnet1',2251,0),('physnet1',2252,0),('physnet1',2253,0),('physnet1',2254,0),('physnet1',2255,0),('physnet1',2256,0),('physnet1',2257,0),('physnet1',2258,0),('physnet1',2259,0),('physnet1',2260,0),('physnet1',2261,0),('physnet1',2262,0),('physnet1',2263,0),('physnet1',2264,0),('physnet1',2265,0),('physnet1',2266,0),('physnet1',2267,0),('physnet1',2268,0),('physnet1',2269,0),('physnet1',2270,0),('physnet1',2271,0),('physnet1',2272,0),('physnet1',2273,0),('physnet1',2274,0),('physnet1',2275,0),('physnet1',2276,0),('physnet1',2277,0),('physnet1',2278,0),('physnet1',2279,0),('physnet1',2280,0),('physnet1',2281,0),('physnet1',2282,0),('physnet1',2283,0),('physnet1',2284,0),('physnet1',2285,0),('physnet1',2286,0),('physnet1',2287,0),('physnet1',2288,0),('physnet1',2289,0),('physnet1',2290,0),('physnet1',2291,0),('physnet1',2292,0),('physnet1',2293,0),('physnet1',2294,0),('physnet1',2295,0),('physnet1',2296,0),('physnet1',2297,0),('physnet1',2298,0),('physnet1',2299,0),('physnet1',2300,0),('physnet1',2301,0),('physnet1',2302,0),('physnet1',2303,0),('physnet1',2304,0),('physnet1',2305,0),('physnet1',2306,0),('physnet1',2307,0),('physnet1',2308,0),('physnet1',2309,0),('physnet1',2310,0),('physnet1',2311,0),('physnet1',2312,0),('physnet1',2313,0),('physnet1',2314,0),('physnet1',2315,0),('physnet1',2316,0),('physnet1',2317,0),('physnet1',2318,0),('physnet1',2319,0),('physnet1',2320,0),('physnet1',2321,0),('physnet1',2322,0),('physnet1',2323,0),('physnet1',2324,0),('physnet1',2325,0),('physnet1',2326,0),('physnet1',2327,0),('physnet1',2328,0),('physnet1',2329,0),('physnet1',2330,0),('physnet1',2331,0),('physnet1',2332,0),('physnet1',2333,0),('physnet1',2334,0),('physnet1',2335,0),('physnet1',2336,0),('physnet1',2337,0),('physnet1',2338,0),('physnet1',2339,0),('physnet1',2340,0),('physnet1',2341,0),('physnet1',2342,0),('physnet1',2343,0),('physnet1',2344,0),('physnet1',2345,0),('physnet1',2346,0),('physnet1',2347,0),('physnet1',2348,0),('physnet1',2349,0),('physnet1',2350,0),('physnet1',2351,0),('physnet1',2352,0),('physnet1',2353,0),('physnet1',2354,0),('physnet1',2355,0),('physnet1',2356,0),('physnet1',2357,0),('physnet1',2358,0),('physnet1',2359,0),('physnet1',2360,0),('physnet1',2361,0),('physnet1',2362,0),('physnet1',2363,0),('physnet1',2364,0),('physnet1',2365,0),('physnet1',2366,0),('physnet1',2367,0),('physnet1',2368,0),('physnet1',2369,0),('physnet1',2370,0),('physnet1',2371,0),('physnet1',2372,0),('physnet1',2373,0),('physnet1',2374,0),('physnet1',2375,0),('physnet1',2376,0),('physnet1',2377,0),('physnet1',2378,0),('physnet1',2379,0),('physnet1',2380,0),('physnet1',2381,0),('physnet1',2382,0),('physnet1',2383,0),('physnet1',2384,0),('physnet1',2385,0),('physnet1',2386,0),('physnet1',2387,0),('physnet1',2388,0),('physnet1',2389,0),('physnet1',2390,0),('physnet1',2391,0),('physnet1',2392,0),('physnet1',2393,0),('physnet1',2394,0),('physnet1',2395,0),('physnet1',2396,0),('physnet1',2397,0),('physnet1',2398,0),('physnet1',2399,0),('physnet1',2400,0),('physnet1',2401,0),('physnet1',2402,0),('physnet1',2403,0),('physnet1',2404,0),('physnet1',2405,0),('physnet1',2406,0),('physnet1',2407,0),('physnet1',2408,0),('physnet1',2409,0),('physnet1',2410,0),('physnet1',2411,0),('physnet1',2412,0),('physnet1',2413,0),('physnet1',2414,0),('physnet1',2415,0),('physnet1',2416,0),('physnet1',2417,0),('physnet1',2418,0),('physnet1',2419,0),('physnet1',2420,0),('physnet1',2421,0),('physnet1',2422,0),('physnet1',2423,0),('physnet1',2424,0),('physnet1',2425,0),('physnet1',2426,0),('physnet1',2427,0),('physnet1',2428,0),('physnet1',2429,0),('physnet1',2430,0),('physnet1',2431,0),('physnet1',2432,0),('physnet1',2433,0),('physnet1',2434,0),('physnet1',2435,0),('physnet1',2436,0),('physnet1',2437,0),('physnet1',2438,0),('physnet1',2439,0),('physnet1',2440,0),('physnet1',2441,0),('physnet1',2442,0),('physnet1',2443,0),('physnet1',2444,0),('physnet1',2445,0),('physnet1',2446,0),('physnet1',2447,0),('physnet1',2448,0),('physnet1',2449,0),('physnet1',2450,0),('physnet1',2451,0),('physnet1',2452,0),('physnet1',2453,0),('physnet1',2454,0),('physnet1',2455,0),('physnet1',2456,0),('physnet1',2457,0),('physnet1',2458,0),('physnet1',2459,0),('physnet1',2460,0),('physnet1',2461,0),('physnet1',2462,0),('physnet1',2463,0),('physnet1',2464,0),('physnet1',2465,0),('physnet1',2466,0),('physnet1',2467,0),('physnet1',2468,0),('physnet1',2469,0),('physnet1',2470,0),('physnet1',2471,0),('physnet1',2472,0),('physnet1',2473,0),('physnet1',2474,0),('physnet1',2475,0),('physnet1',2476,0),('physnet1',2477,0),('physnet1',2478,0),('physnet1',2479,0),('physnet1',2480,0),('physnet1',2481,0),('physnet1',2482,0),('physnet1',2483,0),('physnet1',2484,0),('physnet1',2485,0),('physnet1',2486,0),('physnet1',2487,0),('physnet1',2488,0),('physnet1',2489,0),('physnet1',2490,0),('physnet1',2491,0),('physnet1',2492,0),('physnet1',2493,0),('physnet1',2494,0),('physnet1',2495,0),('physnet1',2496,0),('physnet1',2497,0),('physnet1',2498,0),('physnet1',2499,0),('physnet1',2500,0),('physnet1',2501,0),('physnet1',2502,0),('physnet1',2503,0),('physnet1',2504,0),('physnet1',2505,0),('physnet1',2506,0),('physnet1',2507,0),('physnet1',2508,0),('physnet1',2509,0),('physnet1',2510,0),('physnet1',2511,0),('physnet1',2512,0),('physnet1',2513,0),('physnet1',2514,0),('physnet1',2515,0),('physnet1',2516,0),('physnet1',2517,0),('physnet1',2518,0),('physnet1',2519,0),('physnet1',2520,0),('physnet1',2521,0),('physnet1',2522,0),('physnet1',2523,0),('physnet1',2524,0),('physnet1',2525,0),('physnet1',2526,0),('physnet1',2527,0),('physnet1',2528,0),('physnet1',2529,0),('physnet1',2530,0),('physnet1',2531,0),('physnet1',2532,0),('physnet1',2533,0),('physnet1',2534,0),('physnet1',2535,0),('physnet1',2536,0),('physnet1',2537,0),('physnet1',2538,0),('physnet1',2539,0),('physnet1',2540,0),('physnet1',2541,0),('physnet1',2542,0),('physnet1',2543,0),('physnet1',2544,0),('physnet1',2545,0),('physnet1',2546,0),('physnet1',2547,0),('physnet1',2548,0),('physnet1',2549,0),('physnet1',2550,0),('physnet1',2551,0),('physnet1',2552,0),('physnet1',2553,0),('physnet1',2554,0),('physnet1',2555,0),('physnet1',2556,0),('physnet1',2557,0),('physnet1',2558,0),('physnet1',2559,0),('physnet1',2560,0),('physnet1',2561,0),('physnet1',2562,0),('physnet1',2563,0),('physnet1',2564,0),('physnet1',2565,0),('physnet1',2566,0),('physnet1',2567,0),('physnet1',2568,0),('physnet1',2569,0),('physnet1',2570,0),('physnet1',2571,0),('physnet1',2572,0),('physnet1',2573,0),('physnet1',2574,0),('physnet1',2575,0),('physnet1',2576,0),('physnet1',2577,0),('physnet1',2578,0),('physnet1',2579,0),('physnet1',2580,0),('physnet1',2581,0),('physnet1',2582,0),('physnet1',2583,0),('physnet1',2584,0),('physnet1',2585,0),('physnet1',2586,0),('physnet1',2587,0),('physnet1',2588,0),('physnet1',2589,0),('physnet1',2590,0),('physnet1',2591,0),('physnet1',2592,0),('physnet1',2593,0),('physnet1',2594,0),('physnet1',2595,0),('physnet1',2596,0),('physnet1',2597,0),('physnet1',2598,0),('physnet1',2599,0),('physnet1',2600,0),('physnet1',2601,0),('physnet1',2602,0),('physnet1',2603,0),('physnet1',2604,0),('physnet1',2605,0),('physnet1',2606,0),('physnet1',2607,0),('physnet1',2608,0),('physnet1',2609,0),('physnet1',2610,0),('physnet1',2611,0),('physnet1',2612,0),('physnet1',2613,0),('physnet1',2614,0),('physnet1',2615,0),('physnet1',2616,0),('physnet1',2617,0),('physnet1',2618,0),('physnet1',2619,0),('physnet1',2620,0),('physnet1',2621,0),('physnet1',2622,0),('physnet1',2623,0),('physnet1',2624,0),('physnet1',2625,0),('physnet1',2626,0),('physnet1',2627,0),('physnet1',2628,0),('physnet1',2629,0),('physnet1',2630,0),('physnet1',2631,0),('physnet1',2632,0),('physnet1',2633,0),('physnet1',2634,0),('physnet1',2635,0),('physnet1',2636,0),('physnet1',2637,0),('physnet1',2638,0),('physnet1',2639,0),('physnet1',2640,0),('physnet1',2641,0),('physnet1',2642,0),('physnet1',2643,0),('physnet1',2644,0),('physnet1',2645,0),('physnet1',2646,0),('physnet1',2647,0),('physnet1',2648,0),('physnet1',2649,0),('physnet1',2650,0),('physnet1',2651,0),('physnet1',2652,0),('physnet1',2653,0),('physnet1',2654,0),('physnet1',2655,0),('physnet1',2656,0),('physnet1',2657,0),('physnet1',2658,0),('physnet1',2659,0),('physnet1',2660,0),('physnet1',2661,0),('physnet1',2662,0),('physnet1',2663,0),('physnet1',2664,0),('physnet1',2665,0),('physnet1',2666,0),('physnet1',2667,0),('physnet1',2668,0),('physnet1',2669,0),('physnet1',2670,0),('physnet1',2671,0),('physnet1',2672,0),('physnet1',2673,0),('physnet1',2674,0),('physnet1',2675,0),('physnet1',2676,0),('physnet1',2677,0),('physnet1',2678,0),('physnet1',2679,0),('physnet1',2680,0),('physnet1',2681,0),('physnet1',2682,0),('physnet1',2683,0),('physnet1',2684,0),('physnet1',2685,0),('physnet1',2686,0),('physnet1',2687,0),('physnet1',2688,0),('physnet1',2689,0),('physnet1',2690,0),('physnet1',2691,0),('physnet1',2692,0),('physnet1',2693,0),('physnet1',2694,0),('physnet1',2695,0),('physnet1',2696,0),('physnet1',2697,0),('physnet1',2698,0),('physnet1',2699,0),('physnet1',2700,0),('physnet1',2701,0),('physnet1',2702,0),('physnet1',2703,0),('physnet1',2704,0),('physnet1',2705,0),('physnet1',2706,0),('physnet1',2707,0),('physnet1',2708,0),('physnet1',2709,0),('physnet1',2710,0),('physnet1',2711,0),('physnet1',2712,0),('physnet1',2713,0),('physnet1',2714,0),('physnet1',2715,0),('physnet1',2716,0),('physnet1',2717,0),('physnet1',2718,0),('physnet1',2719,0),('physnet1',2720,0),('physnet1',2721,0),('physnet1',2722,0),('physnet1',2723,0),('physnet1',2724,0),('physnet1',2725,0),('physnet1',2726,0),('physnet1',2727,0),('physnet1',2728,0),('physnet1',2729,0),('physnet1',2730,0),('physnet1',2731,0),('physnet1',2732,0),('physnet1',2733,0),('physnet1',2734,0),('physnet1',2735,0),('physnet1',2736,0),('physnet1',2737,0),('physnet1',2738,0),('physnet1',2739,0),('physnet1',2740,0),('physnet1',2741,0),('physnet1',2742,0),('physnet1',2743,0),('physnet1',2744,0),('physnet1',2745,0),('physnet1',2746,0),('physnet1',2747,0),('physnet1',2748,0),('physnet1',2749,0),('physnet1',2750,0),('physnet1',2751,0),('physnet1',2752,0),('physnet1',2753,0),('physnet1',2754,0),('physnet1',2755,0),('physnet1',2756,0),('physnet1',2757,0),('physnet1',2758,0),('physnet1',2759,0),('physnet1',2760,0),('physnet1',2761,0),('physnet1',2762,0),('physnet1',2763,0),('physnet1',2764,0),('physnet1',2765,0),('physnet1',2766,0),('physnet1',2767,0),('physnet1',2768,0),('physnet1',2769,0),('physnet1',2770,0),('physnet1',2771,0),('physnet1',2772,0),('physnet1',2773,0),('physnet1',2774,0),('physnet1',2775,0),('physnet1',2776,0),('physnet1',2777,0),('physnet1',2778,0),('physnet1',2779,0),('physnet1',2780,0),('physnet1',2781,0),('physnet1',2782,0),('physnet1',2783,0),('physnet1',2784,0),('physnet1',2785,0),('physnet1',2786,0),('physnet1',2787,0),('physnet1',2788,0),('physnet1',2789,0),('physnet1',2790,0),('physnet1',2791,0),('physnet1',2792,0),('physnet1',2793,0),('physnet1',2794,0),('physnet1',2795,0),('physnet1',2796,0),('physnet1',2797,0),('physnet1',2798,0),('physnet1',2799,0),('physnet1',2800,0),('physnet1',2801,0),('physnet1',2802,0),('physnet1',2803,0),('physnet1',2804,0),('physnet1',2805,0),('physnet1',2806,0),('physnet1',2807,0),('physnet1',2808,0),('physnet1',2809,0),('physnet1',2810,0),('physnet1',2811,0),('physnet1',2812,0),('physnet1',2813,0),('physnet1',2814,0),('physnet1',2815,0),('physnet1',2816,0),('physnet1',2817,0),('physnet1',2818,0),('physnet1',2819,0),('physnet1',2820,0),('physnet1',2821,0),('physnet1',2822,0),('physnet1',2823,0),('physnet1',2824,0),('physnet1',2825,0),('physnet1',2826,0),('physnet1',2827,0),('physnet1',2828,0),('physnet1',2829,0),('physnet1',2830,0),('physnet1',2831,0),('physnet1',2832,0),('physnet1',2833,0),('physnet1',2834,0),('physnet1',2835,0),('physnet1',2836,0),('physnet1',2837,0),('physnet1',2838,0),('physnet1',2839,0),('physnet1',2840,0),('physnet1',2841,0),('physnet1',2842,0),('physnet1',2843,0),('physnet1',2844,0),('physnet1',2845,0),('physnet1',2846,0),('physnet1',2847,0),('physnet1',2848,0),('physnet1',2849,0),('physnet1',2850,0),('physnet1',2851,0),('physnet1',2852,0),('physnet1',2853,0),('physnet1',2854,0),('physnet1',2855,0),('physnet1',2856,0),('physnet1',2857,0),('physnet1',2858,0),('physnet1',2859,0),('physnet1',2860,0),('physnet1',2861,0),('physnet1',2862,0),('physnet1',2863,0),('physnet1',2864,0),('physnet1',2865,0),('physnet1',2866,0),('physnet1',2867,0),('physnet1',2868,0),('physnet1',2869,0),('physnet1',2870,0),('physnet1',2871,0),('physnet1',2872,0),('physnet1',2873,0),('physnet1',2874,0),('physnet1',2875,0),('physnet1',2876,0),('physnet1',2877,0),('physnet1',2878,0),('physnet1',2879,0),('physnet1',2880,0),('physnet1',2881,0),('physnet1',2882,0),('physnet1',2883,0),('physnet1',2884,0),('physnet1',2885,0),('physnet1',2886,0),('physnet1',2887,0),('physnet1',2888,0),('physnet1',2889,0),('physnet1',2890,0),('physnet1',2891,0),('physnet1',2892,0),('physnet1',2893,0),('physnet1',2894,0),('physnet1',2895,0),('physnet1',2896,0),('physnet1',2897,0),('physnet1',2898,0),('physnet1',2899,0),('physnet1',2900,0),('physnet1',2901,0),('physnet1',2902,0),('physnet1',2903,0),('physnet1',2904,0),('physnet1',2905,0),('physnet1',2906,0),('physnet1',2907,0),('physnet1',2908,0),('physnet1',2909,0),('physnet1',2910,0),('physnet1',2911,0),('physnet1',2912,0),('physnet1',2913,0),('physnet1',2914,0),('physnet1',2915,0),('physnet1',2916,0),('physnet1',2917,0),('physnet1',2918,0),('physnet1',2919,0),('physnet1',2920,0),('physnet1',2921,0),('physnet1',2922,0),('physnet1',2923,0),('physnet1',2924,0),('physnet1',2925,0),('physnet1',2926,0),('physnet1',2927,0),('physnet1',2928,0),('physnet1',2929,0),('physnet1',2930,0),('physnet1',2931,0),('physnet1',2932,0),('physnet1',2933,0),('physnet1',2934,0),('physnet1',2935,0),('physnet1',2936,0),('physnet1',2937,0),('physnet1',2938,0),('physnet1',2939,0),('physnet1',2940,0),('physnet1',2941,0),('physnet1',2942,0),('physnet1',2943,0),('physnet1',2944,0),('physnet1',2945,0),('physnet1',2946,0),('physnet1',2947,0),('physnet1',2948,0),('physnet1',2949,0),('physnet1',2950,0),('physnet1',2951,0),('physnet1',2952,0),('physnet1',2953,0),('physnet1',2954,0),('physnet1',2955,0),('physnet1',2956,0),('physnet1',2957,0),('physnet1',2958,0),('physnet1',2959,0),('physnet1',2960,0),('physnet1',2961,0),('physnet1',2962,0),('physnet1',2963,0),('physnet1',2964,0),('physnet1',2965,0),('physnet1',2966,0),('physnet1',2967,0),('physnet1',2968,0),('physnet1',2969,0),('physnet1',2970,0),('physnet1',2971,0),('physnet1',2972,0),('physnet1',2973,0),('physnet1',2974,0),('physnet1',2975,0),('physnet1',2976,0),('physnet1',2977,0),('physnet1',2978,0),('physnet1',2979,0),('physnet1',2980,0),('physnet1',2981,0),('physnet1',2982,0),('physnet1',2983,0),('physnet1',2984,0),('physnet1',2985,0),('physnet1',2986,0),('physnet1',2987,0),('physnet1',2988,0),('physnet1',2989,0),('physnet1',2990,0),('physnet1',2991,0),('physnet1',2992,0),('physnet1',2993,0),('physnet1',2994,0),('physnet1',2995,0),('physnet1',2996,0),('physnet1',2997,0),('physnet1',2998,0),('physnet1',2999,0);
/*!40000 ALTER TABLE `ml2_vlan_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_vxlan_allocations`
--

DROP TABLE IF EXISTS `ml2_vxlan_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_vxlan_allocations` (
  `vxlan_vni` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL,
  PRIMARY KEY (`vxlan_vni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_vxlan_allocations`
--

LOCK TABLES `ml2_vxlan_allocations` WRITE;
/*!40000 ALTER TABLE `ml2_vxlan_allocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_vxlan_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_vxlan_endpoints`
--

DROP TABLE IF EXISTS `ml2_vxlan_endpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_vxlan_endpoints` (
  `ip_address` varchar(64) NOT NULL DEFAULT '',
  `udp_port` int(11) NOT NULL,
  PRIMARY KEY (`ip_address`,`udp_port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_vxlan_endpoints`
--

LOCK TABLES `ml2_vxlan_endpoints` WRITE;
/*!40000 ALTER TABLE `ml2_vxlan_endpoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_vxlan_endpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkdhcpagentbindings`
--

DROP TABLE IF EXISTS `networkdhcpagentbindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkdhcpagentbindings` (
  `network_id` varchar(36) NOT NULL,
  `dhcp_agent_id` varchar(36) NOT NULL,
  PRIMARY KEY (`network_id`,`dhcp_agent_id`),
  KEY `dhcp_agent_id` (`dhcp_agent_id`),
  CONSTRAINT `networkdhcpagentbindings_ibfk_1` FOREIGN KEY (`dhcp_agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `networkdhcpagentbindings_ibfk_2` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkdhcpagentbindings`
--

LOCK TABLES `networkdhcpagentbindings` WRITE;
/*!40000 ALTER TABLE `networkdhcpagentbindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `networkdhcpagentbindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networks`
--

DROP TABLE IF EXISTS `networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networks` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `admin_state_up` tinyint(1) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networks`
--

LOCK TABLES `networks` WRITE;
/*!40000 ALTER TABLE `networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ports`
--

DROP TABLE IF EXISTS `ports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ports` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `network_id` varchar(36) NOT NULL,
  `mac_address` varchar(32) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `status` varchar(16) NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `device_owner` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `network_id` (`network_id`),
  CONSTRAINT `ports_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ports`
--

LOCK TABLES `ports` WRITE;
/*!40000 ALTER TABLE `ports` DISABLE KEYS */;
/*!40000 ALTER TABLE `ports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providerresourceassociations`
--

DROP TABLE IF EXISTS `providerresourceassociations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providerresourceassociations` (
  `provider_name` varchar(255) NOT NULL,
  `resource_id` varchar(36) NOT NULL,
  PRIMARY KEY (`provider_name`,`resource_id`),
  UNIQUE KEY `resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providerresourceassociations`
--

LOCK TABLES `providerresourceassociations` WRITE;
/*!40000 ALTER TABLE `providerresourceassociations` DISABLE KEYS */;
/*!40000 ALTER TABLE `providerresourceassociations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotas`
--

DROP TABLE IF EXISTS `quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotas` (
  `id` varchar(36) NOT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_quotas_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotas`
--

LOCK TABLES `quotas` WRITE;
/*!40000 ALTER TABLE `quotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routerl3agentbindings`
--

DROP TABLE IF EXISTS `routerl3agentbindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routerl3agentbindings` (
  `id` varchar(36) NOT NULL,
  `router_id` varchar(36) DEFAULT NULL,
  `l3_agent_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `l3_agent_id` (`l3_agent_id`),
  KEY `router_id` (`router_id`),
  CONSTRAINT `routerl3agentbindings_ibfk_1` FOREIGN KEY (`l3_agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `routerl3agentbindings_ibfk_2` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routerl3agentbindings`
--

LOCK TABLES `routerl3agentbindings` WRITE;
/*!40000 ALTER TABLE `routerl3agentbindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `routerl3agentbindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routerroutes`
--

DROP TABLE IF EXISTS `routerroutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routerroutes` (
  `destination` varchar(64) NOT NULL,
  `nexthop` varchar(64) NOT NULL,
  `router_id` varchar(36) NOT NULL,
  PRIMARY KEY (`destination`,`nexthop`,`router_id`),
  KEY `router_id` (`router_id`),
  CONSTRAINT `routerroutes_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routerroutes`
--

LOCK TABLES `routerroutes` WRITE;
/*!40000 ALTER TABLE `routerroutes` DISABLE KEYS */;
/*!40000 ALTER TABLE `routerroutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routers`
--

DROP TABLE IF EXISTS `routers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routers` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `admin_state_up` tinyint(1) DEFAULT NULL,
  `gw_port_id` varchar(36) DEFAULT NULL,
  `enable_snat` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `gw_port_id` (`gw_port_id`),
  CONSTRAINT `routers_ibfk_1` FOREIGN KEY (`gw_port_id`) REFERENCES `ports` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routers`
--

LOCK TABLES `routers` WRITE;
/*!40000 ALTER TABLE `routers` DISABLE KEYS */;
/*!40000 ALTER TABLE `routers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroupportbindings`
--

DROP TABLE IF EXISTS `securitygroupportbindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygroupportbindings` (
  `port_id` varchar(36) NOT NULL,
  `security_group_id` varchar(36) NOT NULL,
  PRIMARY KEY (`port_id`,`security_group_id`),
  KEY `security_group_id` (`security_group_id`),
  CONSTRAINT `securitygroupportbindings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `securitygroupportbindings_ibfk_2` FOREIGN KEY (`security_group_id`) REFERENCES `securitygroups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroupportbindings`
--

LOCK TABLES `securitygroupportbindings` WRITE;
/*!40000 ALTER TABLE `securitygroupportbindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygroupportbindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygrouprules`
--

DROP TABLE IF EXISTS `securitygrouprules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygrouprules` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `security_group_id` varchar(36) NOT NULL,
  `remote_group_id` varchar(36) DEFAULT NULL,
  `direction` enum('ingress','egress') DEFAULT NULL,
  `ethertype` varchar(40) DEFAULT NULL,
  `protocol` varchar(40) DEFAULT NULL,
  `port_range_min` int(11) DEFAULT NULL,
  `port_range_max` int(11) DEFAULT NULL,
  `remote_ip_prefix` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `security_group_id` (`security_group_id`),
  KEY `remote_group_id` (`remote_group_id`),
  CONSTRAINT `securitygrouprules_ibfk_1` FOREIGN KEY (`security_group_id`) REFERENCES `securitygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `securitygrouprules_ibfk_2` FOREIGN KEY (`remote_group_id`) REFERENCES `securitygroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygrouprules`
--

LOCK TABLES `securitygrouprules` WRITE;
/*!40000 ALTER TABLE `securitygrouprules` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygrouprules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroups`
--

DROP TABLE IF EXISTS `securitygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygroups` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroups`
--

LOCK TABLES `securitygroups` WRITE;
/*!40000 ALTER TABLE `securitygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicedefinitions`
--

DROP TABLE IF EXISTS `servicedefinitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicedefinitions` (
  `id` varchar(36) NOT NULL,
  `service_class` varchar(255) NOT NULL,
  `plugin` varchar(255) DEFAULT NULL,
  `driver` varchar(255) DEFAULT NULL,
  `service_type_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`,`service_class`,`service_type_id`),
  KEY `servicedefinitions_ibfk_1` (`service_type_id`),
  CONSTRAINT `servicedefinitions_ibfk_1` FOREIGN KEY (`service_type_id`) REFERENCES `servicetypes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicedefinitions`
--

LOCK TABLES `servicedefinitions` WRITE;
/*!40000 ALTER TABLE `servicedefinitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicedefinitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicetypes`
--

DROP TABLE IF EXISTS `servicetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicetypes` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `default` tinyint(1) NOT NULL,
  `num_instances` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicetypes`
--

LOCK TABLES `servicetypes` WRITE;
/*!40000 ALTER TABLE `servicetypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subnetroutes`
--

DROP TABLE IF EXISTS `subnetroutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subnetroutes` (
  `destination` varchar(64) NOT NULL,
  `nexthop` varchar(64) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  PRIMARY KEY (`destination`,`nexthop`,`subnet_id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `subnetroutes_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subnetroutes`
--

LOCK TABLES `subnetroutes` WRITE;
/*!40000 ALTER TABLE `subnetroutes` DISABLE KEYS */;
/*!40000 ALTER TABLE `subnetroutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subnets`
--

DROP TABLE IF EXISTS `subnets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subnets` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `network_id` varchar(36) DEFAULT NULL,
  `ip_version` int(11) NOT NULL,
  `cidr` varchar(64) NOT NULL,
  `gateway_ip` varchar(64) DEFAULT NULL,
  `enable_dhcp` tinyint(1) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `ipv6_ra_mode` enum('slaac','dhcpv6-stateful','dhcpv6-stateless') DEFAULT NULL,
  `ipv6_address_mode` enum('slaac','dhcpv6-stateful','dhcpv6-stateless') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `network_id` (`network_id`),
  CONSTRAINT `subnets_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subnets`
--

LOCK TABLES `subnets` WRITE;
/*!40000 ALTER TABLE `subnets` DISABLE KEYS */;
/*!40000 ALTER TABLE `subnets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vpnservices`
--

DROP TABLE IF EXISTS `vpnservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpnservices` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(16) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  `router_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `router_id` (`router_id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `vpnservices_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`),
  CONSTRAINT `vpnservices_ibfk_2` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vpnservices`
--

LOCK TABLES `vpnservices` WRITE;
/*!40000 ALTER TABLE `vpnservices` DISABLE KEYS */;
/*!40000 ALTER TABLE `vpnservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'neutron'
--

--
-- Current Database: `nova`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `nova` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `nova`;

--
-- Table structure for table `agent_builds`
--

DROP TABLE IF EXISTS `agent_builds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent_builds` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hypervisor` varchar(255) DEFAULT NULL,
  `os` varchar(255) DEFAULT NULL,
  `architecture` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `md5hash` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_agent_builds0hypervisor0os0architecture0deleted` (`hypervisor`,`os`,`architecture`,`deleted`),
  KEY `agent_builds_hypervisor_os_arch_idx` (`hypervisor`,`os`,`architecture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent_builds`
--

LOCK TABLES `agent_builds` WRITE;
/*!40000 ALTER TABLE `agent_builds` DISABLE KEYS */;
/*!40000 ALTER TABLE `agent_builds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aggregate_hosts`
--

DROP TABLE IF EXISTS `aggregate_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aggregate_hosts` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) DEFAULT NULL,
  `aggregate_id` int(11) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_aggregate_hosts0host0aggregate_id0deleted` (`host`,`aggregate_id`,`deleted`),
  KEY `aggregate_id` (`aggregate_id`),
  CONSTRAINT `aggregate_hosts_ibfk_1` FOREIGN KEY (`aggregate_id`) REFERENCES `aggregates` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aggregate_hosts`
--

LOCK TABLES `aggregate_hosts` WRITE;
/*!40000 ALTER TABLE `aggregate_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `aggregate_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aggregate_metadata`
--

DROP TABLE IF EXISTS `aggregate_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aggregate_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aggregate_id` int(11) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_aggregate_metadata0aggregate_id0key0deleted` (`aggregate_id`,`key`,`deleted`),
  KEY `aggregate_metadata_key_idx` (`key`),
  CONSTRAINT `aggregate_metadata_ibfk_1` FOREIGN KEY (`aggregate_id`) REFERENCES `aggregates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aggregate_metadata`
--

LOCK TABLES `aggregate_metadata` WRITE;
/*!40000 ALTER TABLE `aggregate_metadata` DISABLE KEYS */;
INSERT INTO `aggregate_metadata` VALUES ('2016-06-20 15:17:58',NULL,NULL,1,1,'availability_zone','serv-login',0);
/*!40000 ALTER TABLE `aggregate_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aggregates`
--

DROP TABLE IF EXISTS `aggregates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aggregates` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aggregates`
--

LOCK TABLES `aggregates` WRITE;
/*!40000 ALTER TABLE `aggregates` DISABLE KEYS */;
INSERT INTO `aggregates` VALUES ('2016-06-20 15:17:58',NULL,NULL,1,'service-and-login',0);
/*!40000 ALTER TABLE `aggregates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_device_mapping`
--

DROP TABLE IF EXISTS `block_device_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_device_mapping` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_name` varchar(255) DEFAULT NULL,
  `delete_on_termination` tinyint(1) DEFAULT NULL,
  `snapshot_id` varchar(36) DEFAULT NULL,
  `volume_id` varchar(36) DEFAULT NULL,
  `volume_size` int(11) DEFAULT NULL,
  `no_device` tinyint(1) DEFAULT NULL,
  `connection_info` mediumtext,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `source_type` varchar(255) DEFAULT NULL,
  `destination_type` varchar(255) DEFAULT NULL,
  `guest_format` varchar(255) DEFAULT NULL,
  `device_type` varchar(255) DEFAULT NULL,
  `disk_bus` varchar(255) DEFAULT NULL,
  `boot_index` int(11) DEFAULT NULL,
  `image_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `snapshot_id` (`snapshot_id`),
  KEY `volume_id` (`volume_id`),
  KEY `block_device_mapping_instance_uuid_idx` (`instance_uuid`),
  KEY `block_device_mapping_instance_uuid_device_name_idx` (`instance_uuid`,`device_name`),
  KEY `block_device_mapping_instance_uuid_virtual_name_device_name_idx` (`instance_uuid`,`device_name`),
  KEY `block_device_mapping_instance_uuid_volume_id_idx` (`instance_uuid`,`volume_id`),
  CONSTRAINT `block_device_mapping_instance_uuid_fkey` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_device_mapping`
--

LOCK TABLES `block_device_mapping` WRITE;
/*!40000 ALTER TABLE `block_device_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `block_device_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bw_usage_cache`
--

DROP TABLE IF EXISTS `bw_usage_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bw_usage_cache` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_period` datetime NOT NULL,
  `last_refreshed` datetime DEFAULT NULL,
  `bw_in` bigint(20) DEFAULT NULL,
  `bw_out` bigint(20) DEFAULT NULL,
  `mac` varchar(255) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `last_ctr_in` bigint(20) DEFAULT NULL,
  `last_ctr_out` bigint(20) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bw_usage_cache_uuid_start_period_idx` (`uuid`,`start_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bw_usage_cache`
--

LOCK TABLES `bw_usage_cache` WRITE;
/*!40000 ALTER TABLE `bw_usage_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `bw_usage_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cells`
--

DROP TABLE IF EXISTS `cells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cells` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_url` varchar(255) DEFAULT NULL,
  `weight_offset` float DEFAULT NULL,
  `weight_scale` float DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `is_parent` tinyint(1) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `transport_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_cells0name0deleted` (`name`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cells`
--

LOCK TABLES `cells` WRITE;
/*!40000 ALTER TABLE `cells` DISABLE KEYS */;
/*!40000 ALTER TABLE `cells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `certificates_project_id_deleted_idx` (`project_id`,`deleted`),
  KEY `certificates_user_id_deleted_idx` (`user_id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates`
--

LOCK TABLES `certificates` WRITE;
/*!40000 ALTER TABLE `certificates` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compute_nodes`
--

DROP TABLE IF EXISTS `compute_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compute_nodes` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL,
  `vcpus` int(11) NOT NULL,
  `memory_mb` int(11) NOT NULL,
  `local_gb` int(11) NOT NULL,
  `vcpus_used` int(11) NOT NULL,
  `memory_mb_used` int(11) NOT NULL,
  `local_gb_used` int(11) NOT NULL,
  `hypervisor_type` mediumtext NOT NULL,
  `hypervisor_version` int(11) NOT NULL,
  `cpu_info` mediumtext NOT NULL,
  `disk_available_least` int(11) DEFAULT NULL,
  `free_ram_mb` int(11) DEFAULT NULL,
  `free_disk_gb` int(11) DEFAULT NULL,
  `current_workload` int(11) DEFAULT NULL,
  `running_vms` int(11) DEFAULT NULL,
  `hypervisor_hostname` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `host_ip` varchar(39) DEFAULT NULL,
  `supported_instances` text,
  `pci_stats` text,
  `metrics` text,
  `extra_resources` text,
  `stats` text,
  PRIMARY KEY (`id`),
  KEY `fk_compute_nodes_service_id` (`service_id`),
  CONSTRAINT `fk_compute_nodes_service_id` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compute_nodes`
--

LOCK TABLES `compute_nodes` WRITE;
/*!40000 ALTER TABLE `compute_nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `compute_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `console_pools`
--

DROP TABLE IF EXISTS `console_pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `console_pools` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(39) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `console_type` varchar(255) DEFAULT NULL,
  `public_hostname` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `compute_host` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_console_pools0host0console_type0compute_host0deleted` (`host`,`console_type`,`compute_host`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `console_pools`
--

LOCK TABLES `console_pools` WRITE;
/*!40000 ALTER TABLE `console_pools` DISABLE KEYS */;
/*!40000 ALTER TABLE `console_pools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consoles`
--

DROP TABLE IF EXISTS `consoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consoles` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `pool_id` int(11) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pool_id` (`pool_id`),
  KEY `consoles_instance_uuid_idx` (`instance_uuid`),
  CONSTRAINT `consoles_ibfk_1` FOREIGN KEY (`pool_id`) REFERENCES `console_pools` (`id`),
  CONSTRAINT `consoles_instance_uuid_fkey` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consoles`
--

LOCK TABLES `consoles` WRITE;
/*!40000 ALTER TABLE `consoles` DISABLE KEYS */;
/*!40000 ALTER TABLE `consoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dns_domains`
--

DROP TABLE IF EXISTS `dns_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dns_domains` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `domain` varchar(255) NOT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`domain`),
  KEY `project_id` (`project_id`),
  KEY `dns_domains_domain_deleted_idx` (`domain`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dns_domains`
--

LOCK TABLES `dns_domains` WRITE;
/*!40000 ALTER TABLE `dns_domains` DISABLE KEYS */;
/*!40000 ALTER TABLE `dns_domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixed_ips`
--

DROP TABLE IF EXISTS `fixed_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixed_ips` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(39) DEFAULT NULL,
  `network_id` int(11) DEFAULT NULL,
  `allocated` tinyint(1) DEFAULT NULL,
  `leased` tinyint(1) DEFAULT NULL,
  `reserved` tinyint(1) DEFAULT NULL,
  `virtual_interface_id` int(11) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_fixed_ips0address0deleted` (`address`,`deleted`),
  KEY `network_id` (`network_id`),
  KEY `fixed_ips_virtual_interface_id_fkey` (`virtual_interface_id`),
  KEY `address` (`address`),
  KEY `fixed_ips_instance_uuid_fkey` (`instance_uuid`),
  KEY `fixed_ips_host_idx` (`host`),
  KEY `fixed_ips_network_id_host_deleted_idx` (`network_id`,`host`,`deleted`),
  KEY `fixed_ips_address_reserved_network_id_deleted_idx` (`address`,`reserved`,`network_id`,`deleted`),
  KEY `fixed_ips_deleted_allocated_idx` (`address`,`deleted`,`allocated`),
  CONSTRAINT `fixed_ips_instance_uuid_fkey` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixed_ips`
--

LOCK TABLES `fixed_ips` WRITE;
/*!40000 ALTER TABLE `fixed_ips` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixed_ips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floating_ips`
--

DROP TABLE IF EXISTS `floating_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `floating_ips` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(39) DEFAULT NULL,
  `fixed_ip_id` int(11) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `auto_assigned` tinyint(1) DEFAULT NULL,
  `pool` varchar(255) DEFAULT NULL,
  `interface` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_floating_ips0address0deleted` (`address`,`deleted`),
  KEY `fixed_ip_id` (`fixed_ip_id`),
  KEY `floating_ips_host_idx` (`host`),
  KEY `floating_ips_project_id_idx` (`project_id`),
  KEY `floating_ips_pool_deleted_fixed_ip_id_project_id_idx` (`pool`,`deleted`,`fixed_ip_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floating_ips`
--

LOCK TABLES `floating_ips` WRITE;
/*!40000 ALTER TABLE `floating_ips` DISABLE KEYS */;
/*!40000 ALTER TABLE `floating_ips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_actions`
--

DROP TABLE IF EXISTS `instance_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_actions` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `request_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instance_uuid_idx` (`instance_uuid`),
  KEY `request_id_idx` (`request_id`),
  CONSTRAINT `fk_instance_actions_instance_uuid` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_actions`
--

LOCK TABLES `instance_actions` WRITE;
/*!40000 ALTER TABLE `instance_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_actions_events`
--

DROP TABLE IF EXISTS `instance_actions_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_actions_events` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` varchar(255) DEFAULT NULL,
  `action_id` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `traceback` text,
  `deleted` int(11) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `details` text,
  PRIMARY KEY (`id`),
  KEY `action_id` (`action_id`),
  CONSTRAINT `instance_actions_events_ibfk_1` FOREIGN KEY (`action_id`) REFERENCES `instance_actions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_actions_events`
--

LOCK TABLES `instance_actions_events` WRITE;
/*!40000 ALTER TABLE `instance_actions_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_actions_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_faults`
--

DROP TABLE IF EXISTS `instance_faults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_faults` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `code` int(11) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `details` mediumtext,
  `host` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instance_faults_host_idx` (`host`),
  KEY `instance_faults_instance_uuid_deleted_created_at_idx` (`instance_uuid`,`deleted`,`created_at`),
  CONSTRAINT `fk_instance_faults_instance_uuid` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_faults`
--

LOCK TABLES `instance_faults` WRITE;
/*!40000 ALTER TABLE `instance_faults` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_faults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_group_member`
--

DROP TABLE IF EXISTS `instance_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_group_member` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` varchar(255) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `instance_group_member_instance_idx` (`instance_id`),
  CONSTRAINT `instance_group_member_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `instance_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_group_member`
--

LOCK TABLES `instance_group_member` WRITE;
/*!40000 ALTER TABLE `instance_group_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_group_metadata`
--

DROP TABLE IF EXISTS `instance_group_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_group_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `instance_group_metadata_key_idx` (`key`),
  CONSTRAINT `instance_group_metadata_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `instance_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_group_metadata`
--

LOCK TABLES `instance_group_metadata` WRITE;
/*!40000 ALTER TABLE `instance_group_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_group_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_group_policy`
--

DROP TABLE IF EXISTS `instance_group_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_group_policy` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `policy` varchar(255) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `instance_group_policy_policy_idx` (`policy`),
  CONSTRAINT `instance_group_policy_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `instance_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_group_policy`
--

LOCK TABLES `instance_group_policy` WRITE;
/*!40000 ALTER TABLE `instance_group_policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_group_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_groups`
--

DROP TABLE IF EXISTS `instance_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_groups` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `uuid` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_instance_groups0uuid0deleted` (`uuid`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_groups`
--

LOCK TABLES `instance_groups` WRITE;
/*!40000 ALTER TABLE `instance_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_id_mappings`
--

DROP TABLE IF EXISTS `instance_id_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_id_mappings` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_instance_id_mappings_uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_id_mappings`
--

LOCK TABLES `instance_id_mappings` WRITE;
/*!40000 ALTER TABLE `instance_id_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_id_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_info_caches`
--

DROP TABLE IF EXISTS `instance_info_caches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_info_caches` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_info` mediumtext,
  `instance_uuid` varchar(36) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_instance_info_caches0instance_uuid` (`instance_uuid`),
  CONSTRAINT `instance_info_caches_instance_uuid_fkey` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_info_caches`
--

LOCK TABLES `instance_info_caches` WRITE;
/*!40000 ALTER TABLE `instance_info_caches` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_info_caches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_metadata`
--

DROP TABLE IF EXISTS `instance_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instance_metadata_instance_uuid_idx` (`instance_uuid`),
  CONSTRAINT `instance_metadata_instance_uuid_fkey` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_metadata`
--

LOCK TABLES `instance_metadata` WRITE;
/*!40000 ALTER TABLE `instance_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_system_metadata`
--

DROP TABLE IF EXISTS `instance_system_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_system_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_uuid` varchar(36) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instance_uuid` (`instance_uuid`),
  CONSTRAINT `instance_system_metadata_ibfk_1` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_system_metadata`
--

LOCK TABLES `instance_system_metadata` WRITE;
/*!40000 ALTER TABLE `instance_system_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_system_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_type_extra_specs`
--

DROP TABLE IF EXISTS `instance_type_extra_specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_type_extra_specs` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_type_id` int(11) NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_instance_type_extra_specs0instance_type_id0key0deleted` (`instance_type_id`,`key`,`deleted`),
  KEY `instance_type_extra_specs_instance_type_id_key_idx` (`instance_type_id`,`key`),
  CONSTRAINT `instance_type_extra_specs_ibfk_1` FOREIGN KEY (`instance_type_id`) REFERENCES `instance_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_type_extra_specs`
--

LOCK TABLES `instance_type_extra_specs` WRITE;
/*!40000 ALTER TABLE `instance_type_extra_specs` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_type_extra_specs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_type_projects`
--

DROP TABLE IF EXISTS `instance_type_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_type_projects` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_type_id` int(11) NOT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_instance_type_projects0instance_type_id0project_id0deleted` (`instance_type_id`,`project_id`,`deleted`),
  KEY `instance_type_id` (`instance_type_id`),
  CONSTRAINT `instance_type_projects_ibfk_1` FOREIGN KEY (`instance_type_id`) REFERENCES `instance_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_type_projects`
--

LOCK TABLES `instance_type_projects` WRITE;
/*!40000 ALTER TABLE `instance_type_projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_type_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_types`
--

DROP TABLE IF EXISTS `instance_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_types` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `memory_mb` int(11) NOT NULL,
  `vcpus` int(11) NOT NULL,
  `swap` int(11) NOT NULL,
  `vcpu_weight` int(11) DEFAULT NULL,
  `flavorid` varchar(255) DEFAULT NULL,
  `rxtx_factor` float DEFAULT NULL,
  `root_gb` int(11) DEFAULT NULL,
  `ephemeral_gb` int(11) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_instance_types0name0deleted` (`name`,`deleted`),
  UNIQUE KEY `uniq_instance_types0flavorid0deleted` (`flavorid`,`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_types`
--

LOCK TABLES `instance_types` WRITE;
/*!40000 ALTER TABLE `instance_types` DISABLE KEYS */;
INSERT INTO `instance_types` VALUES (NULL,NULL,NULL,'m1.medium',1,4096,2,0,NULL,'3',1,40,0,0,1,0),(NULL,NULL,NULL,'m1.tiny',2,512,1,0,NULL,'1',1,1,0,0,1,0),(NULL,NULL,NULL,'m1.large',3,8192,4,0,NULL,'4',1,80,0,0,1,0),(NULL,NULL,NULL,'m1.xlarge',4,16384,8,0,NULL,'5',1,160,0,0,1,0),(NULL,NULL,NULL,'m1.small',5,2048,1,0,NULL,'2',1,20,0,0,1,0),('2016-06-20 15:17:54',NULL,NULL,'mosler.1core',6,500,1,0,NULL,'99f16c0d-0155-4570-b0fc-4de1457260ed',1,10,0,0,1,0),('2016-06-20 15:17:55',NULL,NULL,'mosler.2cores',7,500,1,0,NULL,'ce442cf4-6f71-4688-842a-12ea1b4ae023',1,10,0,0,1,0),('2016-06-20 15:17:56',NULL,NULL,'mosler.4cores',8,500,1,0,NULL,'125de737-3ea9-412d-87f1-c5e475affbdf',1,10,0,0,1,0),('2016-06-20 15:17:57',NULL,NULL,'mosler.8cores',9,500,1,0,NULL,'046bed8e-3404-479d-95f1-ecdb413c0891',1,10,0,0,1,0),('2016-06-20 15:17:57',NULL,NULL,'mosler.16cores',10,500,1,0,NULL,'ae144117-011e-4f1e-90f7-b983fab69b81',1,10,0,0,1,0);
/*!40000 ALTER TABLE `instance_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instances`
--

DROP TABLE IF EXISTS `instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instances` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `internal_id` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `image_ref` varchar(255) DEFAULT NULL,
  `kernel_id` varchar(255) DEFAULT NULL,
  `ramdisk_id` varchar(255) DEFAULT NULL,
  `launch_index` int(11) DEFAULT NULL,
  `key_name` varchar(255) DEFAULT NULL,
  `key_data` mediumtext,
  `power_state` int(11) DEFAULT NULL,
  `vm_state` varchar(255) DEFAULT NULL,
  `memory_mb` int(11) DEFAULT NULL,
  `vcpus` int(11) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `user_data` mediumtext,
  `reservation_id` varchar(255) DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `launched_at` datetime DEFAULT NULL,
  `terminated_at` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `display_description` varchar(255) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `os_type` varchar(255) DEFAULT NULL,
  `launched_on` mediumtext,
  `instance_type_id` int(11) DEFAULT NULL,
  `vm_mode` varchar(255) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `architecture` varchar(255) DEFAULT NULL,
  `root_device_name` varchar(255) DEFAULT NULL,
  `access_ip_v4` varchar(39) DEFAULT NULL,
  `access_ip_v6` varchar(39) DEFAULT NULL,
  `config_drive` varchar(255) DEFAULT NULL,
  `task_state` varchar(255) DEFAULT NULL,
  `default_ephemeral_device` varchar(255) DEFAULT NULL,
  `default_swap_device` varchar(255) DEFAULT NULL,
  `progress` int(11) DEFAULT NULL,
  `auto_disk_config` tinyint(1) DEFAULT NULL,
  `shutdown_terminate` tinyint(1) DEFAULT NULL,
  `disable_terminate` tinyint(1) DEFAULT NULL,
  `root_gb` int(11) DEFAULT NULL,
  `ephemeral_gb` int(11) DEFAULT NULL,
  `cell_name` varchar(255) DEFAULT NULL,
  `node` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `locked_by` enum('owner','admin') DEFAULT NULL,
  `cleaned` int(11) DEFAULT NULL,
  `ephemeral_key_uuid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `project_id` (`project_id`),
  KEY `instances_reservation_id_idx` (`reservation_id`),
  KEY `instances_terminated_at_launched_at_idx` (`terminated_at`,`launched_at`),
  KEY `instances_task_state_updated_at_idx` (`task_state`,`updated_at`),
  KEY `instances_host_deleted_idx` (`host`,`deleted`),
  KEY `instances_uuid_deleted_idx` (`uuid`,`deleted`),
  KEY `instances_host_node_deleted_idx` (`host`,`node`,`deleted`),
  KEY `instances_host_deleted_cleaned_idx` (`host`,`deleted`,`cleaned`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instances`
--

LOCK TABLES `instances` WRITE;
/*!40000 ALTER TABLE `instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iscsi_targets`
--

DROP TABLE IF EXISTS `iscsi_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iscsi_targets` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_num` int(11) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `volume_id` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `iscsi_targets_volume_id_fkey` (`volume_id`),
  KEY `iscsi_targets_host_idx` (`host`),
  KEY `iscsi_targets_host_volume_id_deleted_idx` (`host`,`volume_id`,`deleted`),
  CONSTRAINT `iscsi_targets_volume_id_fkey` FOREIGN KEY (`volume_id`) REFERENCES `volumes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iscsi_targets`
--

LOCK TABLES `iscsi_targets` WRITE;
/*!40000 ALTER TABLE `iscsi_targets` DISABLE KEYS */;
/*!40000 ALTER TABLE `iscsi_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `key_pairs`
--

DROP TABLE IF EXISTS `key_pairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `key_pairs` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `fingerprint` varchar(255) DEFAULT NULL,
  `public_key` mediumtext,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_key_pairs0user_id0name0deleted` (`user_id`,`name`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `key_pairs`
--

LOCK TABLES `key_pairs` WRITE;
/*!40000 ALTER TABLE `key_pairs` DISABLE KEYS */;
/*!40000 ALTER TABLE `key_pairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrate_version`
--

DROP TABLE IF EXISTS `migrate_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrate_version` (
  `repository_id` varchar(250) NOT NULL,
  `repository_path` text,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrate_version`
--

LOCK TABLES `migrate_version` WRITE;
/*!40000 ALTER TABLE `migrate_version` DISABLE KEYS */;
INSERT INTO `migrate_version` VALUES ('nova','/usr/lib/python2.6/site-packages/nova/db/sqlalchemy/migrate_repo',234);
/*!40000 ALTER TABLE `migrate_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_compute` varchar(255) DEFAULT NULL,
  `dest_compute` varchar(255) DEFAULT NULL,
  `dest_host` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `old_instance_type_id` int(11) DEFAULT NULL,
  `new_instance_type_id` int(11) DEFAULT NULL,
  `source_node` varchar(255) DEFAULT NULL,
  `dest_node` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `migrations_by_host_nodes_and_status_idx` (`deleted`,`source_compute`(100),`dest_compute`(100),`source_node`(100),`dest_node`(100),`status`),
  KEY `migrations_instance_uuid_and_status_idx` (`deleted`,`instance_uuid`,`status`),
  KEY `fk_migrations_instance_uuid` (`instance_uuid`),
  CONSTRAINT `fk_migrations_instance_uuid` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networks`
--

DROP TABLE IF EXISTS `networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networks` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `injected` tinyint(1) DEFAULT NULL,
  `cidr` varchar(43) DEFAULT NULL,
  `netmask` varchar(39) DEFAULT NULL,
  `bridge` varchar(255) DEFAULT NULL,
  `gateway` varchar(39) DEFAULT NULL,
  `broadcast` varchar(39) DEFAULT NULL,
  `dns1` varchar(39) DEFAULT NULL,
  `vlan` int(11) DEFAULT NULL,
  `vpn_public_address` varchar(39) DEFAULT NULL,
  `vpn_public_port` int(11) DEFAULT NULL,
  `vpn_private_address` varchar(39) DEFAULT NULL,
  `dhcp_start` varchar(39) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `cidr_v6` varchar(43) DEFAULT NULL,
  `gateway_v6` varchar(39) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `netmask_v6` varchar(39) DEFAULT NULL,
  `bridge_interface` varchar(255) DEFAULT NULL,
  `multi_host` tinyint(1) DEFAULT NULL,
  `dns2` varchar(39) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `rxtx_base` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_networks0vlan0deleted` (`vlan`,`deleted`),
  KEY `networks_host_idx` (`host`),
  KEY `networks_cidr_v6_idx` (`cidr_v6`),
  KEY `networks_bridge_deleted_idx` (`bridge`,`deleted`),
  KEY `networks_project_id_deleted_idx` (`project_id`,`deleted`),
  KEY `networks_uuid_project_id_deleted_idx` (`uuid`,`project_id`,`deleted`),
  KEY `networks_vlan_deleted_idx` (`vlan`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networks`
--

LOCK TABLES `networks` WRITE;
/*!40000 ALTER TABLE `networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pci_devices`
--

DROP TABLE IF EXISTS `pci_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pci_devices` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compute_node_id` int(11) NOT NULL,
  `address` varchar(12) NOT NULL,
  `product_id` varchar(4) DEFAULT NULL,
  `vendor_id` varchar(4) DEFAULT NULL,
  `dev_type` varchar(8) DEFAULT NULL,
  `dev_id` varchar(255) DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  `status` varchar(36) NOT NULL,
  `extra_info` text,
  `instance_uuid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_pci_devices0compute_node_id0address0deleted` (`compute_node_id`,`address`,`deleted`),
  KEY `ix_pci_devices_compute_node_id_deleted` (`compute_node_id`,`deleted`),
  KEY `ix_pci_devices_instance_uuid_deleted` (`instance_uuid`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pci_devices`
--

LOCK TABLES `pci_devices` WRITE;
/*!40000 ALTER TABLE `pci_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `pci_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_user_quotas`
--

DROP TABLE IF EXISTS `project_user_quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_user_quotas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `project_id` varchar(255) NOT NULL,
  `resource` varchar(255) NOT NULL,
  `hard_limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_project_user_quotas0user_id0project_id0resource0deleted` (`user_id`,`project_id`,`resource`,`deleted`),
  KEY `project_user_quotas_project_id_deleted_idx` (`project_id`,`deleted`),
  KEY `project_user_quotas_user_id_deleted_idx` (`user_id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_user_quotas`
--

LOCK TABLES `project_user_quotas` WRITE;
/*!40000 ALTER TABLE `project_user_quotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_user_quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_fw_rules`
--

DROP TABLE IF EXISTS `provider_fw_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_fw_rules` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `protocol` varchar(5) DEFAULT NULL,
  `from_port` int(11) DEFAULT NULL,
  `to_port` int(11) DEFAULT NULL,
  `cidr` varchar(43) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_fw_rules`
--

LOCK TABLES `provider_fw_rules` WRITE;
/*!40000 ALTER TABLE `provider_fw_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_fw_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quota_classes`
--

DROP TABLE IF EXISTS `quota_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota_classes` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `hard_limit` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_quota_classes_class_name` (`class_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quota_classes`
--

LOCK TABLES `quota_classes` WRITE;
/*!40000 ALTER TABLE `quota_classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `quota_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quota_usages`
--

DROP TABLE IF EXISTS `quota_usages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota_usages` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `in_use` int(11) NOT NULL,
  `reserved` int(11) NOT NULL,
  `until_refresh` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_quota_usages_project_id` (`project_id`),
  KEY `ix_quota_usages_user_id_deleted` (`user_id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quota_usages`
--

LOCK TABLES `quota_usages` WRITE;
/*!40000 ALTER TABLE `quota_usages` DISABLE KEYS */;
/*!40000 ALTER TABLE `quota_usages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotas`
--

DROP TABLE IF EXISTS `quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) NOT NULL,
  `hard_limit` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_quotas0project_id0resource0deleted` (`project_id`,`resource`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotas`
--

LOCK TABLES `quotas` WRITE;
/*!40000 ALTER TABLE `quotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservations` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `usage_id` int(11) NOT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `delta` int(11) NOT NULL,
  `expire` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usage_id` (`usage_id`),
  KEY `ix_reservations_project_id` (`project_id`),
  KEY `ix_reservations_user_id_deleted` (`user_id`,`deleted`),
  KEY `reservations_uuid_idx` (`uuid`),
  KEY `reservations_deleted_expire_idx` (`deleted`,`expire`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`usage_id`) REFERENCES `quota_usages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s3_images`
--

DROP TABLE IF EXISTS `s3_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s3_images` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s3_images`
--

LOCK TABLES `s3_images` WRITE;
/*!40000 ALTER TABLE `s3_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `s3_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_group_default_rules`
--

DROP TABLE IF EXISTS `security_group_default_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_group_default_rules` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `protocol` varchar(5) DEFAULT NULL,
  `from_port` int(11) DEFAULT NULL,
  `to_port` int(11) DEFAULT NULL,
  `cidr` varchar(43) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_group_default_rules`
--

LOCK TABLES `security_group_default_rules` WRITE;
/*!40000 ALTER TABLE `security_group_default_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_group_default_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_group_instance_association`
--

DROP TABLE IF EXISTS `security_group_instance_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_group_instance_association` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `security_group_id` int(11) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `security_group_id` (`security_group_id`),
  KEY `security_group_instance_association_instance_uuid_idx` (`instance_uuid`),
  CONSTRAINT `security_group_instance_association_ibfk_1` FOREIGN KEY (`security_group_id`) REFERENCES `security_groups` (`id`),
  CONSTRAINT `security_group_instance_association_instance_uuid_fkey` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_group_instance_association`
--

LOCK TABLES `security_group_instance_association` WRITE;
/*!40000 ALTER TABLE `security_group_instance_association` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_group_instance_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_group_rules`
--

DROP TABLE IF EXISTS `security_group_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_group_rules` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_group_id` int(11) DEFAULT NULL,
  `protocol` varchar(255) DEFAULT NULL,
  `from_port` int(11) DEFAULT NULL,
  `to_port` int(11) DEFAULT NULL,
  `cidr` varchar(43) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_group_id` (`parent_group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `security_group_rules_ibfk_1` FOREIGN KEY (`parent_group_id`) REFERENCES `security_groups` (`id`),
  CONSTRAINT `security_group_rules_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `security_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_group_rules`
--

LOCK TABLES `security_group_rules` WRITE;
/*!40000 ALTER TABLE `security_group_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_group_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_groups`
--

DROP TABLE IF EXISTS `security_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_groups` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_security_groups0project_id0name0deleted` (`project_id`,`name`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_groups`
--

LOCK TABLES `security_groups` WRITE;
/*!40000 ALTER TABLE `security_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) DEFAULT NULL,
  `binary` varchar(255) DEFAULT NULL,
  `topic` varchar(255) DEFAULT NULL,
  `report_count` int(11) NOT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `disabled_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_services0host0topic0deleted` (`host`,`topic`,`deleted`),
  UNIQUE KEY `uniq_services0host0binary0deleted` (`host`,`binary`,`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES ('2016-06-20 15:14:36','2016-06-20 15:17:52',NULL,1,'openstack-controller.novalocal','nova-conductor','conductor',20,0,0,NULL),('2016-06-20 15:14:37','2016-06-20 15:17:53',NULL,4,'openstack-controller.novalocal','nova-scheduler','scheduler',20,0,0,NULL);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_agent_builds`
--

DROP TABLE IF EXISTS `shadow_agent_builds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_agent_builds` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hypervisor` varchar(255) DEFAULT NULL,
  `os` varchar(255) DEFAULT NULL,
  `architecture` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `md5hash` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_agent_builds`
--

LOCK TABLES `shadow_agent_builds` WRITE;
/*!40000 ALTER TABLE `shadow_agent_builds` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_agent_builds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_aggregate_hosts`
--

DROP TABLE IF EXISTS `shadow_aggregate_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_aggregate_hosts` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) DEFAULT NULL,
  `aggregate_id` int(11) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_aggregate_hosts`
--

LOCK TABLES `shadow_aggregate_hosts` WRITE;
/*!40000 ALTER TABLE `shadow_aggregate_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_aggregate_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_aggregate_metadata`
--

DROP TABLE IF EXISTS `shadow_aggregate_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_aggregate_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aggregate_id` int(11) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_aggregate_metadata`
--

LOCK TABLES `shadow_aggregate_metadata` WRITE;
/*!40000 ALTER TABLE `shadow_aggregate_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_aggregate_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_aggregates`
--

DROP TABLE IF EXISTS `shadow_aggregates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_aggregates` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_aggregates`
--

LOCK TABLES `shadow_aggregates` WRITE;
/*!40000 ALTER TABLE `shadow_aggregates` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_aggregates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_block_device_mapping`
--

DROP TABLE IF EXISTS `shadow_block_device_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_block_device_mapping` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_name` varchar(255) DEFAULT NULL,
  `delete_on_termination` tinyint(1) DEFAULT NULL,
  `snapshot_id` varchar(36) DEFAULT NULL,
  `volume_id` varchar(36) DEFAULT NULL,
  `volume_size` int(11) DEFAULT NULL,
  `no_device` tinyint(1) DEFAULT NULL,
  `connection_info` mediumtext,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `source_type` varchar(255) DEFAULT NULL,
  `destination_type` varchar(255) DEFAULT NULL,
  `guest_format` varchar(255) DEFAULT NULL,
  `device_type` varchar(255) DEFAULT NULL,
  `disk_bus` varchar(255) DEFAULT NULL,
  `boot_index` int(11) DEFAULT NULL,
  `image_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_block_device_mapping`
--

LOCK TABLES `shadow_block_device_mapping` WRITE;
/*!40000 ALTER TABLE `shadow_block_device_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_block_device_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_bw_usage_cache`
--

DROP TABLE IF EXISTS `shadow_bw_usage_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_bw_usage_cache` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_period` datetime NOT NULL,
  `last_refreshed` datetime DEFAULT NULL,
  `bw_in` bigint(20) DEFAULT NULL,
  `bw_out` bigint(20) DEFAULT NULL,
  `mac` varchar(255) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `last_ctr_in` bigint(20) DEFAULT NULL,
  `last_ctr_out` bigint(20) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_bw_usage_cache`
--

LOCK TABLES `shadow_bw_usage_cache` WRITE;
/*!40000 ALTER TABLE `shadow_bw_usage_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_bw_usage_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_cells`
--

DROP TABLE IF EXISTS `shadow_cells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_cells` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_url` varchar(255) DEFAULT NULL,
  `weight_offset` float DEFAULT NULL,
  `weight_scale` float DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `is_parent` tinyint(1) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `transport_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_cells`
--

LOCK TABLES `shadow_cells` WRITE;
/*!40000 ALTER TABLE `shadow_cells` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_cells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_certificates`
--

DROP TABLE IF EXISTS `shadow_certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_certificates` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_certificates`
--

LOCK TABLES `shadow_certificates` WRITE;
/*!40000 ALTER TABLE `shadow_certificates` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_compute_nodes`
--

DROP TABLE IF EXISTS `shadow_compute_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_compute_nodes` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL,
  `vcpus` int(11) NOT NULL,
  `memory_mb` int(11) NOT NULL,
  `local_gb` int(11) NOT NULL,
  `vcpus_used` int(11) NOT NULL,
  `memory_mb_used` int(11) NOT NULL,
  `local_gb_used` int(11) NOT NULL,
  `hypervisor_type` mediumtext NOT NULL,
  `hypervisor_version` int(11) NOT NULL,
  `cpu_info` mediumtext NOT NULL,
  `disk_available_least` int(11) DEFAULT NULL,
  `free_ram_mb` int(11) DEFAULT NULL,
  `free_disk_gb` int(11) DEFAULT NULL,
  `current_workload` int(11) DEFAULT NULL,
  `running_vms` int(11) DEFAULT NULL,
  `hypervisor_hostname` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `host_ip` varchar(39) DEFAULT NULL,
  `supported_instances` text,
  `pci_stats` text,
  `metrics` text,
  `extra_resources` text,
  `stats` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_compute_nodes`
--

LOCK TABLES `shadow_compute_nodes` WRITE;
/*!40000 ALTER TABLE `shadow_compute_nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_compute_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_console_pools`
--

DROP TABLE IF EXISTS `shadow_console_pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_console_pools` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(39) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `console_type` varchar(255) DEFAULT NULL,
  `public_hostname` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `compute_host` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_console_pools`
--

LOCK TABLES `shadow_console_pools` WRITE;
/*!40000 ALTER TABLE `shadow_console_pools` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_console_pools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_consoles`
--

DROP TABLE IF EXISTS `shadow_consoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_consoles` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `pool_id` int(11) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_consoles`
--

LOCK TABLES `shadow_consoles` WRITE;
/*!40000 ALTER TABLE `shadow_consoles` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_consoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_dns_domains`
--

DROP TABLE IF EXISTS `shadow_dns_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_dns_domains` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `domain` varchar(255) NOT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_dns_domains`
--

LOCK TABLES `shadow_dns_domains` WRITE;
/*!40000 ALTER TABLE `shadow_dns_domains` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_dns_domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_fixed_ips`
--

DROP TABLE IF EXISTS `shadow_fixed_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_fixed_ips` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(39) DEFAULT NULL,
  `network_id` int(11) DEFAULT NULL,
  `allocated` tinyint(1) DEFAULT NULL,
  `leased` tinyint(1) DEFAULT NULL,
  `reserved` tinyint(1) DEFAULT NULL,
  `virtual_interface_id` int(11) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_fixed_ips`
--

LOCK TABLES `shadow_fixed_ips` WRITE;
/*!40000 ALTER TABLE `shadow_fixed_ips` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_fixed_ips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_floating_ips`
--

DROP TABLE IF EXISTS `shadow_floating_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_floating_ips` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(39) DEFAULT NULL,
  `fixed_ip_id` int(11) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `auto_assigned` tinyint(1) DEFAULT NULL,
  `pool` varchar(255) DEFAULT NULL,
  `interface` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_floating_ips`
--

LOCK TABLES `shadow_floating_ips` WRITE;
/*!40000 ALTER TABLE `shadow_floating_ips` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_floating_ips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_actions`
--

DROP TABLE IF EXISTS `shadow_instance_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_actions` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `request_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_actions`
--

LOCK TABLES `shadow_instance_actions` WRITE;
/*!40000 ALTER TABLE `shadow_instance_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_actions_events`
--

DROP TABLE IF EXISTS `shadow_instance_actions_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_actions_events` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` varchar(255) DEFAULT NULL,
  `action_id` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `finish_time` datetime DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `traceback` text,
  `deleted` int(11) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `details` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_actions_events`
--

LOCK TABLES `shadow_instance_actions_events` WRITE;
/*!40000 ALTER TABLE `shadow_instance_actions_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_actions_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_faults`
--

DROP TABLE IF EXISTS `shadow_instance_faults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_faults` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `code` int(11) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `details` mediumtext,
  `host` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_faults`
--

LOCK TABLES `shadow_instance_faults` WRITE;
/*!40000 ALTER TABLE `shadow_instance_faults` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_faults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_group_member`
--

DROP TABLE IF EXISTS `shadow_instance_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_group_member` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` varchar(255) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_group_member`
--

LOCK TABLES `shadow_instance_group_member` WRITE;
/*!40000 ALTER TABLE `shadow_instance_group_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_group_metadata`
--

DROP TABLE IF EXISTS `shadow_instance_group_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_group_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_group_metadata`
--

LOCK TABLES `shadow_instance_group_metadata` WRITE;
/*!40000 ALTER TABLE `shadow_instance_group_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_group_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_group_policy`
--

DROP TABLE IF EXISTS `shadow_instance_group_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_group_policy` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `policy` varchar(255) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_group_policy`
--

LOCK TABLES `shadow_instance_group_policy` WRITE;
/*!40000 ALTER TABLE `shadow_instance_group_policy` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_group_policy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_groups`
--

DROP TABLE IF EXISTS `shadow_instance_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_groups` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `uuid` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_groups`
--

LOCK TABLES `shadow_instance_groups` WRITE;
/*!40000 ALTER TABLE `shadow_instance_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_id_mappings`
--

DROP TABLE IF EXISTS `shadow_instance_id_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_id_mappings` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_id_mappings`
--

LOCK TABLES `shadow_instance_id_mappings` WRITE;
/*!40000 ALTER TABLE `shadow_instance_id_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_id_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_info_caches`
--

DROP TABLE IF EXISTS `shadow_instance_info_caches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_info_caches` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_info` mediumtext,
  `instance_uuid` varchar(36) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_info_caches`
--

LOCK TABLES `shadow_instance_info_caches` WRITE;
/*!40000 ALTER TABLE `shadow_instance_info_caches` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_info_caches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_metadata`
--

DROP TABLE IF EXISTS `shadow_instance_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_metadata`
--

LOCK TABLES `shadow_instance_metadata` WRITE;
/*!40000 ALTER TABLE `shadow_instance_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_system_metadata`
--

DROP TABLE IF EXISTS `shadow_instance_system_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_system_metadata` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_uuid` varchar(36) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_system_metadata`
--

LOCK TABLES `shadow_instance_system_metadata` WRITE;
/*!40000 ALTER TABLE `shadow_instance_system_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_system_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_type_extra_specs`
--

DROP TABLE IF EXISTS `shadow_instance_type_extra_specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_type_extra_specs` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_type_id` int(11) NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_type_extra_specs`
--

LOCK TABLES `shadow_instance_type_extra_specs` WRITE;
/*!40000 ALTER TABLE `shadow_instance_type_extra_specs` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_type_extra_specs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_type_projects`
--

DROP TABLE IF EXISTS `shadow_instance_type_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_type_projects` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_type_id` int(11) NOT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_type_projects`
--

LOCK TABLES `shadow_instance_type_projects` WRITE;
/*!40000 ALTER TABLE `shadow_instance_type_projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_type_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instance_types`
--

DROP TABLE IF EXISTS `shadow_instance_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instance_types` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `memory_mb` int(11) NOT NULL,
  `vcpus` int(11) NOT NULL,
  `swap` int(11) NOT NULL,
  `vcpu_weight` int(11) DEFAULT NULL,
  `flavorid` varchar(255) DEFAULT NULL,
  `rxtx_factor` float DEFAULT NULL,
  `root_gb` int(11) DEFAULT NULL,
  `ephemeral_gb` int(11) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instance_types`
--

LOCK TABLES `shadow_instance_types` WRITE;
/*!40000 ALTER TABLE `shadow_instance_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instance_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_instances`
--

DROP TABLE IF EXISTS `shadow_instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_instances` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `internal_id` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `image_ref` varchar(255) DEFAULT NULL,
  `kernel_id` varchar(255) DEFAULT NULL,
  `ramdisk_id` varchar(255) DEFAULT NULL,
  `launch_index` int(11) DEFAULT NULL,
  `key_name` varchar(255) DEFAULT NULL,
  `key_data` mediumtext,
  `power_state` int(11) DEFAULT NULL,
  `vm_state` varchar(255) DEFAULT NULL,
  `memory_mb` int(11) DEFAULT NULL,
  `vcpus` int(11) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `user_data` mediumtext,
  `reservation_id` varchar(255) DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `launched_at` datetime DEFAULT NULL,
  `terminated_at` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `display_description` varchar(255) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `os_type` varchar(255) DEFAULT NULL,
  `launched_on` mediumtext,
  `instance_type_id` int(11) DEFAULT NULL,
  `vm_mode` varchar(255) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `architecture` varchar(255) DEFAULT NULL,
  `root_device_name` varchar(255) DEFAULT NULL,
  `access_ip_v4` varchar(39) DEFAULT NULL,
  `access_ip_v6` varchar(39) DEFAULT NULL,
  `config_drive` varchar(255) DEFAULT NULL,
  `task_state` varchar(255) DEFAULT NULL,
  `default_ephemeral_device` varchar(255) DEFAULT NULL,
  `default_swap_device` varchar(255) DEFAULT NULL,
  `progress` int(11) DEFAULT NULL,
  `auto_disk_config` tinyint(1) DEFAULT NULL,
  `shutdown_terminate` tinyint(1) DEFAULT NULL,
  `disable_terminate` tinyint(1) DEFAULT NULL,
  `root_gb` int(11) DEFAULT NULL,
  `ephemeral_gb` int(11) DEFAULT NULL,
  `cell_name` varchar(255) DEFAULT NULL,
  `node` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `locked_by` enum('owner','admin') DEFAULT NULL,
  `cleaned` int(11) DEFAULT NULL,
  `ephemeral_key_uuid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_instances`
--

LOCK TABLES `shadow_instances` WRITE;
/*!40000 ALTER TABLE `shadow_instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_iscsi_targets`
--

DROP TABLE IF EXISTS `shadow_iscsi_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_iscsi_targets` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_num` int(11) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `volume_id` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_iscsi_targets`
--

LOCK TABLES `shadow_iscsi_targets` WRITE;
/*!40000 ALTER TABLE `shadow_iscsi_targets` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_iscsi_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_key_pairs`
--

DROP TABLE IF EXISTS `shadow_key_pairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_key_pairs` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `fingerprint` varchar(255) DEFAULT NULL,
  `public_key` mediumtext,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_key_pairs`
--

LOCK TABLES `shadow_key_pairs` WRITE;
/*!40000 ALTER TABLE `shadow_key_pairs` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_key_pairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_migrate_version`
--

DROP TABLE IF EXISTS `shadow_migrate_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_migrate_version` (
  `repository_id` varchar(250) NOT NULL,
  `repository_path` text,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`repository_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_migrate_version`
--

LOCK TABLES `shadow_migrate_version` WRITE;
/*!40000 ALTER TABLE `shadow_migrate_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_migrate_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_migrations`
--

DROP TABLE IF EXISTS `shadow_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_migrations` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_compute` varchar(255) DEFAULT NULL,
  `dest_compute` varchar(255) DEFAULT NULL,
  `dest_host` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `old_instance_type_id` int(11) DEFAULT NULL,
  `new_instance_type_id` int(11) DEFAULT NULL,
  `source_node` varchar(255) DEFAULT NULL,
  `dest_node` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_migrations`
--

LOCK TABLES `shadow_migrations` WRITE;
/*!40000 ALTER TABLE `shadow_migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_networks`
--

DROP TABLE IF EXISTS `shadow_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_networks` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `injected` tinyint(1) DEFAULT NULL,
  `cidr` varchar(43) DEFAULT NULL,
  `netmask` varchar(39) DEFAULT NULL,
  `bridge` varchar(255) DEFAULT NULL,
  `gateway` varchar(39) DEFAULT NULL,
  `broadcast` varchar(39) DEFAULT NULL,
  `dns1` varchar(39) DEFAULT NULL,
  `vlan` int(11) DEFAULT NULL,
  `vpn_public_address` varchar(39) DEFAULT NULL,
  `vpn_public_port` int(11) DEFAULT NULL,
  `vpn_private_address` varchar(39) DEFAULT NULL,
  `dhcp_start` varchar(39) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `cidr_v6` varchar(43) DEFAULT NULL,
  `gateway_v6` varchar(39) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `netmask_v6` varchar(39) DEFAULT NULL,
  `bridge_interface` varchar(255) DEFAULT NULL,
  `multi_host` tinyint(1) DEFAULT NULL,
  `dns2` varchar(39) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `rxtx_base` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_networks`
--

LOCK TABLES `shadow_networks` WRITE;
/*!40000 ALTER TABLE `shadow_networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_pci_devices`
--

DROP TABLE IF EXISTS `shadow_pci_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_pci_devices` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compute_node_id` int(11) NOT NULL,
  `address` varchar(12) NOT NULL,
  `product_id` varchar(4) DEFAULT NULL,
  `vendor_id` varchar(4) DEFAULT NULL,
  `dev_type` varchar(8) DEFAULT NULL,
  `dev_id` varchar(255) DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  `status` varchar(36) NOT NULL,
  `extra_info` text,
  `instance_uuid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_pci_devices`
--

LOCK TABLES `shadow_pci_devices` WRITE;
/*!40000 ALTER TABLE `shadow_pci_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_pci_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_project_user_quotas`
--

DROP TABLE IF EXISTS `shadow_project_user_quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_project_user_quotas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `project_id` varchar(255) NOT NULL,
  `resource` varchar(255) NOT NULL,
  `hard_limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_project_user_quotas`
--

LOCK TABLES `shadow_project_user_quotas` WRITE;
/*!40000 ALTER TABLE `shadow_project_user_quotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_project_user_quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_provider_fw_rules`
--

DROP TABLE IF EXISTS `shadow_provider_fw_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_provider_fw_rules` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `protocol` varchar(5) DEFAULT NULL,
  `from_port` int(11) DEFAULT NULL,
  `to_port` int(11) DEFAULT NULL,
  `cidr` varchar(43) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_provider_fw_rules`
--

LOCK TABLES `shadow_provider_fw_rules` WRITE;
/*!40000 ALTER TABLE `shadow_provider_fw_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_provider_fw_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_quota_classes`
--

DROP TABLE IF EXISTS `shadow_quota_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_quota_classes` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `hard_limit` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_quota_classes`
--

LOCK TABLES `shadow_quota_classes` WRITE;
/*!40000 ALTER TABLE `shadow_quota_classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_quota_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_quota_usages`
--

DROP TABLE IF EXISTS `shadow_quota_usages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_quota_usages` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `in_use` int(11) NOT NULL,
  `reserved` int(11) NOT NULL,
  `until_refresh` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_quota_usages`
--

LOCK TABLES `shadow_quota_usages` WRITE;
/*!40000 ALTER TABLE `shadow_quota_usages` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_quota_usages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_quotas`
--

DROP TABLE IF EXISTS `shadow_quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_quotas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) NOT NULL,
  `hard_limit` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_quotas`
--

LOCK TABLES `shadow_quotas` WRITE;
/*!40000 ALTER TABLE `shadow_quotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_reservations`
--

DROP TABLE IF EXISTS `shadow_reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_reservations` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `usage_id` int(11) NOT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `delta` int(11) NOT NULL,
  `expire` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_reservations`
--

LOCK TABLES `shadow_reservations` WRITE;
/*!40000 ALTER TABLE `shadow_reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_s3_images`
--

DROP TABLE IF EXISTS `shadow_s3_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_s3_images` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_s3_images`
--

LOCK TABLES `shadow_s3_images` WRITE;
/*!40000 ALTER TABLE `shadow_s3_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_s3_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_security_group_default_rules`
--

DROP TABLE IF EXISTS `shadow_security_group_default_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_security_group_default_rules` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `protocol` varchar(5) DEFAULT NULL,
  `from_port` int(11) DEFAULT NULL,
  `to_port` int(11) DEFAULT NULL,
  `cidr` varchar(43) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_security_group_default_rules`
--

LOCK TABLES `shadow_security_group_default_rules` WRITE;
/*!40000 ALTER TABLE `shadow_security_group_default_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_security_group_default_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_security_group_instance_association`
--

DROP TABLE IF EXISTS `shadow_security_group_instance_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_security_group_instance_association` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `security_group_id` int(11) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_security_group_instance_association`
--

LOCK TABLES `shadow_security_group_instance_association` WRITE;
/*!40000 ALTER TABLE `shadow_security_group_instance_association` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_security_group_instance_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_security_group_rules`
--

DROP TABLE IF EXISTS `shadow_security_group_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_security_group_rules` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_group_id` int(11) DEFAULT NULL,
  `protocol` varchar(255) DEFAULT NULL,
  `from_port` int(11) DEFAULT NULL,
  `to_port` int(11) DEFAULT NULL,
  `cidr` varchar(43) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_security_group_rules`
--

LOCK TABLES `shadow_security_group_rules` WRITE;
/*!40000 ALTER TABLE `shadow_security_group_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_security_group_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_security_groups`
--

DROP TABLE IF EXISTS `shadow_security_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_security_groups` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_security_groups`
--

LOCK TABLES `shadow_security_groups` WRITE;
/*!40000 ALTER TABLE `shadow_security_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_security_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_services`
--

DROP TABLE IF EXISTS `shadow_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_services` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) DEFAULT NULL,
  `binary` varchar(255) DEFAULT NULL,
  `topic` varchar(255) DEFAULT NULL,
  `report_count` int(11) NOT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `disabled_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_services`
--

LOCK TABLES `shadow_services` WRITE;
/*!40000 ALTER TABLE `shadow_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_snapshot_id_mappings`
--

DROP TABLE IF EXISTS `shadow_snapshot_id_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_snapshot_id_mappings` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_snapshot_id_mappings`
--

LOCK TABLES `shadow_snapshot_id_mappings` WRITE;
/*!40000 ALTER TABLE `shadow_snapshot_id_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_snapshot_id_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_snapshots`
--

DROP TABLE IF EXISTS `shadow_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_snapshots` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `volume_id` varchar(36) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `progress` varchar(255) DEFAULT NULL,
  `volume_size` int(11) DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `display_description` varchar(255) DEFAULT NULL,
  `deleted` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_snapshots`
--

LOCK TABLES `shadow_snapshots` WRITE;
/*!40000 ALTER TABLE `shadow_snapshots` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_task_log`
--

DROP TABLE IF EXISTS `shadow_task_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_task_log` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `period_beginning` datetime NOT NULL,
  `period_ending` datetime NOT NULL,
  `message` varchar(255) NOT NULL,
  `task_items` int(11) DEFAULT NULL,
  `errors` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_task_log`
--

LOCK TABLES `shadow_task_log` WRITE;
/*!40000 ALTER TABLE `shadow_task_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_task_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_virtual_interfaces`
--

DROP TABLE IF EXISTS `shadow_virtual_interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_virtual_interfaces` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `network_id` int(11) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_virtual_interfaces`
--

LOCK TABLES `shadow_virtual_interfaces` WRITE;
/*!40000 ALTER TABLE `shadow_virtual_interfaces` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_virtual_interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_volume_id_mappings`
--

DROP TABLE IF EXISTS `shadow_volume_id_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_volume_id_mappings` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_volume_id_mappings`
--

LOCK TABLES `shadow_volume_id_mappings` WRITE;
/*!40000 ALTER TABLE `shadow_volume_id_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_volume_id_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_volume_usage_cache`
--

DROP TABLE IF EXISTS `shadow_volume_usage_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_volume_usage_cache` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `volume_id` varchar(36) NOT NULL,
  `tot_last_refreshed` datetime DEFAULT NULL,
  `tot_reads` bigint(20) DEFAULT NULL,
  `tot_read_bytes` bigint(20) DEFAULT NULL,
  `tot_writes` bigint(20) DEFAULT NULL,
  `tot_write_bytes` bigint(20) DEFAULT NULL,
  `curr_last_refreshed` datetime DEFAULT NULL,
  `curr_reads` bigint(20) DEFAULT NULL,
  `curr_read_bytes` bigint(20) DEFAULT NULL,
  `curr_writes` bigint(20) DEFAULT NULL,
  `curr_write_bytes` bigint(20) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `project_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_volume_usage_cache`
--

LOCK TABLES `shadow_volume_usage_cache` WRITE;
/*!40000 ALTER TABLE `shadow_volume_usage_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_volume_usage_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shadow_volumes`
--

DROP TABLE IF EXISTS `shadow_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shadow_volumes` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `ec2_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  `mountpoint` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `attach_status` varchar(255) DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `launched_at` datetime DEFAULT NULL,
  `terminated_at` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `display_description` varchar(255) DEFAULT NULL,
  `provider_location` varchar(256) DEFAULT NULL,
  `provider_auth` varchar(256) DEFAULT NULL,
  `snapshot_id` varchar(36) DEFAULT NULL,
  `volume_type_id` int(11) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `attach_time` datetime DEFAULT NULL,
  `deleted` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shadow_volumes`
--

LOCK TABLES `shadow_volumes` WRITE;
/*!40000 ALTER TABLE `shadow_volumes` DISABLE KEYS */;
/*!40000 ALTER TABLE `shadow_volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshot_id_mappings`
--

DROP TABLE IF EXISTS `snapshot_id_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snapshot_id_mappings` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshot_id_mappings`
--

LOCK TABLES `snapshot_id_mappings` WRITE;
/*!40000 ALTER TABLE `snapshot_id_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `snapshot_id_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshots`
--

DROP TABLE IF EXISTS `snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snapshots` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `volume_id` varchar(36) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `progress` varchar(255) DEFAULT NULL,
  `volume_size` int(11) DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `display_description` varchar(255) DEFAULT NULL,
  `deleted` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshots`
--

LOCK TABLES `snapshots` WRITE;
/*!40000 ALTER TABLE `snapshots` DISABLE KEYS */;
/*!40000 ALTER TABLE `snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_log`
--

DROP TABLE IF EXISTS `task_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_log` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `period_beginning` datetime NOT NULL,
  `period_ending` datetime NOT NULL,
  `message` varchar(255) NOT NULL,
  `task_items` int(11) DEFAULT NULL,
  `errors` int(11) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_task_log0task_name0host0period_beginning0period_ending` (`task_name`,`host`,`period_beginning`,`period_ending`),
  KEY `ix_task_log_period_beginning` (`period_beginning`),
  KEY `ix_task_log_host` (`host`),
  KEY `ix_task_log_period_ending` (`period_ending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_log`
--

LOCK TABLES `task_log` WRITE;
/*!40000 ALTER TABLE `task_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtual_interfaces`
--

DROP TABLE IF EXISTS `virtual_interfaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtual_interfaces` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `network_id` int(11) DEFAULT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_virtual_interfaces0address0deleted` (`address`,`deleted`),
  KEY `network_id` (`network_id`),
  KEY `virtual_interfaces_instance_uuid_fkey` (`instance_uuid`),
  CONSTRAINT `virtual_interfaces_instance_uuid_fkey` FOREIGN KEY (`instance_uuid`) REFERENCES `instances` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtual_interfaces`
--

LOCK TABLES `virtual_interfaces` WRITE;
/*!40000 ALTER TABLE `virtual_interfaces` DISABLE KEYS */;
/*!40000 ALTER TABLE `virtual_interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_id_mappings`
--

DROP TABLE IF EXISTS `volume_id_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_id_mappings` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) NOT NULL,
  `deleted` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_id_mappings`
--

LOCK TABLES `volume_id_mappings` WRITE;
/*!40000 ALTER TABLE `volume_id_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_id_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_usage_cache`
--

DROP TABLE IF EXISTS `volume_usage_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_usage_cache` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `volume_id` varchar(36) NOT NULL,
  `tot_last_refreshed` datetime DEFAULT NULL,
  `tot_reads` bigint(20) DEFAULT NULL,
  `tot_read_bytes` bigint(20) DEFAULT NULL,
  `tot_writes` bigint(20) DEFAULT NULL,
  `tot_write_bytes` bigint(20) DEFAULT NULL,
  `curr_last_refreshed` datetime DEFAULT NULL,
  `curr_reads` bigint(20) DEFAULT NULL,
  `curr_read_bytes` bigint(20) DEFAULT NULL,
  `curr_writes` bigint(20) DEFAULT NULL,
  `curr_write_bytes` bigint(20) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `project_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_usage_cache`
--

LOCK TABLES `volume_usage_cache` WRITE;
/*!40000 ALTER TABLE `volume_usage_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_usage_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `ec2_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `availability_zone` varchar(255) DEFAULT NULL,
  `mountpoint` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `attach_status` varchar(255) DEFAULT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `launched_at` datetime DEFAULT NULL,
  `terminated_at` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `display_description` varchar(255) DEFAULT NULL,
  `provider_location` varchar(256) DEFAULT NULL,
  `provider_auth` varchar(256) DEFAULT NULL,
  `snapshot_id` varchar(36) DEFAULT NULL,
  `volume_type_id` int(11) DEFAULT NULL,
  `instance_uuid` varchar(36) DEFAULT NULL,
  `attach_time` datetime DEFAULT NULL,
  `deleted` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `volumes_instance_uuid_idx` (`instance_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'nova'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-20 15:18:01
