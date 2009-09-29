-- MySQL dump 10.11
--
-- Host: localhost    Database: live_development
-- ------------------------------------------------------
-- Server version	5.0.75-0ubuntu10.2

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
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `blogs` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `published_date` datetime default NULL,
  `is_published` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL auto_increment,
  `mrc_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `address2` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `zip` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (2,2,'client 2',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(3,3,'client 3',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(4,4,'client 4',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(5,5,'client 5',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(6,6,'client 6',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(8,8,'client 8 saved','','','','','',NULL,'2009-09-05 13:12:39','2009-09-06 11:42:56'),(9,9,'client 9',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(10,10,'client 10',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(11,11,'client 11',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(12,12,'client 12',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(13,13,'client 13',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(15,15,'client 15',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(16,16,'client 16',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(17,17,'client 17',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(18,18,'client 18',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(19,19,'client 19',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:12:39','2009-09-05 13:12:39'),(22,1,'client no 22','','','','','',NULL,'2009-09-06 11:58:34','2009-09-06 12:59:33');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrcs`
--

DROP TABLE IF EXISTS `mrcs`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `mrcs` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `address2` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `zip` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `mrcs`
--

LOCK TABLES `mrcs` WRITE;
/*!40000 ALTER TABLE `mrcs` DISABLE KEYS */;
INSERT INTO `mrcs` VALUES (1,'mrc 1',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(2,'mrc 2',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(3,'mrc 3',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(4,'mrc 4',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(5,'mrc 5',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(6,'mrc 6',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(7,'mrc 7',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(8,'mrc 8',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(9,'mrc 9',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(10,'mrc 10',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(11,'mrc 11',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(12,'mrc 12',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(13,'mrc 13',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(14,'mrc 14',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(15,'mrc 15',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(16,'mrc 16',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(17,'mrc 17',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(18,'mrc 18',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(19,'mrc 19',NULL,NULL,NULL,NULL,NULL,NULL,'2009-09-05 13:11:33','2009-09-05 13:11:33'),(21,'','','','','','',NULL,'2009-09-06 10:22:16','2009-09-06 10:22:16');
/*!40000 ALTER TABLE `mrcs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ownerships`
--

DROP TABLE IF EXISTS `ownerships`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `ownerships` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `ownable_id` int(11) default NULL,
  `role_id` int(11) default NULL,
  `ownable_type` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `ownerships`
--

LOCK TABLES `ownerships` WRITE;
/*!40000 ALTER TABLE `ownerships` DISABLE KEYS */;
INSERT INTO `ownerships` VALUES (1,1,1,1,'self','2009-09-05 12:27:02','2009-09-05 12:27:02'),(2,2,1,1,'user','2009-09-05 13:20:12','2009-09-05 13:20:12'),(3,3,1,1,'mrc','2009-09-05 13:22:27','2009-09-05 13:22:27'),(4,3,3,3,'mrc','2009-09-06 08:19:29','2009-09-06 08:19:29'),(5,4,4,3,'mrc','2009-09-06 08:19:29','2009-09-06 08:19:29'),(6,5,5,3,'mrc','2009-09-06 08:19:29','2009-09-06 08:19:29'),(7,6,6,1,'mrc','2009-09-06 08:19:29','2009-09-06 08:19:29'),(8,3,2,2,'mrc','2009-09-06 08:19:29','2009-09-06 08:19:29'),(9,8,8,2,'mrc','2009-09-06 08:19:29','2009-09-06 08:19:29'),(11,10,2,1,'client','2009-09-06 08:20:32','2009-09-06 08:20:32'),(12,11,3,2,'client','2009-09-06 08:20:32','2009-09-06 08:20:32'),(13,12,4,1,'client','2009-09-06 08:20:32','2009-09-06 08:20:32'),(14,13,5,3,'client','2009-09-06 08:20:32','2009-09-06 08:20:32'),(15,14,6,2,'client','2009-09-06 08:20:32','2009-09-06 08:20:32'),(16,15,6,3,'client','2009-09-06 08:20:32','2009-09-06 08:20:32'),(17,16,0,2,'project','2009-09-06 08:21:28','2009-09-06 08:21:28'),(18,17,1,1,'project','2009-09-06 08:21:28','2009-09-06 08:21:28'),(21,20,4,2,'project','2009-09-06 08:21:28','2009-09-06 08:21:28');
/*!40000 ALTER TABLE `ownerships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `client_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `display` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,NULL,'project 1',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(2,2,'project 2','','2009-09-06','2009-09-06',NULL,'2009-09-05 13:13:24','2009-09-06 14:46:27'),(3,3,'project 3',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(4,4,'project 4',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(5,5,'project 5',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(6,6,'project 6',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(7,NULL,'project 7',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(8,8,'project 8',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(9,9,'project 9',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(10,10,'project 10',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(11,11,'project 11',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(12,12,'project 12',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(13,13,'project 13',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(14,NULL,'project 14',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(15,15,'project 15',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(16,16,'project 16',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(17,17,'project 17',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(18,18,'project 18',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(19,19,'project 19',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(20,NULL,'project 20',NULL,NULL,NULL,NULL,'2009-09-05 13:13:24','2009-09-05 13:13:24'),(21,NULL,'shree\'s project','test','2009-09-06','2009-09-06',NULL,'2009-09-06 13:26:36','2009-09-06 13:26:36'),(24,22,'project for 22','client 22\'s project','2009-09-06','2009-09-06',NULL,'2009-09-06 14:47:49','2009-09-06 14:47:49');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','admin','2009-09-05 12:15:48','2009-09-05 12:15:48'),(2,'write','write','2009-09-05 12:15:48','2009-09-05 12:15:48'),(3,'read','read','2009-09-05 12:15:48','2009-09-05 12:15:48');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20090825062256'),('20090825083905'),('20090905111820'),('20090905111854'),('20090905112336'),('20090905112527'),('20090905112614'),('20090905114857');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveys`
--

DROP TABLE IF EXISTS `surveys`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `surveys` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `published_date` datetime default NULL,
  `is_approved` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `surveys`
--

LOCK TABLES `surveys` WRITE;
/*!40000 ALTER TABLE `surveys` DISABLE KEYS */;
/*!40000 ALTER TABLE `surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(40) NOT NULL,
  `first_name` varchar(100) default '',
  `last_name` varchar(100) default '',
  `crypted_password` varchar(40) NOT NULL,
  `salt` varchar(40) default NULL,
  `level` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  `mobile` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(40) default NULL,
  `remember_token_expires_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_users_on_login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'cromano@aberonit.com','Carmen','Romano','db2be03c8f5e11aaf239de83b552a61d9ee38142','6a8253192db939ac17ad0a3a8b63083acf191ed8','liveline',NULL,NULL,'2009-09-05 12:26:11','2009-09-05 12:26:11',NULL,NULL),(2,'user1@gmail.com','user','1','638507cc931ccd8e1ca08f649118617d4cae838e','cd2a30fe22d73b98e3fe3f2ef3d77a419b0336c5','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(3,'user2@gmail.com','user','2','6c4c0084e8383d71bb92d1e869bbe71e8c077933','191c430916d0032dc386f9cb334b7c33694878e5','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(4,'user3@gmail.com','user','3','af577752f071e767e5446eb905d51f458ae40ca6','4c58d4ba7330386d2e62ef629030055b6e66a3ec','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(5,'user4@gmail.com','user','4','68d20f443ac617ce01cabcfee6e04aa8decb1f02','c8ef45dbf1b09f19ff9f429cd7cd608d40e59bc0','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(6,'user5@gmail.com','user','5','0be53f74aba939c33669571ff24c2cde11d453de','474fd5a5358917ac100028b0ce05cf35caacf932','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(7,'user6@gmail.com','user','6','cf42775dcf8c3f6f1239f817933e81832272da13','a14d4e129da399c2faaac9ec8d93d2bc1213c877','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(8,'user7@gmail.com','user','7','913e5f761f8731eae7b0b466cdd06bcbcba05749','ea2021588bbf4d62ebced575cc557e31f497f37d','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(9,'user8@gmail.com','user','8','020ae0e974248b5527989284bf10ea1b7517f4de','bb9970a4a5b19b9ba976dd1ba2323ce938b43e6a','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(10,'user9@gmail.com','user','9','ea7ae32e63e32aab2f48469effa5d417c1a418d3','aba74bf7a5f5d533b8e4d0485e78c942e90a33e1','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(11,'user10@gmail.com','user','10','8a6077a9cf4a1c26dd6b1abda7170edaeb34c884','c631ed1abba99ffe09e64c5df4ed604b4095ec3e','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(12,'user11@gmail.com','user','11','3e895be20a88c420703e38254c9f45e5a6ffdb8e','1c7f0151665a4389cb92a7ea695e29020b310a8c','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(13,'user12@gmail.com','user','12','992bc629dbbcbab38643048c2f23e5596ae19657','6662b5d335e9037fca5d683eb994b0b1c3219219','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(14,'user13@gmail.com','user','13','e72a9c555b235f54cb1ab98da61194a9f43842d7','43a89b9ae3431cd1e3538a192bfd20964d7b19a2','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(15,'user14@gmail.com','user','14','4fcebdcbc0ab2e533306dc220ec96aa7f8a0895b','48114e82ff70dfa13a2d707390417375e6f71738','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(16,'user15@gmail.com','user','15','7826e968a6fbc0bc3af84bfc3289cdfc70c3c9af','c8a0f5dc81dc35e5cef71cc6a9ef938c939b3669','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(17,'user16@gmail.com','user','16','72ddc2e8746d0ef55fe26e1a0a3e1b694083a41a','12220e8a5db5f649ad54a76f3705292ac140f3ea','user',NULL,NULL,'2009-09-05 13:10:23','2009-09-05 13:10:23',NULL,NULL),(22,'shree.jay19@gmail.com','shree','jay','c89f7dd8f03218001a881202ca2e9497520743fd','9fffb8b1e491f77bdde691ed3b16cb64fe00fde9','user',NULL,NULL,'2009-09-06 18:11:27','2009-09-06 18:11:27',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-09-06 18:34:58
