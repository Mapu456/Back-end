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
  `admin_id` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  `photoUrl` varchar(128) NOT NULL,
  `country` varchar(60) NOT NULL,
  `city` varchar(60) NOT NULL,
  `emailAddress` varchar(60) NOT NULL,
  `phone` varchar(60) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `industries`
--

DROP TABLE IF EXISTS `industries`;
CREATE TABLE `industries` (
  `industry_id` varchar(60) NOT NULL,
  `industry_name` varchar(60) NOT NULL,
  PRIMARY KEY (`industry_id`)
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
  `female_founders` SMALLINT NOT NULL,
  `industry` varchar(60) NOT NULL,
  `active` BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`pymeId`),
  FOREIGN KEY (`industry`) REFERENCES `industries` (`industry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `kpi_general`
--

DROP TABLE IF EXISTS `kpi_general`;
CREATE TABLE `kpi_general` (
  `id` varchar(60) NOT NULL,
  `pymeId` varchar(60) NOT NULL,
  `revenue` FLOAT NOT NULL,
  `ARR` FLOAT NOT NULL,
  `EBITDA` FLOAT NOT NULL,
  `GMV` FLOAT NOT NULL,
  `number_employees` SMALLINT NOT NULL,
  `fundraising` FLOAT NOT NULL,
  `CAC` FLOAT NOT NULL,
  `active_clients` mediumint NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`pymeId`) REFERENCES `startup_general` (`pymeId`)
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
  `id` varchar(60) NOT NULL,
  `user_id` varchar(60) NOT NULL,
  `rights` varchar(128) NOT NULL,
  `pymeId` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  FOREIGN KEY (`pymeId`) REFERENCES `startup_general` (`pymeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `user_cube`
--

DROP TABLE IF EXISTS `user_cube`;
CREATE TABLE `user_cube` (
  `id` varchar(60) NOT NULL,
  `user_id` varchar(60) NOT NULL,
  `rights` varchar(128) NOT NULL,
  `admin_id` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `authentication`
--

DROP TABLE IF EXISTS `authentication`;
CREATE TABLE `authentication` (
  `id` varchar(60) NOT NULL,
  `user_id` varchar(60) NOT NULL,
  `access_user` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `authen_admin`
--

DROP TABLE IF EXISTS `authen_admin`;
CREATE TABLE `authen_admin` (
  `id` varchar(60) NOT NULL,
  `admin_id` varchar(60) NOT NULL,
  `access_user` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `kpi_updating`
--

DROP TABLE IF EXISTS `kpi_updating`;
CREATE TABLE `kpi_updating` (
  `id` varchar(60) NOT NULL,
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
  PRIMARY KEY (`id`),
  FOREIGN KEY (`pymeId`) REFERENCES `startup_general` (`pymeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
