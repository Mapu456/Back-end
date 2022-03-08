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
  `startup_id` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  `logo` varchar(128) NOT NULL,
  `country` varchar(60) NOT NULL,
  `city` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `phone` varchar(60) NOT NULL,
  `founders` SMALLINT NOT NULL,
  `female_founders` SMALLINT NOT NULL,
  `industry` varchar(60) NOT NULL,
  `active` BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`startup_id`),
  FOREIGN KEY (`industry`) REFERENCES `industries` (`industry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `kpi_general`
--

DROP TABLE IF EXISTS `kpi_general`;
CREATE TABLE `kpi_general` (
  `kpi_id` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  `active` BOOLEAN NOT NULL DEFAULT TRUE,
  `attribute` varchar(60) NOT NULL,
  `unit` SMALLINT NOT NULL,
  PRIMARY KEY (`kpi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `startup_kpi`
--

DROP TABLE IF EXISTS `startup_kpi`;
CREATE TABLE `startup_kpi` (
  `startup_id` varchar(60) NOT NULL,
  `kpi_id` varchar(60) NOT NULL,
  FOREIGN KEY (`startup_id`) REFERENCES `startup_general` (`startup_id`),
  FOREIGN KEY (`kpi_id`) REFERENCES `kpi_general` (`kpi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `user_startup`
--

DROP TABLE IF EXISTS `user_startup`;
CREATE TABLE `user_startup` (
  `user_id` varchar(60) NOT NULL,
  `startup_id` varchar(60) NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  FOREIGN KEY (`startup_id`) REFERENCES `startup_general` (`startup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `user_cube`
--

DROP TABLE IF EXISTS `user_cube`;
CREATE TABLE `user_cube` (
  `admin_id` varchar(60) NOT NULL,
  `cube_id` varchar(60) NOT NULL,
  FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  FOREIGN KEY (`cube_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



--
-- Table structure for table `authentication`
--

DROP TABLE IF EXISTS `authentication`;
CREATE TABLE `authentication` (
  `user_id` varchar(60) NOT NULL,
  `access_user` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `user_startup` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `authen_admin`
--

DROP TABLE IF EXISTS `authen_admin`;
CREATE TABLE `authen_admin` (
  `admin_id` varchar(60) NOT NULL,
  `access_user` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  FOREIGN KEY (`admin_id`) REFERENCES `user_cube` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

