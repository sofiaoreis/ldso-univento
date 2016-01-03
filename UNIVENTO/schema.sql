-- MySQL dump 10.13  Distrib 5.6.27, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: UNIVENTO_development
-- ------------------------------------------------------
-- Server version	5.6.27-0ubuntu1

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
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Category` (
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CategoryTags`
--

DROP TABLE IF EXISTS `CategoryTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CategoryTags` (
  `tagsID` int(11) NOT NULL DEFAULT '0',
  `categoryID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tagsID`,`categoryID`),
  KEY `FK_CategoryTags_Category` (`categoryID`),
  CONSTRAINT `FK_CategoryTags_Category` FOREIGN KEY (`categoryID`) REFERENCES `Category` (`categoryID`) ON DELETE CASCADE,
  CONSTRAINT `FK_CategoryTags_Tags` FOREIGN KEY (`tagsID`) REFERENCES `Tags` (`tagsID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Colaborator`
--

DROP TABLE IF EXISTS `Colaborator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Colaborator` (
  `promoterID` int(11) NOT NULL DEFAULT '0',
  `normalID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`promoterID`,`normalID`),
  KEY `FK_Colaborator_Normal` (`normalID`),
  CONSTRAINT `FK_Colaborator_Normal` FOREIGN KEY (`normalID`) REFERENCES `Normal` (`normalID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Colaborator_Promoter` FOREIGN KEY (`promoterID`) REFERENCES `Promoter` (`promoterID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ConviteColaborator`
--

DROP TABLE IF EXISTS `ConviteColaborator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ConviteColaborator` (
  `hashID` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `promoterID` int(11) NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`hashID`),
  KEY `FK_Convite_Promoter` (`promoterID`),
  CONSTRAINT `FK_Convite_Promoter` FOREIGN KEY (`promoterID`) REFERENCES `Promoter` (`promoterID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Event`
--

DROP TABLE IF EXISTS `Event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Event` (
  `descrition` text COLLATE utf8_unicode_ci,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `propose` tinyint(1) DEFAULT NULL,
  `averageRate` double DEFAULT NULL,
  `numRates` int(11) DEFAULT NULL,
  `activeDate` datetime DEFAULT NULL,
  `docsID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eventID` int(11) NOT NULL AUTO_INCREMENT,
  `categoryID` int(11) DEFAULT NULL,
  `promoterID` int(11) DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `normalID` int(11) DEFAULT NULL,
  PRIMARY KEY (`eventID`),
  KEY `categoryID` (`categoryID`),
  KEY `promoterID` (`promoterID`),
  KEY `normalID` (`normalID`),
  CONSTRAINT `FK_Event_Category` FOREIGN KEY (`categoryID`) REFERENCES `Category` (`categoryID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Event_Normal` FOREIGN KEY (`normalID`) REFERENCES `Normal` (`normalID`) ON DELETE SET NULL,
  CONSTRAINT `FK_Event_Promoter` FOREIGN KEY (`promoterID`) REFERENCES `Promoter` (`promoterID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EventDate`
--

DROP TABLE IF EXISTS `EventDate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventDate` (
  `descrition` text COLLATE utf8_unicode_ci,
  `startDate` datetime DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `dateID` int(11) NOT NULL AUTO_INCREMENT,
  `eventID` int(11) DEFAULT NULL,
  `localID` int(11) DEFAULT NULL,
  PRIMARY KEY (`dateID`),
  KEY `eventID` (`eventID`),
  KEY `localID` (`localID`),
  CONSTRAINT `FK_Date_Event` FOREIGN KEY (`eventID`) REFERENCES `Event` (`eventID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Date_Local` FOREIGN KEY (`localID`) REFERENCES `Local` (`localID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EventTags`
--

DROP TABLE IF EXISTS `EventTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventTags` (
  `eventID` int(11) NOT NULL DEFAULT '0',
  `tagsID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventID`,`tagsID`),
  KEY `FK_EventTags_Tags` (`tagsID`),
  CONSTRAINT `FK_EventTags_Event` FOREIGN KEY (`eventID`) REFERENCES `Event` (`eventID`) ON DELETE CASCADE,
  CONSTRAINT `FK_EventTags_Tags` FOREIGN KEY (`tagsID`) REFERENCES `Tags` (`tagsID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Friendship`
--

DROP TABLE IF EXISTS `Friendship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Friendship` (
  `requesterNormalID` int(11) NOT NULL DEFAULT '0',
  `requestedNormalID` int(11) NOT NULL DEFAULT '0',
  `friends` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`requesterNormalID`,`requestedNormalID`),
  KEY `FK_Requested_Normal` (`requestedNormalID`),
  CONSTRAINT `FK_Requested_Normal` FOREIGN KEY (`requestedNormalID`) REFERENCES `Normal` (`normalID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Requester_Normal` FOREIGN KEY (`requesterNormalID`) REFERENCES `Normal` (`normalID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Image`
--

DROP TABLE IF EXISTS `Image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Image` (
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `imageID` int(11) NOT NULL AUTO_INCREMENT,
  `eventID` int(11) DEFAULT NULL,
  PRIMARY KEY (`imageID`),
  KEY `eventID` (`eventID`),
  CONSTRAINT `FK_Image_Event` FOREIGN KEY (`eventID`) REFERENCES `Event` (`eventID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Local`
--

DROP TABLE IF EXISTS `Local`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Local` (
  `address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `localID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`localID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Normal`
--

DROP TABLE IF EXISTS `Normal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Normal` (
  `birthday` date DEFAULT NULL,
  `first_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `normalID` int(11) NOT NULL,
  PRIMARY KEY (`normalID`),
  CONSTRAINT `FK_Normal_User` FOREIGN KEY (`normalID`) REFERENCES `User` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NormalCategory`
--

DROP TABLE IF EXISTS `NormalCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NormalCategory` (
  `normalID` int(11) NOT NULL DEFAULT '0',
  `categoryID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`normalID`,`categoryID`),
  KEY `FK_NormalCategory_Category` (`categoryID`),
  CONSTRAINT `FK_NormalCategory_Category` FOREIGN KEY (`categoryID`) REFERENCES `Category` (`categoryID`) ON DELETE CASCADE,
  CONSTRAINT `FK_NormalCategory_Normal` FOREIGN KEY (`normalID`) REFERENCES `Normal` (`normalID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NormalTags`
--

DROP TABLE IF EXISTS `NormalTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NormalTags` (
  `normalID` int(11) NOT NULL DEFAULT '0',
  `tagsID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`normalID`,`tagsID`),
  KEY `FK_NormalTags_Tags` (`tagsID`),
  CONSTRAINT `FK_NormalTags_Normal` FOREIGN KEY (`normalID`) REFERENCES `Normal` (`normalID`) ON DELETE CASCADE,
  CONSTRAINT `FK_NormalTags_Tags` FOREIGN KEY (`tagsID`) REFERENCES `Tags` (`tagsID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Promoter`
--

DROP TABLE IF EXISTS `Promoter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Promoter` (
  `contact` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `institution` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `promoterID` int(11) NOT NULL,
  PRIMARY KEY (`promoterID`),
  CONSTRAINT `FK_Promoter_User` FOREIGN KEY (`promoterID`) REFERENCES `User` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Rate`
--

DROP TABLE IF EXISTS `Rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rate` (
  `rate` int(11) DEFAULT NULL,
  `eventID` int(11) NOT NULL DEFAULT '0',
  `normalID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventID`,`normalID`),
  KEY `FK_Rate_Normal` (`normalID`),
  CONSTRAINT `FK_Rate_Event` FOREIGN KEY (`eventID`) REFERENCES `Event` (`eventID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Rate_Normal` FOREIGN KEY (`normalID`) REFERENCES `Normal` (`normalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Registration`
--

DROP TABLE IF EXISTS `Registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Registration` (
  `eventID` int(11) NOT NULL DEFAULT '0',
  `normalID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventID`,`normalID`),
  KEY `FK_Registration_Normal` (`normalID`),
  CONSTRAINT `FK_Registration_Event` FOREIGN KEY (`eventID`) REFERENCES `Event` (`eventID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Registration_Normal` FOREIGN KEY (`normalID`) REFERENCES `Normal` (`normalID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Spotify`
--

DROP TABLE IF EXISTS `Spotify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Spotify` (
  `playListLink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `spotifyID` int(11) NOT NULL AUTO_INCREMENT,
  `eventID` int(11) DEFAULT NULL,
  PRIMARY KEY (`spotifyID`),
  KEY `eventID` (`eventID`),
  CONSTRAINT `FK_Spotify_Event` FOREIGN KEY (`eventID`) REFERENCES `Event` (`eventID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Tags`
--

DROP TABLE IF EXISTS `Tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tags` (
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tagsID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`tagsID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `banned` tinyint(1) DEFAULT '0',
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `index_User_on_email` (`email`),
  UNIQUE KEY `index_User_on_reset_password_token` (`reset_password_token`),
  KEY `index_User_on_provider` (`provider`),
  KEY `index_User_on_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Youtube`
--

DROP TABLE IF EXISTS `Youtube`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Youtube` (
  `videoID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `youtubeID` int(11) NOT NULL AUTO_INCREMENT,
  `eventID` int(11) DEFAULT NULL,
  PRIMARY KEY (`youtubeID`),
  KEY `eventID` (`eventID`),
  CONSTRAINT `FK_Youtube_Event` FOREIGN KEY (`eventID`) REFERENCES `Event` (`eventID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `average_caches`
--

DROP TABLE IF EXISTS `average_caches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `average_caches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rater_id` int(11) DEFAULT NULL,
  `rateable_id` int(11) DEFAULT NULL,
  `rateable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avg` float NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ckeditor_assets`
--

DROP TABLE IF EXISTS `ckeditor_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckeditor_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_file_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_file_size` int(11) DEFAULT NULL,
  `assetable_id` int(11) DEFAULT NULL,
  `assetable_type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ckeditor_assetable_type` (`assetable_type`,`type`,`assetable_id`),
  KEY `idx_ckeditor_assetable` (`assetable_type`,`assetable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `overall_averages`
--

DROP TABLE IF EXISTS `overall_averages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `overall_averages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rateable_id` int(11) DEFAULT NULL,
  `rateable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `overall_avg` float NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rates`
--

DROP TABLE IF EXISTS `rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rater_id` int(11) DEFAULT NULL,
  `rateable_id` int(11) DEFAULT NULL,
  `rateable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stars` float NOT NULL,
  `dimension` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rates_on_rater_id` (`rater_id`),
  KEY `index_rates_on_rateable_id_and_rateable_type` (`rateable_id`,`rateable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating_caches`
--

DROP TABLE IF EXISTS `rating_caches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_caches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheable_id` int(11) DEFAULT NULL,
  `cacheable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avg` float NOT NULL,
  `qty` int(11) NOT NULL,
  `dimension` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rating_caches_on_cacheable_id_and_cacheable_type` (`cacheable_id`,`cacheable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-01-02 18:14:51
