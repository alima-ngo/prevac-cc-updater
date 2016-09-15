-- MySQL dump 10.13  Distrib 5.5.42, for Linux (x86_64)
--
-- Host: dbsrv1.mdm.morpho    Database: alima-mme
-- ------------------------------------------------------
-- Server version	5.5.42-log

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
-- Table structure for table `upload_download`
--

DROP TABLE IF EXISTS `upload_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_download` (
  `TID` int(11) NOT NULL,
  `upload_day` date DEFAULT NULL,
  `upload_time` time DEFAULT NULL,
  `download_day` date DEFAULT NULL,
  `download_time` time DEFAULT NULL,
  PRIMARY KEY (`TID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload_download`
--

LOCK TABLES `upload_download` WRITE;
/*!40000 ALTER TABLE `upload_download` DISABLE KEYS */;
INSERT INTO `upload_download` VALUES (0,NULL,NULL,'2016-08-23','11:53:11'),(170215,'2016-08-23','15:37:10','2016-08-23','15:37:46'),(170216,'2016-08-23','15:32:31','2016-08-23','15:33:12'),(170217,'2016-08-23','15:37:37','2016-08-23','15:38:03'),(170220,'2016-08-23','15:25:44','2016-08-23','15:26:16'),(170221,'2016-08-23','15:30:45','2016-08-23','15:30:46'),(170222,'2016-08-23','14:44:48','2016-08-23','14:45:32'),(170225,'2016-08-23','16:22:43','2016-08-23','16:23:06'),(170226,'2016-08-23','13:43:40','2016-08-23','13:43:40'),(170227,'2016-08-23','14:57:22','2016-08-23','14:57:55'),(170228,'2016-08-23','15:17:51','2016-08-23','15:18:13'),(170229,'2016-08-23','16:56:05','2016-08-23','16:56:26'),(170230,'2016-08-23','15:54:09','2016-08-23','15:54:43'),(170231,'2016-08-23','14:50:12','2016-08-23','14:51:08'),(170232,'2016-08-23','14:57:19','2016-08-23','14:57:49'),(170233,'2016-08-23','15:46:12','2016-08-23','15:46:39'),(170235,'2016-08-24','11:35:17','2016-08-24','11:35:36'),(170236,'2016-08-23','14:35:13','2016-08-23','14:36:08'),(170237,'2016-08-23','15:01:36','2016-08-23','15:02:13'),(170239,'2016-08-23','14:39:33','2016-08-23','14:40:23'),(170240,'2016-08-23','15:46:00','2016-08-23','15:47:00'),(170241,'2016-08-23','13:39:21','2016-08-23','13:39:31'),(170242,'2016-08-24','12:07:40','2016-08-24','12:07:41'),(170243,'2016-08-23','13:23:39','2016-08-23','13:23:57'),(170244,'2016-08-23','15:37:25','2016-08-23','15:37:51'),(170245,'2016-08-23','15:43:19','2016-08-23','15:43:57'),(170246,'2016-08-23','13:23:24','2016-08-23','13:23:30'),(170247,'2016-08-23','15:16:38','2016-08-23','15:16:58'),(170249,'2016-08-23','17:11:08','2016-08-23','17:11:24'),(170250,'2016-08-24','08:55:40','2016-08-24','08:55:40'),(170251,'2016-08-23','13:28:19','2016-08-23','13:28:29'),(170252,'2016-08-23','15:33:11','2016-08-23','15:33:47'),(170253,'2016-08-23','14:57:34','2016-08-23','14:58:05'),(170254,'2016-08-23','14:39:58','2016-08-23','14:41:19'),(170255,'2016-08-23','16:57:30','2016-08-23','16:57:49'),(170256,'2016-08-23','15:54:11','2016-08-23','15:54:42'),(170257,'2016-08-23','14:41:52','2016-08-23','14:42:47'),(170258,'2016-08-23','15:46:23','2016-08-23','15:47:14'),(170260,'2016-08-23','15:06:07','2016-08-23','15:06:35'),(170262,'2016-08-23','14:50:35','2016-08-23','14:51:23'),(170263,'2016-08-23','15:16:51','2016-08-23','15:17:22'),(170264,'2016-08-23','14:33:51','2016-08-23','14:34:01'),(170265,'2016-08-23','14:53:33','2016-08-23','14:53:50'),(170266,'2016-08-23','15:47:02','2016-08-23','15:47:36'),(170267,'2016-08-23','17:17:01','2016-08-23','17:17:12'),(170268,'2016-08-23','13:25:20','2016-08-23','13:25:32');
/*!40000 ALTER TABLE `upload_download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beneficiaries_visits`
--

DROP TABLE IF EXISTS `beneficiaries_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beneficiaries_visits` (
  `PID` varchar(8) NOT NULL,
  `Visit_Type` int(11) NOT NULL,
  `Start_From` date NOT NULL,
  `End_In` date NOT NULL,
  `Date_Of_Visit` date DEFAULT NULL,
  `Visit_Flag` int(11) DEFAULT '0',
  `Originating_Procedure` int(11) DEFAULT NULL,
  `Operator` varchar(45) DEFAULT NULL,
  `Time_Of_Visit` time DEFAULT NULL,
  PRIMARY KEY (`PID`,`Visit_Type`),
  KEY `Beneficiaries_Visits_FK` (`PID`),
  CONSTRAINT `Beneficiaries_Visits_FK` FOREIGN KEY (`PID`) REFERENCES `beneficiaries` (`PID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiaries_visits`
--

LOCK TABLES `beneficiaries_visits` WRITE;
/*!40000 ALTER TABLE `beneficiaries_visits` DISABLE KEYS */;
INSERT INTO `beneficiaries_visits` VALUES ('H0000001',1,'2016-09-10','2016-09-16',NULL,0,0,'',NULL),('H0000001',2,'2016-09-17','2016-09-23',NULL,0,0,'',NULL),('H0000001',3,'2016-09-27','2016-10-11',NULL,0,0,'',NULL),('H0000001',4,'2016-10-29','2016-11-04',NULL,0,0,'',NULL),('H0000001',5,'2016-11-05','2016-11-11',NULL,0,0,'',NULL),('H0000001',6,'2016-11-20','2016-12-20',NULL,0,0,'',NULL),('H0000001',7,'2017-02-06','2017-04-06',NULL,0,0,'',NULL),('H0000001',8,'2017-08-06','2017-10-06',NULL,0,0,'',NULL),('H0008383',1,'2016-08-28','2016-09-03',NULL,0,0,'',NULL),('H0008383',2,'2016-09-04','2016-09-10',NULL,0,0,'',NULL),('H0008383',3,'2016-09-14','2016-09-28',NULL,0,0,'',NULL),('H0008383',4,'2016-10-16','2016-10-22',NULL,0,0,'',NULL),('H0008383',5,'2016-10-23','2016-10-29',NULL,0,0,'',NULL),('H0008383',6,'2016-11-07','2016-12-08',NULL,0,0,'',NULL),('H0008383',7,'2017-01-24','2017-03-24',NULL,0,0,'',NULL),('H0008383',8,'2017-07-24','2017-09-24',NULL,0,0,'',NULL),('H0008387',1,'2016-08-19','2016-08-25',NULL,0,0,'',NULL),('H0008387',2,'2016-08-26','2016-09-01',NULL,0,0,'',NULL),('H0008387',3,'2016-09-05','2016-09-19',NULL,0,0,'',NULL),('H0008387',4,'2016-10-07','2016-10-13',NULL,0,0,'',NULL),('H0008387',5,'2016-10-14','2016-10-20',NULL,0,0,'',NULL),('H0008387',6,'2016-10-29','2016-11-29',NULL,0,0,'',NULL),('H0008387',7,'2017-01-15','2017-03-15',NULL,0,0,'',NULL),('H0008387',8,'2017-07-15','2017-09-15',NULL,0,0,'',NULL),('h3536765',1,'2016-08-26','2016-09-01',NULL,0,0,'',NULL),('h3536765',2,'2016-09-02','2016-09-08',NULL,0,0,'',NULL),('h3536765',3,'2016-09-12','2016-09-26',NULL,0,0,'',NULL),('h3536765',4,'2016-10-14','2016-10-20',NULL,0,0,'',NULL),('h3536765',5,'2016-10-21','2016-10-27',NULL,0,0,'',NULL),('h3536765',6,'2016-11-05','2016-12-06',NULL,0,0,'',NULL),('h3536765',7,'2017-01-22','2017-03-22',NULL,0,0,'',NULL),('h3536765',8,'2017-07-22','2017-09-22',NULL,0,0,'',NULL),('n6758658',1,'2016-09-09','2016-09-15',NULL,0,0,'',NULL),('n6758658',2,'2016-09-16','2016-09-22',NULL,0,0,'',NULL),('n6758658',3,'2016-09-26','2016-10-10',NULL,0,0,'',NULL),('n6758658',4,'2016-10-28','2016-11-03',NULL,0,0,'',NULL),('n6758658',5,'2016-11-04','2016-11-10',NULL,0,0,'',NULL),('n6758658',6,'2016-11-19','2016-12-19',NULL,0,0,'',NULL),('n6758658',7,'2017-02-05','2017-04-05',NULL,0,0,'',NULL),('n6758658',8,'2017-08-05','2017-10-05',NULL,0,0,'',NULL);
/*!40000 ALTER TABLE `beneficiaries_visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beneficiaries_unexcpeted_visits`
--

DROP TABLE IF EXISTS `beneficiaries_unexcpeted_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beneficiaries_unexcpeted_visits` (
  `PID` varchar(8) NOT NULL,
  `Date_Of_Visit` date NOT NULL,
  `Originating_Procedure` int(11) DEFAULT NULL,
  `Visit_Type` int(11) NOT NULL DEFAULT '8',
  `Operator` varchar(45) DEFAULT NULL,
  `Time_Of_Visit` time DEFAULT NULL,
  PRIMARY KEY (`PID`,`Date_Of_Visit`),
  KEY `Beneficiaries_Unexpected_Visit` (`PID`),
  CONSTRAINT `Beneficiaries_Unexpected_Visit` FOREIGN KEY (`PID`) REFERENCES `beneficiaries` (`PID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiaries_unexcpeted_visits`
--

LOCK TABLES `beneficiaries_unexcpeted_visits` WRITE;
/*!40000 ALTER TABLE `beneficiaries_unexcpeted_visits` DISABLE KEYS */;
INSERT INTO `beneficiaries_unexcpeted_visits` VALUES ('H0000001','2016-08-24',3,9,'Quality Triage operator','10:45:39');
/*!40000 ALTER TABLE `beneficiaries_unexcpeted_visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment_data`
--

DROP TABLE IF EXISTS `enrollment_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enrollment_data` (
  `PID` varchar(8) NOT NULL,
  `Enrollement_Site` varchar(48) NOT NULL,
  `Date_Of_Enrollment` date NOT NULL,
  `TID` varchar(48) NOT NULL,
  `Operator_ID` varchar(48) NOT NULL,
  `Paper_File_Number` varchar(48) NOT NULL,
  `Morpho_Number` int(22) NOT NULL,
  `Time_Of_Visit` time DEFAULT NULL,
  PRIMARY KEY (`PID`),
  KEY `Enrollment_Data_FK` (`PID`),
  CONSTRAINT `Enrollment_Data_FK` FOREIGN KEY (`PID`) REFERENCES `beneficiaries` (`PID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment_data`
--

LOCK TABLES `enrollment_data` WRITE;
/*!40000 ALTER TABLE `enrollment_data` DISABLE KEYS */;
INSERT INTO `enrollment_data` VALUES ('H0000001','Site A','2016-09-06','170215','Gueret1','1',0,'10:08:40'),('H0008383','C','2016-08-24','170242','Enroll1','13568',0,'10:02:21'),('H0008387','Cn','2016-08-15','170235','Admin1','Khgfdddddd',0,'11:34:25'),('h3536765','C','2016-08-22','170215','Benevent2','1234567890987543',0,'14:47:55'),('n6758658','C','2016-09-05','170215','Benevent2','12345678900',0,'16:47:37');
/*!40000 ALTER TABLE `enrollment_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beneficiaries`
--

DROP TABLE IF EXISTS `beneficiaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beneficiaries` (
  `PID` varchar(8) NOT NULL,
  `Full_Name` varchar(200) NOT NULL,
  `Prefecture` varchar(250) NOT NULL,
  `Sub_Prefecture` varchar(250) NOT NULL,
  `Village` varchar(200) DEFAULT NULL,
  `Phone_Number_1` varchar(9) NOT NULL,
  `Phone_Number_2` varchar(9) DEFAULT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `Full_Name_Additional_Contact_1` varchar(200) NOT NULL,
  `Information_Additional_Contact_1` varchar(250) NOT NULL,
  `Phone_Number_Additional_Contact_1` varchar(9) DEFAULT NULL,
  `Full_Name_Additional_Contact_2` varchar(200) NOT NULL,
  `Information_Additional_Contact_2` varchar(250) NOT NULL,
  `Phone_Number_Additional_Contact_2` varchar(9) DEFAULT NULL,
  `Day_Of_Birth` int(2) DEFAULT NULL,
  `Month_Of_Birth` int(2) DEFAULT NULL,
  `Year_Of_Birth` int(4) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Age` int(3) NOT NULL,
  `Manual_No_Hit` varchar(10) DEFAULT NULL,
  `Fales_Attempts` int(10) DEFAULT '0',
  `Operator` varchar(200) NOT NULL,
  `Duplicated` int(11) DEFAULT '0',
  `Date_Of_Update` date DEFAULT NULL,
  `Time_Of_Update` time DEFAULT NULL,
  `Exclude` int(11) DEFAULT '0',
  `Date_Of_Exclude` date DEFAULT NULL,
  `Time_Of_Excluse` time DEFAULT NULL,
  PRIMARY KEY (`PID`),
  KEY `PREFECTURE_BENEFICIARIES_FK_idx` (`Prefecture`),
  KEY `SUB_PREFECTURE_BENEFICIARIES_FK_idx` (`Sub_Prefecture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiaries`
--

LOCK TABLES `beneficiaries` WRITE;
/*!40000 ALTER TABLE `beneficiaries` DISABLE KEYS */;
INSERT INTO `beneficiaries` VALUES ('H0000001','Hisham','Conakry','Kaloum','','625258458','','','No One','Nothing','','No One','Nothing','',0,0,1981,'Masculin',35,'Oui',0,'Gueret1',0,NULL,NULL,0,'2016-11-05','11:53:18'),('H0008383','Hisham','Coyah','Kouriah','Vaulx','789654223','789654236','hisham@id.com','Diego','Amigo','789654136','Leo','Amigo','789654233',0,12,1930,'Masculin',86,'Oui',0,'Enroll1',0,'2016-08-24','10:38:31',0,'2016-08-24','10:52:34'),('H0008387','Hisham Morpho','Kissidougou','Yombiro','','085632366','','','Lola','Amie','','Jacques','Ami','',0,6,1986,'Masculin',30,'Oui',0,'Admin1',0,NULL,NULL,NULL,NULL,NULL),('h3536765','Diego Maradona','Kissidougou','Firawa','Villa','625258458','','','Gui','Gui','','Co','Co','',0,12,1930,'Masculin',86,'Non',0,'Benevent2',0,NULL,NULL,NULL,NULL,NULL),('n6758658','Leo Messi','Koundara','Koundara-commune urbaine','Buenos Aires','792345000','','','Diego','Copain','123456789','Navarro','Copain','',0,11,1980,'Masculin',36,'Non',0,'Benevent2',0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `beneficiaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `control_originating_procedures`
--

DROP TABLE IF EXISTS `control_originating_procedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `control_originating_procedures` (
  `ID` int(11) NOT NULL,
  `EN_Description` varchar(45) NOT NULL,
  `FR_Description` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `control_originating_procedures`
--

LOCK TABLES `control_originating_procedures` WRITE;
/*!40000 ALTER TABLE `control_originating_procedures` DISABLE KEYS */;
INSERT INTO `control_originating_procedures` VALUES (1,'Fingerprint','Empreinte digitale'),(2,'Barcode Scan','Scan de code-barres'),(3,'Query','Base de données requête');
/*!40000 ALTER TABLE `control_originating_procedures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visits_type`
--

DROP TABLE IF EXISTS `visits_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visits_type` (
  `ID` int(11) NOT NULL,
  `EN_Description` varchar(200) NOT NULL,
  `FR_Description` varchar(200) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visits_type`
--

LOCK TABLES `visits_type` WRITE;
/*!40000 ALTER TABLE `visits_type` DISABLE KEYS */;
INSERT INTO `visits_type` VALUES (1,'Day 7 Visit Windows','Day 7 Visit Windows'),(2,'Day 14 Visit Windows','Day 14 Visit Windows'),(3,'Day 28 Visit Windows','Day 28 Visit Windows'),(4,'Day 56 Visit Windows','Day 56 Visit Windows'),(5,'Day 63 Visit windows','Day 63 Visit windows'),(6,'Month 3 Visit Windows','Month 3 Visit Windows'),(7,'Month 6 Visit Windows','Month 6 Visit Windows'),(8,'Month 12 Visit Windows','Month 12 Visit Windows'),(9,'Unexpected Visit','Unexpected Visit');
/*!40000 ALTER TABLE `visits_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prefecture`
--

DROP TABLE IF EXISTS `prefecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prefecture` (
  `Name` varchar(250) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prefecture`
--

LOCK TABLES `prefecture` WRITE;
/*!40000 ALTER TABLE `prefecture` DISABLE KEYS */;
INSERT INTO `prefecture` VALUES ('Beyla'),('Boffa'),('Boké'),('Conakry'),('Coyah'),('Dabola'),('Dalaba'),('Dinguiraye'),('Dubréka'),('Faranah'),('Forécariah'),('Fria'),('Gaoual'),('Guéckédou'),('Kankan'),('Kérouané'),('Kindia'),('Kissidougou'),('Koubia'),('Koundara'),('Kouroussa'),('Labé'),('Lélouma'),('Lola'),('Macenta'),('Mali'),('Mamou'),('Mandiana'),('N\'Zérékoré'),('Pita'),('Siguiri'),('Télimélé'),('Tougué'),('Yomou');
/*!40000 ALTER TABLE `prefecture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_prefecture`
--

DROP TABLE IF EXISTS `sub_prefecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_prefecture` (
  `Prefecture` varchar(250) NOT NULL,
  `Sub_Prefecture` varchar(250) NOT NULL,
  PRIMARY KEY (`Prefecture`,`Sub_Prefecture`),
  CONSTRAINT `PREFECTURE_SUB_PREFECTURE_FK` FOREIGN KEY (`Prefecture`) REFERENCES `prefecture` (`Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_prefecture`
--

LOCK TABLES `sub_prefecture` WRITE;
/*!40000 ALTER TABLE `sub_prefecture` DISABLE KEYS */;
INSERT INTO `sub_prefecture` VALUES ('Beyla','Beyla-commune urbaine'),('Beyla','Boola'),('Beyla','Diara-Guerala'),('Beyla','Diassodou'),('Beyla','Fouala'),('Beyla','Gbakedou'),('Beyla','Gbessoba'),('Beyla','Karala'),('Beyla','Koumandou'),('Beyla','Moussadou'),('Beyla','Nionsomoridou'),('Beyla','Samana'),('Beyla','Sinko'),('Beyla','Sokourala'),('Boffa','Boffa-commune urbaine'),('Boffa','Colia'),('Boffa','Douprou'),('Boffa','Koba-Tatema'),('Boffa','Lisso'),('Boffa','Mankountan'),('Boffa','Tamita'),('Boffa','Tougnifili'),('Boké','	Bintimodiya'),('Boké','	Boké-commune urbaine'),('Boké','	Dabiss'),('Boké','	Kamsar'),('Boké','	Kanfarandé'),('Boké','	Kolaboui'),('Boké','	Malapouyah'),('Boké','	Sangarédi'),('Boké','	Sansalé'),('Boké','	Tanéné'),('Conakry','	Dixinn'),('Conakry','	Kaloum'),('Conakry','	Matam'),('Conakry','	Matoto'),('Conakry','	Ratoma'),('Coyah','Coyah-commune urbaine'),('Coyah','Kouriah'),('Coyah','Manéah'),('Coyah','Wonkifong'),('Dabola','Arfamoussaya'),('Dabola','Banko'),('Dabola','Bissikrima'),('Dabola','Dabola-commune urbaine'),('Dabola','Dogomet'),('Dabola','Kankama'),('Dabola','Kindoyé'),('Dabola','Konindou'),('Dabola','N\'Déma'),('Dalaba','Bodié'),('Dalaba','Dalaba-commune urbaine'),('Dalaba','Ditinn'),('Dalaba','Kaala'),('Dalaba','Kankalabé'),('Dalaba','Kébali'),('Dalaba','Koba'),('Dalaba','Mafara'),('Dalaba','Mitty'),('Dalaba','Mombéyah'),('Dinguiraye','Banora'),('Dinguiraye','Dialakoro'),('Dinguiraye','Diatifèrè'),('Dinguiraye','Dinguiraye-commune urbaine'),('Dinguiraye','Gagnakali'),('Dinguiraye','Kalinko'),('Dinguiraye','Lansanya'),('Dinguiraye','Sélouma'),('Dubréka','Badi'),('Dubréka','Dubréka-commune urbaine'),('Dubréka','Faléssadé'),('Dubréka','Khorira'),('Dubréka','Ouassou'),('Dubréka','Tanéné'),('Dubréka','Tondon'),('Faranah','Banian'),('Faranah','Beindou'),('Faranah','Faranah-commune urbaine'),('Faranah','Gnaléah'),('Faranah','Hérémakonon'),('Faranah','Kobikoro'),('Faranah','Marela'),('Faranah','Passayah'),('Faranah','Sandéniah'),('Faranah','Songoyah'),('Faranah','Tiro'),('Forécariah','Alassoya'),('Forécariah','Benty'),('Forécariah','Farmoriah'),('Forécariah','Forécariah-commune urbaine'),('Forécariah','Kaback'),('Forécariah','Kakossa'),('Forécariah','Kallia'),('Forécariah','Maférinya'),('Forécariah','Moussayah'),('Forécariah','Sikhourou'),('Fria','	Baguinet'),('Fria','	Banguigny'),('Fria','	Fria-commune urbaine'),('Fria','	Tormélin'),('Gaoual','Foulamory'),('Gaoual','Gaoual-commune urbaine'),('Gaoual','Kakony'),('Gaoual','Koumbia'),('Gaoual','Kounsitel'),('Gaoual','Malanta'),('Gaoual','Touba'),('Gaoual','Wendou M\'Bour'),('Guéckédou','Bolodou'),('Guéckédou','Fangamadou'),('Guéckédou','Guéckédou-commune urbaine'),('Guéckédou','Guendembou'),('Guéckédou','Kassadou'),('Guéckédou','Koundou'),('Guéckédou','Nongoa'),('Guéckédou','Ouéndé-Kénéma'),('Guéckédou','Tekoulo'),('Guéckédou','Termessadou-Dibou'),('Kankan','Balandougou'),('Kankan','Bate-Nafadji'),('Kankan','Boula'),('Kankan','Gbérédou-Baranama'),('Kankan','Kanfamoriyah'),('Kankan','Kankan-commune urbaine'),('Kankan','Koumban'),('Kankan','Mamouroudou'),('Kankan','Missamana'),('Kankan','Moribayah'),('Kankan','Sabadou-Baranama'),('Kankan','Tinti-Oulen'),('Kankan','Toukounou'),('Kérouané','Banankoro'),('Kérouané','Damaro'),('Kérouané','Kérouané-commune urbaine'),('Kérouané','Komodou'),('Kérouané','Kounsankoro'),('Kérouané','Linko'),('Kérouané','Sibiribaro'),('Kérouané','Soromaya'),('Kindia','Bangouyah'),('Kindia','Damankanyah'),('Kindia','Friguiagbé'),('Kindia','Kindia-commune urbaine'),('Kindia','Kolenté'),('Kindia','Madina-Oula'),('Kindia','Mambia'),('Kindia','Molota'),('Kindia','Samaya'),('Kindia','Souguéta'),('Kissidougou','Albadaria'),('Kissidougou','Banama'),('Kissidougou','Bardou'),('Kissidougou','Beindou'),('Kissidougou','Fermessadou-Pombo'),('Kissidougou','Firawa'),('Kissidougou','Gbangbadou'),('Kissidougou','Kissidougou-commune urbaine'),('Kissidougou','Kondiadou'),('Kissidougou','Manfran'),('Kissidougou','Sangradou'),('Kissidougou','Yendé-Millimou'),('Kissidougou','Yombiro'),('Koubia','Fafaya'),('Koubia','Gadha-Woundou'),('Koubia','Koubia- commune urbaine'),('Koubia','Matakou'),('Koubia','Missira'),('Koubia','Pilimini'),('Koundara','Guingan'),('Koundara','Kamaby'),('Koundara','Koundara-commune urbaine'),('Koundara','Samballo'),('Koundara','Saréboido'),('Koundara','Termesse '),('Koundara','Youkounkoun'),('Kouroussa','Babila'),('Kouroussa','Balato'),('Kouroussa','Banfèlè'),('Kouroussa','Baro'),('Kouroussa','Cisséla'),('Kouroussa','Douaka'),('Kouroussa','Doura'),('Kouroussa','Kinièro'),('Kouroussa','Komola-Koura'),('Kouroussa','Koumana'),('Kouroussa','Kouroussa- commune urbaine'),('Kouroussa','Sanguiana'),('Labé','Dalein'),('Labé','Daralabe'),('Labé','Diari'),('Labé','Dionfo'),('Labé','Garambé'),('Labé','Hafia'),('Labé','Kaalan'),('Labé','Kouramangui'),('Labé','Labé-commune urbaine'),('Labé','Noussy'),('Labé','Popodara'),('Labé','Sannou'),('Labé','Tountouroun'),('Lélouma','Balaya'),('Lélouma','Djountou'),('Lélouma','Hérico'),('Lélouma','Korbé'),('Lélouma','Lafou'),('Lélouma','Lélouma-commune urbaine'),('Lélouma','Linsan'),('Lélouma','Manda'),('Lélouma','Parawol'),('Lélouma','Sagalé'),('Lélouma','Tyanguel-Bori'),('Lola','Bossou'),('Lola','Foumbadou'),('Lola','Gama'),('Lola','Guéassou'),('Lola','Kokota'),('Lola','Lain'),('Lola','Lola-commune urbaine'),('Lola','N\'Zoo'),('Lola','Tounkarata'),('Macenta','Balizia'),('Macenta','Binikala'),('Macenta','Bofossou'),('Macenta','Daro'),('Macenta','Fassankoni'),('Macenta','Kouankan'),('Macenta','Koyamah'),('Macenta','Macenta-commune urbaine'),('Macenta','N\'Zébéla'),('Macenta','Ourémai'),('Macenta','Panziazou'),('Macenta','Sengbédou'),('Macenta','Sérédou'),('Macenta','Vassérédou'),('Macenta','Watanka'),('Mali','Balaki'),('Mali','Donghol-Sigon'),('Mali','Dougountouny'),('Mali','Fougou'),('Mali','Gayah'),('Mali','Hidayatou'),('Mali','Lèbékére'),('Mali','Madina-Wora'),('Mali','Mali-commune urbaine'),('Mali','Salambandé'),('Mali','Téliré'),('Mali','Touba'),('Mali','Yimbéring'),('Mamou','Bouliwel'),('Mamou','Dounet'),('Mamou','Gongoret'),('Mamou','Kégnéko'),('Mamou','Konkouré'),('Mamou','Mamon-commune urbaine'),('Mamou','Nyagara'),('Mamou','Ouré-Kaba'),('Mamou','Porédaka'),('Mamou','Saramoussaya'),('Mamou','Soyah'),('Mamou','Téguéréya'),('Mamou','Timbo'),('Mamou','Tolo'),('Mandiana','Balandougouba'),('Mandiana','Dialakoro'),('Mandiana','Faralako'),('Mandiana','Kantoumania'),('Mandiana','Kiniéran'),('Mandiana','Koundian'),('Mandiana','Koundianakoro'),('Mandiana','Mandiana-commune urbaine'),('Mandiana','Morodou'),('Mandiana','Niantania'),('Mandiana','Saladou'),('Mandiana','Sansando'),('N\'Zérékoré','Bounouma'),('N\'Zérékoré','Gouécké'),('N\'Zérékoré','Kobéla'),('N\'Zérékoré','Koropara'),('N\'Zérékoré','Koulé'),('N\'Zérékoré','N\'Zérékoré-commune urbaine'),('N\'Zérékoré','Palé'),('N\'Zérékoré','Samoé'),('N\'Zérékoré','Soulouta'),('N\'Zérékoré','Womey'),('N\'Zérékoré','Yalenzou'),('Pita','Bantignel'),('Pita','Bourouwal-Tappé'),('Pita','Dongol-Touma'),('Pita','Gongoret'),('Pita','Ley-Miro'),('Pita','Maci'),('Pita','Ninguélandé'),('Pita','Pita-commune urbaine'),('Pita','Sangaréah'),('Pita','Sintali'),('Pita','Timbi-Madina'),('Pita','Timbi-Touny'),('Siguiri','Bankon'),('Siguiri','Doko'),('Siguiri','Franwalia'),('Siguiri','Kiniébakoura'),('Siguiri','Kintinian'),('Siguiri','Maléa'),('Siguiri','Naboun'),('Siguiri','Niagassola'),('Siguiri','Niandankoro'),('Siguiri','Norassoba'),('Siguiri','Siguiri-commune urbaine'),('Siguiri','Siguirini'),('Télimélé','Bourouwal '),('Télimélé','Daramagnaky'),('Télimélé','Gougoudjé'),('Télimélé','Koba'),('Télimélé','Kollet'),('Télimélé','Konsotamy'),('Télimélé','Missira'),('Télimélé','Santou'),('Télimélé','Sarékaly'),('Télimélé','Sintali'),('Télimélé','Sogolon'),('Télimélé','Tarihoye'),('Télimélé','Télimélé-commune urbaine'),('Télimélé','Thionthian'),('Tougué','Fatako'),('Tougué','Fello-Koundoua'),('Tougué','Kansangui'),('Tougué','Koïn'),('Tougué','Kolangui'),('Tougué','Kollet'),('Tougué','Konah'),('Tougué','Kouratongo'),('Tougué','Tangali'),('Tougué','Tougué-commune urbaine'),('Yomou','Banié'),('Yomou','Bheeta'),('Yomou','Bignamou'),('Yomou','Bowé'),('Yomou','Diécké'),('Yomou','Péla'),('Yomou','Yomou-commune urbaine');
/*!40000 ALTER TABLE `sub_prefecture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beneficiary_exclude_log`
--

DROP TABLE IF EXISTS `beneficiary_exclude_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beneficiary_exclude_log` (
  `PID` varchar(8) NOT NULL,
  `Operator` varchar(100) NOT NULL,
  `Operator_ID` int(11) NOT NULL,
  `Operation` varchar(45) NOT NULL,
  `Date_Of_Exclude` date NOT NULL,
  `Time_Of_Exclude` time NOT NULL,
  PRIMARY KEY (`PID`,`Date_Of_Exclude`,`Time_Of_Exclude`),
  KEY `PID_excluded_log` (`PID`),
  CONSTRAINT `PID_excluded_log` FOREIGN KEY (`PID`) REFERENCES `beneficiaries` (`PID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiary_exclude_log`
--

LOCK TABLES `beneficiary_exclude_log` WRITE;
/*!40000 ALTER TABLE `beneficiary_exclude_log` DISABLE KEYS */;
INSERT INTO `beneficiary_exclude_log` VALUES ('H0000001','Administrator',170215,'Exclude','2016-08-23','11:49:41'),('H0000001','Administrator',170215,'NonExclude','2016-11-05','11:53:18'),('H0008383','Administrator',170242,'Exclude','2016-08-24','10:37:24'),('H0008383','Administrator',170242,'NonExclude','2016-08-24','10:37:46'),('H0008383','Administrator',170242,'Exclude','2016-08-24','10:38:36'),('H0008383','Administrator',170235,'NonExclude','2016-08-24','10:52:34');
/*!40000 ALTER TABLE `beneficiary_exclude_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beneficiary_update_log`
--

DROP TABLE IF EXISTS `beneficiary_update_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beneficiary_update_log` (
  `PID` varchar(8) NOT NULL,
  `Operator` varchar(100) NOT NULL,
  `Operator_ID` int(11) NOT NULL,
  `Date_Of_Update` date NOT NULL,
  `Time_Of_Update` time NOT NULL,
  PRIMARY KEY (`PID`,`Date_Of_Update`,`Time_Of_Update`),
  KEY `PID_updated_log` (`PID`),
  CONSTRAINT `PID_updated_log` FOREIGN KEY (`PID`) REFERENCES `beneficiaries` (`PID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiary_update_log`
--

LOCK TABLES `beneficiary_update_log` WRITE;
/*!40000 ALTER TABLE `beneficiary_update_log` DISABLE KEYS */;
INSERT INTO `beneficiary_update_log` VALUES ('H0008383','Admin1',170242,'2016-08-24','10:34:32'),('H0008383','Admin1',170242,'2016-08-24','10:37:07'),('H0008383','Administrator',170242,'2016-08-24','10:38:31');
/*!40000 ALTER TABLE `beneficiary_update_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-12 14:28:36
