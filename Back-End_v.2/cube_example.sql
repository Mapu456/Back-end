-- Drop database
DROP DATABASE IF EXISTS cubeTestDb;

-- Create database + user if doesn't exist
CREATE DATABASE IF NOT EXISTS cubeTestDb;
FLUSH PRIVILEGES;

USE cubeTestDb;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `roleId` varchar(60) NOT NULL,
  `role` varchar(60) NOT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `role`
--
LOCK TABLES `role` WRITE;
INSERT INTO `role` VALUES ('1adm','Admin'),('2ru','regular_user');
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
-- Table structure for table `startup`
--

DROP TABLE IF EXISTS `startup`;
CREATE TABLE `startup` (
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
-- Dumping data for table `startup`
--
LOCK TABLES `startup` WRITE;
INSERT INTO `startup` VALUES
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
INSERT INTO `permission` VALUES ('0A1','admin_right'),('0B2','ruser_right');
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` varchar(60) NOT NULL,
  `firstname` varchar(128) NOT NULL,
  `lastname` varchar(128) NOT NULL,
  `cityOfResidence` varchar(128) NOT NULL,
  `countryOfResidence` varchar(128) NOT NULL,
  `photoUrl` varchar(128) NOT NULL,
  `phone` varchar(128) NOT NULL,
  `emailAddress` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--
LOCK TABLES `user` WRITE;
INSERT INTO `user` VALUES
('SR1','Santiago','Rojas', 'Bogota', 'Colombia','www.google.com', '573111236930', 'sr@cube.ventures', 'dasdasd'),
('KB1','Ken','Buving', 'New York', 'USA', 'www.google.com', '12103134567890', '123@gmail.com', '78923123'),
('ED2','Elon','Musk', 'Silicon Valley','USA', 'www.google.com', '12103134567899', '456@gmail.com', '432fwwe4'),
('TM3','Tom','Keen', 'Bogota', 'Colombia','www.google.com', '573111234500', '789@gmail.com', 'fwew323'),
('AB4','Ana','Buving', 'Bogota', 'Colombia', 'www.google.com', '573111233300', '012@gmail.com', '3423kdqdq'),
('JD5','Jack','Dole', 'Mexico DF', 'Mexico', 'www.google.com', '573111234500', '456@gmail.com', '89712kdsa')
;
UNLOCK TABLES;

--
-- Table structure for table `userRole`
--

DROP TABLE IF EXISTS `userRole`;
CREATE TABLE `userRole` (
  `userId` varchar(60) NOT NULL,
  `roleId` varchar(60) NOT NULL,
  FOREIGN KEY (`userId`) REFERENCES `user` (`userId`),
  FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`),
  PRIMARY KEY (`userId`, `roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userRole`
--
LOCK TABLES `userRole` WRITE;
INSERT INTO `userRole` VALUES ('SR1','1adm'), ('KB1','2ru'), ('ED2','2ru'), ('TM3','2ru'), ('AB4','2ru'), ('JD5','2ru');
UNLOCK TABLES;

--
-- Table structure for table `rolePermission`
--

DROP TABLE IF EXISTS `rolePermission`;
CREATE TABLE `rolePermission` (
  `roleId` varchar(60) NOT NULL,
  `permissionId` varchar(60) NOT NULL,
  FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`),
  FOREIGN KEY (`permissionId`) REFERENCES `permission` (`permissionId`),
  PRIMARY KEY (`roleId`, `permissionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rolePermission`
--
LOCK TABLES `rolePermission` WRITE;
INSERT INTO `rolePermission` VALUES ('1adm','0A1'),('2ru','0B2');
UNLOCK TABLES;



--
-- Table structure for table `kpiRegister`
--

DROP TABLE IF EXISTS `kpiRegister`;
CREATE TABLE `kpiRegister` (
  `kpiId` varchar(60) NOT NULL,
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
  FOREIGN KEY (`startupId`) REFERENCES `startup` (`startupId`),
  PRIMARY KEY (`kpiId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kpiRegister`
--
LOCK TABLES `kpiRegister` WRITE;
INSERT INTO `kpiRegister` VALUES
('kpi1','2022-03-21','start1','100000', '20000', '4000', '1000', '20', '100000', '500', '30'),
('kpi2','2022-03-22','start2','200000', '20000', '5000', '2000', '10', '110000', '600', '40'),
('kpi3','2022-03-23','start3','300000', '20000', '6000', '3000', '13', '120000', '700', '50'),
('kpi4','2022-03-24','start4','400000', '20000', '7000', '4000', '40', '130000', '800', '60'),
('kpi5','2022-03-25','start5','500000', '20000', '8000', '5000', '21', '140000', '900', '70')
;
UNLOCK TABLES;

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
