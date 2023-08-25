-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Aug 24, 2023 at 10:07 AM
-- Wersja serwera: 8.0.32
-- Wersja PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `autos_forms`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `allocation`
--

CREATE TABLE `allocation` (
  `id` bigint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `allocation`
--

INSERT INTO `allocation` (`id`, `name`) VALUES
(1, 'Technik'),
(2, 'Magister'),
(3, 'Kierownik');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `app_task`
--

CREATE TABLE `app_task` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_task`
--

INSERT INTO `app_task` (`id`, `name`) VALUES
(5, 'pcDelete'),
(6, 'pcHide'),
(9, 'pClose'),
(7, 'pDelete'),
(8, 'pHide'),
(1, 'psDelete'),
(2, 'psHide'),
(4, 'pvDelete'),
(3, 'pvHide');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `department`
--

CREATE TABLE `department` (
  `ID` int NOT NULL,
  `NAME` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`ID`, `NAME`) VALUES
(1, 'Marketing');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `department_user`
--

CREATE TABLE `department_user` (
  `id_department` int NOT NULL,
  `id_user` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department_user`
--

INSERT INTO `department_user` (`id_department`, `id_user`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dictionary_measurement_units`
--

CREATE TABLE `dictionary_measurement_units` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `default_unit` enum('t','n') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'n',
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dictionary_measurement_units`
--

INSERT INTO `dictionary_measurement_units` (`id`, `name`, `default_unit`, `delete_status`) VALUES
(1, 'kB', 'n', '0'),
(2, 'MB', 'n', '0'),
(3, 'GB', 'n', '0'),
(4, 'TB', 't', '0');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `employee`
--

CREATE TABLE `employee` (
  `id` bigint NOT NULL,
  `imie` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `nazwisko` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `stanowisko` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Struktura tabeli dla tabeli `employee_allocation`
--

CREATE TABLE `employee_allocation` (
  `id_employee` bigint NOT NULL,
  `id_allocation` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `employee_project`
--

CREATE TABLE `employee_project` (
  `id_employee` bigint NOT NULL,
  `id_project` bigint NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `surname` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `percentage` int NOT NULL COMMENT 'udzial procentowy',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form`
--

CREATE TABLE `form` (
  `id` int NOT NULL,
  `name` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form`
--

INSERT INTO `form` (`id`, `name`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(1, 'Formularz dostawcy kwalifikowanego', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 09:04:45', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 09:05:43', '127.0.0.1', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_col`
--

CREATE TABLE `form_col` (
  `id` int NOT NULL,
  `id_parent` int NOT NULL,
  `type` enum('p','i','s','c','r','ta') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'p' COMMENT 'p - paragraph; i - input; s - select; c - checkbox; r - radio; tx - textarea',
  `order` int NOT NULL COMMENT 'display order',
  `at_main_page` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT 'show column at main list',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form_col`
--

INSERT INTO `form_col` (`id`, `id_parent`, `type`, `order`, `at_main_page`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(1, 2, 'i', 1, '1', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:59:31', '127.0.0.1', '0', NULL, NULL),
(2, 2, 'i', 2, '1', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:00:19', '127.0.0.1', '0', NULL, NULL),
(3, 3, 'i', 3, '1', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:00:32', '127.0.0.1', '0', NULL, NULL),
(4, 5, 'i', 4, '1', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:00:44', '127.0.0.1', '0', NULL, NULL),
(5, 6, 'i', 5, '1', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:00:55', '127.0.0.1', '0', NULL, NULL),
(6, 6, 'i', 6, '1', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:01:03', '127.0.0.1', '0', NULL, NULL),
(7, 7, 'i', 7, '1', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:02:01', '127.0.0.1', '0', NULL, NULL),
(8, 7, 'i', 8, '1', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:02:09', '127.0.0.1', '0', NULL, NULL),
(9, 8, 'i', 9, '1', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:02:24', '127.0.0.1', '0', NULL, NULL),
(10, 8, 'i', 10, '1', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:02:31', '127.0.0.1', '0', NULL, NULL),
(11, 9, 'i', 11, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:02:44', '127.0.0.1', '0', NULL, NULL),
(12, 9, 'i', 12, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:02:50', '127.0.0.1', '0', NULL, NULL),
(13, 10, 'i', 13, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:03:06', '127.0.0.1', '0', NULL, NULL),
(14, 10, 'i', 14, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:03:12', '127.0.0.1', '0', NULL, NULL),
(15, 11, 'p', 15, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:35:31', '127.0.0.1', '0', NULL, NULL),
(16, 12, 'i', 16, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:37:53', '127.0.0.1', '0', NULL, NULL),
(17, 13, 'i', 17, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:03', '127.0.0.1', '0', NULL, NULL),
(18, 14, 'i', 18, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:03', '127.0.0.1', '0', NULL, NULL),
(19, 15, 'i', 19, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:03', '127.0.0.1', '0', NULL, NULL),
(20, 16, 'i', 20, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:03', '127.0.0.1', '0', NULL, NULL),
(21, 17, 'i', 21, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(22, 18, 'i', 22, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(23, 19, 'i', 23, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(24, 20, 'i', 24, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(25, 21, 'i', 25, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(26, 22, 'i', 26, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(27, 23, 'i', 27, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(28, 24, 'i', 28, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(29, 25, 'i', 29, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(30, 26, 'i', 30, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(31, 27, 'i', 31, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(32, 28, 'i', 32, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(33, 29, 'i', 33, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(34, 30, 'i', 34, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(35, 31, 'i', 35, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(36, 32, 'i', 36, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(37, 33, 'i', 37, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(38, 34, 'i', 38, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(39, 35, 'i', 39, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(40, 36, 'i', 40, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(41, 37, 'i', 41, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(42, 38, 'i', 42, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(43, 39, 'i', 43, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(44, 40, 'i', 44, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(45, 41, 'i', 45, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(46, 42, 'i', 46, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(47, 43, 'i', 47, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(48, 44, 'i', 48, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(49, 45, 'i', 49, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(50, 46, 'i', 50, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(51, 47, 'i', 51, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(52, 48, 'i', 52, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(53, 49, 'i', 53, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(54, 50, 'i', 54, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(55, 51, 'i', 55, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(56, 52, 'i', 56, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(57, 53, 'i', 57, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(58, 54, 'i', 58, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(59, 55, 'i', 59, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(60, 56, 'i', 60, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(61, 57, 'i', 61, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(62, 58, 'i', 62, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(63, 59, 'i', 63, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(64, 60, 'i', 64, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(65, 61, 'i', 65, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(66, 62, 'i', 66, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(67, 63, 'i', 67, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(68, 64, 'i', 68, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(69, 65, 'i', 69, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(70, 66, 'i', 70, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(71, 67, 'i', 71, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(72, 68, 'i', 72, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(73, 69, 'i', 73, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(74, 70, 'i', 74, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(75, 71, 'i', 75, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(76, 72, 'i', 76, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:48', '127.0.0.1', '0', NULL, NULL),
(77, 73, 'i', 77, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:48', '127.0.0.1', '0', NULL, NULL),
(78, 74, 'i', 78, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:48', '127.0.0.1', '0', NULL, NULL),
(79, 75, 'i', 79, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:58', '127.0.0.1', '0', NULL, NULL),
(80, 76, 'i', 80, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(81, 77, 'i', 81, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(82, 78, 'i', 82, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(83, 79, 'i', 83, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(84, 80, 'i', 84, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(85, 81, 'i', 85, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(86, 82, 'i', 86, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(87, 83, 'i', 87, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(88, 84, 'i', 88, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(89, 85, 'i', 89, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(90, 86, 'i', 90, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(91, 87, 'i', 91, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(92, 88, 'i', 92, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(93, 89, 'i', 93, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(94, 90, 'i', 94, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(95, 91, 'i', 95, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(96, 92, 'i', 96, '0', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_col_property`
--

CREATE TABLE `form_col_property` (
  `id` int NOT NULL,
  `id_parent` int NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form_col_property`
--

INSERT INTO `form_col_property` (`id`, `id_parent`, `property`, `value`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(1, 1, 'label', 'Imię', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:08:32', '127.0.0.1', '0', NULL, NULL),
(2, 2, 'label', 'Nazwisko', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:09:18', '127.0.0.1', '0', NULL, NULL),
(3, 3, 'label', 'Stanowisko', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:10:31', '127.0.0.1', '0', NULL, NULL),
(4, 4, 'label', 'Pełna nazwa firmy', 2, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 15:11:32', '127.0.0.1', '0', NULL, NULL),
(5, 5, 'label', '*NIP', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-21 08:03:47', '127.0.0.1', '0', NULL, NULL),
(6, 6, 'label', '*Ulica i numer', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-21 08:06:30', '127.0.0.1', '0', NULL, NULL),
(7, 7, 'label', '*Kod pocztowy', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-21 08:06:40', '127.0.0.1', '0', NULL, NULL),
(8, 8, 'label', '*Miasto', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-21 08:07:01', '127.0.0.1', '0', NULL, NULL),
(9, 9, 'label', '*Rok założenia', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-21 08:07:08', '127.0.0.1', '0', NULL, NULL),
(10, 10, 'label', '*Liczba pracowników', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-21 08:07:18', '127.0.0.1', '0', NULL, NULL),
(11, 11, 'label', 'Kapitał zakładowy', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-21 08:11:33', '127.0.0.1', '0', NULL, NULL),
(12, 12, 'label', '*Strona WWW', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-21 08:11:33', '127.0.0.1', '0', NULL, NULL),
(13, 13, 'label', 'Podmiot powiązany', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-21 08:11:33', '127.0.0.1', '0', NULL, NULL),
(14, 14, 'label', '*Dystrybutorzy w PL', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-21 08:11:33', '127.0.0.1', '0', NULL, NULL),
(15, 15, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:19', '127.0.0.1', '0', NULL, NULL),
(16, 16, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(17, 17, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(18, 18, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(19, 19, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(20, 20, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(21, 21, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(22, 22, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(23, 23, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(24, 24, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(25, 25, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(26, 26, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(27, 27, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(28, 28, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(29, 29, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(30, 30, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(31, 31, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(32, 32, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(33, 33, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(34, 34, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(35, 35, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(36, 36, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(37, 37, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(38, 38, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(39, 39, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(40, 40, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(41, 41, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(42, 42, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(43, 43, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(44, 44, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(45, 45, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(46, 46, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(47, 47, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(48, 48, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(49, 49, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(50, 50, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(51, 51, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(52, 52, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(53, 53, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(54, 54, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(55, 55, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(56, 56, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(57, 57, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(58, 58, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(59, 59, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(60, 60, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(61, 61, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(62, 62, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(63, 63, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(64, 64, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(65, 65, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(66, 66, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(67, 67, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(68, 68, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(69, 69, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(70, 70, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(71, 71, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(72, 72, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(73, 73, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(74, 74, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(75, 75, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(76, 76, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(77, 77, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(78, 78, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(79, 79, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(80, 80, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(81, 81, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(82, 82, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(83, 83, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(84, 84, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(85, 85, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(86, 86, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(87, 87, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(88, 88, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(89, 89, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(90, 90, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(91, 91, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(92, 92, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(93, 93, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(94, 94, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(95, 95, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(96, 96, 'label', '-UPDATE-', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_col_style`
--

CREATE TABLE `form_col_style` (
  `id` int NOT NULL,
  `id_parent` int NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_property`
--

CREATE TABLE `form_property` (
  `id` int NOT NULL,
  `id_parent` int NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_row`
--

CREATE TABLE `form_row` (
  `id` int NOT NULL,
  `id_parent` int NOT NULL,
  `type` enum('p','d','h','i') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'p' COMMENT 'h - section header; i - input',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `form_row`
--

INSERT INTO `form_row` (`id`, `id_parent`, `type`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(1, 1, 'h', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:46:41', '127.0.0.1', '0', NULL, NULL),
(2, 1, 'i', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:47:35', '127.0.0.1', '0', NULL, NULL),
(3, 1, 'i', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:48:09', '127.0.0.1', '0', NULL, NULL),
(4, 1, 'h', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(5, 1, 'i', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(6, 1, 'i', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(7, 1, 'i', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(8, 1, 'i', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(9, 1, 'i', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(10, 1, 'i', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(11, 1, 'i', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(12, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:33', '127.0.0.1', '0', NULL, NULL),
(13, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(14, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(15, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(16, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(17, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(18, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(19, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(20, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(21, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(22, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(23, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(24, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(25, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(26, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(27, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(28, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(29, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(30, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(31, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(32, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(33, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(34, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(35, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(36, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(37, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(38, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(39, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(40, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(41, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(42, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(43, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(44, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(45, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(46, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(47, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(48, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(49, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(50, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(51, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(52, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(53, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(54, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(55, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(56, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(57, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(58, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(59, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(60, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(61, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(62, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(63, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(64, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(65, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(66, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(67, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(68, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(69, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(70, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(71, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(72, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(73, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(74, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(75, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(76, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(77, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(78, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(79, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(80, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(81, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(82, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(83, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(84, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(85, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(86, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(87, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(88, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(89, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(90, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(91, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(92, 1, 'p', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_row_property`
--

CREATE TABLE `form_row_property` (
  `id` int NOT NULL,
  `id_parent` int NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_row_style`
--

CREATE TABLE `form_row_style` (
  `id` int NOT NULL,
  `id_parent` int NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_style`
--

CREATE TABLE `form_style` (
  `id` int NOT NULL,
  `id_parent` int NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project`
--

CREATE TABLE `project` (
  `id` bigint NOT NULL,
  `rodzaj_umowy` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `rodzaj_umowy_id` int NOT NULL,
  `rodzaj_umowy_alt` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `numer_umowy` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `klient` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `temat_umowy` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `typ` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `typ_id` int NOT NULL,
  `nadzor` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `nadzor_id` int NOT NULL,
  `kier_grupy` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `kier_grupy_id` int NOT NULL,
  `kier_osr` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `kier_osr_id` int NOT NULL,
  `technolog` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `technolog_id` int NOT NULL,
  `term_realizacji` datetime DEFAULT NULL,
  `harm_data` datetime NOT NULL,
  `koniec_proj` datetime DEFAULT NULL,
  `status` enum('n','c','d','m') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'n' COMMENT 'n - nowy; c - zamkniety; d - uniety; m - w trakcie;',
  `status_info` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Nowy',
  `quota` int NOT NULL,
  `r_dane` int NOT NULL,
  `j_dane` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `system` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `system_id` int NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 - aktywny; 1 - usuniety',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hide_status` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL,
  `hide_date` datetime DEFAULT NULL,
  `hide_reason` varchar(300) COLLATE utf8mb4_general_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_document`
--

CREATE TABLE `project_document` (
  `id` bigint NOT NULL,
  `id_project` bigint NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo`
--

CREATE TABLE `slo` (
  `id` int NOT NULL,
  `id_app_task` int NOT NULL,
  `nazwa` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `slo`
--

INSERT INTO `slo` (`id`, `id_app_task`, `nazwa`, `delete_status`) VALUES
(1, 1, 'Błąd przy wprowadzaniu danych', '0'),
(2, 2, 'Błąd przy wprowadzaniu danych', '1'),
(3, 3, 'Błąd przy wprowadzaniu danych', '0'),
(4, 4, 'Błąd przy wprowadzaniu danych', '0'),
(5, 8, 'Błąd przy wprowadzaniu danych', '0'),
(6, 7, 'Błąd przy wprowadzaniu danych', '0'),
(7, 9, 'Projekt spełnił wszystkie kryteria zamknięcia.', '0');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_color`
--

CREATE TABLE `slo_color` (
  `PL` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ENG` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `HEX` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `slo_color`
--

INSERT INTO `slo_color` (`PL`, `ENG`, `HEX`) VALUES
(NULL, 'Acid Green', '#B0BF1A'),
(NULL, 'Algae Green', '#64E986'),
(NULL, 'AliceBlue', '#F0F8FF'),
(NULL, 'Alien Gray', '#736F6E'),
(NULL, 'Alien Green', '#6CC417'),
(NULL, 'Aloe Vera Green', '#98F516'),
(NULL, 'Antique Bronze', '#665D1E'),
(NULL, 'AntiqueWhite', '#FAEBD7'),
(NULL, 'Aqua or Cyan', '#00FFFF'),
(NULL, 'Aquamarine', '#7FFFD4'),
(NULL, 'Aquamarine Stone', '#348781'),
(NULL, 'Army Brown', '#827B60'),
(NULL, 'Army Green', '#4B5320'),
(NULL, 'Ash Gray', '#666362'),
(NULL, 'Ash White', '#E9E4D4'),
(NULL, 'Avocado Green', '#B2C248'),
(NULL, 'Aztech Purple', '#893BFF'),
(NULL, 'Azure', '#F0FFFF'),
(NULL, 'Azure Blue', '#4863A0'),
(NULL, 'Baby Blue', '#95B9C7'),
(NULL, 'Baby Pink', '#FAAFBA'),
(NULL, 'Bakers Brown', '#5C3317'),
(NULL, 'Balloon Blue', '#2B60DE'),
(NULL, 'Banana Yellow', '#F5E216'),
(NULL, 'Bashful Pink', '#C25283'),
(NULL, 'Basil Green', '#829F82'),
(NULL, 'Basket Ball Orange', '#F88158'),
(NULL, 'Battleship Gray', '#848482'),
(NULL, 'Bean Red', '#F75D59'),
(NULL, 'Bee Yellow', '#E9AB17'),
(NULL, 'Beer', '#FBB117'),
(NULL, 'Beetle Green', '#4C787E'),
(NULL, 'Beige', '#F5F5DC'),
(NULL, 'Bisque', '#FFE4C4'),
('Czarny', 'Black', '#000000'),
(NULL, 'Black Bean', '#3D0C02'),
(NULL, 'Black Cat', '#413839'),
(NULL, 'Black Cow', '#4C4646'),
(NULL, 'Black Eel', '#463E3F'),
(NULL, 'BlanchedAlmond', '#FFEBCD'),
(NULL, 'Blonde', '#FBF6D9'),
(NULL, 'Blood Night', '#551606'),
(NULL, 'Blood Red', '#7E3517'),
(NULL, 'Blossom Pink', '#F9B7FF'),
('Niebieski', 'Blue', '#0000FF'),
(NULL, 'Blue Angel', '#B7CEEC'),
(NULL, 'Blue Diamond', '#4EE2EC'),
(NULL, 'Blue Dress', '#157DEC'),
(NULL, 'Blue Eyes', '#1569C7'),
(NULL, 'Blue Gray', '#98AFC7'),
(NULL, 'Blue Green', '#7BCCB5'),
(NULL, 'Blue Hosta', '#77BFC7'),
(NULL, 'Blue Ivy', '#3090C7'),
(NULL, 'Blue Jay', '#2B547E'),
(NULL, 'Blue Koi', '#659EC7'),
(NULL, 'Blue Lagoon', '#8EEBEC'),
(NULL, 'Blue Lotus', '#6960EC'),
(NULL, 'Blue Moss Green', '#3C565B'),
(NULL, 'Blue Orchid', '#1F45FC'),
(NULL, 'Blue Ribbon', '#306EFF'),
(NULL, 'Blue Turquoise', '#43C6DB'),
(NULL, 'Blue Whale', '#342D7E'),
(NULL, 'Blue Zircon', '#57FEFF'),
(NULL, 'Blueberry Blue', '#0041C2'),
(NULL, 'BlueViolet', '#8A2BE2'),
(NULL, 'Blurple', '#5865F2'),
(NULL, 'Blush', '#FFE6E8'),
(NULL, 'Blush Pink', '#E6A9EC'),
(NULL, 'Blush Red', '#E56E94'),
(NULL, 'Bold Yellow', '#F9DB24'),
(NULL, 'Bone White', '#F9F6EE'),
(NULL, 'Bottle Green', '#006A4E'),
(NULL, 'Brass', '#B5A642'),
(NULL, 'Bright Blue', '#0909FF'),
(NULL, 'Bright Cyan', '#0AFFFF'),
(NULL, 'Bright Gold', '#FDD017'),
(NULL, 'Bright Grape', '#6F2DA8'),
(NULL, 'Bright Green', '#66FF00'),
(NULL, 'Bright Lilac', '#D891EF'),
(NULL, 'Bright Maroon', '#C32148'),
(NULL, 'Bright Navy Blue', '#1974D2'),
(NULL, 'Bright Neon Pink', '#F433FF'),
(NULL, 'Bright Orange', '#FF5F1F'),
(NULL, 'Bright Pink', '#FF007F'),
(NULL, 'Bright Purple', '#6A0DAD'),
(NULL, 'Bright Teal', '#01F9C6'),
(NULL, 'Bright Turquoise', '#16E2F5'),
(NULL, 'Bronze', '#CD7F32'),
(NULL, 'Bronze Gold', '#C9AE5D'),
(NULL, 'Brown', '#A52A2A'),
(NULL, 'Brown Bear', '#835C3B'),
(NULL, 'Brown Sand', '#EE9A4D'),
(NULL, 'Brown Sugar', '#E2A76F'),
(NULL, 'Bullet Shell', '#AF9B60'),
(NULL, 'Burgundy', '#8C001A'),
(NULL, 'BurlyWood', '#DEB887'),
(NULL, 'Burnt Pink', '#C12267'),
(NULL, 'Butterfly Blue', '#38ACEC'),
(NULL, 'Cactus Green', '#227442'),
(NULL, 'CadetBlue', '#5F9EA0'),
(NULL, 'Cadillac Pink', '#E38AAE'),
(NULL, 'Camel Brown', '#C19A6B'),
(NULL, 'Camouflage Green', '#78866B'),
(NULL, 'Canary Blue', '#2916F5'),
(NULL, 'Canary Yellow', '#FFEF00'),
(NULL, 'Cantaloupe', '#FFA62F'),
(NULL, 'Caramel', '#C68E17'),
(NULL, 'Carbon Gray', '#625D5D'),
(NULL, 'Carbon Red', '#A70D2A'),
(NULL, 'Cardboard Brown', '#EDDA74'),
(NULL, 'Carnation Pink', '#F778A1'),
(NULL, 'Carrot Orange', '#F88017'),
(NULL, 'Celeste', '#50EBEC'),
(NULL, 'Chameleon Green', '#BDF516'),
(NULL, 'Champagne', '#F7E7CE'),
(NULL, 'Charcoal', '#34282C'),
(NULL, 'Charcoal Blue', '#36454F'),
(NULL, 'Chartreuse', '#7FFF00'),
(NULL, 'Cheese Orange', '#FFA600'),
(NULL, 'Cherry Red', '#C24641'),
(NULL, 'Chestnut', '#954535'),
(NULL, 'Chestnut Red', '#C34A2C'),
(NULL, 'Chilli Pepper', '#C11B17'),
(NULL, 'Chocolate', '#D2691E'),
(NULL, 'Chocolate Brown', '#3F000F'),
(NULL, 'Chrome Gold', '#FFCE44'),
(NULL, 'Chrome Green', '#1AA260'),
(NULL, 'Chrome Pink', '#FF33AA'),
(NULL, 'Chrome White', '#E8F1D4'),
(NULL, 'Cinnamon', '#C58917'),
(NULL, 'Citron Green', '#8FB31D'),
(NULL, 'Clematis Violet', '#842DCE'),
(NULL, 'Cloudy Gray', '#6D6968'),
(NULL, 'Clover Green', '#3EA055'),
(NULL, 'Cobalt Blue', '#0020C2'),
(NULL, 'Coffee', '#6F4E37'),
(NULL, 'Columbia Blue', '#87AFC7'),
(NULL, 'Construction Cone Orange', '#F87431'),
(NULL, 'Cookie Brown', '#C7A317'),
(NULL, 'Copper', '#B87333'),
(NULL, 'Copper Red', '#CB6D51'),
(NULL, 'Coral', '#FF7F50'),
(NULL, 'Coral Blue', '#AFDCEC'),
(NULL, 'Coral Brown', '#9E4638'),
(NULL, 'Coral Peach', '#FBD5AB'),
(NULL, 'Corn Yellow', '#FFF380'),
(NULL, 'CornflowerBlue', '#6495ED'),
(NULL, 'Cornsilk', '#FFF8DC'),
(NULL, 'Cotton', '#FBFBF9'),
(NULL, 'Cotton Candy', '#FCDFFF'),
(NULL, 'Cranberry', '#9F000F'),
(NULL, 'Cream', '#FFFFCC'),
(NULL, 'Cream White', '#FFFDD0'),
(NULL, 'Crimson', '#DC143C'),
(NULL, 'Crimson Purple', '#E238EC'),
(NULL, 'Crimson Red', '#990000'),
(NULL, 'Crocus Purple', '#9172EC'),
(NULL, 'Crystal Blue', '#5CB3FF'),
(NULL, 'Cyan Opaque', '#92C7C7'),
(NULL, 'Dark Almond', '#AB784E'),
(NULL, 'Dark Beige', '#9F8C76'),
(NULL, 'Dark Bisque', '#B86500'),
(NULL, 'Dark Blonde', '#F0E2B6'),
(NULL, 'Dark Blue Grey', '#29465B'),
(NULL, 'Dark Bronze', '#804A00'),
(NULL, 'Dark Brown', '#654321'),
(NULL, 'Dark Carnation Pink', '#C12283'),
(NULL, 'Dark Coffee', '#3B2F2F'),
(NULL, 'Dark Forest Green', '#254117'),
(NULL, 'Dark Gold', '#AA6C39'),
(NULL, 'Dark Gray', '#3A3B3C'),
(NULL, 'Dark Green Blue', '#1F6357'),
(NULL, 'Dark Hot Pink', '#F660AB'),
(NULL, 'Dark Lime Green', '#41A317'),
(NULL, 'Dark Maroon', '#2F0909'),
(NULL, 'Dark Mint', '#31906E'),
(NULL, 'Dark Moccasin', '#827839'),
(NULL, 'Dark Pink', '#E75480'),
(NULL, 'Dark Purple', '#4B0150'),
(NULL, 'Dark Raspberry', '#872657'),
(NULL, 'Dark Scarlet', '#560319'),
(NULL, 'Dark Sienna', '#8A4117'),
(NULL, 'Dark Slate', '#2B3856'),
(NULL, 'Dark Teal', '#045D5D'),
(NULL, 'Dark White', '#E1D9D1'),
(NULL, 'Dark Yellow', '#8B8000'),
(NULL, 'DarkBlue', '#00008B'),
(NULL, 'DarkCyan', '#008B8B'),
(NULL, 'DarkGoldenRod', '#B8860B'),
(NULL, 'DarkGray or DarkGrey', '#A9A9A9'),
(NULL, 'DarkGreen', '#006400'),
(NULL, 'DarkKhaki', '#BDB76B'),
(NULL, 'DarkMagenta', '#8B008B'),
(NULL, 'DarkOliveGreen', '#556B2F'),
(NULL, 'DarkOrange', '#FF8C00'),
(NULL, 'DarkOrchid', '#9932CC'),
(NULL, 'DarkRed', '#8B0000'),
(NULL, 'DarkSalmon', '#E9967A'),
(NULL, 'DarkSeaGreen', '#8FBC8F'),
(NULL, 'DarkSlateBlue', '#483D8B'),
(NULL, 'DarkSlateGray or DarkSlateGrey', '#25383C'),
(NULL, 'DarkTurquoise', '#00CED1'),
(NULL, 'DarkViolet', '#9400D3'),
(NULL, 'Day Sky Blue', '#82CAFF'),
(NULL, 'Deep Emerald Green', '#046307'),
(NULL, 'Deep Green', '#056608'),
(NULL, 'Deep Mauve', '#DF73D4'),
(NULL, 'Deep Peach', '#FFCBA4'),
(NULL, 'Deep Periwinkle', '#5453A6'),
(NULL, 'Deep Purple', '#36013F'),
(NULL, 'Deep Red', '#800517'),
(NULL, 'Deep Rose', '#FBBBB9'),
(NULL, 'Deep Teal', '#033E3E'),
(NULL, 'Deep Turquoise', '#48CCCD'),
(NULL, 'Deep Yellow', '#F6BE00'),
(NULL, 'Deep-Sea', '#3B9C9C'),
(NULL, 'Deep-Sea Blue', '#123456'),
(NULL, 'Deep-Sea Green', '#306754'),
(NULL, 'DeepPink', '#FF1493'),
(NULL, 'DeepSkyBlue', '#00BFFF'),
(NULL, 'Deer Brown', '#E6BF83'),
(NULL, 'Denim Blue', '#79BAEC'),
(NULL, 'Denim Dark Blue', '#151B8D'),
(NULL, 'Desert Sand', '#EDC9AF'),
(NULL, 'DimGray or DimGrey', '#696969'),
(NULL, 'Dimorphotheca Magenta', '#E3319D'),
(NULL, 'Dinosaur Green', '#73A16C'),
(NULL, 'Dirty White', '#E8E4C9'),
(NULL, 'DodgerBlue', '#1E90FF'),
(NULL, 'Dollar Bill Green', '#85BB65'),
(NULL, 'Donut Pink', '#FAAFBE'),
(NULL, 'Dragon Green', '#6AFB92'),
(NULL, 'Dull Green Yellow', '#B1FB17'),
(NULL, 'Dull Purple', '#7F525D'),
(NULL, 'Dull-Sea Green', '#4E8975'),
(NULL, 'Dusky Pink', '#CC7A8B'),
(NULL, 'Dusty Pink', '#D58A94'),
(NULL, 'Dusty Rose', '#C9A9A6'),
(NULL, 'Earth Blue', '#0000A5'),
(NULL, 'Earth Green', '#34A56F'),
(NULL, 'Egg Shell', '#FFF9E3'),
(NULL, 'Eggplant', '#614051'),
(NULL, 'Electric Blue', '#9AFEFF'),
(NULL, 'Elf Green', '#1B8A6B'),
(NULL, 'Emerald', '#50C878'),
(NULL, 'Emerald Green', '#5FFB17'),
(NULL, 'Estoril Blue', '#2F539B'),
(NULL, 'Fall Forest Green', '#4E9258'),
(NULL, 'Fall Leaf Brown', '#C8B560'),
(NULL, 'Fern Green', '#667C26'),
(NULL, 'Ferrari Red', '#F70D1A'),
(NULL, 'Fire Engine Red', '#F62817'),
(NULL, 'FireBrick', '#B22222'),
(NULL, 'Flamingo Pink', '#F9A7B0'),
(NULL, 'FloralWhite', '#FFFAF0'),
(NULL, 'ForestGreen', '#228B22'),
(NULL, 'French Lilac', '#86608E'),
(NULL, 'Frog Green', '#99C68E'),
(NULL, 'Fuchsia or Magenta', '#FF00FF'),
(NULL, 'Fuchsia Pink', '#FF77FF'),
(NULL, 'Gainsboro', '#DCDCDC'),
(NULL, 'Garnet Red', '#733635'),
(NULL, 'GhostWhite', '#F8F8FF'),
(NULL, 'Ginger Brown', '#C9BE62'),
(NULL, 'Glacial Blue Ice', '#368BC1'),
(NULL, 'Gold', '#FFD700'),
(NULL, 'Gold Pink', '#E6C7C2'),
(NULL, 'Golden Blonde', '#FBE7A1'),
(NULL, 'Golden Brown', '#EAC117'),
(NULL, 'Golden Silk', '#F3E3C3'),
(NULL, 'Golden Yellow', '#FFDF00'),
(NULL, 'GoldenRod', '#DAA520'),
(NULL, 'Granite', '#837E7C'),
(NULL, 'Grape', '#5E5A80'),
(NULL, 'Grapefruit', '#DC381F'),
(NULL, 'Grass Green', '#3F9B0B'),
(NULL, 'Gray Brown', '#3D3635'),
(NULL, 'Gray Cloud', '#B6B6B4'),
(NULL, 'Gray Dolphin', '#5C5858'),
(NULL, 'Gray Goose', '#D1D0CE'),
(NULL, 'Gray Green', '#A2AD9C'),
(NULL, 'Gray or Grey', '#808080'),
(NULL, 'Gray Wolf', '#504A4B'),
(NULL, 'Grayish Turquoise', '#5E7D7E'),
(NULL, 'Green', '#008000'),
(NULL, 'Green Apple', '#4CC417'),
(NULL, 'Green Leaves', '#3A5F0B'),
(NULL, 'Green Onion', '#6AA121'),
(NULL, 'Green Peas', '#89C35C'),
(NULL, 'Green Pepper', '#4AA02C'),
(NULL, 'Green Snake', '#6CBB3C'),
(NULL, 'Green Thumb', '#B5EAAA'),
(NULL, 'Greenish Blue', '#307D7E'),
(NULL, 'GreenYellow', '#ADFF2F'),
(NULL, 'Gulf Blue', '#C9DFEC'),
(NULL, 'Gunmetal', '#2C3539'),
(NULL, 'Gunmetal Gray', '#8D918D'),
(NULL, 'Half White', '#FFFEFA'),
(NULL, 'Halloween Orange', '#E66C2C'),
(NULL, 'Harvest Gold', '#EDE275'),
(NULL, 'Hazel', '#8E7618'),
(NULL, 'Hazel Green', '#617C58'),
(NULL, 'Heavenly Blue', '#C6DEFF'),
(NULL, 'Heliotrope Purple', '#D462FF'),
(NULL, 'HoneyDew', '#F0FFF0'),
(NULL, 'Hot Deep Pink', '#F52887'),
(NULL, 'HotPink', '#FF69B4'),
(NULL, 'Hummingbird Green', '#7FE817'),
(NULL, 'Hunter Green', '#355E3B'),
(NULL, 'Iceberg', '#56A5EC'),
(NULL, 'Iguana Green', '#9CB071'),
(NULL, 'Indian Saffron', '#FF7722'),
(NULL, 'IndianRed', '#CD5C5C'),
(NULL, 'Indigo', '#4B0082'),
(NULL, 'Iridium', '#3D3C3A'),
(NULL, 'Irish Green', '#08A04B'),
(NULL, 'Iron Gray', '#52595D'),
(NULL, 'Ivory', '#FFFFF0'),
(NULL, 'Jade', '#00A36C'),
(NULL, 'Jade Green', '#5EFB6E'),
(NULL, 'Jasmine Purple', '#A23BEC'),
(NULL, 'Jeans Blue', '#A0CFEC'),
(NULL, 'Jellyfish', '#46C7C7'),
(NULL, 'Jet Gray', '#616D7E'),
(NULL, 'Jungle Green', '#347C2C'),
(NULL, 'Kelly Green', '#4CC552'),
(NULL, 'Khaki', '#F0E68C'),
(NULL, 'Khaki Green', '#8A865D'),
(NULL, 'Khaki Rose', '#C5908E'),
(NULL, 'Lapis Blue', '#15317E'),
(NULL, 'Lava Red', '#E42217'),
(NULL, 'Lavender', '#E6E6FA'),
(NULL, 'Lavender Blue', '#E3E4FA'),
(NULL, 'Lavender Pinocchio', '#EBDDE2'),
(NULL, 'Lavender Purple', '#967BB6'),
(NULL, 'LavenderBlush', '#FFF0F5'),
(NULL, 'LawnGreen', '#7CFC00'),
(NULL, 'Lemon Green', '#ADF802'),
(NULL, 'LemonChiffon', '#FFFACD'),
(NULL, 'Light Aquamarine', '#93FFE8'),
(NULL, 'Light Black', '#454545'),
(NULL, 'Light Brown', '#B5651D'),
(NULL, 'Light Copper', '#DA8A67'),
(NULL, 'Light Day Blue', '#ADDFFF'),
(NULL, 'Light French Beige', '#C8AD7F'),
(NULL, 'Light Gold', '#F1E5AC'),
(NULL, 'Light Jade', '#C3FDB8'),
(NULL, 'Light Mint Green', '#C2E5D3'),
(NULL, 'Light Olive Green', '#B8BC86'),
(NULL, 'Light Orange', '#FED8B1'),
(NULL, 'Light Purple', '#8467D7'),
(NULL, 'Light Purple Blue', '#728FCE'),
(NULL, 'Light Red', '#FFCCCB'),
(NULL, 'Light Rose', '#FBCFCD'),
(NULL, 'Light Rose Green', '#DBF9DB'),
(NULL, 'Light Salmon Rose', '#F9966B'),
(NULL, 'Light Slate', '#CCFFFF'),
(NULL, 'Light Slate Blue', '#736AFF'),
(NULL, 'Light Teal', '#B3D9D9'),
(NULL, 'Light White', '#FFFFF7'),
(NULL, 'LightBlue', '#ADD8E6'),
(NULL, 'LightCoral', '#F08080'),
(NULL, 'LightCyan', '#E0FFFF'),
(NULL, 'LightGoldenRodYellow', '#FAFAD2'),
(NULL, 'LightGray or LightGrey', '#D3D3D3'),
(NULL, 'LightGreen', '#90EE90'),
(NULL, 'LightPink', '#FFB6C1'),
(NULL, 'LightSalmon', '#FFA07A'),
(NULL, 'LightSeaGreen', '#20B2AA'),
(NULL, 'LightSkyBlue', '#87CEFA'),
(NULL, 'LightSlateGray or LightSlateGrey', '#778899'),
(NULL, 'LightSteelBlue', '#B0CFDE'),
(NULL, 'LightYellow', '#FFFFE0'),
(NULL, 'Lilac', '#C8A2C8'),
(NULL, 'Lime', '#00FF00'),
(NULL, 'Lime Mint Green', '#36F57F'),
(NULL, 'LimeGreen', '#32CD32'),
(NULL, 'Linen', '#FAF0E6'),
(NULL, 'Lipstick Pink', '#C48793'),
(NULL, 'Lotus Green', '#004225'),
(NULL, 'Love Red', '#E41B17'),
(NULL, 'Lovely Purple', '#7F38EC'),
(NULL, 'Macaroni and Cheese', '#F2BB66'),
(NULL, 'Macaw Blue Green', '#43BFC7'),
(NULL, 'Magenta Pink', '#CC338B'),
(NULL, 'Magic Mint', '#AAF0D1'),
(NULL, 'Mahogany', '#C04000'),
(NULL, 'Mango Orange', '#FF8040'),
(NULL, 'Marble Blue', '#566D7E'),
(NULL, 'Maroon', '#800000'),
(NULL, 'Maroon Red', '#8F0B0B'),
(NULL, 'Mauve', '#E0B0FF'),
(NULL, 'Mauve Taupe', '#915F6D'),
(NULL, 'Medium Forest Green', '#347235'),
(NULL, 'Medium Teal', '#045F5F'),
(NULL, 'MediumAquaMarine', '#66CDAA'),
(NULL, 'MediumBlue', '#0000CD'),
(NULL, 'MediumOrchid', '#BA55D3'),
(NULL, 'MediumPurple', '#9370DB'),
(NULL, 'MediumSeaGreen', '#3CB371'),
(NULL, 'MediumSlateBlue', '#7B68EE'),
(NULL, 'MediumSpringGreen', '#00FA9A'),
(NULL, 'MediumTurquoise', '#48D1CC'),
(NULL, 'MediumVioletRed', '#C71585'),
(NULL, 'Metallic Bronze', '#A97142'),
(NULL, 'Metallic Gold', '#D4AF37'),
(NULL, 'Metallic Green', '#7C9D8E'),
(NULL, 'Metallic Silver', '#BCC6CC'),
(NULL, 'Midday Blue', '#3BB9FF'),
(NULL, 'Midnight', '#2B1B17'),
(NULL, 'Midnight Purple', '#2E1A47'),
(NULL, 'MidnightBlue', '#191970'),
(NULL, 'Military Green', '#4E5B31'),
(NULL, 'Milk Chocolate', '#513B1C'),
(NULL, 'Milk White', '#FEFCFF'),
(NULL, 'Millennium Jade', '#93917C'),
(NULL, 'Mint', '#3EB489'),
(NULL, 'Mint Green', '#98FF98'),
(NULL, 'MintCream', '#F5FFFA'),
(NULL, 'Mist Blue', '#646D7E'),
(NULL, 'MistyRose', '#FFE4E1'),
(NULL, 'Moccasin', '#FFE4B5'),
(NULL, 'Mocha', '#493D26'),
(NULL, 'Moss Green', '#8A9A5B'),
(NULL, 'Mustard Yellow', '#FFDB58'),
(NULL, 'Nardo Gray', '#686A6C'),
(NULL, 'NavajoWhite', '#FFDEAD'),
(NULL, 'Navy', '#000080'),
(NULL, 'Nebula Green', '#59E817'),
(NULL, 'Neon Blue', '#1589FF'),
(NULL, 'Neon Gold', '#FDBD01'),
(NULL, 'Neon Green', '#16F529'),
(NULL, 'Neon Hot Pink', '#FD349C'),
(NULL, 'Neon Orange', '#FF6700'),
(NULL, 'Neon Pink', '#F535AA'),
(NULL, 'Neon Purple', '#9D00FF'),
(NULL, 'Neon Red', '#FD1C03'),
(NULL, 'Neon Yellow', '#FFFF33'),
(NULL, 'Neon Yellow Green', '#DAEE01'),
(NULL, 'New Midnight Blue', '#0000A0'),
(NULL, 'Night', '#0C090A'),
(NULL, 'Night Blue', '#151B54'),
(NULL, 'Northern Lights Blue', '#78C7C7'),
(NULL, 'Oak Brown', '#806517'),
(NULL, 'Ocean Blue', '#2B65EC'),
(NULL, 'Off White', '#F8F0E3'),
(NULL, 'Oil', '#3B3131'),
(NULL, 'Old Burgundy', '#43302E'),
(NULL, 'Old Rose', '#C08081'),
(NULL, 'OldLace', '#FEF0E3'),
(NULL, 'Olive', '#808000'),
(NULL, 'Olive Green', '#BAB86C'),
(NULL, 'OliveDrab', '#6B8E23'),
(NULL, 'Orange', '#FFA500'),
(NULL, 'Orange Gold', '#D4A017'),
(NULL, 'Orange Salmon', '#C47451'),
(NULL, 'OrangeRed', '#FF4500'),
(NULL, 'Orchid', '#DA70D6'),
(NULL, 'Orchid Purple', '#B048B5'),
(NULL, 'Organic Brown', '#E3F9A6'),
(NULL, 'Pale Blue Lily', '#CFECEC'),
(NULL, 'Pale Lilac', '#DCD0FF'),
(NULL, 'Pale Pink', '#F2D4D7'),
(NULL, 'Pale Silver', '#C9C0BB'),
(NULL, 'PaleGoldenRod', '#EEE8AA'),
(NULL, 'PaleGreen', '#98FB98'),
(NULL, 'PaleTurquoise', '#AFEEEE'),
(NULL, 'PaleVioletRed', '#DB7093'),
(NULL, 'Papaya Orange', '#E56717'),
(NULL, 'PapayaWhip', '#FFEFD5'),
(NULL, 'Parchment', '#FFFFC2'),
(NULL, 'Parrot Green', '#12AD2B'),
(NULL, 'Pastel Blue', '#B4CFEC'),
(NULL, 'Pastel Brown', '#B1907F'),
(NULL, 'Pastel Green', '#77DD77'),
(NULL, 'Pastel Light Blue', '#D5D6EA'),
(NULL, 'Pastel Orange', '#F8B88B'),
(NULL, 'Pastel Pink', '#FEA3AA'),
(NULL, 'Pastel Purple', '#F2A2E8'),
(NULL, 'Pastel Red', '#F67280'),
(NULL, 'Pastel Rose', '#E5788F'),
(NULL, 'Pastel Violet', '#D291BC'),
(NULL, 'Pastel Yellow', '#FAF884'),
(NULL, 'Pea Green', '#52D017'),
(NULL, 'Peach', '#FFE5B4'),
(NULL, 'Peach Pink', '#F98B88'),
(NULL, 'PeachPuff', '#FFDAB9'),
(NULL, 'Pearl', '#FDEEF4'),
(NULL, 'Pearl White', '#F8F6F0'),
(NULL, 'Periwinkle', '#CCCCFF'),
(NULL, 'Periwinkle Pink', '#E9CFEC'),
(NULL, 'Periwinkle Purple', '#7575CF'),
(NULL, 'Peru', '#CD853F'),
(NULL, 'Petra Gold', '#B76734'),
(NULL, 'Pig Pink', '#FDD7E4'),
(NULL, 'Pine Green', '#387C44'),
(NULL, 'Pink', '#FFC0CB'),
(NULL, 'Pink Brown', '#C48189'),
(NULL, 'Pink Bubble Gum', '#FFDFDD'),
(NULL, 'Pink Coral', '#E77471'),
(NULL, 'Pink Cupcake', '#E45E9D'),
(NULL, 'Pink Daisy', '#E799A3'),
(NULL, 'Pink Lemonade', '#E4287C'),
(NULL, 'Pink Orange', '#F89880'),
(NULL, 'Pink Plum', '#B93B8F'),
(NULL, 'Pink Violet', '#CA226B'),
(NULL, 'Pistachio Green', '#9DC209'),
(NULL, 'Platinum', '#E5E4E2'),
(NULL, 'Platinum Gray', '#797979'),
(NULL, 'Platinum Silver', '#CECECE'),
(NULL, 'Plum', '#DDA0DD'),
(NULL, 'Plum Pie', '#7D0541'),
(NULL, 'Plum Purple', '#583759'),
(NULL, 'Plum Velvet', '#7D0552'),
(NULL, 'Powder Pink', '#FFB2D0'),
(NULL, 'PowderBlue', '#B0E0E6'),
(NULL, 'Puce', '#7F5A58'),
(NULL, 'Pumpkin Orange', '#F87217'),
(NULL, 'Purple', '#800080'),
(NULL, 'Purple Amethyst', '#6C2DC7'),
(NULL, 'Purple Daffodil', '#B041FF'),
(NULL, 'Purple Dragon', '#C38EC7'),
(NULL, 'Purple Flower', '#A74AC7'),
(NULL, 'Purple Haze', '#4E387E'),
(NULL, 'Purple Iris', '#571B7E'),
(NULL, 'Purple Jam', '#6A287E'),
(NULL, 'Purple Lily', '#550A35'),
(NULL, 'Purple Maroon', '#810541'),
(NULL, 'Purple Mimosa', '#9E7BFF'),
(NULL, 'Purple Monster', '#461B7E'),
(NULL, 'Purple Navy', '#4E5180'),
(NULL, 'Purple Pink', '#D16587'),
(NULL, 'Purple Plum', '#8E35EF'),
(NULL, 'Purple Sage Bush', '#7A5DC7'),
(NULL, 'Purple Thistle', '#D2B9D3'),
(NULL, 'Purple Violet', '#8D38C9'),
(NULL, 'Purple White', '#DFD3E3'),
(NULL, 'Raspberry', '#E30B5D'),
(NULL, 'Raspberry Purple', '#B3446C'),
(NULL, 'Rat Gray', '#6D7B8D'),
(NULL, 'RebeccaPurple', '#663399'),
(NULL, 'Red', '#FF0000'),
(NULL, 'Red Blood', '#660000'),
(NULL, 'Red Brown', '#622F22'),
(NULL, 'Red Dirt', '#7F5217'),
(NULL, 'Red Fox', '#C35817'),
(NULL, 'Red Gold', '#EB5406'),
(NULL, 'Red Pink', '#FA2A55'),
(NULL, 'Red White', '#F3E8EA'),
(NULL, 'Red Wine or Wine Red', '#990012'),
(NULL, 'Rice', '#FAF5EF'),
(NULL, 'Rich Lilac', '#B666D2'),
(NULL, 'Robin Egg Blue', '#BDEDFF'),
(NULL, 'Rogue Pink', '#C12869'),
(NULL, 'Roman Silver', '#838996'),
(NULL, 'Rose', '#E8ADAA'),
(NULL, 'Rose Dust', '#997070'),
(NULL, 'Rose Gold', '#ECC5C0'),
(NULL, 'Rose Pink or Pink Rose', '#E7A1B0'),
(NULL, 'Rose Purple', '#B09FCA'),
(NULL, 'Rose Red', '#C21E56'),
(NULL, 'Rosy Pink', '#B38481'),
(NULL, 'Rosy-Finch', '#7F4E52'),
(NULL, 'RosyBrown', '#BC8F8F'),
(NULL, 'Royal Pink', '#E759AC'),
(NULL, 'RoyalBlue', '#4169E1'),
(NULL, 'Rubber Ducky Yellow', '#FFD801'),
(NULL, 'Ruby Red', '#F62217'),
(NULL, 'Rust', '#C36241'),
(NULL, 'SaddleBrown', '#8B4513'),
(NULL, 'Saffron', '#FBB917'),
(NULL, 'Saffron Red', '#931314'),
(NULL, 'Sage', '#BCB88A'),
(NULL, 'Sage Green', '#848B79'),
(NULL, 'Salad Green', '#A1C935'),
(NULL, 'Salmon', '#FA8072'),
(NULL, 'Salmon Pink', '#FF8674'),
(NULL, 'Samco Blue', '#0002FF'),
(NULL, 'Sand', '#C2B280'),
(NULL, 'Sandstone', '#786D5F'),
(NULL, 'SandyBrown', '#F4A460'),
(NULL, 'Sangria', '#7E3817'),
(NULL, 'Sapphire Blue', '#2554C7'),
(NULL, 'Scarlet Red', '#FF2400'),
(NULL, 'School Bus Yellow', '#E8A317'),
(NULL, 'Sea Blue', '#C2DFFF'),
(NULL, 'Sea Turtle Green', '#438D80'),
(NULL, 'Seafoam Green', '#3EA99F'),
(NULL, 'SeaGreen', '#2E8B57'),
(NULL, 'SeaShell', '#FFF5EE'),
(NULL, 'Seaweed Green', '#437C17'),
(NULL, 'Sedona', '#CC6600'),
(NULL, 'Sepia', '#7F462C'),
(NULL, 'Sepia Brown', '#704214'),
(NULL, 'Shamrock Green', '#347C17'),
(NULL, 'Shocking Orange', '#E55B3C'),
(NULL, 'Sienna', '#A0522D'),
(NULL, 'Silk Blue', '#488AC7'),
(NULL, 'Silver', '#C0C0C0'),
(NULL, 'Silver Pink', '#C4AEAD'),
(NULL, 'Silver White', '#DADBDD'),
(NULL, 'Sky Blue Dress', '#6698FF'),
(NULL, 'SkyBlue', '#87CEEB'),
(NULL, 'Slate Blue Grey', '#737CA1'),
(NULL, 'Slate Granite Gray', '#657383'),
(NULL, 'SlateBlue', '#6A5ACD'),
(NULL, 'SlateGray or SlateGrey', '#708090'),
(NULL, 'Slime Green', '#BCE954'),
(NULL, 'Smokey Gray', '#726E6D'),
(NULL, 'Snow', '#FFFAFA'),
(NULL, 'Soft Ivory', '#FAF0DD'),
(NULL, 'Soft Pink', '#FFB8BF'),
(NULL, 'Sonic Silver', '#757575'),
(NULL, 'SpringGreen', '#00FF7F'),
(NULL, 'SteelBlue', '#4682B4'),
(NULL, 'Stoplight Go Green', '#57E964'),
(NULL, 'Sun Yellow', '#FFE87C'),
(NULL, 'Sunrise Orange', '#E67451'),
(NULL, 'Tan', '#D2B48C'),
(NULL, 'Tan Brown', '#ECE5B6'),
(NULL, 'Tangerine', '#E78A61'),
(NULL, 'Taupe', '#483C32'),
(NULL, 'Tea Green', '#CCFB5D'),
(NULL, 'Teal', '#008080'),
(NULL, 'Teal Blue', '#007C80'),
(NULL, 'Teal Green', '#00827F'),
(NULL, 'Thistle', '#D8BFD8'),
(NULL, 'Tiffany Blue', '#81D8D0'),
(NULL, 'Tiger Orange', '#C88141'),
(NULL, 'Tomato', '#FF6347'),
(NULL, 'Tomato Sauce Red', '#B21807'),
(NULL, 'Tron Blue', '#7DFDFE'),
(NULL, 'Tulip Pink', '#C25A7C'),
(NULL, 'Turquoise', '#40E0D0'),
(NULL, 'Turquoise Green', '#A0D6B4'),
(NULL, 'Tyrian Purple', '#C45AEC'),
(NULL, 'Unbleached Silk', '#FFDDCA'),
(NULL, 'Valentine Red', '#E55451'),
(NULL, 'Vampire Gray', '#565051'),
(NULL, 'Vanilla', '#F3E5AB'),
(NULL, 'Velvet Maroon', '#7E354D'),
(NULL, 'Venom Green', '#728C00'),
(NULL, 'Vermilion', '#7E191B'),
(NULL, 'Very Peri', '#6667AB'),
(NULL, 'Viola Purple', '#7E587E'),
(NULL, 'Violet', '#EE82EE'),
(NULL, 'Violet Red', '#F6358A'),
(NULL, 'Warm Pink', '#F6C6BD'),
(NULL, 'Warm White', '#EFEBD8'),
(NULL, 'Water', '#EBF4FA'),
(NULL, 'Watermelon Pink', '#FC6C85'),
(NULL, 'Western Charcoal', '#49413F'),
(NULL, 'Wheat', '#F5DEB3'),
('Biały', 'White', '#FFFFFF'),
(NULL, 'White Blue', '#DBE9FA'),
(NULL, 'White Chocolate', '#EDE6D6'),
(NULL, 'White Gold', '#FFFFF4'),
(NULL, 'White Ice', '#EAEEE9'),
(NULL, 'WhiteSmoke', '#F5F5F5'),
(NULL, 'Windows Blue', '#357EC7'),
(NULL, 'Wisteria Purple', '#C6AEC7'),
(NULL, 'Wood', '#966F33'),
(NULL, 'Yellow', '#FFFF00'),
(NULL, 'Yellow Green Grosbeak', '#E2F516'),
(NULL, 'Yellow Lawn Green', '#87F717'),
(NULL, 'Yellow Orange or Orange Yellow', '#FFAE42'),
(NULL, 'YellowGreen', '#9ACD32'),
(NULL, 'Zombie Green', '#54C571');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_font_family`
--

CREATE TABLE `slo_font_family` (
  `NAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `slo_font_family`
--

INSERT INTO `slo_font_family` (`NAME`) VALUES
('Andalé Mono'),
('Arial'),
('Arial Black'),
('Baskerville'),
('Bradley Hand'),
('Brush Script MT'),
('Comic Sans MS'),
('Courier'),
('Georgia'),
('Gill Sans'),
('Helvetica'),
('Impact'),
('Lucida'),
('Luminari'),
('Monaco'),
('Palatino'),
('Tahoma'),
('Times New Roman'),
('Trebuchet MS'),
('Verdana');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_list`
--

CREATE TABLE `slo_list` (
  `id` int NOT NULL,
  `NAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `VALUE` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `TYPE` enum('s','l','m','ls') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 's' COMMENT 's - specjalne; l - interlinia; m - miara (Measurement); ls - leading sign'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `slo_list`
--

INSERT INTO `slo_list` (`id`, `NAME`, `VALUE`, `TYPE`) VALUES
(1, 'co najmniej', 'atLeast', 'l'),
(2, 'pojedynczy', 'single', 'l'),
(3, 'jeden i pół', 'oneAndHalf', 'l'),
(4, 'dokładnie', 'exactly', 'l'),
(5, 'wiele', 'multiple', 'l'),
(6, 'kropka', 'dot', 'ls'),
(7, 'myślnik', 'dash', 'ls'),
(8, 'podkreślenie', 'underline', 'ls'),
(9, 'brak', 'none', 'ls');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_list_type`
--

CREATE TABLE `slo_list_type` (
  `NAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `VALUE` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `slo_list_type`
--

INSERT INTO `slo_list_type` (`NAME`, `VALUE`) VALUES
('&#8226;', 'bullet'),
('0 1 2 3 4 ...', 'decimal'),
('0. 1. 2. 3. 4. ...', 'decimal-dot'),
('00 01 02 03 04 ...', 'decimal-leading-zero'),
('0) 1) 2) 3) 4) ...', 'decimal-round-right-bracket'),
('a b c d ...', 'lower-alpha'),
('a. b. c. d. ...', 'lower-alpha-dot'),
('a) b) c) d) ...', 'lower-alpha-round-right-bracket'),
('i ii iii iv ...', 'lower-roman'),
('i. ii. iii. iv. ...', 'lower-roman-dot'),
('i) ii) iii) iv) ...', 'lower-roman-round-right-bracket'),
('A B C D ....', 'upper-alpha'),
('A. B. C. D. ....', 'upper-alpha-dot'),
('A) B) C) D) ....', 'upper-alpha-round-right-bracket'),
('I II III IV ....', 'upper-roman'),
('I. II. III. IV. ....', 'upper-roman-dot'),
('I) II) III) IV) ....', 'upper-roman-round-right-bracket');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage`
--

CREATE TABLE `slo_project_stage` (
  `id` bigint NOT NULL,
  `departmentId` int NOT NULL,
  `departmentName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('tx') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'tx',
  `new_page` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `part` enum('b','f','h') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'b' COMMENT 'b - body; f - fotter; h - header',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `buffer_user_id` int DEFAULT NULL,
  `hide_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `hide_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hide_date` datetime DEFAULT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_const`
--

CREATE TABLE `slo_project_stage_const` (
  `id` int NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `buffer_user_id` int DEFAULT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hide_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `hide_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_property`
--

CREATE TABLE `slo_project_stage_property` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_section`
--

CREATE TABLE `slo_project_stage_section` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_section_property`
--

CREATE TABLE `slo_project_stage_section_property` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_section_style`
--

CREATE TABLE `slo_project_stage_section_style` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_style`
--

CREATE TABLE `slo_project_stage_style` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection`
--

CREATE TABLE `slo_project_stage_subsection` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_property`
--

CREATE TABLE `slo_project_stage_subsection_property` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row`
--

CREATE TABLE `slo_project_stage_subsection_row` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_i`
--

CREATE TABLE `slo_project_stage_subsection_row_i` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_i_style`
--

CREATE TABLE `slo_project_stage_subsection_row_i_style` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_l_property`
--

CREATE TABLE `slo_project_stage_subsection_row_l_property` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_l_style`
--

CREATE TABLE `slo_project_stage_subsection_row_l_style` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_property`
--

CREATE TABLE `slo_project_stage_subsection_row_property` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_p_property`
--

CREATE TABLE `slo_project_stage_subsection_row_p_property` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_p_style`
--

CREATE TABLE `slo_project_stage_subsection_row_p_style` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_p_tabstop`
--

CREATE TABLE `slo_project_stage_subsection_row_p_tabstop` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `lp` bigint NOT NULL,
  `position` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `measurement` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `measurementName` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alignment` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alignmentName` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `leadingSign` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `leadingSignName` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_p_variable`
--

CREATE TABLE `slo_project_stage_subsection_row_p_variable` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `id_variable` bigint NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_style`
--

CREATE TABLE `slo_project_stage_subsection_row_style` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_t_property`
--

CREATE TABLE `slo_project_stage_subsection_row_t_property` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_t_style`
--

CREATE TABLE `slo_project_stage_subsection_row_t_style` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_style`
--

CREATE TABLE `slo_project_stage_subsection_style` (
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_project_stage_variable`
--

CREATE TABLE `slo_project_stage_variable` (
  `id` int NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL,
  `buffer_user_id` int DEFAULT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `hide_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `hide_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Struktura tabeli dla tabeli `slo_style`
--

CREATE TABLE `slo_style` (
  `PL` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `ENG` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `GROUP` int NOT NULL,
  `NUMBER` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `slo_style`
--

INSERT INTO `slo_style` (`PL`, `ENG`, `GROUP`, `NUMBER`) VALUES
('Lewo', 'LEFT', 1, 1),
('Prawo', 'RIGHT', 1, 2),
('Wyśrodkuj', 'CENTRE', 1, 3),
('Wyjustuj', 'JUSTIFY', 1, 4),
('px', 'px', 2, 1),
('pt', 'pt', 2, 2),
('cm', 'cm', 2, 3),
('mm', 'mm', 2, 4),
('pkt', 'pkt', 2, 5),
('Pogrubiony', 'BOLD', 0, 1),
('Podkreślony', 'UNDERLINE', 0, 1),
('Pochylony', 'ITALIC', 0, 2),
('Przekreśony', 'line-through', 0, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_all_prac_v4`
--

CREATE TABLE `v_all_prac_v4` (
  `id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `v_all_prac_v4`
--

INSERT INTO `v_all_prac_v4` (`id`) VALUES
(96636218987);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_all_prac_v5`
-- (See below for the actual view)
--
CREATE TABLE `v_all_prac_v5` (
`ID` bigint
,`ImieNazwisko` varchar(301)
,`Stanowisko` varchar(200)
,`Procent` varchar(1)
,`Email` varchar(300)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_all_user`
-- (See below for the actual view)
--
CREATE TABLE `v_all_user` (
`ID` int
,`Imie` varchar(100)
,`Nazwisko` varchar(100)
,`Login` varchar(100)
,`Email` varchar(100)
,`wskU` enum('0','1')
,`IdRola` int
,`TypKontaValue` int
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_parm_v2`
-- (See below for the actual view)
--
CREATE TABLE `v_parm_v2` (
`ID` int
,`Skrót` varchar(100)
,`Nazwa` varchar(100)
,`Opis` varchar(1024)
,`Wartość` varchar(100)
,`Typ` enum('n','t','c','p','s-color','s-measurement','s-font-family','s-text-align','s-decoration','s-line-spacing','s-list-type')
,`ModDat` datetime
,`ModUser` varchar(200)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_slo_dok`
--

CREATE TABLE `v_slo_dok` (
  `ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_slo_glow_tech_proj`
--

CREATE TABLE `v_slo_glow_tech_proj` (
  `id` int NOT NULL,
  `ImieNazwisko` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `v_slo_glow_tech_proj`
--

INSERT INTO `v_slo_glow_tech_proj` (`id`, `ImieNazwisko`) VALUES
(1, 'Sebastian Majewski'),
(2, 'Radosław Graban');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_slo_kier_osr_proj`
--

CREATE TABLE `v_slo_kier_osr_proj` (
  `id` int NOT NULL,
  `ImieNazwisko` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `v_slo_kier_osr_proj`
--

INSERT INTO `v_slo_kier_osr_proj` (`id`, `ImieNazwisko`) VALUES
(1, 'Paulina Marek Słowik');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_slo_kier_proj`
--

CREATE TABLE `v_slo_kier_proj` (
  `id` int NOT NULL,
  `ImieNazwisko` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `v_slo_kier_proj`
--

INSERT INTO `v_slo_kier_proj` (`id`, `ImieNazwisko`) VALUES
(1, 'Robert Kwiatkowski'),
(2, 'Anna Lewandowska');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_slo_lider_proj`
--

CREATE TABLE `v_slo_lider_proj` (
  `id` int NOT NULL,
  `ImieNazwisko` varchar(200) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `v_slo_lider_proj`
--

INSERT INTO `v_slo_lider_proj` (`id`, `ImieNazwisko`) VALUES
(1, 'Tomasz Borczyński'),
(2, 'Adam Borczyński');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_slo_rola`
-- (See below for the actual view)
--
CREATE TABLE `v_slo_rola` (
`ID` int
,`NAZWA` varchar(100)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_slo_rola_all`
-- (See below for the actual view)
--
CREATE TABLE `v_slo_rola_all` (
`ID` int
,`Nazwa` varchar(100)
,`WSK_U` enum('0','1')
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_slo_sys_um`
--

CREATE TABLE `v_slo_sys_um` (
  `ID` int NOT NULL,
  `Nazwa` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `v_slo_sys_um`
--

INSERT INTO `v_slo_sys_um` (`ID`, `Nazwa`) VALUES
(1, 'Paradigm'),
(2, 'Volt');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_slo_typ_um`
--

CREATE TABLE `v_slo_typ_um` (
  `ID` int NOT NULL,
  `Nazwa` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `v_slo_typ_um`
--

INSERT INTO `v_slo_typ_um` (`ID`, `Nazwa`) VALUES
(1, 'zlecenie');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_slo_um_proj`
--

CREATE TABLE `v_slo_um_proj` (
  `ID` int NOT NULL,
  `Nazwa` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `NazwaAlt` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `v_slo_um_proj`
--

INSERT INTO `v_slo_um_proj` (`ID`, `Nazwa`, `NazwaAlt`) VALUES
(1, 'Test Nazwa', 'Test Nazwa Alt'),
(2, 'Test Nazwa 2', 'Test Nazwa Alt 2');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_slo_upr`
-- (See below for the actual view)
--
CREATE TABLE `v_slo_upr` (
`ID` int
,`NAZWA` varchar(200)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_slo_u_spec`
--

CREATE TABLE `v_slo_u_spec` (
  `ID` int NOT NULL,
  `NAZWA` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `DEFAULT` enum('n','t') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `v_slo_u_spec`
--

INSERT INTO `v_slo_u_spec` (`ID`, `NAZWA`, `DEFAULT`) VALUES
(1, 'Technik', 'n'),
(2, 'Kierownik', 'n');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_uzyt_i_upr`
--

CREATE TABLE `v_uzyt_i_upr` (
  `idUzytkownik` int NOT NULL,
  `idUprawnienie` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura widoku `v_all_prac_v5`
--
DROP TABLE IF EXISTS `v_all_prac_v5`;

CREATE ALGORITHM=UNDEFINED DEFINER=`server101661_autos-forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_all_prac_v5`  AS SELECT `employee`.`id` AS `ID`, concat(`employee`.`imie`,' ',`employee`.`nazwisko`) AS `ImieNazwisko`, `employee`.`stanowisko` AS `Stanowisko`, '0' AS `Procent`, `employee`.`email` AS `Email` FROM `employee` ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_all_user`
--
DROP TABLE IF EXISTS `v_all_user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`server101661_autos-forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_all_user`  AS SELECT `u`.`id` AS `ID`, `u`.`imie` AS `Imie`, `u`.`nazwisko` AS `Nazwisko`, `u`.`login` AS `Login`, `u`.`email` AS `Email`, `u`.`wsk_u` AS `wskU`, `u`.`id_rola` AS `IdRola`, `u`.`typ` AS `TypKontaValue` FROM `uzytkownik` AS `u` WHERE (0 <> 1) ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_parm_v2`
--
DROP TABLE IF EXISTS `v_parm_v2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`server101661_autos-forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_parm_v2`  AS SELECT `parametry`.`ID` AS `ID`, `parametry`.`SKROT` AS `Skrót`, `parametry`.`NAZWA` AS `Nazwa`, `parametry`.`OPIS` AS `Opis`, `parametry`.`WARTOSC` AS `Wartość`, `parametry`.`TYP` AS `Typ`, `parametry`.`MOD_DATE` AS `ModDat`, `parametry`.`MOD_USER` AS `ModUser` FROM `parametry` ORDER BY `parametry`.`ID` ASC ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_slo_rola`
--
DROP TABLE IF EXISTS `v_slo_rola`;

CREATE ALGORITHM=UNDEFINED DEFINER=`server101661_autos-forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_slo_rola`  AS SELECT `slo_rola`.`ID` AS `ID`, `slo_rola`.`NAZWA` AS `NAZWA` FROM `slo_rola` WHERE (`slo_rola`.`WSK_U` = '0') ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_slo_rola_all`
--
DROP TABLE IF EXISTS `v_slo_rola_all`;

CREATE ALGORITHM=UNDEFINED DEFINER=`server101661_autos-forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_slo_rola_all`  AS SELECT `r`.`ID` AS `ID`, `r`.`NAZWA` AS `Nazwa`, `r`.`WSK_U` AS `WSK_U` FROM `slo_rola` AS `r` WHERE (0 <> 1) ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_slo_upr`
--
DROP TABLE IF EXISTS `v_slo_upr`;

CREATE ALGORITHM=UNDEFINED DEFINER=`server101661_autos-forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_slo_upr`  AS SELECT `u`.`ID` AS `ID`, `u`.`NAZWA` AS `NAZWA` FROM `uprawnienia` AS `u` WHERE (0 <> 1) ;

-- --------------------------------------------------------

--
-- Indeksy dla tabeli `allocation`
--
ALTER TABLE `allocation`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `app_task`
--
ALTER TABLE `app_task`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeksy dla tabeli `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `dictionary_measurement_units`
--
ALTER TABLE `dictionary_measurement_units`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_EmployeeCreateUser` (`create_user_id`),
  ADD KEY `FK_EmployeeModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `employee_allocation`
--
ALTER TABLE `employee_allocation`
  ADD KEY `FK_EmployeeAllocationEmployee` (`id_employee`),
  ADD KEY `FK_EmployeeAllocationSpecialization` (`id_allocation`);

--
-- Indeksy dla tabeli `employee_project`
--
ALTER TABLE `employee_project`
  ADD KEY `FK_EmployeeProjectCreateUser` (`create_user_id`),
  ADD KEY `FK_EmployeeProjectModifyUser` (`mod_user_id`),
  ADD KEY `FK_EmployeeProjectEmployee` (`id_employee`),
  ADD KEY `FK_EmployeeProjectProject` (`id_project`);

--
-- Indeksy dla tabeli `form`
--
ALTER TABLE `form`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormCreateUser` (`create_user_id`),
  ADD KEY `FK_FormModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `form_col`
--
ALTER TABLE `form_col`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormColCreateUser` (`create_user_id`),
  ADD KEY `FK_FormColModifyUser` (`mod_user_id`),
  ADD KEY `FK_FormColParent` (`id_parent`);

--
-- Indeksy dla tabeli `form_col_property`
--
ALTER TABLE `form_col_property`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_FormColPropertyProperty` (`id_parent`,`property`),
  ADD KEY `FK_FormColPropertyCreateUser` (`create_user_id`),
  ADD KEY `FK_FormColPropertyModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `form_col_style`
--
ALTER TABLE `form_col_style`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_FormColStyleProperty` (`id_parent`,`property`),
  ADD KEY `FK_FormColStyleCreateUser` (`create_user_id`),
  ADD KEY `FK_FormColStyleModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `form_property`
--
ALTER TABLE `form_property`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_FormPropertyProperty` (`id_parent`,`property`),
  ADD KEY `FK_FormPropertyCreateUser` (`create_user_id`),
  ADD KEY `FK_FormPropertyModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `form_row`
--
ALTER TABLE `form_row`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormRowCreateUser` (`create_user_id`),
  ADD KEY `FK_FormRowModifyUser` (`mod_user_id`),
  ADD KEY `FK_FormRowParent` (`id_parent`);

--
-- Indeksy dla tabeli `form_row_property`
--
ALTER TABLE `form_row_property`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_FormRowPropertyProperty` (`id_parent`,`property`),
  ADD KEY `FK_FormRowPropertyCreateUser` (`create_user_id`),
  ADD KEY `FK_FormRowPropertyModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `form_row_style`
--
ALTER TABLE `form_row_style`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_FormRowStyleProperty` (`id_parent`,`property`),
  ADD KEY `FK_FormRowStyleCreateUser` (`create_user_id`),
  ADD KEY `FK_FormRowStyleModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `form_style`
--
ALTER TABLE `form_style`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_FormStyleProperty` (`id_parent`,`property`),
  ADD KEY `FK_FormStyleCreateUser` (`create_user_id`),
  ADD KEY `FK_FormStyleModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`,`klient`),
  ADD KEY `FK_ProjectCreateUser` (`create_user_id`),
  ADD KEY `FK_ProjectModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `project_document`
--
ALTER TABLE `project_document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectDocumentParent` (`id_project`),
  ADD KEY `FK_ProjectDocumentCreateUser` (`create_user_id`),
  ADD KEY `FK_ProjectDocumentModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `slo`
--
ALTER TABLE `slo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_AppTask` (`id_app_task`);

--
-- Indeksy dla tabeli `slo_color`
--
ALTER TABLE `slo_color`
  ADD UNIQUE KEY `ENG` (`ENG`),
  ADD UNIQUE KEY `HEX` (`HEX`),
  ADD UNIQUE KEY `PL` (`PL`);

--
-- Indeksy dla tabeli `slo_font_family`
--
ALTER TABLE `slo_font_family`
  ADD UNIQUE KEY `NAME` (`NAME`);

--
-- Indeksy dla tabeli `slo_list`
--
ALTER TABLE `slo_list`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `slo_list_type`
--
ALTER TABLE `slo_list_type`
  ADD UNIQUE KEY `NAME` (`NAME`),
  ADD UNIQUE KEY `VALUE` (`VALUE`);

--
-- Indeksy dla tabeli `slo_project_stage`
--
ALTER TABLE `slo_project_stage`
  ADD UNIQUE KEY `UNIQUE_ID` (`id`) USING BTREE,
  ADD KEY `FK_SloStageCreateUser` (`create_user_id`);

--
-- Indeksy dla tabeli `slo_project_stage_const`
--
ALTER TABLE `slo_project_stage_const`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `slo_project_stage_section`
--
ALTER TABLE `slo_project_stage_section`
  ADD UNIQUE KEY `UNIQUE_ID` (`id`) USING BTREE,
  ADD KEY `FK_SloSectionCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSectionParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_section_property`
--
ALTER TABLE `slo_project_stage_section_property`
  ADD UNIQUE KEY `UNIQUE_StageSectionProperty` (`id_parent`,`property`),
  ADD KEY `FK_SloSectionProeprtyCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSectionPropertyModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSectionProeprtyParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_section_style`
--
ALTER TABLE `slo_project_stage_section_style`
  ADD UNIQUE KEY `UNIQUE_StageSectionStyle` (`id_parent`,`property`),
  ADD KEY `FK_SloSectionStyleCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSectionStyleModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `slo_project_stage_style`
--
ALTER TABLE `slo_project_stage_style`
  ADD UNIQUE KEY `UNIQUE_StageStageStyle` (`id_parent`,`property`),
  ADD KEY `FK_SloStageStyleCreateUser` (`create_user_id`),
  ADD KEY `FK_SloStageStyleModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloStageStyleParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection`
--
ALTER TABLE `slo_project_stage_subsection`
  ADD UNIQUE KEY `UNIQUE_ID` (`id`) USING BTREE,
  ADD KEY `FK_SloSubsectionCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_property`
--
ALTER TABLE `slo_project_stage_subsection_property`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionProperty` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionPropertyCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionPropertyModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionPropertyParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row`
--
ALTER TABLE `slo_project_stage_subsection_row`
  ADD UNIQUE KEY `UNIQUE_ID` (`id`) USING BTREE,
  ADD KEY `FK_SloSubsectionRowCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_i`
--
ALTER TABLE `slo_project_stage_subsection_row_i`
  ADD UNIQUE KEY `UNIQUE_ID` (`id`) USING BTREE,
  ADD KEY `FK_SloSubsectionRowICreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowIParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_i_style`
--
ALTER TABLE `slo_project_stage_subsection_row_i_style`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionRowIstyle` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionRowIstyleCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowIstyleModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowIstyleParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_l_property`
--
ALTER TABLE `slo_project_stage_subsection_row_l_property`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionRowLproeprty` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionRowLpropertyCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowLpropertyModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowLpropertyParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_l_style`
--
ALTER TABLE `slo_project_stage_subsection_row_l_style`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionRowLstyle` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionRowLstyleCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowLstyleModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowLstyleParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_property`
--
ALTER TABLE `slo_project_stage_subsection_row_property`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionRowProperty` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionRowPropertyCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowPropertyModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowPropertyParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_p_property`
--
ALTER TABLE `slo_project_stage_subsection_row_p_property`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionRowPproeprty` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionRowPpropertyCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowPpropertyModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowPpropertyParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_p_style`
--
ALTER TABLE `slo_project_stage_subsection_row_p_style`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionRowPstyle` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionRowPstyleCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowPstyleModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowPstyleParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_p_tabstop`
--
ALTER TABLE `slo_project_stage_subsection_row_p_tabstop`
  ADD KEY `FK_SloSubsectionRowPtabstopCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowPtabstopModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowPtabstopParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_p_variable`
--
ALTER TABLE `slo_project_stage_subsection_row_p_variable`
  ADD KEY `FK_SloSubsectionRowPvariableCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowPvariableModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowPvariableParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_style`
--
ALTER TABLE `slo_project_stage_subsection_row_style`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionRowStyle` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionRowStyleCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowStyleModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowStyleParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_t_property`
--
ALTER TABLE `slo_project_stage_subsection_row_t_property`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionRowTproperty` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionRowTpropertyCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowTpropertyModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowTpropertyParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_t_style`
--
ALTER TABLE `slo_project_stage_subsection_row_t_style`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionRowTstyle` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionRowTstyleCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowTstyleModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowTstyleParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_subsection_style`
--
ALTER TABLE `slo_project_stage_subsection_style`
  ADD UNIQUE KEY `UNIQUE_StageSubsectionStyle` (`id_parent`,`property`),
  ADD KEY `FK_SloSubsectionStyleCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionStyleModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionStyleParent` (`id_parent`);

--
-- Indeksy dla tabeli `slo_project_stage_variable`
--
ALTER TABLE `slo_project_stage_variable`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `v_all_prac_v4`
--
ALTER TABLE `v_all_prac_v4`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `v_slo_glow_tech_proj`
--
ALTER TABLE `v_slo_glow_tech_proj`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `v_slo_kier_osr_proj`
--
ALTER TABLE `v_slo_kier_osr_proj`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `v_slo_kier_proj`
--
ALTER TABLE `v_slo_kier_proj`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `v_slo_lider_proj`
--
ALTER TABLE `v_slo_lider_proj`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `v_slo_sys_um`
--
ALTER TABLE `v_slo_sys_um`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `v_slo_typ_um`
--
ALTER TABLE `v_slo_typ_um`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `v_slo_um_proj`
--
ALTER TABLE `v_slo_um_proj`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `v_slo_u_spec`
--
ALTER TABLE `v_slo_u_spec`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_task`
--
ALTER TABLE `app_task`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dictionary_measurement_units`
--
ALTER TABLE `dictionary_measurement_units`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `form`
--
ALTER TABLE `form`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `form_col`
--
ALTER TABLE `form_col`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `form_col_property`
--
ALTER TABLE `form_col_property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `form_col_style`
--
ALTER TABLE `form_col_style`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `form_property`
--
ALTER TABLE `form_property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `form_row`
--
ALTER TABLE `form_row`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `form_row_property`
--
ALTER TABLE `form_row_property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `form_row_style`
--
ALTER TABLE `form_row_style`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `form_style`
--
ALTER TABLE `form_style`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `slo`
--
ALTER TABLE `slo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `slo_list`
--
ALTER TABLE `slo_list`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `slo_project_stage_const`
--
ALTER TABLE `slo_project_stage_const`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `slo_project_stage_variable`
--
ALTER TABLE `slo_project_stage_variable`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `v_all_prac_v4`
--
ALTER TABLE `v_all_prac_v4`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96636218988;

--
-- AUTO_INCREMENT for table `v_slo_glow_tech_proj`
--
ALTER TABLE `v_slo_glow_tech_proj`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `v_slo_kier_osr_proj`
--
ALTER TABLE `v_slo_kier_osr_proj`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `v_slo_kier_proj`
--
ALTER TABLE `v_slo_kier_proj`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `v_slo_lider_proj`
--
ALTER TABLE `v_slo_lider_proj`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `v_slo_sys_um`
--
ALTER TABLE `v_slo_sys_um`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `v_slo_typ_um`
--
ALTER TABLE `v_slo_typ_um`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `v_slo_um_proj`
--
ALTER TABLE `v_slo_um_proj`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `v_slo_u_spec`
--
ALTER TABLE `v_slo_u_spec`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `FK_EmployeeCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_EmployeeModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Constraints for table `employee_allocation`
--
ALTER TABLE `employee_allocation`
  ADD CONSTRAINT `FK_EmployeeAllocationEmployee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `FK_EmployeeAllocationSpecialization` FOREIGN KEY (`id_allocation`) REFERENCES `allocation` (`id`);

--
-- Constraints for table `employee_project`
--
ALTER TABLE `employee_project`
  ADD CONSTRAINT `FK_EmployeeProjectCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_EmployeeProjectEmployee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `FK_EmployeeProjectModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_EmployeeProjectProject` FOREIGN KEY (`id_project`) REFERENCES `project` (`id`);

--
-- Constraints for table `form`
--
ALTER TABLE `form`
  ADD CONSTRAINT `FK_FormCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Constraints for table `form_col`
--
ALTER TABLE `form_col`
  ADD CONSTRAINT `FK_FormColCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColParent` FOREIGN KEY (`id_parent`) REFERENCES `form_row` (`id`);

--
-- Constraints for table `form_col_property`
--
ALTER TABLE `form_col_property`
  ADD CONSTRAINT `FK_FormColPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `form_col` (`id`);

--
-- Constraints for table `form_col_style`
--
ALTER TABLE `form_col_style`
  ADD CONSTRAINT `FK_FormColStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `form_col` (`id`);

--
-- Constraints for table `form_property`
--
ALTER TABLE `form_property`
  ADD CONSTRAINT `FK_FormPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `form` (`id`);

--
-- Constraints for table `form_row`
--
ALTER TABLE `form_row`
  ADD CONSTRAINT `FK_FormRowCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowParent` FOREIGN KEY (`id_parent`) REFERENCES `form` (`id`);

--
-- Constraints for table `form_row_property`
--
ALTER TABLE `form_row_property`
  ADD CONSTRAINT `FK_FormRowPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `form_row` (`id`);

--
-- Constraints for table `form_row_style`
--
ALTER TABLE `form_row_style`
  ADD CONSTRAINT `FK_FormRowStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `form_row` (`id`);

--
-- Constraints for table `form_style`
--
ALTER TABLE `form_style`
  ADD CONSTRAINT `FK_FormStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `form` (`id`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `FK_ProjectCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Constraints for table `project_document`
--
ALTER TABLE `project_document`
  ADD CONSTRAINT `FK_ProjectDocumentCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectDocumentModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectDocumentParent` FOREIGN KEY (`id_project`) REFERENCES `project` (`id`);

--
-- Constraints for table `slo`
--
ALTER TABLE `slo`
  ADD CONSTRAINT `FK_AppTask` FOREIGN KEY (`id_app_task`) REFERENCES `app_task` (`id`);

--
-- Constraints for table `slo_project_stage`
--
ALTER TABLE `slo_project_stage`
  ADD CONSTRAINT `FK_SloStageCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Constraints for table `slo_project_stage_section`
--
ALTER TABLE `slo_project_stage_section`
  ADD CONSTRAINT `FK_SloSectionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSectionParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage` (`id`);

--
-- Constraints for table `slo_project_stage_section_property`
--
ALTER TABLE `slo_project_stage_section_property`
  ADD CONSTRAINT `FK_SloSectionPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSectionPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSectionPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_section` (`id`);

--
-- Constraints for table `slo_project_stage_section_style`
--
ALTER TABLE `slo_project_stage_section_style`
  ADD CONSTRAINT `FK_SloSectionStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSectionStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSectionStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_section` (`id`);

--
-- Constraints for table `slo_project_stage_style`
--
ALTER TABLE `slo_project_stage_style`
  ADD CONSTRAINT `FK_SloStageStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloStageStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloStageStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage` (`id`);

--
-- Constraints for table `slo_project_stage_subsection`
--
ALTER TABLE `slo_project_stage_subsection`
  ADD CONSTRAINT `FK_SloSubsectionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_section` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_property`
--
ALTER TABLE `slo_project_stage_subsection_property`
  ADD CONSTRAINT `FK_SloSubsectionPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row`
--
ALTER TABLE `slo_project_stage_subsection_row`
  ADD CONSTRAINT `FK_SloSubsectionRowCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_i`
--
ALTER TABLE `slo_project_stage_subsection_row_i`
  ADD CONSTRAINT `FK_SloSubsectionRowICreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowIParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_i_style`
--
ALTER TABLE `slo_project_stage_subsection_row_i_style`
  ADD CONSTRAINT `FK_SloSubsectionRowIstyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowIstyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowIstyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row_i` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_l_property`
--
ALTER TABLE `slo_project_stage_subsection_row_l_property`
  ADD CONSTRAINT `FK_SloSubsectionRowLpropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowLpropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowLpropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_l_style`
--
ALTER TABLE `slo_project_stage_subsection_row_l_style`
  ADD CONSTRAINT `FK_SloSubsectionRowLstyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowLstyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowLstyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_property`
--
ALTER TABLE `slo_project_stage_subsection_row_property`
  ADD CONSTRAINT `FK_SloSubsectionRowPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_p_property`
--
ALTER TABLE `slo_project_stage_subsection_row_p_property`
  ADD CONSTRAINT `FK_SloSubsectionRowPpropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPpropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPpropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_p_style`
--
ALTER TABLE `slo_project_stage_subsection_row_p_style`
  ADD CONSTRAINT `FK_SloSubsectionRowPstyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPstyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPstyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_p_tabstop`
--
ALTER TABLE `slo_project_stage_subsection_row_p_tabstop`
  ADD CONSTRAINT `FK_SloSubsectionRowPtabstopCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPtabstopModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPtabstopParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_p_variable`
--
ALTER TABLE `slo_project_stage_subsection_row_p_variable`
  ADD CONSTRAINT `FK_SloSubsectionRowPvariableCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPvariableModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPvariableParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_style`
--
ALTER TABLE `slo_project_stage_subsection_row_style`
  ADD CONSTRAINT `FK_SloSubsectionRowStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_t_property`
--
ALTER TABLE `slo_project_stage_subsection_row_t_property`
  ADD CONSTRAINT `FK_SloSubsectionRowTpropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowTpropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowTpropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_row_t_style`
--
ALTER TABLE `slo_project_stage_subsection_row_t_style`
  ADD CONSTRAINT `FK_SloSubsectionRowTstyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowTstyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowTstyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Constraints for table `slo_project_stage_subsection_style`
--
ALTER TABLE `slo_project_stage_subsection_style`
  ADD CONSTRAINT `FK_SloSubsectionStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
