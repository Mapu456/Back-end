-- Drop database
DROP DATABASE IF EXISTS cube_test_db;

-- Create database + user if doesn't exist
CREATE DATABASE IF NOT EXISTS cube_test_db;
FLUSH PRIVILEGES;

USE cube_test_db;


--
-- Table structure for table `startup_general`
--

DROP TABLE IF EXISTS `startup_general`;
CREATE TABLE `startup_general` (
  `id` varchar(60) NOT NULL,
  `startup_id` varchar(60) NOT NULL,
  `legal_startup_id` varchar(60) NOT NULL,  
  `active` BOOLEAN NOT NULL DEFAULT TRUE,
  `access` varchar(60) NOT NULL,
  `a_user` varchar(60) NOT NULL,
  `a_date` DATE NOT NULL,
  `a_category_user` varchar(60) NOT NULL,
  PRIMARY KEY (`startup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(60) NOT NULL,
  `user_id` varchar(60) NOT NULL,
  `startup_id` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  `a_user` varchar(60) NOT NULL,
  `a_date` DATE NOT NULL,
  `a_category_user` varchar(60) NOT NULL,
  PRIMARY KEY (`user_id`),
  FOREIGN KEY (`startup_id`) REFERENCES `startup_general` (`startup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `autentication`
--

DROP TABLE IF EXISTS `authentication`;
CREATE TABLE `authentication` (
  `id` varchar(60) NOT NULL,
  `user_id` varchar(60) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  `a_user` varchar(60) NOT NULL,
  `a_date` DATE NOT NULL,
  `a_category_user` varchar(60) NOT NULL,
  PRIMARY KEY (`user_id`),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




--
-- Table structure for table `kpi_general`
--

DROP TABLE IF EXISTS `kpi_general`;
CREATE TABLE `kpi_general` (
  `id` varchar(60) NOT NULL,
  `startup_id` varchar(60) NOT NULL,
  `kpi_id` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  `month_register` SMALLINT NOT NULL,
  `year_register` SMALLINT NOT NULL,
  `active` BOOLEAN NOT NULL DEFAULT TRUE,
  `a_user` varchar(60) NOT NULL,
  `a_date` DATE NOT NULL,
  `a_category_user` varchar(60) NOT NULL,
  PRIMARY KEY (`kpi_id`),
  FOREIGN KEY (`startup_id`) REFERENCES `startup_general` (`startup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `kpi_attributes`
--

DROP TABLE IF EXISTS `kpi_attributes`;
CREATE TABLE `kpi_attributes` (
  `id` varchar(60) NOT NULL,
  `kpi_id` varchar(60) NOT NULL,
  `attribute` varchar(60) NOT NULL,
  `unit` SMALLINT NOT NULL,
  `month` SMALLINT NOT NULL,
  `year` SMALLINT NOT NULL,
  `a_user` varchar(60) NOT NULL,
  `a_date` DATE NOT NULL,
  `a_category_user` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`kpi_id`) REFERENCES `kpi_general` (`kpi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `startup_attributes`
--

DROP TABLE IF EXISTS `startup_attributes`;
CREATE TABLE `startup_attributes` (
  `id` varchar(60) NOT NULL,
  `startup_id` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  `logo` varchar(60) NOT NULL,
  `country` varchar(128) NOT NULL,
  `address` varchar(128) NOT NULL,
  `a_user` varchar(60) NOT NULL,
  `a_date` DATE NOT NULL,
  `a_category_user` varchar(60) NOT NULL,
  PRIMARY KEY (`startup_id`),
  FOREIGN KEY (`startup_id`) REFERENCES `startup_general` (`startup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` varchar(60) NOT NULL,
  `admin_id` varchar(60) NOT NULL,
  `name` varchar(128) NOT NULL,
  `a_user` varchar(60) NOT NULL,
  `a_date` DATE NOT NULL,
  `a_category_user` varchar(60) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `auten_admin`
--

DROP TABLE IF EXISTS `authen_admin`;
CREATE TABLE `authen_admin` (
  `id` varchar(60) NOT NULL,
  `admin_id` varchar(60) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(60) NOT NULL,
  `a_user` varchar(60) NOT NULL,
  `a_date` DATE NOT NULL,
  `a_category_user` varchar(60) NOT NULL,
  PRIMARY KEY (`admin_id`),
  FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

