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
-- Dumping data for table `admin`
--
LOCK TABLES `admin` WRITE;
INSERT INTO `admin` VALUES ('a1','Santiago','www.google.com', 'Colombia', 'Bogota','sr@cube.ventures', '573221234567');
UNLOCK TABLES;



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
INSERT INTO `industry` VALUES ('01','Proptech'),('02','LegalTech'),('03','HealthTech'),('04','TravelTech'),('05','FinTech'),('06','MarketPlace'),('07','E-Commerce'),('08','EvenTech'),('09','SAAS');
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
-- Dumping data for table `startupGeneral`
--
LOCK TABLES `startupGeneral` WRITE;
INSERT INTO `startupGeneral` VALUES
('start1','asisvisa','www.google.com', 'USA', 'New York', '123@cube.com', '12105661896', '3', '1', '01', '1'),
('start2','torre', 'www.google.com', 'USA', 'Silicon Valley', '456@cube.com', '12105661896', '2', '1','02', '1'),
 ('start3','voyyo', 'www.google.com', 'Colombia', 'Bogota', '456@cube.com', '12105661896', '3', '1','03', '1'),
 ('start4','check', 'www.google.com', 'Colombia', 'Bogota', '012@cube.com', '573111234890', '4', '3','04', '1'),
 ('start5','igo', 'www.google.com', 'Mexico', 'Mexico DF', '345@cube.com', '573111234890', '3', '1','05', '1');
UNLOCK TABLES;

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
-- Dumping data for table `permission`
--
LOCK TABLES `permission` WRITE;
INSERT INTO `permission` VALUES ('0A1','pr1'),('0B2','pr2'),('0C3','pr3'),('0D4','pr4'),('0E5','pr5'),('0F6','pr6');
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(60) NOT NULL,
  `firstname` varchar(128) NOT NULL,
  `lastname` varchar(128) NOT NULL,
  `cityOfResidence` varchar(128) NOT NULL,
  `countryOfResidence` varchar(128) NOT NULL,
  `photoUrl` varchar(128) NOT NULL,
  `phone` varchar(128) NOT NULL,
  `emailAddress` varchar(128) NOT NULL,
  `right` varchar(60) NOT NULL,
  `userBasicId` varchar(60) NOT NULL,
  `accessUser` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  -- FOREIGN KEY (`userBasicId`) REFERENCES `admin` (`adminId`), --
  FOREIGN KEY (`userBasicId`) REFERENCES `startupGeneral` (`startupId`),
  FOREIGN KEY (`right`) REFERENCES `permission` (`permissionId`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--
LOCK TABLES `user` WRITE;
INSERT INTO `user` VALUES
-- ('SR1','Santiago','Rojas', 'Bogota', 'Colombia','www.google.com', '573111236930', 'sr@cube.ventures', '0A1', 'a1', 'e2e2131', 'dasdasd') --
('KB1','Ken','Buving', 'New York', 'USA', 'www.google.com', '12103134567890', '123@gmail.com', '0B2', 'start1', 'KB1assda', '78923123'),
('ED2','Elon','Musk', 'Silicon Valley','USA', 'www.google.com', '12103134567899', '456@gmail.com', '0C3', 'start2', 'ED2asaf', '432fwwe4'),
('TM3','Tom','Keen', 'Bogota', 'Colombia','www.google.com', '573111234500', '789@gmail.com', '0D4', 'start3', 'TM3asfaf', 'fwew323'),
('AB4','Ana','Buving', 'Bogota', 'Colombia', 'www.google.com', '573111233300', '012@gmail.com', '0E5', 'start4', 'AB4afdfs', '3423kdqdq'),
('JD5','Jack','Dole', 'Mexico DF', 'Mexico', 'www.google.com', '573111234500', '456@gmail.com', '0F6', 'start5', 'JD5fafd', '89712kdsa')
;
UNLOCK TABLES;

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

CREATE USER IF NOT EXISTS '0A1'@'localhost' IDENTIFIED BY 'dasdasd';
CREATE USER IF NOT EXISTS '0B2'@'localhost' IDENTIFIED BY '78923123';
CREATE USER IF NOT EXISTS '0C3'@'localhost' IDENTIFIED BY '432fwwe4';
CREATE USER IF NOT EXISTS '0D4'@'localhost' IDENTIFIED BY 'fwew323';
CREATE USER IF NOT EXISTS '0E5'@'localhost' IDENTIFIED BY '3423kdqdq';
CREATE USER IF NOT EXISTS '0F6'@'localhost' IDENTIFIED BY '89712kdsa';
GRANT ALL PRIVILEGES ON `cubeTestDb`.* TO '0A1'@'localhost' WITH GRANT OPTION;
GRANT SELECT ON `performance_schema`.* TO '0A1'@'localhost';
GRANT SELECT, INSERT, UPDATE ON cubeTestDb.kpiRegister TO '0B2'@'localhost';
GRANT SELECT, INSERT, UPDATE ON cubeTestDb.kpiRegister TO '0C3'@'localhost';
GRANT SELECT, INSERT, UPDATE ON cubeTestDb.kpiRegister TO '0D4'@'localhost';
GRANT SELECT, INSERT, UPDATE ON cubeTestDb.kpiRegister TO '0E5'@'localhost';
GRANT SELECT, INSERT, UPDATE ON cubeTestDb.kpiRegister TO '0F6'@'localhost';
FLUSH PRIVILEGES;





