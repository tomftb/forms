-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Wrz 28, 2023 at 01:17 PM
-- Wersja serwera: 8.0.32
-- Wersja PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `autos_forms`
--

--
-- Dumping data for table `glossary`
--

INSERT INTO `glossary` (`id`, `name`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `buffer_user_id`, `hide_status`, `hide_reason`, `hide_date`, `delete_status`, `delete_reason`, `delete_date`) VALUES
(1, 'Kraj', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 11:18:34', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 11:19:43', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(2, 'Waluta rozliczenia', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:31:13', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:32:23', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(3, 'Kraj fakturowania towaru', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:58:36', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:59:27', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(4, 'Waluta', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:58:36', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:59:58', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
