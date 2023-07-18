CREATE DATABASE  IF NOT EXISTS `librasensedb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `librasensedb`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: librasensedb
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `isbn` varchar(17) NOT NULL,
  `title` varchar(35) NOT NULL,
  PRIMARY KEY (`isbn`),
  UNIQUE KEY `title_idx` (`title`),
  CONSTRAINT `titlefk` FOREIGN KEY (`title`) REFERENCES `book_info` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('978-11-51902-708','A Decent Woman'),('978-08-21942-141','Attachments'),('978-43-67419-787','Dare Me'),('978-14-42791-090','Dark Places'),('978-03-77419-932','Gone Girl'),('978-21-86091-565','In Cold Blood'),('978-89-01236-096','It'),('978-17-05297-444','Me Before You'),('978-91-58096-121','Meant to be Mine'),('978-51-03291-796','No Exit'),('978-03-15865-982','Outlander'),('978-52-21049-630','Pride and Prejudice'),('978-76-50932-115','Sharp Objects'),('978-08-74395-116','The Black Dahlia'),('978-38-61209-361','The Da Vinci Code'),('978-42-09651-812','The Godfather'),('978-45-86102-591','The Hobbit'),('978-10-43819-118','The Hunger Games'),('978-64-30189-117','The Maze Runner'),('978-31-89461-093','The Notebook'),('978-53-98142-119','The Peacock Summer'),('978-51-82365-818','The Shining'),('978-05-59872-120','The Snowman'),('978-12-34567-897','The Thief'),('978-09-56731-711','Treasure Island');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_author`
--

