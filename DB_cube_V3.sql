-- Drop database
DROP DATABASE IF EXISTS cube_test_db;

-- Create database + user if doesn't exist
CREATE DATABASE IF NOT EXISTS cube_test_db;
FLUSH PRIVILEGES;

USE cube_test_db;

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
-- Table structure for table `startup_general`
--

DROP TABLE IF EXISTS `startup_general`;
CREATE TABLE `startup_general` (
  `pymeId` varchar(60) NOT NULL,
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
  PRIMARY KEY (`pymeId`),
  FOREIGN KEY (`industry`) REFERENCES `industry` (`industryId`)
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `user_startup`
--

DROP TABLE IF EXISTS `user_startup`;
CREATE TABLE `user_startup` (
  `userId` varchar(60) NOT NULL,
  `rights` varchar(128) NOT NULL,
  `pymeId` varchar(60) NOT NULL,
  FOREIGN KEY (`userId`) REFERENCES `user` (`id`),
  FOREIGN KEY (`pymeId`) REFERENCES `startup_general` (`pymeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `user_cube`
--

DROP TABLE IF EXISTS `user_cube`;
CREATE TABLE `user_cube` (
  `userId` varchar(60) NOT NULL,
  `rights` varchar(128) NOT NULL,
  `adminId` varchar(60) NOT NULL,
  FOREIGN KEY (`adminId`) REFERENCES `admin` (`adminId`),
  FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `authentication`
--

DROP TABLE IF EXISTS `authentication`;
CREATE TABLE `authentication` (
  `userId` varchar(60) NOT NULL,
  `accessUser` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  FOREIGN KEY (`userId`) REFERENCES `user_startup` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `authen_admin`
--

DROP TABLE IF EXISTS `authen_admin`;
CREATE TABLE `authen_admin` (
  `adminId` varchar(60) NOT NULL,
  `accessUser` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  FOREIGN KEY (`adminId`) REFERENCES `user_cube` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `kpi_updating`
--

DROP TABLE IF EXISTS `kpi_updating`;
CREATE TABLE `kpi_updating` (
  `date` date NOT NULL,
  `pymeId` varchar(60) NOT NULL,
  `revenue` FLOAT NOT NULL,
  `ARR` FLOAT NOT NULL,
  `EBITDA` FLOAT NOT NULL,
  `GMV` FLOAT NOT NULL,
  `number_employees` SMALLINT NOT NULL,
  `fundraising` FLOAT NOT NULL,
  `CAC` FLOAT NOT NULL,
  `active_clients` mediumint NOT NULL,
  FOREIGN KEY (`pymeId`) REFERENCES `startup_general` (`pymeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
