
-- Drop database
DROP DATABASE IF EXISTS cubeTestDb;

-- Create database + user if doesn't exist
CREATE DATABASE IF NOT EXISTS cubeTestDb;
FLUSH PRIVILEGES;

USE cubeTestDb;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `adminId` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  `photoUrl` varchar(128) NOT NULL,
  `country` varchar(60) NOT NULL,
  `city` varchar(60) NOT NULL,
  `emailAddress` varchar(60) NOT NULL,
  `phone` varchar(60) NOT NULL,
  PRIMARY KEY (`adminId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `industries`
--

DROP TABLE IF EXISTS `industry`;
CREATE TABLE `industry` (
  `industryId` varchar(60) NOT NULL,
  `industryName` varchar(60) NOT NULL,
  PRIMARY KEY (`industryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Dumping data for table `industry`
--
LOCK TABLES `industry` WRITE;
/*!40000 ALTER TABLE `industry` DISABLE KEYS */;
INSERT INTO `industry` VALUES ('01','Proptech'),('02','LegalTech'),('03','HealthTech'),('04','TravelTech'),('05','FinTech'),('06','MarketPlace'),('07','E-Commerce'),('08','EvenTech'),('09','SAAS');
/*!40000 ALTER TABLE `industry` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `startupGeneral`
--

DROP TABLE IF EXISTS `startupGeneral`;
CREATE TABLE `startupGeneral` (
  `startupId` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  `photoUrl` varchar(128) NOT NULL,
  `country` varchar(60) NOT NULL,
  `city` varchar(60) NOT NULL,
  `emailAddress` varchar(60) NOT NULL,
  `phone` varchar(60) NOT NULL,
  `founders` SMALLINT NOT NULL,
  `femaleFounders` SMALLINT NOT NULL,
  `industry` varchar(60) NOT NULL,
  `active` BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`startupId`),
  FOREIGN KEY (`industry`) REFERENCES `industry` (`industryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `permissionId` varchar(60) NOT NULL,
  `permissionRight` varchar(128) NOT NULL,
  PRIMARY KEY (`permissionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(60) NOT NULL,
  `firstname` varchar(128) NOT NULL,
  `Lastname` varchar(128) NOT NULL,
  `cityOfResidence` varchar(128) NOT NULL,
  `countryOfResidence` varchar(128) NOT NULL,
  `photoUrl` varchar(128) NOT NULL,
  `phone` varchar(128) NOT NULL,
  `emailAddress` varchar(128) NOT NULL,
  `right` varchar(60) NOT NULL,
  `userBasicId` varchar(60) NOT NULL,
  `accessUser` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  FOREIGN KEY (`userBasicId`) REFERENCES `admin` (`adminId`),
  FOREIGN KEY (`userBasicId`) REFERENCES `startupGeneral` (`startupId`),
  FOREIGN KEY (`right`) REFERENCES `permission` (`permissionId`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `kpiRegister`
--

DROP TABLE IF EXISTS `kpiRegister`;
CREATE TABLE `kpiRegister` (
  `date` date NOT NULL,
  `startupId` varchar(60) NOT NULL,
  `revenue` FLOAT NOT NULL,
  `ARR` FLOAT NOT NULL,
  `EBITDA` FLOAT NOT NULL,
  `GMV` FLOAT NOT NULL,
  `numberEmployees` SMALLINT NOT NULL,
  `fundRaising` FLOAT NOT NULL,
  `CAC` FLOAT NOT NULL,
  `activeClients` mediumint NOT NULL,
  FOREIGN KEY (`startupId`) REFERENCES `startupGeneral` (`startupId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