DROP TABLE IF EXISTS `book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_author` (
  `isbn` varchar(17) NOT NULL,
  `author_name` varchar(30) NOT NULL,
  PRIMARY KEY (`isbn`,`author_name`),
  KEY `author_idx` (`author_name`),
  CONSTRAINT `ba_isbnfk` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_author`
--

LOCK TABLES `book_author` WRITE;
/*!40000 ALTER TABLE `book_author` DISABLE KEYS */;
INSERT INTO `book_author` VALUES ('978-11-51902-708',' Eleanor Parker Sapia'),('978-08-21942-141',' Rainbow Rowell'),('978-51-03291-796',' Taylor Adams'),('978-91-58096-121','Becky Wade'),('978-38-61209-361','Dan Brown'),('978-03-15865-982','Diana Gabaldon'),('978-12-34567-897','Fuminori Nakamura'),('978-03-77419-932','Gillian Flynn'),('978-14-42791-090','Gillian Flynn'),('978-76-50932-115','Gillian Flynn'),('978-53-98142-119','Hannah Richell'),('978-45-86102-591','J.R.R. Tolkein'),('978-64-30189-117','James Dashner'),('978-08-74395-116','James Ellroy'),('978-52-21049-630','Jane Austen'),('978-05-59872-120','Jo Nesbø'),('978-17-05297-444','Jojo Moyes'),('978-42-09651-812','Mario Puzo'),('978-43-67419-787','Megan Abbott'),('978-31-89461-093','Nicholas Sparks'),('978-09-56731-711','Robert Louis Stevenson'),('978-51-82365-818','Stephen King'),('978-89-01236-096','Stephen King'),('978-10-43819-118','Suzanne Collins'),('978-21-86091-565','Truman Capote');
/*!40000 ALTER TABLE `book_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_info`
--

DROP TABLE IF EXISTS `book_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_info` (
  `title` varchar(35) NOT NULL,
  `category` varchar(30) DEFAULT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`title`),
  KEY `cat_idx` (`category`),
  KEY `price_idx` (`price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_info`
--

LOCK TABLES `book_info` WRITE;
/*!40000 ALTER TABLE `book_info` DISABLE KEYS */;
INSERT INTO `book_info` VALUES ('A Decent Woman','Historical',140),('Attachments','Romance',150),('Dare Me','Crime',120),('Dark Places','Mystery',180),('Gone Girl','Mystery',170),('In Cold Blood','Crime',120),('It','Horror',120),('Me Before You','Romance',260),('Meant to be Mine','Romance',220),('No Exit','Horror',160),('Outlander','Romance',200),('Pride and Prejudice','Romance',180),('Sharp Objects','Mystery',240),('The Black Dahlia','Mystery',130),('The Da Vinci Code','Mystery',140),('The Godfather','Crime',140),('The Hobbit','Adventure',220),('The Hunger Games','Fiction',150),('The Maze Runner','Fiction',190),('The Notebook','Romance',100),('The Peacock Summer','Fiction',200),('The Shining','Horror',140),('The Snowman','Mystery',150),('The Thief','Crime',130),('Treasure Island','Adventure',120);
/*!40000 ALTER TABLE `book_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `book_records_admin`
--

DROP TABLE IF EXISTS `book_records_admin`;
/*!50001 DROP VIEW IF EXISTS `book_records_admin`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `book_records_admin` AS SELECT 
 1 AS `isbn`,
 1 AS `title`,
 1 AS `category`,
 1 AS `price`,
 1 AS `author`,
 1 AS `condition`,
 1 AS `availability`,
 1 AS `publisher_id`,
 1 AS `publisher`,
 1 AS `year`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `borrows`
--

DROP TABLE IF EXISTS `borrows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrows` (
  `user_id` int NOT NULL,
  `isbn` varchar(17) NOT NULL,
  `issue_date` datetime NOT NULL,
  `due_date` datetime NOT NULL,
  `return_date` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`,`isbn`),
  KEY `ub_isbnfk` (`isbn`),
  KEY `issuedate_idx` (`issue_date`),
  CONSTRAINT `ub_isbnfk` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`),
  CONSTRAINT `ub_useridfk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrows`
--

LOCK TABLES `borrows` WRITE;
/*!40000 ALTER TABLE `borrows` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ebook`
--

DROP TABLE IF EXISTS `ebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ebook` (
  `isbn` varchar(17) NOT NULL,
  `file_size` varchar(20) DEFAULT NULL,
  `file_format` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`isbn`),
  KEY `filesize_idx` (`file_size`),
  CONSTRAINT `eb_isbnfk` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ebook`
--

LOCK TABLES `ebook` WRITE;
/*!40000 ALTER TABLE `ebook` DISABLE KEYS */;
INSERT INTO `ebook` VALUES ('978-05-59872-120','27.710518','PDF'),('978-08-21942-141','4.695547','PDF'),('978-08-74395-116','1.516433','PDF'),('978-10-43819-118','2.587298','PDF'),('978-11-51902-708','1.812037','PDF'),('978-14-42791-090','1.103283','PDF'),('978-51-03291-796','0.994412','PDF'),('978-53-98142-119','2.602339','PDF'),('978-64-30189-117','1.291729','PDF'),('978-76-50932-115','0.953478','PDF'),('978-91-58096-121','2.857975','PDF');
/*!40000 ALTER TABLE `ebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ebook_records_admin`
--

DROP TABLE IF EXISTS `ebook_records_admin`;
/*!50001 DROP VIEW IF EXISTS `ebook_records_admin`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ebook_records_admin` AS SELECT 
 1 AS `isbn`,
 1 AS `title`,
 1 AS `category`,
 1 AS `price`,
 1 AS `author`,
 1 AS `file_size`,
 1 AS `file_format`,
 1 AS `publisher_id`,
 1 AS `publisher`,
 1 AS `year`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `keeps_track_of`
--

DROP TABLE IF EXISTS `keeps_track_of`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `keeps_track_of` (
  `staff_id` varchar(7) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`staff_id`,`user_id`),
  KEY `su_useridfk` (`user_id`),
  CONSTRAINT `su_staffidfk` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `su_useridfk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keeps_track_of`
--

LOCK TABLES `keeps_track_of` WRITE;
/*!40000 ALTER TABLE `keeps_track_of` DISABLE KEYS */;
INSERT INTO `keeps_track_of` VALUES ('ST-0006',4);
/*!40000 ALTER TABLE `keeps_track_of` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintains`
--

DROP TABLE IF EXISTS `maintains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintains` (
  `isbn` varchar(17) NOT NULL,
  `staff_id` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`isbn`),
  KEY `sb_staffidfk` (`staff_id`),
  CONSTRAINT `sb_isbnfk` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`),
  CONSTRAINT `sb_staffidfk` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintains`
--

LOCK TABLES `maintains` WRITE;
/*!40000 ALTER TABLE `maintains` DISABLE KEYS */;
INSERT INTO `maintains` VALUES ('978-03-15865-982','ST-0004'),('978-03-77419-932','ST-0004'),('978-09-56731-711','ST-0004'),('978-12-34567-897','ST-0004'),('978-17-05297-444','ST-0004'),('978-21-86091-565','ST-0004'),('978-31-89461-093','ST-0004'),('978-38-61209-361','ST-0004'),('978-42-09651-812','ST-0004'),('978-43-67419-787','ST-0004'),('978-45-86102-591','ST-0004'),('978-51-82365-818','ST-0004'),('978-52-21049-630','ST-0004'),('978-89-01236-096','ST-0004'),('978-05-59872-120','ST-0005'),('978-08-21942-141','ST-0005'),('978-08-74395-116','ST-0005'),('978-10-43819-118','ST-0005'),('978-11-51902-708','ST-0005'),('978-14-42791-090','ST-0005'),('978-51-03291-796','ST-0005'),('978-53-98142-119','ST-0005'),('978-64-30189-117','ST-0005'),('978-76-50932-115','ST-0005'),('978-91-58096-121','ST-0005');
/*!40000 ALTER TABLE `maintains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physical_book`
--

DROP TABLE IF EXISTS `physical_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `physical_book` (
  `isbn` varchar(17) NOT NULL,
  `book_condition` varchar(10) DEFAULT NULL,
  `availability` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`isbn`),
  KEY `availability_idx` (`availability`),
  CONSTRAINT `pb_isbnfk` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physical_book`
--

LOCK TABLES `physical_book` WRITE;
/*!40000 ALTER TABLE `physical_book` DISABLE KEYS */;
INSERT INTO `physical_book` VALUES ('978-03-15865-982','Good','Yes'),('978-03-77419-932','Excellent','Yes'),('978-09-56731-711','Bad','Yes'),('978-12-34567-897','Excellent','Yes'),('978-17-05297-444','Excellent','Yes'),('978-21-86091-565','Good','Yes'),('978-31-89461-093','Good','Yes'),('978-38-61209-361','Good','Yes'),('978-42-09651-812','Good','Yes'),('978-43-67419-787','Excellent','Yes'),('978-45-86102-591','Good','Yes'),('978-51-82365-818','Good','Yes'),('978-52-21049-630','Bad','Yes'),('978-89-01236-096','Good','Yes');
/*!40000 ALTER TABLE `physical_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `publisher_id` int NOT NULL AUTO_INCREMENT,
  `publisher_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`publisher_id`),
  KEY `publishername_idx` (`publisher_name`)
) ENGINE=InnoDB AUTO_INCREMENT=590 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (571,' Broadway Books'),(585,' Mysterious Press'),(572,'Anchor Books'),(582,'Bethany House Publishers'),(581,'Crown Publishing Group'),(586,'Delacorte Press'),(567,'Dell Publishing'),(580,'Dutton Adult'),(574,'G.P. Putnam\'s Sons'),(568,'HarperCollins'),(588,'Orion'),(578,'Pamela Dorman Books'),(566,'Penguin Classics'),(569,'Puffin Classics'),(576,'Random House'),(589,'Random House '),(564,'Reagen Arthur Books'),(587,'Scholastic Press'),(584,'Shaye Areheart Books'),(563,'Soho Crime'),(573,'Viking'),(565,'Warner Books'),(583,'William Morrow'),(579,'Winter Goose Publishing');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishes`
--

DROP TABLE IF EXISTS `publishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishes` (
  `isbn` varchar(17) NOT NULL,
  `publisher_id` int DEFAULT NULL,
  `publication_year` int DEFAULT NULL,
  PRIMARY KEY (`isbn`),
  KEY `publisher_idfk` (`publisher_id`),
  KEY `publiyear_idx` (`publication_year`),
  CONSTRAINT `isbnfk` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`),
  CONSTRAINT `publisher_idfk` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishes`
--

LOCK TABLES `publishes` WRITE;
/*!40000 ALTER TABLE `publishes` DISABLE KEYS */;
INSERT INTO `publishes` VALUES ('978-03-15865-982',567,1991),('978-03-77419-932',571,2012),('978-05-59872-120',589,2007),('978-08-21942-141',580,2011),('978-08-74395-116',585,1987),('978-09-56731-711',569,1883),('978-10-43819-118',587,2008),('978-11-51902-708',579,2015),('978-12-34567-897',563,2005),('978-14-42791-090',581,2009),('978-17-05297-444',578,2012),('978-21-86091-565',576,1966),('978-31-89461-093',565,1996),('978-38-61209-361',572,2003),('978-42-09651-812',574,1969),('978-43-67419-787',564,2012),('978-45-86102-591',568,1937),('978-51-03291-796',583,2017),('978-51-82365-818',572,1997),('978-52-21049-630',566,1813),('978-53-98142-119',588,2018),('978-64-30189-117',586,2008),('978-76-50932-115',584,2006),('978-89-01236-096',573,1986),('978-91-58096-121',582,2014);
/*!40000 ALTER TABLE `publishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` varchar(7) NOT NULL,
  `email` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `s_email_idx` (`email`),
  CONSTRAINT `st_emailfk` FOREIGN KEY (`email`) REFERENCES `staff_info` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES ('ST-0006','AdanLuvsPeacock@gmail.com'),('ST-0004','AlexisChuchu@gmail.com'),('ST-0005','Azher69@gmail.com'),('ST-0001','mmuk0603@gmail.com');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_info`
--

DROP TABLE IF EXISTS `staff_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_info` (
  `email` varchar(35) NOT NULL,
  `job` varchar(15) NOT NULL,
  `name` varchar(30) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`email`),
  KEY `job_idx` (`job`),
  KEY `name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_info`
--

LOCK TABLES `staff_info` WRITE;
/*!40000 ALTER TABLE `staff_info` DISABLE KEYS */;
INSERT INTO `staff_info` VALUES ('AdanLuvsPeacock@gmail.com','Records Manager','Muhammad Adan','Landhi','$2b$10$h2KCejZjhInkFsjaAoh1D.Pf8jaw41YATng8OVDezF0oClit2yVo2'),('AlexisChuchu@gmail.com','Books Manager','Alex Hayden','Times Square','$2b$10$E4Md02hZMILu4WkSSgrHw.A73yD7Wj2LZmxRdQpiElPDxz.3VpRKW'),('Azher69@gmail.com','Ebooks Manager','Muhammad Azher','Gosht Gali','$2b$10$BnzMZGtPflwowwo0qT2oi.hNngBC/JIMUeTDygaiOWDQBe/5pSM/y'),('mmuk0603@gmail.com','Admin','Muhib','PHA housing scheme','$2b$10$LUw3ECxPsTUX4RcVXHIHou0ZKoJr3crM1GCqT2p/YMhjNSkq4S2jG');
/*!40000 ALTER TABLE `staff_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `staff_maintains_ebooks`
--

DROP TABLE IF EXISTS `staff_maintains_ebooks`;
/*!50001 DROP VIEW IF EXISTS `staff_maintains_ebooks`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `staff_maintains_ebooks` AS SELECT 
 1 AS `staffid`,
 1 AS `staffname`,
 1 AS `isbn`,
 1 AS `title`,
 1 AS `author_name`,
 1 AS `publisher_id`,
 1 AS `publisher_name`,
 1 AS `category`,
 1 AS `price`,
 1 AS `file_format`,
 1 AS `file_size`,
 1 AS `publication_year`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `staff_maintains_pbooks`
--

DROP TABLE IF EXISTS `staff_maintains_pbooks`;
/*!50001 DROP VIEW IF EXISTS `staff_maintains_pbooks`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `staff_maintains_pbooks` AS SELECT 
 1 AS `staffid`,
 1 AS `staffname`,
 1 AS `isbn`,
 1 AS `title`,
 1 AS `author_name`,
 1 AS `publisher_id`,
 1 AS `publisher_name`,
 1 AS `category`,
 1 AS `price`,
 1 AS `book_condition`,
 1 AS `availability`,
 1 AS `publication_year`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `staff_records`
--

DROP TABLE IF EXISTS `staff_records`;
/*!50001 DROP VIEW IF EXISTS `staff_records`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `staff_records` AS SELECT 
 1 AS `StaffID`,
 1 AS `Name`,
 1 AS `Email`,
 1 AS `Address`,
 1 AS `Job`,
 1 AS `Manager`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `staff_user_records`
--

DROP TABLE IF EXISTS `staff_user_records`;
/*!50001 DROP VIEW IF EXISTS `staff_user_records`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `staff_user_records` AS SELECT 
 1 AS `isbn`,
 1 AS `title`,
 1 AS `booktype`,
 1 AS `category`,
 1 AS `price`,
 1 AS `user_id`,
 1 AS `name`,
 1 AS `email`,
 1 AS `address`,
 1 AS `telno`,
 1 AS `due_date`,
 1 AS `issue_date`,
 1 AS `return_date`,
 1 AS `staff_id`,
 1 AS `staff_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `u_email_idx` (`email`),
  CONSTRAINT `useremailfk` FOREIGN KEY (`email`) REFERENCES `user_info` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'HamzaILY@gmail.com'),(3,'HamzaM@gmail.com'),(1,'jawwadkareem@gmail.com'),(2,'SYJ@gmail.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `user_books`
--

DROP TABLE IF EXISTS `user_books`;
/*!50001 DROP VIEW IF EXISTS `user_books`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_books` AS SELECT 
 1 AS `isbn`,
 1 AS `title`,
 1 AS `author`,
 1 AS `Category`,
 1 AS `Price`,
 1 AS `book_Condition`,
 1 AS `Availability`,
 1 AS `publisher_name`,
 1 AS `publication_year`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `user_borrows_books`
--

DROP TABLE IF EXISTS `user_borrows_books`;
/*!50001 DROP VIEW IF EXISTS `user_borrows_books`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_borrows_books` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `email`,
 1 AS `isbn`,
 1 AS `title`,
 1 AS `category`,
 1 AS `price`,
 1 AS `author_name`,
 1 AS `publisher_name`,
 1 AS `publication_year`,
 1 AS `file_size`,
 1 AS `file_format`,
 1 AS `booktype`,
 1 AS `issue_date`,
 1 AS `due_date`,
 1 AS `return_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `user_ebooks`
--

DROP TABLE IF EXISTS `user_ebooks`;
/*!50001 DROP VIEW IF EXISTS `user_ebooks`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_ebooks` AS SELECT 
 1 AS `isbn`,
 1 AS `title`,
 1 AS `author`,
 1 AS `Category`,
 1 AS `Price`,
 1 AS `file_size`,
 1 AS `file_format`,
 1 AS `publisher_name`,
 1 AS `publication_year`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_info` (
  `email` varchar(35) NOT NULL,
  `name` varchar(30) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`email`),
  KEY `name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES ('HamzaILY@gmail.com','Hamza Anwar','Federal B-Area','$2b$10$JXEfw7jS90smAYHuuFiba.bCviVHC6jlG3Du/tgUFgf2PuZiHZxGG'),('HamzaM@gmail.com','Hamza Anwer Mohiuddin','Federal B-Area','$2b$10$sup6aJ/tGK6rq.9Smi/yN.MtH/Kkr2Z.3rMWDNkk2BEr/KssKUseq'),('jawwadkareem@gmail.com','Jawwad Kareem','North Karachi ','123456'),('SYJ@gmail.com','Syed Yaseen Jamal','North Nazimabad','huhaas');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `user_records_admin`
--

DROP TABLE IF EXISTS `user_records_admin`;
/*!50001 DROP VIEW IF EXISTS `user_records_admin`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_records_admin` AS SELECT 
 1 AS `UserID`,
 1 AS `Name`,
 1 AS `Email`,
 1 AS `Address`,
 1 AS `Contact`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_telno`
--

DROP TABLE IF EXISTS `user_telno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_telno` (
  `user_id` int NOT NULL,
  `telno` varchar(12) NOT NULL,
  PRIMARY KEY (`user_id`,`telno`),
  CONSTRAINT `ut_useridfk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_telno`
--

LOCK TABLES `user_telno` WRITE;
/*!40000 ALTER TABLE `user_telno` DISABLE KEYS */;
INSERT INTO `user_telno` VALUES (1,'031567582632'),(2,'0315432876'),(2,'0342256969'),(3,'0313678532'),(3,'0342564312'),(4,'03214353121'),(4,'03457543231');
/*!40000 ALTER TABLE `user_telno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works_for`
--

DROP TABLE IF EXISTS `works_for`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `works_for` (
  `worker_staff_id` varchar(7) NOT NULL,
  `manager_staff_id` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`worker_staff_id`),
  KEY `wf_mstaffidfk` (`manager_staff_id`),
  CONSTRAINT `wf_mstaffidfk` FOREIGN KEY (`manager_staff_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `wf_wstaffidfk` FOREIGN KEY (`worker_staff_id`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_for`
--

LOCK TABLES `works_for` WRITE;
/*!40000 ALTER TABLE `works_for` DISABLE KEYS */;
INSERT INTO `works_for` VALUES ('ST-0001',NULL),('ST-0004','ST-0001'),('ST-0005','ST-0001'),('ST-0006','ST-0001');
/*!40000 ALTER TABLE `works_for` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `book_records_admin`
--

/*!50001 DROP VIEW IF EXISTS `book_records_admin`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `book_records_admin` AS select `b`.`isbn` AS `isbn`,`b`.`title` AS `title`,`bi`.`category` AS `category`,`bi`.`price` AS `price`,`ba`.`author_name` AS `author`,`pb`.`book_condition` AS `condition`,`pb`.`availability` AS `availability`,`p`.`publisher_id` AS `publisher_id`,`p`.`publisher_name` AS `publisher`,`ps`.`publication_year` AS `year` from (((((`book` `b` join `book_info` `bi` on((`b`.`title` = `bi`.`title`))) join `book_author` `ba` on((`b`.`isbn` = `ba`.`isbn`))) join `physical_book` `pb` on((`b`.`isbn` = `pb`.`isbn`))) join `publishes` `ps` on((`b`.`isbn` = `ps`.`isbn`))) join `publisher` `p` on((`p`.`publisher_id` = `ps`.`publisher_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ebook_records_admin`
--

/*!50001 DROP VIEW IF EXISTS `ebook_records_admin`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ebook_records_admin` AS select `b`.`isbn` AS `isbn`,`b`.`title` AS `title`,`bi`.`category` AS `category`,`bi`.`price` AS `price`,`ba`.`author_name` AS `author`,`eb`.`file_size` AS `file_size`,`eb`.`file_format` AS `file_format`,`p`.`publisher_id` AS `publisher_id`,`p`.`publisher_name` AS `publisher`,`ps`.`publication_year` AS `year` from (((((`book` `b` join `book_info` `bi` on((`b`.`title` = `bi`.`title`))) join `book_author` `ba` on((`b`.`isbn` = `ba`.`isbn`))) join `ebook` `eb` on((`b`.`isbn` = `eb`.`isbn`))) join `publishes` `ps` on((`b`.`isbn` = `ps`.`isbn`))) join `publisher` `p` on((`p`.`publisher_id` = `ps`.`publisher_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `staff_maintains_ebooks`
--

/*!50001 DROP VIEW IF EXISTS `staff_maintains_ebooks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `staff_maintains_ebooks` AS select `s`.`staff_id` AS `staffid`,`si`.`name` AS `staffname`,`b`.`isbn` AS `isbn`,`bi`.`title` AS `title`,`ba`.`author_name` AS `author_name`,`p`.`publisher_id` AS `publisher_id`,`p`.`publisher_name` AS `publisher_name`,`bi`.`category` AS `category`,`bi`.`price` AS `price`,`eb`.`file_format` AS `file_format`,`eb`.`file_size` AS `file_size`,`pub`.`publication_year` AS `publication_year` from ((((((((`staff` `s` join `staff_info` `si` on((`si`.`email` = `s`.`email`))) join `maintains` `m` on((`m`.`staff_id` = `s`.`staff_id`))) join `ebook` `eb` on((`eb`.`isbn` = `m`.`isbn`))) join `book` `b` on((`b`.`isbn` = `eb`.`isbn`))) join `book_info` `bi` on((`bi`.`title` = `b`.`title`))) join `publishes` `pub` on((`pub`.`isbn` = `b`.`isbn`))) join `publisher` `p` on((`p`.`publisher_id` = `pub`.`publisher_id`))) join `book_author` `ba` on((`ba`.`isbn` = `b`.`isbn`))) where (`si`.`job` = 'Ebooks Manager') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `staff_maintains_pbooks`
--

/*!50001 DROP VIEW IF EXISTS `staff_maintains_pbooks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `staff_maintains_pbooks` AS select `s`.`staff_id` AS `staffid`,`si`.`name` AS `staffname`,`b`.`isbn` AS `isbn`,`bi`.`title` AS `title`,`ba`.`author_name` AS `author_name`,`p`.`publisher_id` AS `publisher_id`,`p`.`publisher_name` AS `publisher_name`,`bi`.`category` AS `category`,`bi`.`price` AS `price`,`pb`.`book_condition` AS `book_condition`,`pb`.`availability` AS `availability`,`pub`.`publication_year` AS `publication_year` from ((((((((`staff` `s` join `staff_info` `si` on((`si`.`email` = `s`.`email`))) join `maintains` `m` on((`m`.`staff_id` = `s`.`staff_id`))) join `physical_book` `pb` on((`pb`.`isbn` = `m`.`isbn`))) join `book` `b` on((`b`.`isbn` = `pb`.`isbn`))) join `book_info` `bi` on((`bi`.`title` = `b`.`title`))) join `publishes` `pub` on((`pub`.`isbn` = `b`.`isbn`))) join `publisher` `p` on((`p`.`publisher_id` = `pub`.`publisher_id`))) join `book_author` `ba` on((`ba`.`isbn` = `b`.`isbn`))) where (`si`.`job` = 'Books Manager') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `staff_records`
--

/*!50001 DROP VIEW IF EXISTS `staff_records`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `staff_records` AS select `s`.`staff_id` AS `StaffID`,`si`.`name` AS `Name`,`si`.`email` AS `Email`,`si`.`address` AS `Address`,`si`.`job` AS `Job`,`w`.`manager_staff_id` AS `Manager` from ((`staff_info` `si` join `staff` `s` on((`si`.`email` = `s`.`email`))) join `works_for` `w` on((`s`.`staff_id` = `w`.`worker_staff_id`))) order by `s`.`staff_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `staff_user_records`
--

/*!50001 DROP VIEW IF EXISTS `staff_user_records`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `staff_user_records` AS select `b`.`isbn` AS `isbn`,`b`.`title` AS `title`,(case when exists(select 1 from `physical_book` `pb` where (`pb`.`isbn` = `b`.`isbn`)) then 'Physical' when exists(select 1 from `ebook` `eb` where (`eb`.`isbn` = `b`.`isbn`)) then 'Ebook' else 'Unknown' end) AS `booktype`,`bi`.`category` AS `category`,`bi`.`price` AS `price`,`u`.`user_id` AS `user_id`,`ui`.`name` AS `name`,`u`.`email` AS `email`,`ui`.`address` AS `address`,group_concat(`ut`.`telno` separator ',') AS `telno`,date_format(`bo`.`due_date`,'%Y-%m-%d %H:%i:%s') AS `due_date`,date_format(`bo`.`issue_date`,'%Y-%m-%d %H:%i:%s') AS `issue_date`,date_format(`bo`.`return_date`,'%Y-%m-%d %H:%i:%s') AS `return_date`,`s`.`staff_id` AS `staff_id`,`si`.`name` AS `staff_name` from ((((((((`book` `b` join `book_info` `bi` on((`b`.`title` = `bi`.`title`))) join `borrows` `bo` on((`b`.`isbn` = `bo`.`isbn`))) join `user` `u` on((`bo`.`user_id` = `u`.`user_id`))) join `user_info` `ui` on((`u`.`email` = `ui`.`email`))) join `user_telno` `ut` on((`u`.`user_id` = `ut`.`user_id`))) left join `keeps_track_of` `kto` on((`u`.`user_id` = `kto`.`user_id`))) left join `staff` `s` on((`kto`.`staff_id` = `s`.`staff_id`))) left join `staff_info` `si` on((`s`.`email` = `si`.`email`))) where (exists(select 1 from `physical_book` `pb` where (`pb`.`isbn` = `b`.`isbn`)) or exists(select 1 from `ebook` `eb` where (`eb`.`isbn` = `b`.`isbn`))) group by `b`.`isbn`,`b`.`title`,`booktype`,`bi`.`category`,`bi`.`price`,`u`.`user_id`,`ui`.`name`,`u`.`email`,`ui`.`address`,`bo`.`due_date`,`bo`.`issue_date`,`bo`.`return_date`,`s`.`staff_id`,`si`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_books`
--

/*!50001 DROP VIEW IF EXISTS `user_books`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_books` AS select `b`.`isbn` AS `isbn`,`b`.`title` AS `title`,`ba`.`author_name` AS `author`,`bi`.`category` AS `Category`,`bi`.`price` AS `Price`,`pb`.`book_condition` AS `book_Condition`,`pb`.`availability` AS `Availability`,`p`.`publisher_name` AS `publisher_name`,`pp`.`publication_year` AS `publication_year` from (((((`book` `b` join `book_author` `ba` on((`b`.`isbn` = `ba`.`isbn`))) join `book_info` `bi` on((`b`.`title` = `bi`.`title`))) join `physical_book` `pb` on((`ba`.`isbn` = `pb`.`isbn`))) join `publishes` `pp` on((`pp`.`isbn` = `b`.`isbn`))) join `publisher` `p` on((`p`.`publisher_id` = `pp`.`publisher_id`))) order by `b`.`isbn` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_borrows_books`
--

/*!50001 DROP VIEW IF EXISTS `user_borrows_books`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_borrows_books` AS select `u`.`user_id` AS `user_id`,`ui`.`name` AS `username`,`u`.`email` AS `email`,`b`.`isbn` AS `isbn`,`b`.`title` AS `title`,`bi`.`category` AS `category`,`bi`.`price` AS `price`,`ba`.`author_name` AS `author_name`,`p`.`publisher_name` AS `publisher_name`,`pub`.`publication_year` AS `publication_year`,`eb`.`file_size` AS `file_size`,`eb`.`file_format` AS `file_format`,(case when (`pb`.`isbn` is not null) then 'Physical Book' when (`eb`.`isbn` is not null) then 'Ebook' else 'Unknown' end) AS `booktype`,date_format(`bo`.`issue_date`,'%Y-%m-%d %H:%i:%s') AS `issue_date`,date_format(`bo`.`due_date`,'%Y-%m-%d %H:%i:%s') AS `due_date`,date_format(`bo`.`return_date`,'%Y-%m-%d %H:%i:%s') AS `return_date` from (((((((((`user` `u` join `user_info` `ui` on((`u`.`email` = `ui`.`email`))) join `borrows` `bo` on((`u`.`user_id` = `bo`.`user_id`))) join `book` `b` on((`bo`.`isbn` = `b`.`isbn`))) join `book_info` `bi` on((`b`.`title` = `bi`.`title`))) join `book_author` `ba` on((`b`.`isbn` = `ba`.`isbn`))) join `publishes` `pub` on((`b`.`isbn` = `pub`.`isbn`))) join `publisher` `p` on((`p`.`publisher_id` = `pub`.`publisher_id`))) left join `physical_book` `pb` on((`b`.`isbn` = `pb`.`isbn`))) left join `ebook` `eb` on((`b`.`isbn` = `eb`.`isbn`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_ebooks`
--

/*!50001 DROP VIEW IF EXISTS `user_ebooks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_ebooks` AS select `b`.`isbn` AS `isbn`,`b`.`title` AS `title`,`ba`.`author_name` AS `author`,`bi`.`category` AS `Category`,`bi`.`price` AS `Price`,`eb`.`file_size` AS `file_size`,`eb`.`file_format` AS `file_format`,`p`.`publisher_name` AS `publisher_name`,`pp`.`publication_year` AS `publication_year` from (((((`book` `b` join `book_author` `ba` on((`b`.`isbn` = `ba`.`isbn`))) join `book_info` `bi` on((`b`.`title` = `bi`.`title`))) join `ebook` `eb` on((`ba`.`isbn` = `eb`.`isbn`))) join `publishes` `pp` on((`pp`.`isbn` = `b`.`isbn`))) join `publisher` `p` on((`p`.`publisher_id` = `pp`.`publisher_id`))) order by `b`.`isbn` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_records_admin`
--

/*!50001 DROP VIEW IF EXISTS `user_records_admin`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_records_admin` AS select `u`.`user_id` AS `UserID`,`ui`.`name` AS `Name`,`ui`.`email` AS `Email`,`ui`.`address` AS `Address`,`ut`.`telno` AS `Contact` from ((`user_info` `ui` join `user` `u` on((`ui`.`email` = `u`.`email`))) join `user_telno` `ut` on((`u`.`user_id` = `ut`.`user_id`))) order by `u`.`user_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-18 23:36:35
