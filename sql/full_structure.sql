-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:4455
-- Czas generowania: 31 Paź 2025, 14:51
-- Wersja serwera: 8.2.0
-- Wersja PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `forms`
--
CREATE DATABASE IF NOT EXISTS `forms` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci;
USE `forms`;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `allocation`
--

CREATE TABLE `allocation` (
  `id` bigint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `default_checked` enum('n','y') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `allocation`
--

INSERT INTO `allocation` (`id`, `name`, `default_checked`) VALUES
(1, 'Lider', 'n'),
(2, 'Manager', 'n'),
(3, 'Kierownik ośrodka', 'n'),
(4, 'Główny technolog', 'n');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `app_account_type`
--

CREATE TABLE `app_account_type` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `wsk_u` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `app_account_type`
--

INSERT INTO `app_account_type` (`id`, `name`, `code`, `wsk_u`) VALUES
(1, 'Database', 'database', ''),
(2, 'Active Directory (AD)', 'ldap', ''),
(3, 'Active Directory (AD)', 'ldapAutos', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `app_task`
--

CREATE TABLE `app_task` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `app_task`
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
  `NAME` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `department`
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
-- Zrzut danych tabeli `department_user`
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
-- Zrzut danych tabeli `dictionary_measurement_units`
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
  `imie` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nazwisko` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `stanowisko` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `employee`
--

INSERT INTO `employee` (`id`, `imie`, `nazwisko`, `stanowisko`, `email`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`) VALUES
(961608535752, 'Tomasz', 'Borczynski', 'IT Specjalist', 'tborczynski@tomftb.pl', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-29 18:30:33', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-29 18:30:33', '127.0.0.1', '0');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `employee_allocation`
--

CREATE TABLE `employee_allocation` (
  `id_employee` bigint NOT NULL,
  `id_allocation` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `employee_allocation`
--

INSERT INTO `employee_allocation` (`id_employee`, `id_allocation`) VALUES
(961608535752, 1),
(961608535752, 2),
(961608535752, 3),
(961608535752, 4);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `employee_project`
--

CREATE TABLE `employee_project` (
  `id_employee` bigint NOT NULL,
  `id_project` bigint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `surname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `percentage` int NOT NULL COMMENT 'udzial procentowy',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `employee_project`
--

INSERT INTO `employee_project` (`id_employee`, `id_project`, `name`, `surname`, `percentage`, `start_date`, `end_date`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(961608535752, 681137715046, 'Tomasz', 'Borczynski', 6, '2025-10-30', '2025-10-30', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 10:51:55', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 11:11:00', '127.0.0.1', '0', NULL, '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `filled_form`
--

CREATE TABLE `filled_form` (
  `id` bigint NOT NULL,
  `id_form` bigint DEFAULT NULL,
  `name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
-- Zrzut danych tabeli `filled_form`
--

INSERT INTO `filled_form` (`id`, `id_form`, `name`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(485156859713, NULL, 'Formularz dostawcy kwalifikowanego', 1, 'admin', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1056400312577, NULL, 'Formularz dostawcy kwalifikowanego', 1, 'admin', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `filled_form_field`
--

CREATE TABLE `filled_form_field` (
  `id` bigint NOT NULL,
  `id_filled_form` bigint NOT NULL,
  `id_form_field` bigint DEFAULT NULL,
  `name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('h','i') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'i' COMMENT 'i - input; h - header',
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
-- Zrzut danych tabeli `filled_form_field`
--

INSERT INTO `filled_form_field` (`id`, `id_filled_form`, `id_form_field`, `name`, `value`, `type`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(2225281524, 485156859713, NULL, '048-1-input-cISO_45001', 'false', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(12504943053, 485156859713, NULL, '191-10-input-ESG', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(15806400849, 485156859713, NULL, '007-1-header-companyData', 'Osoba wypełniająca formularz', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(25477764907, 485156859713, NULL, '032-1-input-settlementCurrency', 'PLN', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(25594278364, 485156859713, NULL, '158-9-input-postalCodeShippingWarehouse', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(38458054104, 485156859713, NULL, '000-0-header-filledPearson', 'Osoba wypełniająca formularz', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(39981457335, 485156859713, NULL, '124-8-input-guaranteeBonus', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(45663773702, 485156859713, NULL, '094-6-input-positionOffer', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(46672405547, 485156859713, NULL, '034-1-input-directSelling', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(48689347188, 1056400312577, NULL, '138-8-input-sharedPriceList', '0|Tak', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(50068015966, 485156859713, NULL, '101-7-input-nameCommerce', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(50725080736, 1056400312577, NULL, '085-5-input-phoneTechnic', '+48888888888', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(54627372949, 485156859713, NULL, '128-8-input-logisticsBonus', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(59563791075, 485156859713, NULL, '144-8-input-guaranteeTime', '24 mi', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(64895585912, 485156859713, NULL, '057-3-header-director', 'Prezes zarządu/dyrektor', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(78802740145, 1056400312577, NULL, '073-4-input-positionTrade', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(85160167695, 485156859713, NULL, '183-10-input-accountNumberBank', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(87922793112, 1056400312577, NULL, '048-1-input-cISO_45001', 'on', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(94890304637, 1056400312577, NULL, '089-6-header-offer', 'Zapytania ofertowe', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(98391011016, 485156859713, NULL, '201-10-input-text', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(101272606751, 1056400312577, NULL, '158-9-input-postalCodeShippingWarehouse', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(102430949118, 485156859713, NULL, '024-1-input-companyWWW', '127.0.0.1', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(108360651496, 1056400312577, NULL, '079-5-header-technic', 'Sprawy techniczne', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(108743457827, 1056400312577, NULL, '014-1-input-companyPostalCode', '86-050', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(114391294618, 1056400312577, NULL, '069-4-input-nameTrade', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(124416659932, 1056400312577, NULL, '132-8-input-complaintConsiderationPeriod', '2 dni', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(135426710418, 485156859713, NULL, '030-1-input-countryInvoicingItem', 'PL', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(141838369031, 485156859713, NULL, '116-8-input-positionExecution', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(142243538791, 485156859713, NULL, '150-8-input-expressDelivery', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(153828074653, 1056400312577, NULL, '114-8-input-surnameExecution', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(155958570581, 1056400312577, NULL, '026-1-input-affiliatedEntity', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(164799768917, 1056400312577, NULL, '077-4-input-emailTrade', 'admin@tomftb.pl', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(166371402472, 485156859713, NULL, '136-8-input-complaintsMail', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(169705632308, 485156859713, NULL, '157-9-input-streetShippingWarehouse', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(170755485464, 1056400312577, NULL, '105-7-input-positionCommerce', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(172463491998, 485156859713, NULL, '008-1-input-companyFullName', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(174636688044, 1056400312577, NULL, '087-5-input-emailTechnic', 'admin@tomftb.pl', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(178718986920, 1056400312577, NULL, '040-1-input-cISO_14001', 'on', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(183797857134, 1056400312577, NULL, '090-6-input-nameOffer', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(190459873318, 485156859713, NULL, '114-8-input-surnameExecution', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(193804255930, 1056400312577, NULL, '056-2-header-contactData', 'Dane kontaktowe', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(197155075845, 1056400312577, NULL, '008-1-input-companyFullName', 'Autos', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(197466542684, 1056400312577, NULL, '168-9-input-tecdoc', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(199147160909, 1056400312577, NULL, '054-1-input-cSCC_VCA', 'on', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(208609003335, 485156859713, NULL, '073-4-input-positionTrade', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(213623328595, 485156859713, NULL, '010-1-input-companyNIP', 'pl2314343242432', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(214813723274, 1056400312577, NULL, '071-4-input-surnameTrade', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(233342362575, 485156859713, NULL, '134-8-input-complaintsKind', 'nie mam pojęcia', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(236886296403, 1056400312577, NULL, '191-10-input-ESG', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(237769282073, 1056400312577, NULL, '126-8-input-marketingBonus', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(242564314792, 485156859713, NULL, '069-4-input-nameTrade', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(245648541432, 1056400312577, NULL, '174-9-input-B2B', '0|Tak', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(248546984290, 1056400312577, NULL, '118-8-input-phoneExecution', '+48888888888', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(250850509935, 485156859713, NULL, '146-8-input-warrantyTime', '21', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(252505488978, 1056400312577, NULL, '162-9-input-invoiceFormat', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(253419561462, 485156859713, NULL, '090-6-input-nameOffer', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(264515960033, 485156859713, NULL, '085-5-input-phoneTechnic', '+4889999999', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(265302940274, 485156859713, NULL, '052-1-input-cISO_37001', 'false', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(265414413341, 1056400312577, NULL, '032-1-input-settlementCurrency', 'PLN', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(274264945367, 485156859713, NULL, '012-1-input-companyStreet', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(276563255009, 1056400312577, NULL, '111-8-header-execution', 'Realizacja zamówień', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(279600703217, 485156859713, NULL, '142-8-input-creditLimit', '200 PLN', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(294704119512, 1056400312577, NULL, '140-8-input-priceListComments', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(299298915858, 1056400312577, NULL, '007-1-header-companyData', 'Osoba wypełniająca formularz', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(299694648994, 1056400312577, NULL, '046-1-input-cISO_27001', 'on', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(310268389112, 1056400312577, NULL, '010-1-input-companyNIP', 'PL213213213221', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(324341263252, 485156859713, NULL, '079-5-header-technic', 'Sprawy techniczne', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(328720266440, 485156859713, NULL, '056-2-header-contactData', 'Dane kontaktowe', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(342907412131, 1056400312577, NULL, '003-0-input-surnameFormAuthor', 'Sieradzki', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(343100201814, 1056400312577, NULL, '164-9-input-maintenanceBo', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(348098236544, 485156859713, NULL, '040-1-input-cISO_14001', 'on', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(348102335629, 485156859713, NULL, '028-1-input-distributors', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(348747770657, 485156859713, NULL, '105-7-input-positionCommerce', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(358750491734, 1056400312577, NULL, '001-0-input-nameFormAuthor', 'Jakub', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(364438409874, 485156859713, NULL, '062-3-input-positionDirector', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(365999798370, 1056400312577, NULL, '176-10-header-bank', 'Adres magazynu wysyłkowego', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(374919747058, 485156859713, NULL, '162-9-input-invoiceFormat', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(381591038593, 1056400312577, NULL, '005-0-input-positionFormAuthor', 'programista', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(387577412041, 485156859713, NULL, '174-9-input-B2B', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(392517137680, 485156859713, NULL, '014-1-input-companyPostalCode', '85-050', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(405726387870, 485156859713, NULL, '016-1-input-companyCity', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(407115080897, 1056400312577, NULL, '080-5-input-nameTechnic', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(408362141572, 485156859713, NULL, '096-6-input-phoneOffer', '+4889999999', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(409677690342, 1056400312577, NULL, '201-10-input-text', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(422920229212, 1056400312577, NULL, '154-8-input-api', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(424759753521, 485156859713, NULL, '152-8-input-hubShipping', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(427088148237, 485156859713, NULL, '054-1-input-cSCC_VCA', 'false', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(432407012517, 485156859713, NULL, '046-1-input-cISO_27001', 'false', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(434935349292, 485156859713, NULL, '042-1-input-cOHSAS_18001', 'false', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(435937887436, 1056400312577, NULL, '075-4-input-phoneTrade', '+48888888888', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(444967467973, 1056400312577, NULL, '172-9-input-teccom', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(445014489916, 1056400312577, NULL, '068-4-header-trade', 'Sprawy handlowe', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(451252481134, 485156859713, NULL, '187-10-input-EDI', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(456267007601, 485156859713, NULL, '038-1-input-cISO_9001', 'false', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(492921928601, 1056400312577, NULL, '199-10-input-bdoNumber', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(496268194613, 1056400312577, NULL, '000-0-header-filledPearson', 'Osoba wypełniająca formularz', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(501746027966, 1056400312577, NULL, '052-1-input-cISO_37001', 'on', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(502715600859, 1056400312577, NULL, '028-1-input-distributors', 'brak', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(502941746672, 1056400312577, NULL, '189-10-input-orderConfirm', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(511742642267, 1056400312577, NULL, '066-3-input-emailDirector', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(514836133885, 1056400312577, NULL, '036-1-input-manufacturerDistributor', '0|Producentem', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(515533464128, 485156859713, NULL, '064-3-input-phoneDirector', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(519152220545, 1056400312577, NULL, '112-8-input-nameExecution', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(530865044728, 485156859713, NULL, '181-10-input-currencyBank', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(532305889737, 1056400312577, NULL, '179-10-input-addressBank', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(552274718104, 485156859713, NULL, '058-3-input-nameDirector', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(554773563936, 1056400312577, NULL, '142-8-input-creditLimit', '200 zł', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(561652031943, 485156859713, NULL, '160-9-input-cityShippingWarehouse', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(568480041991, 1056400312577, NULL, '170-9-input-tecdocCode', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(574344721119, 1056400312577, NULL, '152-8-input-hubShipping', 'tak', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(584735080026, 485156859713, NULL, '020-1-input-numberOfEmployeesCompany', '4321432', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(592509811822, 1056400312577, NULL, '060-3-input-surnameDirector', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(604583473138, 1056400312577, NULL, '130-8-input-warehouseCleaning', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(606502475456, 485156859713, NULL, '092-6-input-surnameOffer', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(608880423095, 1056400312577, NULL, '018-1-input-yearFoundationCompany', '5656', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(614852139560, 485156859713, NULL, '022-1-input-shareCapitalCompany', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(621428818750, 1056400312577, NULL, '020-1-input-numberOfEmployeesCompany', '2000', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(625300650551, 1056400312577, NULL, '101-7-input-nameCommerce', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(629618628716, 485156859713, NULL, '179-10-input-addressBank', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(633065840469, 485156859713, NULL, '003-0-input-surnameFormAuthor', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(636379662612, 485156859713, NULL, '197-10-input-catalogLink', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(638691695290, 485156859713, NULL, '005-0-input-positionFormAuthor', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(643370093154, 1056400312577, NULL, '092-6-input-surnameOffer', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(647505659822, 485156859713, NULL, '140-8-input-priceListComments', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(655835995842, 1056400312577, NULL, '050-1-input-cISO_50001', 'on', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(656111996955, 1056400312577, NULL, '183-10-input-accountNumberBank', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(663913209360, 1056400312577, NULL, '146-8-input-warrantyTime', 'dostawca', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(668909092110, 1056400312577, NULL, '136-8-input-complaintsMail', '0|Tak', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(669141816085, 1056400312577, NULL, '150-8-input-expressDelivery', 'tak', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(674842669972, 485156859713, NULL, '107-7-input-phoneCommerce', '+4889999999', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(680130195893, 1056400312577, NULL, '166-9-input-boComments', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(684034910027, 485156859713, NULL, '189-10-input-orderConfirm', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(686361776202, 485156859713, NULL, '118-8-input-phoneExecution', '+4889999999', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(690268479644, 1056400312577, NULL, '124-8-input-guaranteeBonus', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(706014282070, 1056400312577, NULL, '012-1-input-companyStreet', 'Cyprysowa 3', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(706813461206, 1056400312577, NULL, '042-1-input-cOHSAS_18001', 'on', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(708147427736, 485156859713, NULL, '138-8-input-sharedPriceList', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(711119187656, 485156859713, NULL, '103-7-input-surnameCommerce', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(713171934554, 1056400312577, NULL, '082-5-input-surnameTechnic', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(716890732560, 485156859713, NULL, '001-0-input-nameFormAuthor', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(717016518064, 485156859713, NULL, '185-10-input-skontoBank', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(718515703668, 1056400312577, NULL, '062-3-input-positionDirector', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(718883856997, 1056400312577, NULL, '094-6-input-positionOffer', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(719818411800, 485156859713, NULL, '075-4-input-phoneTrade', '+4889999999', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(720525871084, 485156859713, NULL, '018-1-input-yearFoundationCompany', '2000', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(735536794962, 1056400312577, NULL, '098-6-input-emailOffer', 'admin@tomftb.pl', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(754125449157, 485156859713, NULL, '148-8-input-MOV', '300000 PLN', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(762926136862, 485156859713, NULL, '132-8-input-complaintConsiderationPeriod', '12 dni', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(763075216151, 485156859713, NULL, '068-4-header-trade', 'Sprawy handlowe', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(768499007891, 485156859713, NULL, '100-7-header-commerce', 'Opiekun handlowy', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(770123266318, 485156859713, NULL, '066-3-input-emailDirector', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(772607681867, 485156859713, NULL, '176-10-header-bank', 'Adres magazynu wysyłkowego', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(775350603569, 485156859713, NULL, '193-10-input-expirationDateProducts', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(777497392638, 485156859713, NULL, '199-10-input-bdoNumber', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(779298191727, 1056400312577, NULL, '116-8-input-positionExecution', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(783863067022, 485156859713, NULL, '156-9-header-shippingWarehouse', 'Adres magazynu wysyłkowego', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(785386432461, 1056400312577, NULL, '022-1-input-shareCapitalCompany', '2 banie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(787195837217, 485156859713, NULL, '164-9-input-maintenanceBo', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(788607051506, 1056400312577, NULL, '057-3-header-director', 'Prezes zarządu/dyrektor', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(797679169281, 1056400312577, NULL, '134-8-input-complaintsKind', 'nie wiem', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(808293201967, 1056400312577, NULL, '128-8-input-logisticsBonus', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(820060210792, 485156859713, NULL, '077-4-input-emailTrade', 'admin@tomftb.pl', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL);
INSERT INTO `filled_form_field` (`id`, `id_filled_form`, `id_form_field`, `name`, `value`, `type`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(822826082369, 485156859713, NULL, '154-8-input-api', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(840411915660, 485156859713, NULL, '195-10-input-productionWarehouse', '0|z magazynu', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(847036815592, 1056400312577, NULL, '144-8-input-guaranteeTime', '12 miesięcy', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(850061779447, 1056400312577, NULL, '083-5-input-positionTechnic', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(850767897923, 1056400312577, NULL, '160-9-input-cityShippingWarehouse', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(864159323697, 485156859713, NULL, '112-8-input-nameExecution', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(865198052561, 485156859713, NULL, '060-3-input-surnameDirector', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(872391250860, 1056400312577, NULL, '109-7-input-emailCommerce', 'admin@tomftb.pl', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(875401643638, 1056400312577, NULL, '181-10-input-currencyBank', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(878699232854, 1056400312577, NULL, '193-10-input-expirationDateProducts', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(881391933019, 1056400312577, NULL, '044-1-input-cIATF_16949', 'on', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(886347374357, 1056400312577, NULL, '034-1-input-directSelling', '0|Tak', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(888965319079, 485156859713, NULL, '166-9-input-boComments', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(893182499192, 485156859713, NULL, '170-9-input-tecdocCode', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(895169267515, 1056400312577, NULL, '197-10-input-catalogLink', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(897184334223, 1056400312577, NULL, '058-3-input-nameDirector', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(900073181176, 485156859713, NULL, '098-6-input-emailOffer', 'admin@tomftb.pl', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(906494742508, 1056400312577, NULL, '038-1-input-cISO_9001', 'on', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(915690117432, 1056400312577, NULL, '064-3-input-phoneDirector', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(918111666516, 485156859713, NULL, '044-1-input-cIATF_16949', 'false', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(922852283124, 485156859713, NULL, '126-8-input-marketingBonus', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(930070983347, 485156859713, NULL, '050-1-input-cISO_50001', 'false', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(931782172964, 1056400312577, NULL, '103-7-input-surnameCommerce', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(933770910978, 1056400312577, NULL, '148-8-input-MOV', '200 PLN', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(936470924982, 1056400312577, NULL, '016-1-input-companyCity', 'Solec Kujawski', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(938022030834, 485156859713, NULL, '080-5-input-nameTechnic', 'testowe', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(941666244013, 485156859713, NULL, '120-8-input-emailExecution', 'admin@tomftb.pl', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(943057132477, 485156859713, NULL, '111-8-header-execution', 'Realizacja zamówień', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(945284634093, 1056400312577, NULL, '185-10-input-skontoBank', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(956583483420, 1056400312577, NULL, '096-6-input-phoneOffer', '+48888888888', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(958764655173, 1056400312577, NULL, '122-8-input-paymentDate', '2 dni', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(958960199737, 1056400312577, NULL, '120-8-input-emailExecution', 'admin@tomftb.pl', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(971866298828, 1056400312577, NULL, '156-9-header-shippingWarehouse', 'Adres magazynu wysyłkowego', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(988819775445, 1056400312577, NULL, '177-10-input-nameBank', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(992510105098, 1056400312577, NULL, '157-9-input-streetShippingWarehouse', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(992945631516, 485156859713, NULL, '172-9-input-teccom', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(996696093706, 485156859713, NULL, '089-6-header-offer', 'Zapytania ofertowe', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(997639881026, 1056400312577, NULL, '187-10-input-EDI', '0|Tak', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1001385823732, 485156859713, NULL, '168-9-input-tecdoc', '1|Nie', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1024957803277, 485156859713, NULL, '036-1-input-manufacturerDistributor', '1|Dystrybutorem', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1026212397258, 485156859713, NULL, '026-1-input-affiliatedEntity', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1031479212502, 1056400312577, NULL, '107-7-input-phoneCommerce', '+48888888888', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1037469889251, 485156859713, NULL, '122-8-input-paymentDate', '2 dni', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1040057555142, 485156859713, NULL, '130-8-input-warehouseCleaning', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1042135393788, 1056400312577, NULL, '195-10-input-productionWarehouse', '0|z magazynu', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1053640933603, 1056400312577, NULL, '100-7-header-commerce', 'Opiekun handlowy', 'h', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1055840567031, 485156859713, NULL, '087-5-input-emailTechnic', 'admin@tomftb.pl', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1056581587054, 485156859713, NULL, '177-10-input-nameBank', '', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1057927865627, 1056400312577, NULL, '030-1-input-countryInvoicingItem', 'PL', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1070919687383, 485156859713, NULL, '071-4-input-surnameTrade', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1071996506727, 1056400312577, NULL, '024-1-input-companyWWW', '127.0.0.1', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1081349241066, 485156859713, NULL, '082-5-input-surnameTechnic', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1088845494032, 485156859713, NULL, '109-7-input-emailCommerce', 'admin@tomftb.pl', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1089557825913, 485156859713, NULL, '083-5-input-positionTechnic', 'test', 'i', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `filled_form_field_question`
--

CREATE TABLE `filled_form_field_question` (
  `id` bigint NOT NULL,
  `id_filled_form_field` bigint NOT NULL,
  `id_form_field_question` bigint DEFAULT NULL,
  `name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
-- Zrzut danych tabeli `filled_form_field_question`
--

INSERT INTO `filled_form_field_question` (`id`, `id_filled_form_field`, `id_form_field_question`, `name`, `value`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(10234205304, 392517137680, NULL, '015-1-inputLabel-companyPostalCode', 'Kod pocztowy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(17127452811, 174636688044, NULL, '088-5-inputLabel-emailTechnic', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(27733760318, 405726387870, NULL, '017-1-inputLabel-companyCity', 'Miasto', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(28995666711, 54627372949, NULL, '129-8-inputLabel-logisticsBonus', 'Bonus logistyczny', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(34076576761, 906494742508, NULL, '039-1-inputLabel-cISO_9001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(44045059263, 178718986920, NULL, '041-1-inputLabel-cISO_14001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(47855263668, 1089557825913, NULL, '083-5-inputLabel-surnameTechnic', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(61565929227, 787195837217, NULL, '165-9-inputLabel-maintenanceBo', 'Czy firma urzymuje BO?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(71521863825, 197466542684, NULL, '169-9-inputLabel-tecdoc', 'Czy dostawca dostarcza numery TECDOC?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(77490915189, 936470924982, NULL, '017-1-inputLabel-companyCity', 'Miasto', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(77581536722, 2225281524, NULL, '049-1-inputLabel-cISO_45001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(78300158859, 638691695290, NULL, '006-0-inputLabel-positionFormAuthor', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(81579326053, 434935349292, NULL, '043-1-inputLabel-cOHSAS_18001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(90557993124, 432407012517, NULL, '047-1-inputLabel-cISO_27001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(92679321114, 39981457335, NULL, '125-8-inputLabel-guaranteeBonus', 'Bonus gwarancyjny', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(100264825596, 997639881026, NULL, '188-10-inputLabel-EDI', 'Czy firma wspiera EDI?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(101647162563, 248546984290, NULL, '119-8-inputLabel-phoneExecution', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(113743559682, 358750491734, NULL, '002-0-inputLabel-nameFormAuthor', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(113813319893, 142243538791, NULL, '151-8-inputLabel-expressDelivery', 'Wysyłki ekspresowe', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(132937046628, 762926136862, NULL, '133-8-inputLabel-complaintConsiderationPeriod', 'Termin rozpatrywania reklamacji', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(146034223384, 718515703668, NULL, '063-3-inputLabel-positionDirector', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(161779441896, 274264945367, NULL, '013-1-inputLabel-companyStreet', 'Ulica i numer', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(171508926678, 12504943053, NULL, '192-10-inputLabel-ESG', 'Czy firma wprowadziła zasady ESG?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(180967069243, 265414413341, NULL, '033-1-inputLabel-settlementCurrency', 'Walta rozliczenia', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(182509144914, 108743457827, NULL, '015-1-inputLabel-companyPostalCode', 'Kod pocztowy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(189033579888, 456267007601, NULL, '039-1-inputLabel-cISO_9001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(195132831811, 847036815592, NULL, '145-8-inputLabel-guaranteeTime', 'Czas gwarancji', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(205217969225, 435937887436, NULL, '076-4-inputLabel-phoneTrade', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(210091311303, 931782172964, NULL, '104-7-inputLabel-surnameCommerce', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(211422439074, 621428818750, NULL, '021-1-inputLabel-numberOfEmployeesCompany', 'Liczba pracowników', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(225819785647, 684034910027, NULL, '190-10-inputLabel-orderConfirm', 'Czy firma deklaruje potwierdzanie zamówień?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(238034875217, 706014282070, NULL, '013-1-inputLabel-companyStreet', 'Ulica i numer', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(239646774317, 897184334223, NULL, '059-3-inputLabel-nameDirector', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(244989154336, 592509811822, NULL, '061-3-inputLabel-surnameDirector', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(250579706680, 214813723274, NULL, '072-4-inputLabel-surnameTrade', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(250903670500, 407115080897, NULL, '081-5-inputLabel-nameTechnic', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(259122838632, 422920229212, NULL, '155-8-inputLabel-api', 'Czy firma udostępnia dane po API?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(285489694424, 519152220545, NULL, '113-8-inputLabel-nameExecution', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(290594447254, 958960199737, NULL, '121-8-inputLabel-emailExecution', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(290688290055, 625300650551, NULL, '102-7-inputLabel-nameCommerce', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(292347376967, 213623328595, NULL, '011-1-inputLabel-companyNIP', 'NIP', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(300920391570, 242564314792, NULL, '070-4-inputLabel-nameTrade', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(303569659939, 1031479212502, NULL, '108-7-inputLabel-phoneCommerce', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(307947654416, 1001385823732, NULL, '169-9-inputLabel-tecdoc', 'Czy dostawca dostarcza numery TECDOC?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(311788901195, 1057927865627, NULL, '031-1-inputLabel-countryInvoicingItem', 'Kraj fakturowania towaru', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(316209339977, 886347374357, NULL, '035-1-inputLabel-directSelling', 'Czy firma prowadzi sprzedaż bezpośrednią do klientów indywidualnych?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(317606621257, 706813461206, NULL, '043-1-inputLabel-cOHSAS_18001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(334553882133, 114391294618, NULL, '070-4-inputLabel-nameTrade', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(339745798784, 511742642267, NULL, '067-3-inputLabel-emailDirector', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(346532929379, 387577412041, NULL, '175-9-inputLabel-B2B', 'Czy firma posiada platformę B2B?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(348552322457, 895169267515, NULL, '198-10-inputLabel-catalogLink', 'Katalog link', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(349966134597, 958764655173, NULL, '123-8-inputLabel-paymentDate', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(352370231096, 364438409874, NULL, '063-3-inputLabel-positionDirector', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(353910635505, 374919747058, NULL, '163-9-inputLabel-invoiceFormat', 'Format faktur', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(357598807707, 1055840567031, NULL, '088-5-inputLabel-emailTechnic', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(358485665559, 492921928601, NULL, '200-10-inputLabel-bdoNumber', 'Numer BDO', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(361904977406, 25594278364, NULL, '158-9-inputLabel-streetShippingWarehouse', 'Ulica i numer', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(363857310298, 514836133885, NULL, '037-1-inputLabel-manufacturerDistributor', 'Czy firma jest producentem czy dystrybutorem?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(368529323426, 718883856997, NULL, '095-6-inputLabel-positionOffer', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(390396712097, 135426710418, NULL, '031-1-inputLabel-countryInvoicingItem', 'Kraj fakturowania towaru', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(393546145389, 444967467973, NULL, '173-9-inputLabel-teccom', 'Czy firma wspiera połączenie TECCOM?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(395526661678, 797679169281, NULL, '135-8-inputLabel-complaintsKind', 'Sposób rozpatrwania reklamacji', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(397070657050, 956583483420, NULL, '097-6-inputLabel-phoneOffer', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(400148065839, 647505659822, NULL, '141-8-inputLabel-priceListComments', 'Uwagi dot cennika', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(404519446216, 46672405547, NULL, '035-1-inputLabel-directSelling', 'Czy firma prowadzi sprzedaż bezpośrednią do klientów indywidualnych?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(410195484133, 342907412131, NULL, '004-0-inputLabel-surnameFormAuthor', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(436750056380, 408362141572, NULL, '097-6-inputLabel-phoneOffer', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(439069882958, 754125449157, NULL, '149-8-inputLabel-MOV', 'Czy MOV', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(440860145066, 680130195893, NULL, '167-9-inputLabel-boComments', 'Uwagi dot. BO', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(440897983875, 48689347188, NULL, '139-8-inputLabel-sharedPriceList', 'Czy dostawca dostarczył cennik?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(451168690155, 878699232854, NULL, '194-10-inputLabel-expirationDateProducts', 'Czy firma posiada w ofercie produkty z terminem ważności?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(459274315034, 279600703217, NULL, '143-8-inputLabel-creditLimit', 'Limit kredytowy u dostawcy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(477416059236, 87922793112, NULL, '049-1-inputLabel-cISO_45001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(478327482155, 85160167695, NULL, '184-10-inputLabel-accountNumberBank', 'Numer konta', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(482022449555, 1026212397258, NULL, '027-1-inputLabel-affiliatedEntity', 'Podmiot powiązany', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(482509774872, 164799768917, NULL, '078-4-inputLabel-emailTrade', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(485256853655, 655835995842, NULL, '051-1-inputLabel-cISO_50001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(488008603572, 719818411800, NULL, '076-4-inputLabel-phoneTrade', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(495163401851, 720525871084, NULL, '019-1-inputLabel-yearFoundationCompany', 'Rok założenia', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(500791856750, 78802740145, NULL, '074-4-inputLabel-positionTrade', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(504301511631, 1037469889251, NULL, '123-8-inputLabel-paymentDate', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(507531350258, 643370093154, NULL, '093-6-inputLabel-surnameOffer', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(509699945704, 153828074653, NULL, '115-8-inputLabel-surnameExecution', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(517130830598, 822826082369, NULL, '155-8-inputLabel-api', 'Czy firma udostępnia dane po API?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(523897200864, 1070919687383, NULL, '072-4-inputLabel-surnameTrade', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(525387827069, 1024957803277, NULL, '037-1-inputLabel-manufacturerDistributor', 'Czy firma jest producentem czy dystrybutorem?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(526592891285, 1071996506727, NULL, '025-1-inputLabel-companyWWW', 'Strona WWW', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(527807157812, 690268479644, NULL, '125-8-inputLabel-guaranteeBonus', 'Bonus gwarancyjny', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(531621159164, 409677690342, NULL, '202-10-inputLabel-text', 'Text', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(538044108515, 183797857134, NULL, '091-6-inputLabel-nameOffer', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(541748296653, 427088148237, NULL, '055-1-inputLabel-cSCC_VCA', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(563724821800, 1040057555142, NULL, '131-8-inputLabel-warehouseCleaning', '% zwrotu towaru - czyszczenie magazynu', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(570849611138, 237769282073, NULL, '127-8-inputLabel-marketingBonus', 'Bonus marketingowy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(575380287356, 574344721119, NULL, '153-8-inputLabel-hubShipping', 'Wysyłka HUB', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(581290128525, 945284634093, NULL, '186-10-inputLabel-skontoBank', 'Skonto', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(586215170758, 502715600859, NULL, '029-1-inputLabel-distributors', 'Dystrybutorzy powiązani', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(594213765999, 735536794962, NULL, '099-6-inputLabel-emailOffer', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(597763001037, 686361776202, NULL, '119-8-inputLabel-phoneExecution', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(598990439324, 777497392638, NULL, '200-10-inputLabel-bdoNumber', 'Numer BDO', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(612539496464, 1089557825913, NULL, '084-5-inputLabel-positionTechnic', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(616299507696, 915690117432, NULL, '065-3-inputLabel-phoneDirector', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(619239334959, 98391011016, NULL, '202-10-inputLabel-text', 'Text', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(619787878559, 893182499192, NULL, '171-9-inputLabel-tecdocCode', 'Kod dostawcy TECDOC', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(621856753864, 636379662612, NULL, '198-10-inputLabel-catalogLink', 'Katalog link', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(630786009091, 172463491998, NULL, '009-1-inputLabel-companyFullName', 'Pełna nazwa firmy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(633883856954, 502941746672, NULL, '190-10-inputLabel-orderConfirm', 'Czy firma deklaruje potwierdzanie zamówień?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(640244444491, 875401643638, NULL, '182-10-inputLabel-currencyBank', 'Waluta', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(644845540750, 424759753521, NULL, '153-8-inputLabel-hubShipping', 'Wysyłka HUB', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(647780959647, 820060210792, NULL, '078-4-inputLabel-emailTrade', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(649301940805, 930070983347, NULL, '051-1-inputLabel-cISO_50001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(654504447358, 933770910978, NULL, '149-8-inputLabel-MOV', 'Czy MOV', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(662279074000, 310268389112, NULL, '011-1-inputLabel-companyNIP', 'NIP', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(662409937555, 711119187656, NULL, '104-7-inputLabel-surnameCommerce', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(680641317430, 265302940274, NULL, '053-1-inputLabel-cISO_37001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(683636424812, 501746027966, NULL, '053-1-inputLabel-cISO_37001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(684281336409, 850767897923, NULL, '161-9-inputLabel-cityShippingWarehouse', 'Miasto', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(689731321284, 245648541432, NULL, '175-9-inputLabel-B2B', 'Czy firma posiada platformę B2B?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(691291090513, 663913209360, NULL, '147-8-inputLabel-warrantyTime', 'Warunki dostawcy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(692212401344, 785386432461, NULL, '023-1-inputLabel-shareCapitalCompany', 'Kapitał zakładowy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(696229363312, 101272606751, NULL, '159-9-inputLabel-postalCodeShippingWarehouse', 'Kod pocztowy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(705838292470, 716890732560, NULL, '002-0-inputLabel-nameFormAuthor', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(707364795782, 808293201967, NULL, '129-8-inputLabel-logisticsBonus', 'Bonus logistyczny', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(709120978348, 190459873318, NULL, '115-8-inputLabel-surnameExecution', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(715546155858, 674842669972, NULL, '108-7-inputLabel-phoneCommerce', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(718058928062, 584735080026, NULL, '021-1-inputLabel-numberOfEmployeesCompany', 'Liczba pracowników', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(731242437988, 568480041991, NULL, '171-9-inputLabel-tecdocCode', 'Kod dostawcy TECDOC', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(739491013030, 141838369031, NULL, '117-8-inputLabel-positionExecution', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(750373381594, 208609003335, NULL, '074-4-inputLabel-positionTrade', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(760377356202, 1088845494032, NULL, '110-7-inputLabel-emailCommerce', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(765448834861, 299694648994, NULL, '047-1-inputLabel-cISO_27001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(776367424102, 348102335629, NULL, '029-1-inputLabel-distributors', 'Dystrybutorzy powiązani', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(783857117911, 865198052561, NULL, '061-3-inputLabel-surnameDirector', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(783900870051, 708147427736, NULL, '139-8-inputLabel-sharedPriceList', 'Czy dostawca dostarczył cennik?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(786781213208, 941666244013, NULL, '121-8-inputLabel-emailExecution', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(789018668093, 888965319079, NULL, '167-9-inputLabel-boComments', 'Uwagi dot. BO', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(792137028596, 124416659932, NULL, '133-8-inputLabel-complaintConsiderationPeriod', 'Termin rozpatrywania reklamacji', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(801963406567, 170755485464, NULL, '106-7-inputLabel-positionCommerce', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(803350877971, 343100201814, NULL, '165-9-inputLabel-maintenanceBo', 'Czy firma urzymuje BO?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(803915575923, 900073181176, NULL, '099-6-inputLabel-emailOffer', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(808849546194, 515533464128, NULL, '065-3-inputLabel-phoneDirector', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(816208968246, 922852283124, NULL, '127-8-inputLabel-marketingBonus', 'Bonus marketingowy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(816490177798, 668909092110, NULL, '137-8-inputLabel-complaintsMail', 'Czy reklamacje rozpatrywane są mailowo?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(817442265429, 992945631516, NULL, '173-9-inputLabel-teccom', 'Czy firma wspiera połączenie TECCOM?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(831249727922, 530865044728, NULL, '182-10-inputLabel-currencyBank', 'Waluta', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(831623815125, 606502475456, NULL, '093-6-inputLabel-surnameOffer', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(831903828841, 938022030834, NULL, '081-5-inputLabel-nameTechnic', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(838902996953, 45663773702, NULL, '095-6-inputLabel-positionOffer', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(840802901342, 199147160909, NULL, '055-1-inputLabel-cSCC_VCA', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(840856580766, 669141816085, NULL, '151-8-inputLabel-expressDelivery', 'Wysyłki ekspresowe', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(845370213971, 850061779447, NULL, '084-5-inputLabel-positionTechnic', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(857689403633, 552274718104, NULL, '059-3-inputLabel-nameDirector', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(863546896447, 604583473138, NULL, '131-8-inputLabel-warehouseCleaning', '% zwrotu towaru - czyszczenie magazynu', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(870224208129, 253419561462, NULL, '091-6-inputLabel-nameOffer', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(888466025217, 614852139560, NULL, '023-1-inputLabel-shareCapitalCompany', 'Kapitał zakładowy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(899449811635, 50068015966, NULL, '102-7-inputLabel-nameCommerce', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(902402840895, 532305889737, NULL, '180-10-inputLabel-addressBank', 'Adres banku', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(902653558201, 840411915660, NULL, '196-10-inputLabel-productionWarehouse', 'Czy firma realizuje zamówienia z magazynu czy pod zamówienie klienta?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL);
INSERT INTO `filled_form_field_question` (`id`, `id_filled_form_field`, `id_form_field_question`, `name`, `value`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(903278794075, 554773563936, NULL, '143-8-inputLabel-creditLimit', 'Limit kredytowy u dostawcy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(903952253100, 608880423095, NULL, '019-1-inputLabel-yearFoundationCompany', 'Rok założenia', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(906530937614, 348098236544, NULL, '041-1-inputLabel-cISO_14001', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(909245619541, 1056581587054, NULL, '178-10-inputLabel-nameBank', 'Nazwa banku', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(912406545988, 850061779447, NULL, '083-5-inputLabel-surnameTechnic', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(921864819946, 918111666516, NULL, '045-1-inputLabel-cIATF_16949', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(922223064788, 775350603569, NULL, '194-10-inputLabel-expirationDateProducts', 'Czy firma posiada w ofercie produkty z terminem ważności?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(924403404305, 102430949118, NULL, '025-1-inputLabel-companyWWW', 'Strona WWW', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(931431611483, 881391933019, NULL, '045-1-inputLabel-cIATF_16949', 'Posiadany certyfikat', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(932146949678, 50725080736, NULL, '086-5-inputLabel-phoneTechnic', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(935111205084, 348747770657, NULL, '106-7-inputLabel-positionCommerce', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(939401567576, 864159323697, NULL, '113-8-inputLabel-nameExecution', 'Imię', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(955438619709, 197155075845, NULL, '009-1-inputLabel-companyFullName', 'Pełna nazwa firmy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(955552861662, 1042135393788, NULL, '196-10-inputLabel-productionWarehouse', 'Czy firma realizuje zamówienia z magazynu czy pod zamówienie klienta?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(957358466277, 988819775445, NULL, '178-10-inputLabel-nameBank', 'Nazwa banku', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(961070301310, 770123266318, NULL, '067-3-inputLabel-emailDirector', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(961469454432, 101272606751, NULL, '158-9-inputLabel-streetShippingWarehouse', 'Ulica i numer', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(968231021842, 264515960033, NULL, '086-5-inputLabel-phoneTechnic', 'Telefon', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(974151521525, 236886296403, NULL, '192-10-inputLabel-ESG', 'Czy firma wprowadziła zasady ESG?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(979755962060, 294704119512, NULL, '141-8-inputLabel-priceListComments', 'Uwagi dot cennika', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1000605363869, 250850509935, NULL, '147-8-inputLabel-warrantyTime', 'Warunki dostawcy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1012375811932, 166371402472, NULL, '137-8-inputLabel-complaintsMail', 'Czy reklamacje rozpatrywane są mailowo?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1014531289852, 155958570581, NULL, '027-1-inputLabel-affiliatedEntity', 'Podmiot powiązany', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1014570394335, 25594278364, NULL, '159-9-inputLabel-postalCodeShippingWarehouse', 'Kod pocztowy', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1016769966567, 717016518064, NULL, '186-10-inputLabel-skontoBank', 'Skonto', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1017160480034, 59563791075, NULL, '145-8-inputLabel-guaranteeTime', 'Czas gwarancji', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1023062333474, 779298191727, NULL, '117-8-inputLabel-positionExecution', 'Stanowisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1033155882574, 381591038593, NULL, '006-0-inputLabel-positionFormAuthor', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1045086686087, 561652031943, NULL, '161-9-inputLabel-cityShippingWarehouse', 'Miasto', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1054913449289, 233342362575, NULL, '135-8-inputLabel-complaintsKind', 'Sposób rozpatrwania reklamacji', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1057367273460, 629618628716, NULL, '180-10-inputLabel-addressBank', 'Adres banku', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1072472779553, 872391250860, NULL, '110-7-inputLabel-emailCommerce', 'Email', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1078458380526, 656111996955, NULL, '184-10-inputLabel-accountNumberBank', 'Numer konta', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1079436483471, 633065840469, NULL, '004-0-inputLabel-surnameFormAuthor', 'Nazwisko', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1092449747751, 25477764907, NULL, '033-1-inputLabel-settlementCurrency', 'Walta rozliczenia', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL),
(1095186421081, 252505488978, NULL, '163-9-inputLabel-invoiceFormat', 'Format faktur', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:15:13', '127.0.0.1', '0', NULL, NULL),
(1097675179592, 451252481134, NULL, '188-10-inputLabel-EDI', 'Czy firma wspiera EDI?', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', 1, 'aplikacjaFormularze', 'Aplikacja formularze', 'admin@tomftb.pl', '2023-08-16 14:55:23', '127.0.0.1', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form`
--

CREATE TABLE `form` (
  `id` int NOT NULL,
  `name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `department_id` int NOT NULL,
  `department_name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `form`
--

INSERT INTO `form` (`id`, `name`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`, `department_id`, `department_name`) VALUES
(1, 'Formularz dostawcy kwalifikowanego', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 09:04:45', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 09:05:43', '127.0.0.1', '0', NULL, NULL, 1, 'Marketing');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_chosen_stage`
--

CREATE TABLE `form_chosen_stage` (
  `id` bigint NOT NULL,
  `id_parent` int NOT NULL,
  `id_form_stage` bigint NOT NULL,
  `department_id` int NOT NULL,
  `department_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
-- Struktura tabeli dla tabeli `form_chosen_stage_row`
--

CREATE TABLE `form_chosen_stage_row` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `id_form_stage_row` bigint NOT NULL,
  `id_row` bigint DEFAULT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('text','input','select','checkbox','radio') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'text',
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
-- Struktura tabeli dla tabeli `form_chosen_stage_row_glossary`
--

CREATE TABLE `form_chosen_stage_row_glossary` (
  `id_row` bigint NOT NULL,
  `id_glossary` bigint NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_glossary_position` bigint NOT NULL,
  `position_name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_chosen_stage_row_property`
--

CREATE TABLE `form_chosen_stage_row_property` (
  `id_row` bigint NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_chosen_stage_row_style`
--

CREATE TABLE `form_chosen_stage_row_style` (
  `id_row` bigint NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_chosen_stage_section`
--

CREATE TABLE `form_chosen_stage_section` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `id_form_stage_section` bigint NOT NULL,
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
-- Struktura tabeli dla tabeli `form_chosen_stage_subsection`
--

CREATE TABLE `form_chosen_stage_subsection` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `id_form_stage_subsection` bigint NOT NULL,
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
-- Struktura tabeli dla tabeli `form_col`
--

CREATE TABLE `form_col` (
  `id` int NOT NULL,
  `id_parent` int NOT NULL,
  `type` enum('p','i','s','c','r','ta') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'p' COMMENT 'p - paragraph; i - input; s - select; c - checkbox; r - radio; tx - textarea',
  `order` int NOT NULL COMMENT 'display order',
  `at_main_page` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT 'show column at main list',
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
-- Zrzut danych tabeli `form_col`
--

INSERT INTO `form_col` (`id`, `id_parent`, `type`, `order`, `at_main_page`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(1, 2, 'i', 1, '1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:59:31', '127.0.0.1', '0', NULL, NULL),
(2, 2, 'i', 2, '1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:00:19', '127.0.0.1', '0', NULL, NULL),
(3, 3, 'i', 3, '1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:00:32', '127.0.0.1', '0', NULL, NULL),
(4, 5, 'i', 4, '1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:00:44', '127.0.0.1', '0', NULL, NULL),
(5, 6, 'i', 5, '1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:00:55', '127.0.0.1', '0', NULL, NULL),
(6, 6, 'i', 6, '1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:01:03', '127.0.0.1', '0', NULL, NULL),
(7, 7, 'i', 7, '1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:02:01', '127.0.0.1', '0', NULL, NULL),
(8, 7, 'i', 8, '1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:02:09', '127.0.0.1', '0', NULL, NULL),
(9, 8, 'i', 9, '1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:02:24', '127.0.0.1', '0', NULL, NULL),
(10, 8, 'i', 10, '1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:02:31', '127.0.0.1', '0', NULL, NULL),
(11, 9, 'i', 11, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:02:44', '127.0.0.1', '0', NULL, NULL),
(12, 9, 'i', 12, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:02:50', '127.0.0.1', '0', NULL, NULL),
(13, 10, 'i', 13, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:03:06', '127.0.0.1', '0', NULL, NULL),
(14, 10, 'i', 14, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:03:12', '127.0.0.1', '0', NULL, NULL),
(15, 11, 'p', 15, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:35:31', '127.0.0.1', '0', NULL, NULL),
(16, 12, 'i', 16, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:37:53', '127.0.0.1', '0', NULL, NULL),
(17, 13, 'i', 17, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:03', '127.0.0.1', '0', NULL, NULL),
(18, 14, 'i', 18, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:03', '127.0.0.1', '0', NULL, NULL),
(19, 15, 'i', 19, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:03', '127.0.0.1', '0', NULL, NULL),
(20, 16, 'i', 20, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:03', '127.0.0.1', '0', NULL, NULL),
(21, 17, 'i', 21, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(22, 18, 'i', 22, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(23, 19, 'i', 23, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(24, 20, 'i', 24, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(25, 21, 'i', 25, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(26, 22, 'i', 26, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(27, 23, 'i', 27, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(28, 24, 'i', 28, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(29, 25, 'i', 29, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(30, 26, 'i', 30, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(31, 27, 'i', 31, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(32, 28, 'i', 32, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(33, 29, 'i', 33, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(34, 30, 'i', 34, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(35, 31, 'i', 35, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(36, 32, 'i', 36, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(37, 33, 'i', 37, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(38, 34, 'i', 38, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(39, 35, 'i', 39, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(40, 36, 'i', 40, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(41, 37, 'i', 41, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:04', '127.0.0.1', '0', NULL, NULL),
(42, 38, 'i', 42, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(43, 39, 'i', 43, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(44, 40, 'i', 44, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(45, 41, 'i', 45, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(46, 42, 'i', 46, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(47, 43, 'i', 47, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(48, 44, 'i', 48, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(49, 45, 'i', 49, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:08', '127.0.0.1', '0', NULL, NULL),
(50, 46, 'i', 50, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(51, 47, 'i', 51, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(52, 48, 'i', 52, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(53, 49, 'i', 53, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(54, 50, 'i', 54, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(55, 51, 'i', 55, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(56, 52, 'i', 56, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(57, 53, 'i', 57, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(58, 54, 'i', 58, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:31', '127.0.0.1', '0', NULL, NULL),
(59, 55, 'i', 59, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(60, 56, 'i', 60, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(61, 57, 'i', 61, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(62, 58, 'i', 62, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(63, 59, 'i', 63, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(64, 60, 'i', 64, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(65, 61, 'i', 65, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(66, 62, 'i', 66, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(67, 63, 'i', 67, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(68, 64, 'i', 68, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(69, 65, 'i', 69, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(70, 66, 'i', 70, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(71, 67, 'i', 71, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(72, 68, 'i', 72, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(73, 69, 'i', 73, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(74, 70, 'i', 74, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(75, 71, 'i', 75, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:32', '127.0.0.1', '0', NULL, NULL),
(76, 72, 'i', 76, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:48', '127.0.0.1', '0', NULL, NULL),
(77, 73, 'i', 77, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:48', '127.0.0.1', '0', NULL, NULL),
(78, 74, 'i', 78, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:48', '127.0.0.1', '0', NULL, NULL),
(79, 75, 'i', 79, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:58', '127.0.0.1', '0', NULL, NULL),
(80, 76, 'i', 80, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(81, 77, 'i', 81, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(82, 78, 'i', 82, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(83, 79, 'i', 83, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(84, 80, 'i', 84, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(85, 81, 'i', 85, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(86, 82, 'i', 86, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(87, 83, 'i', 87, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(88, 84, 'i', 88, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(89, 85, 'i', 89, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(90, 86, 'i', 90, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(91, 87, 'i', 91, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(92, 88, 'i', 92, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(93, 89, 'i', 93, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(94, 90, 'i', 94, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(95, 91, 'i', 95, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL),
(96, 92, 'i', 96, '0', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 15:38:59', '127.0.0.1', '0', NULL, NULL);

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
-- Zrzut danych tabeli `form_col_property`
--

INSERT INTO `form_col_property` (`id`, `id_parent`, `property`, `value`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(1, 1, 'label', 'Imię', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:08:32', '127.0.0.1', '0', NULL, NULL),
(2, 2, 'label', 'Nazwisko', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:09:18', '127.0.0.1', '0', NULL, NULL),
(3, 3, 'label', 'Stanowisko', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:10:31', '127.0.0.1', '0', NULL, NULL),
(4, 4, 'label', 'Pełna nazwa firmy', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 15:11:32', '127.0.0.1', '0', NULL, NULL),
(5, 5, 'label', '*NIP', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-21 08:03:47', '127.0.0.1', '0', NULL, NULL),
(6, 6, 'label', '*Ulica i numer', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-21 08:06:30', '127.0.0.1', '0', NULL, NULL),
(7, 7, 'label', '*Kod pocztowy', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-21 08:06:40', '127.0.0.1', '0', NULL, NULL),
(8, 8, 'label', '*Miasto', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-21 08:07:01', '127.0.0.1', '0', NULL, NULL),
(9, 9, 'label', '*Rok założenia', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-21 08:07:08', '127.0.0.1', '0', NULL, NULL),
(10, 10, 'label', '*Liczba pracowników', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-21 08:07:18', '127.0.0.1', '0', NULL, NULL),
(11, 11, 'label', 'Kapitał zakładowy', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-21 08:11:33', '127.0.0.1', '0', NULL, NULL),
(12, 12, 'label', '*Strona WWW', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-21 08:11:33', '127.0.0.1', '0', NULL, NULL),
(13, 13, 'label', 'Podmiot powiązany', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-21 08:11:33', '127.0.0.1', '0', NULL, NULL),
(14, 14, 'label', '*Dystrybutorzy w PL', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-21 08:11:33', '127.0.0.1', '0', NULL, NULL),
(15, 15, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:19', '127.0.0.1', '0', NULL, NULL),
(16, 16, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(17, 17, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(18, 18, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(19, 19, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(20, 20, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(21, 21, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(22, 22, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:28', '127.0.0.1', '0', NULL, NULL),
(23, 23, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(24, 24, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(25, 25, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(26, 26, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(27, 27, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(28, 28, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(29, 29, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(30, 30, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(31, 31, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(32, 32, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(33, 33, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(34, 34, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(35, 35, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(36, 36, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(37, 37, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(38, 38, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(39, 39, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(40, 40, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(41, 41, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(42, 42, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(43, 43, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(44, 44, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(45, 45, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(46, 46, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(47, 47, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(48, 48, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(49, 49, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(50, 50, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(51, 51, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(52, 52, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(53, 53, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(54, 54, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(55, 55, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(56, 56, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(57, 57, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(58, 58, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(59, 59, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(60, 60, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(61, 61, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(62, 62, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(63, 63, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(64, 64, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(65, 65, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(66, 66, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(67, 67, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(68, 68, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(69, 69, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(70, 70, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(71, 71, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(72, 72, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(73, 73, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(74, 74, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(75, 75, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(76, 76, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(77, 77, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(78, 78, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(79, 79, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(80, 80, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(81, 81, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(82, 82, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(83, 83, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(84, 84, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(85, 85, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(86, 86, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(87, 87, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(88, 88, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(89, 89, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(90, 90, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(91, 91, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(92, 92, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(93, 93, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(94, 94, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(95, 95, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL),
(96, 96, 'label', '-UPDATE-', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-21 08:01:56', '127.0.0.1', 1, 'admin', 'Admin', 't.borczynski87@gmail.com', '2023-08-22 15:49:38', '127.0.0.1', '0', NULL, NULL);

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
-- Zrzut danych tabeli `form_row`
--

INSERT INTO `form_row` (`id`, `id_parent`, `type`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(1, 1, 'h', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:46:41', '127.0.0.1', '0', NULL, NULL),
(2, 1, 'i', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:47:35', '127.0.0.1', '0', NULL, NULL),
(3, 1, 'i', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:48:09', '127.0.0.1', '0', NULL, NULL),
(4, 1, 'h', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(5, 1, 'i', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(6, 1, 'i', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(7, 1, 'i', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(8, 1, 'i', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(9, 1, 'i', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(10, 1, 'i', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(11, 1, 'i', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:48:36', '127.0.0.1', '0', NULL, NULL),
(12, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:33', '127.0.0.1', '0', NULL, NULL),
(13, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(14, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(15, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(16, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(17, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(18, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(19, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(20, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(21, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(22, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(23, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(24, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(25, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(26, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(27, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(28, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(29, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(30, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(31, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(32, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(33, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(34, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(35, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(36, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(37, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(38, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(39, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(40, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(41, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(42, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(43, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(44, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(45, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(46, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:49', '127.0.0.1', '0', NULL, NULL),
(47, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(48, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(49, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(50, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(51, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(52, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(53, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(54, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(55, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(56, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(57, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(58, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(59, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(60, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(61, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(62, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(63, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(64, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(65, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(66, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(67, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(68, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(69, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(70, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(71, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(72, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(73, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(74, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(75, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(76, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(77, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(78, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(79, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(80, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(81, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(82, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(83, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(84, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(85, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(86, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(87, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(88, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(89, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(90, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(91, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL),
(92, 1, 'p', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-18 14:45:54', '127.0.0.1', 1, 'admin', 'Admin', 'admin@tomftb.pl', '2023-08-22 13:56:50', '127.0.0.1', '0', NULL, NULL);

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
-- Struktura tabeli dla tabeli `form_stage`
--

CREATE TABLE `form_stage` (
  `id` bigint NOT NULL,
  `department_id` int NOT NULL,
  `department_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
  `buffer_user_id` int DEFAULT NULL,
  `hide_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `hide_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hide_date` datetime DEFAULT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `form_stage`
--

INSERT INTO `form_stage` (`id`, `department_id`, `department_name`, `title`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `buffer_user_id`, `hide_status`, `hide_reason`, `hide_date`, `delete_status`, `delete_reason`, `delete_date`) VALUES
(1, 1, 'Marketing', 'text', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 07:59:44', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 07:59:44', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_stage_row`
--

CREATE TABLE `form_stage_row` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `id_row` bigint DEFAULT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('text','input','select','checkbox','radio') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'text',
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
-- Zrzut danych tabeli `form_stage_row`
--

INSERT INTO `form_stage_row` (`id`, `id_parent`, `id_row`, `value`, `name`, `type`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_reason`, `delete_date`) VALUES
(1, 1, NULL, 'test', '7516_text', 'text', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 07:59:44', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 07:59:44', '127.0.0.1', '0', NULL, NULL),
(2, 1, NULL, '', '516138_input', 'input', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 07:59:44', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 07:59:44', '127.0.0.1', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_stage_row_glossary`
--

CREATE TABLE `form_stage_row_glossary` (
  `id_row` bigint NOT NULL,
  `id_glossary` bigint NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_glossary_position` bigint NOT NULL,
  `position_name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_stage_row_property`
--

CREATE TABLE `form_stage_row_property` (
  `id_row` bigint NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `form_stage_row_property`
--

INSERT INTO `form_stage_row_property` (`id_row`, `name`, `value`) VALUES
(1, 'type', 'text'),
(2, 'type', 'text');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_stage_row_style`
--

CREATE TABLE `form_stage_row_style` (
  `id_row` bigint NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_stage_section`
--

CREATE TABLE `form_stage_section` (
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
-- Zrzut danych tabeli `form_stage_section`
--

INSERT INTO `form_stage_section` (`id`, `id_parent`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_reason`, `delete_date`) VALUES
(1, 1, 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 07:59:44', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 07:59:44', '127.0.0.1', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form_stage_subsection`
--

CREATE TABLE `form_stage_subsection` (
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
-- Zrzut danych tabeli `form_stage_subsection`
--

INSERT INTO `form_stage_subsection` (`id`, `id_parent`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_reason`, `delete_date`) VALUES
(1, 1, 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 07:59:44', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 07:59:44', '127.0.0.1', '0', NULL, NULL);

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
-- Struktura tabeli dla tabeli `glossary`
--

CREATE TABLE `glossary` (
  `id` bigint NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
  `buffer_user_id` int DEFAULT NULL,
  `hide_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `hide_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hide_date` datetime DEFAULT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `glossary`
--

INSERT INTO `glossary` (`id`, `name`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `buffer_user_id`, `hide_status`, `hide_reason`, `hide_date`, `delete_status`, `delete_reason`, `delete_date`) VALUES
(1, 'Kraj', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 11:18:34', '127.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 11:19:43', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(2, 'Waluta rozliczenia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:31:13', '127.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:23', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(3, 'Kraj fakturowania towaru', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:58:36', '127.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:59:27', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(4, 'Waluta', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:58:36', '127.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:59:58', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `glossary_position`
--

CREATE TABLE `glossary_position` (
  `id` bigint NOT NULL,
  `id_glossary` bigint NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
  `buffer_user_id` int DEFAULT NULL,
  `hide_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `hide_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hide_date` datetime DEFAULT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `glossary_position`
--

INSERT INTO `glossary_position` (`id`, `id_glossary`, `name`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `buffer_user_id`, `hide_status`, `hide_reason`, `hide_date`, `delete_status`, `delete_reason`, `delete_date`) VALUES
(1, 1, 'PL', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 11:21:17', '127.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 11:22:08', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(2, 1, 'EN', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 11:21:17', '127.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 11:22:19', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(3, 1, 'DE', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 11:21:17', '127.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 11:22:30', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(4, 2, 'AFN - Afgani', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(5, 2, 'ALL - Lek', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(6, 2, 'DZD - Dinar algierski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(7, 2, 'EUR - Euro', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(8, 2, 'AOA - Kwanza', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(9, 2, 'XCD - Dolar wschodniokaraibski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(10, 2, 'SAR - Rial saudyjski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(11, 2, 'ARS - Peso Argentyńskie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(12, 2, 'AMD - Dram', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(13, 2, 'AWG - Florin arubański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(14, 2, 'AUD - Dolar Australijski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(15, 2, 'AZN - Manat Azerbejdżański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(16, 2, 'BSD - Dolar Bahamski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(17, 2, 'BHD - Dinar bahrajński', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(18, 2, 'BDT - Taka', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(19, 2, 'BBD - Dolar Barbadosu', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(20, 2, 'BZD - Dolar Belizeński', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(21, 2, 'XOF - CFA Frank BCEAO', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(22, 2, 'BMD - Dolar Bermudzki', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(23, 2, 'BTN - Ngultrum', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(24, 2, 'INR - Rupia indyjska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(25, 2, 'BYR - Rubel białoruski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(26, 2, 'BOB - Boliviano', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(27, 2, 'BOV - Mvdol', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(28, 2, 'BWP - Pula', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(29, 2, 'BAM - Marka Zamienna', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(30, 2, 'BRL - Real Brazylijski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(31, 2, 'BND - Dolar Brunejski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(32, 2, 'USD - Amerykański Dolar', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(33, 2, 'BIF - Frank Burundyjski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(34, 2, 'BGN - Lew', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(35, 2, 'MKD - Denar Macedoński', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(36, 2, 'CLF - Chilijska Unidad de Fomentos', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(37, 2, 'CLP - Peso Chilijskie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(38, 2, 'CNY - Renminbi', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(39, 2, 'HRK - Kuna', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(40, 2, 'ANG - Gulden antylski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(41, 2, 'XAF - CFA Frank BEAC', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(42, 2, 'CZK - Korona Czeska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(43, 2, 'DKK - Korona Duńska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(44, 2, 'CDF - Frank Kongijski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(45, 2, 'DJF - Frank dżibutyjski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(46, 2, 'EGP - Funt Egipski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(47, 2, 'ERN - Nakfa', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(48, 2, 'SZL - Lilangeni', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(49, 2, 'ETB - Birr', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(50, 2, 'FKP - Funt Falklandzki', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(51, 2, 'FJD - Dolar Fidżi', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(52, 2, 'PHP - Peso filipińskie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(53, 2, 'GMD - Dalasi', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(54, 2, 'GEL - Lari', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(55, 2, 'GHS - Cedi', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(56, 2, 'GIP - Funt Gibraltarski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(57, 2, 'GYD - Dolar Gujański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(58, 2, 'GTQ - Quetzal', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(59, 2, 'GNF - Frank gwinejski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(60, 2, 'HTG - Gourde', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(61, 2, 'HNL - Lempira', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(62, 2, 'HKD - Dolar hongkoński', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(63, 2, 'IDR - Rupia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(64, 2, 'IQD - Dinar Iracki', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(65, 2, 'IRR - Rial irański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(66, 2, 'ISK - Korona islandzka', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(67, 2, 'ILS - Nowy Szekel', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(68, 2, 'JMD - Dolar Jamajski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(69, 2, 'JPY - Jen', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(70, 2, 'YER - Rial jemeński', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(71, 2, 'GBP - Brytyjski funt szterling', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(72, 2, 'JOD - Dinar jordański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(73, 2, 'KYD - Dolar Kajmański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(74, 2, 'KHR - Riel kambodżański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(75, 2, 'CAD - Kanadyjski Dolar', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(76, 2, 'QAR - Rial katarski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(77, 2, 'KZT - Tenge', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(78, 2, 'KES - Szyling kenijski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(79, 2, 'KGS - Som', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(80, 2, 'COP - Peso kolumbijskie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(81, 2, 'KMF - Frank Komoryjski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(82, 2, 'KPW - Won północnokoreański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(83, 2, 'KRW - Won', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(84, 2, 'CRC - Colón', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(85, 2, 'CUC - Peso Kubańskie Wymienialne', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(86, 2, 'CUP - Peso Kubańskie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(87, 2, 'KWD - Dinar kuwejcki', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(88, 2, 'LAK - Kip', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(89, 2, 'LSL - Loti', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(90, 2, 'ZAR - Rand', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(91, 2, 'LBP - Funt Libański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(92, 2, 'LRD - Dolar liberyjski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(93, 2, 'LYD - Dinar Libijski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(94, 2, 'CHF - Frank szwajcarski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(95, 2, 'MGA - Ariary', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(96, 2, 'MOP - Pataca', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(97, 2, 'MWK - Kwacha zambijska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(98, 2, 'MVR - Rupia malediwska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(99, 2, 'MYR - Ringgit', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(100, 2, 'MAD - Dirham marokański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(101, 2, 'MRU - Ugija', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(102, 2, 'MUR - Rupia maurytyjska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(103, 2, 'MXN - Peso Meksykańskie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(104, 2, 'MMK - Kiat', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(105, 2, 'MNT - Tugrik', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(106, 2, 'MZN - Metical', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(107, 2, 'MDL - Lej mołdawski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(108, 2, 'NAD - Dolar namibijski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(109, 2, 'NPR - Rupia nepalska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(110, 2, 'NGN - Naira', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(111, 2, 'NIO - Córdoba', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(112, 2, 'NZD - Dolar Nowozelandzki', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(113, 2, 'NOK - Korona Norweska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(114, 2, 'XPF - Frank CFP', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(115, 2, 'OMR - Rial omański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(116, 2, 'PKR - Rupia pakistańska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(117, 2, 'PAB - Balboa', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(118, 2, 'PGK - Kina', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(119, 2, 'PYG - Guarani', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(120, 2, 'PEN - Sol', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(121, 2, 'PLN - Złoty', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(122, 2, 'DOP - Peso dominikańskie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(123, 2, 'RUB - Rubel rosyjski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(124, 2, 'RON - Lej', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(125, 2, 'RWF - Frank rwandyjski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(126, 2, 'SVC - Colón salwadorski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(127, 2, 'WST - Tala', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(128, 2, 'RSD - Dinar serbski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(129, 2, 'SCR - Rupia seszelska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(130, 2, 'SLL - Leone', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(131, 2, 'SGD - Dolar singapurski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(132, 2, 'XSU - Sucre', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(133, 2, 'SOS - Szyling somalijski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(134, 2, 'LKR - Rupia lankijska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(135, 2, 'SDG - Funt sudański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(136, 2, 'SSP - Funt południowosudański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(137, 2, 'SRD - Dolar surinamski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(138, 2, 'SYP - Funt syryjski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(139, 2, 'CHE - WIR Euro', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(140, 2, 'CHW - WIR Frank', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(141, 2, 'SEK - Korona szwedzka', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(142, 2, 'TJS - Somoni', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(143, 2, 'THB - Bat', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(144, 2, 'TWD - Dolar tajwański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(145, 2, 'TZS - Szyling tanzański', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(146, 2, 'TOP - Paanga', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(147, 2, 'TTD - Dolar Trynidadu i Tobago', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(148, 2, 'TND - Dinar tunezyjski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(149, 2, 'TRY - Lira turecka', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(150, 2, 'TMT - Manat turkmeński', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(151, 2, 'UGX - Szyling ugandyjski', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(152, 2, 'UAH - Hrywna', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(153, 2, 'UYU - Peso urugwajskie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(154, 2, 'UZS - Sum', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(155, 2, 'VUV - Vatu', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(156, 2, 'VEF - Boliwar', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(157, 2, 'VND - Dong', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(158, 2, 'SHP - Funt Świętej Heleny', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(159, 2, 'SBD - Dolar Wysp Salomona', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(160, 2, 'CVE - Escudo Republiki Zielonego Przylądka', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(161, 2, 'STN - Dobra', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(162, 2, 'HUF - Forint', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(163, 2, 'ZMW - Kwacha zambijska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(164, 2, 'ZWL - Dolar Zimbabwe', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(165, 2, 'AED - UAE Dirham', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:56:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(166, 3, 'Afganistan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(167, 3, 'Albania', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(168, 3, 'Algieria', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(169, 3, 'Andora', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(170, 3, 'Angola', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(171, 3, 'Anguilla', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(172, 3, 'Antarktyda', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(173, 3, 'Antigua i Barbuda', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(174, 3, 'Arabia Saudyjska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(175, 3, 'Argentyna', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(176, 3, 'Armenia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(177, 3, 'Aruba', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(178, 3, 'Australia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(179, 3, 'Austria', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(180, 3, 'Azerbejdżan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(181, 3, 'Bahamy', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(182, 3, 'Bahrajn', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(183, 3, 'Bangladesz', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(184, 3, 'Barbados', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(185, 3, 'Belgia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(186, 3, 'Belize', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(187, 3, 'Benin', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(188, 3, 'Bermudy', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(189, 3, 'Bhutan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(190, 3, 'Białoruś', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(191, 3, 'Boliwia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(192, 3, 'Bonaire, Sint Eustatius i Saba', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(193, 3, 'Bośnia i Hercegowina', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(194, 3, 'Botswana', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(195, 3, 'Brazylia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(196, 3, 'Brunei Darussalam', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(197, 3, 'Brytyjskie Terytorium Oceanu Indyjskiego', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(198, 3, 'Bułgaria', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(199, 3, 'Burkina Faso', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:22', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(200, 3, 'Burundi', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(201, 3, 'Ceuta', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(202, 3, 'Chile', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(203, 3, 'Chiny', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(204, 3, 'Curaçao', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(205, 3, 'Chorwacja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(206, 3, 'Cypr', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(207, 3, 'Czad', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(208, 3, 'Czarnogóra', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(209, 3, 'Czechy', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(210, 3, 'Dania', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(211, 3, 'Dominika', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(212, 3, 'Dominikana', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(213, 3, 'Dżibuti', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(214, 3, 'Egipt', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(215, 3, 'Ekwador', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(216, 3, 'Erytrea', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL);
INSERT INTO `glossary_position` (`id`, `id_glossary`, `name`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `buffer_user_id`, `hide_status`, `hide_reason`, `hide_date`, `delete_status`, `delete_reason`, `delete_date`) VALUES
(217, 3, 'Estonia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(218, 3, 'Etiopia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(219, 3, 'Falklandy', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(220, 3, 'Fidżi Republika', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(221, 3, 'Filipiny', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(222, 3, 'Finlandia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(223, 3, 'Francuskie Terytorium Południowe', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(224, 3, 'Francja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(225, 3, 'Gabon', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(226, 3, 'Gambia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(227, 3, 'Ghana', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(228, 3, 'Gibraltar', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(229, 3, 'Grecja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(230, 3, 'Grenada', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(231, 3, 'Grenlandia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(232, 3, 'Gruzja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(233, 3, 'Guam', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(234, 3, 'Gujana', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(235, 3, 'Gwatemala', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(236, 3, 'Gwinea', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(237, 3, 'Gwinea Równikowa', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(238, 3, 'Gwinea-Bissau', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(239, 3, 'Haiti', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(240, 3, 'Hiszpania', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(241, 3, 'Honduras', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(242, 3, 'Hongkong', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(243, 3, 'Indie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(244, 3, 'Indonezja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(245, 3, 'Irak', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(246, 3, 'Iran', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(247, 3, 'Irlandia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(248, 3, 'Islandia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(249, 3, 'Izrael', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(250, 3, 'Jamajka', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(251, 3, 'Japonia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(252, 3, 'Jemen', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(253, 3, 'Jordania', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(254, 3, 'Kajmany', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(255, 3, 'Kambodża', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(256, 3, 'Kamerun', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(257, 3, 'Kanada', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(258, 3, 'Katar', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(259, 3, 'Kazachstan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(260, 3, 'Kenia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(261, 3, 'Kirgistan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(262, 3, 'Kiribati', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(263, 3, 'Kolumbia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(264, 3, 'Komory', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(265, 3, 'Kongo', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(266, 3, 'Kongo, Republika Demokratyczna', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(267, 3, 'Koreańska Republika Ludowo-Demokratyczna', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(268, 3, 'Kosowo', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(269, 3, 'Kostaryka', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(270, 3, 'Kuba', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(271, 3, 'Kuwejt', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(272, 3, 'Laos', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(273, 3, 'Lesotho', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(274, 3, 'Liban', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(275, 3, 'Liberia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(276, 3, 'Libia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(277, 3, 'Liechtenstein', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(278, 3, 'Litwa', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(279, 3, 'Luksemburg', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(280, 3, 'Łotwa', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(281, 3, 'Macedonia Północna', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(282, 3, 'Madagaskar', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(283, 3, 'Majotta', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(284, 3, 'Makau', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(285, 3, 'Malawi', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(286, 3, 'Malediwy', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(287, 3, 'Malezja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(288, 3, 'Mali', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(289, 3, 'Malta', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(290, 3, 'Mariany Północne', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:23', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(291, 3, 'Maroko', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(292, 3, 'Mauretania', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(293, 3, 'Mauritius', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(294, 3, 'Meksyk', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(295, 3, 'Melilla', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(296, 3, 'Mikronezja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(297, 3, 'Minor (Powiernicze Wyspy Pacyfiku Stanów Zjednoczonych)', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(298, 3, 'Mołdawia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(299, 3, 'Mongolia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(300, 3, 'Montserrat', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(301, 3, 'Mozambik', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(302, 3, 'Myanmar (Burma)', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(303, 3, 'Namibia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(304, 3, 'Nauru', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(305, 3, 'Nepal', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(306, 3, 'Niderlandy', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(307, 3, 'Niemcy', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(308, 3, 'Niger', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(309, 3, 'Nigeria', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(310, 3, 'Nikaragua', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(311, 3, 'Niue', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(312, 3, 'Norfolk', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(313, 3, 'Norwegia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(314, 3, 'Nowa Kaledonia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(315, 3, 'Nowa Zelandia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(316, 3, 'Okupowane Terytorium Palestyny', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(317, 3, 'Oman', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(318, 3, 'Pakistan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(319, 3, 'Palau', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(320, 3, 'Panama', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(321, 3, 'Papua Nowa Gwinea', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(322, 3, 'Paragwaj', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(323, 3, 'Peru', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(324, 3, 'Pitcairn', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(325, 3, 'Polinezja Francuska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(326, 3, 'Polska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(327, 3, 'Południowa Afryka', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(328, 3, 'Południowa Georgia i Południowe Wyspy Sandwich', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(329, 3, 'Portugalia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(330, 3, 'Republika Korei', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(331, 3, 'Rep.Środkowoafryańska', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(332, 3, 'Rosja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(333, 3, 'Rwanda', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(334, 3, 'Sahara Zachodnia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(335, 3, 'Saint Barthelemy', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(336, 3, 'Rumunia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(337, 3, 'Salwador', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(338, 3, 'Samoa', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(339, 3, 'Samoa Amerykańskie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(340, 3, 'San Marino', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(341, 3, 'Senegal', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(342, 3, 'Serbia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(343, 3, 'Seszele', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(344, 3, 'Sierra Leone', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(345, 3, 'Singapur', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(346, 3, 'Suazi', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(347, 3, 'Słowacja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(348, 3, 'Słowenia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(349, 3, 'Somalia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(350, 3, 'Sri Lanka', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(351, 3, 'St. Pierre i Miquelon', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(352, 3, 'St.Kitts i Nevis', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(353, 3, 'St.Lucia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(354, 3, 'St.Vincent i Grenadyny', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(355, 3, 'Stany Zjedn. Ameryki', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(356, 3, 'Sudan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(357, 3, 'Sudan Południowy', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(358, 3, 'Surinam', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(359, 3, 'Syria', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(360, 3, 'Szwajcaria', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(361, 3, 'Szwecja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(362, 3, 'Święta Helena', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(363, 3, 'Tadżykistan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(364, 3, 'Tajlandia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(365, 3, 'Tajwan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(366, 3, 'Tanzania', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(367, 3, 'Togo', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(368, 3, 'Tokelau', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(369, 3, 'Tonga', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(370, 3, 'Trynidad i Tobago', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(371, 3, 'Tunezja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(372, 3, 'Turcja', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(373, 3, 'Turkmenistan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(374, 3, 'Wyspy Turks i Caicos', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(375, 3, 'Tuvalu', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(376, 3, 'Uganda', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:24', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(377, 3, 'Ukraina', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(378, 3, 'Urugwaj', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(379, 3, 'Uzbekistan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(380, 3, 'Vanuatu', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(381, 3, 'Wallis i Futuna', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(382, 3, 'Watykan', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(383, 3, 'Wenezuela', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(384, 3, 'Węgry', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(385, 3, 'Wielka Brytania', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(386, 3, 'Wietnam', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(387, 3, 'Włochy', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(388, 3, 'Wschodni Timor', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(389, 3, 'Wyb.Kości Słoniowej', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(390, 3, 'Wyspa Bouveta', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(391, 3, 'Wyspa Bożego Narodzenia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(392, 3, 'Wyspy Cooka', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(393, 3, 'Wyspy Dziewicze-USA', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(394, 3, 'Wyspy Dziewicze-W.B', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(395, 3, 'Wyspy Heard i McDonald', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(396, 3, 'Wyspy Kokosowe (Keelinga)', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(397, 3, 'Wyspy Owcze', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(398, 3, 'Wyspy Marshalla', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(399, 3, 'Wyspy Salomona', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(400, 3, 'Wyspa Sint Maarten (część holenderska wyspy)', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(401, 3, 'Wyspy Św.Tomasza i Książęca', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(402, 3, 'Zambia', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(403, 3, 'Zielony Przylądek', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(404, 3, 'Zimbabwe', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(405, 3, 'Zjedn.Emiraty Arabskie', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(406, 3, 'Zjednoczone Królestwo (Irlandia Północna)', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 12:32:31', '12.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:25', '12.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(409, 4, 'PLN', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:48', '127.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:10:52', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(410, 4, 'EUR', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:08:48', '127.0.0.1', 1, 'admin', 'Admin', 'tborczynski@tomftb.pl', '2023-09-28 13:10:52', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klaster`
--

CREATE TABLE `klaster` (
  `id` int NOT NULL,
  `nod` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pracownia` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `parametry`
--

CREATE TABLE `parametry` (
  `ID` int NOT NULL,
  `SKROT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAZWA` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `OPIS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WARTOSC` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TYP` enum('t','p','s','c','a','n','sc','sa','sf','sm','sl','slm') CHARACTER SET utf8mb3 COLLATE utf8mb3_polish_ci NOT NULL COMMENT 't - text, p - password,n - number,s - select, c - checkbox,sc - slo color, sa - text align, sf - font family, sm - font measurement, sl - list style, slm - list style measurement',
  `MOD_USER_ID` int NOT NULL,
  `MOD_USER` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MOD_DAT` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MOD_LOGIN` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `MOD_HOST` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `parametry`
--

INSERT INTO `parametry` (`ID`, `SKROT`, `NAZWA`, `OPIS`, `WARTOSC`, `TYP`, `MOD_USER_ID`, `MOD_USER`, `MOD_DAT`, `MOD_LOGIN`, `MOD_HOST`) VALUES
(1, 'STAGE_LIST_DEFAULT_LVL', 'Etapy projektu - lista - domyślny poziom listy', '1', '1', 'n', 1, ' Admin', '2025-10-31 12:07:42', 'admin', '127.0.0.1'),
(2, 'STAGE_LIST_MAX_LVL', 'Etapy projektu - lista - maksymalny poziom listy', '7', '7', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(3, 'STAGE_LIST_INDENTATION', 'Etapy projektu - lista - domyślna wartość wcięcia', '1', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(4, 'STAGE_LIST_INDENTATION_MEASUREMENT', 'Etapy projektu - lista - domyślna wartość miary wcięcia', '', 'px', 'slm', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(5, 'STAGE_LIST_EJECTION', 'Etapy projektu - lista - domyślna wartość wysunięcia', '1', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(6, 'STAGE_LIST_EJECTION_MEASUREMENT', 'Etapy projektu - lista - domyślna wartość miary wysunięcia', '1', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(7, 'STAGE_LIST_MARGIN_LEFT', 'Etapy projektu - lista - lewy margines', '1', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(8, 'STAGE_LIST_MARGIN_RIGHT', 'Etapy projektu - lista - prawy margines', '1', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(9, 'STAGE_LIST_MARGIN_TOP', 'Etapy projektu - lista - górny margines', '1', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(10, 'STAGE_LIST_MARGIN_BOTTOM', 'Etapy projektu - lista - dony margines', '1', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(11, 'STAGE_LIST_COLOR', 'Acid Green', 'Acid Green1', '#B0BF1A', 'sc', 1, 'admin', '2025-10-29 14:03:17', 'admin', '127.0.0.1'),
(12, 'STAGE_LIST_SECTION_BACKGROUND_COLOR', 'Ash White', 'Ash White1', '#E9E4D4', 'sc', 1, 'admin', '2025-10-29 14:05:57', 'admin', '127.0.0.1'),
(13, 'PROJ_QUOTA', 'PROJ_QUOTA', '', '10', 'n', 1, 'admin', '2025-10-29 14:16:00', 'admin', '127.0.0.1'),
(14, 'PROJ_BASE_FILE_SIZE', 'PROJ_BASE_FILE_SIZE', '', '1000', 'n', 1, 'admin', '2025-10-29 14:17:01', 'admin', '127.0.0.1'),
(15, 'STAGE_LIST_BACKGROUND_COLOR', 'Dark Mint', 'Dark Mint1', '#31906E', 'sc', 1, 'admin', '2025-10-29 14:35:31', 'admin', '127.0.0.1'),
(16, 'STAGE_LIST_ALIGN', 'LEFT', 'LEWO', 'LEFT', 'a', 1, 'admin', '2025-10-29 14:36:31', 'admin', '127.0.0.1'),
(17, 'STAGE_LIST_FONT_SIZE_MEASUREMENT', 'STAGE_LIST_FONT_SIZE_MEASUREMENT', '', 'px', 'sm', 1, 'admin', '2025-10-29 14:37:20', 'admin', '127.0.0.1'),
(18, 'STAGE_LIST_LEFT_EJECTION_MEASUREMENT', 'STAGE_LIST_LEFT_EJECTION_MEASUREMENT', '', 'px', 'sm', 1, 'admin', '2025-10-29 14:37:59', 'admin', '127.0.0.1'),
(19, 'STAGE_LIST_RIGHT_EJECTION_MEASUREMENT', 'STAGE_LIST_RIGHT_EJECTION_MEASUREMENT', '', 'px', 'sm', 1, 'admin', '2025-10-29 14:38:11', 'admin', '127.0.0.1'),
(20, 'STAGE_LIST_SPACE_AFTER_MEASUREMENT', 'STAGE_LIST_SPACE_AFTER_MEASUREMENT', '', '5', 'n', 1, 'admin', '2025-10-29 14:38:28', 'admin', '127.0.0.1'),
(21, 'STAGE_LIST_SPACE_BEFORE_MEASUREMENT', 'STAGE_LIST_SPACE_BEFORE_MEASUREMENT', '', '5', 'n', 1, 'admin', '2025-10-29 14:38:38', 'admin', '127.0.0.1'),
(22, 'STAGE_LIST_LINE_SPACING_MEASUREMENT', 'STAGE_LIST_LINE_SPACING_MEASUREMENT', '', '5', 'n', 1, 'admin', '2025-10-29 14:38:46', 'admin', '127.0.0.1'),
(23, 'STAGE_LIST_TABSTOP_MEASUREMENT', 'STAGE_LIST_TABSTOP_MEASUREMENT', '', '5', 'n', 1, 'admin', '2025-10-29 14:38:54', 'admin', '127.0.0.1'),
(24, 'STAGE_LIST_LINE_SPACING', 'STAGE_LIST_LINE_SPACING', '', 'single', 'sl', 1, 'admin', '2025-10-29 14:39:21', 'admin', '127.0.0.1'),
(25, 'STAGE_TEXT_PAGE_FROM_NEW', 'STAGE_TEXT_PAGE_FROM_NEW', '', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(26, 'STAGE_TEXT_FONT_SIZE_MEASUREMENT', 'STAGE_TEXT_FONT_SIZE_MEASUREMENT', '', 'px', 'sm', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(27, 'STAGE_TEXT_FONT_SIZE', 'STAGE_TEXT_FONT_SIZE', '', '12', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(28, 'STAGE_TEXT_COLOR', 'Aloe Vera Green', 'Aloe Vera Green1', '#98F516', 'sc', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(29, 'STAGE_TEXT_ALIGN', 'STAGE_TEXT_ALIGN', 'LEWO', 'LEFT', 'sa', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(30, 'STAGE_TEXT_BACKGROUND_COLOR', 'Night', 'Night1', '#0C090A', 'sc', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(31, 'STAGE_TEXT_FONT_FAMILY', 'STAGE_TEXT_FONT_FAMILY', '', 'Arial', 'sf', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(32, 'STAGE_TEXT_FONT_BOLD', 'STAGE_TEXT_FONT_BOLD', '', '1', 'c', 1, ' Admin', '2025-10-31 12:09:59', 'admin', '127.0.0.1'),
(33, 'STAGE_TEXT_FONT_ITALIC', 'STAGE_TEXT_FONT_ITALIC', '', '1', 'c', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(34, 'STAGE_TEXT_FONT_UNDERLINE', 'STAGE_TEXT_FONT_UNDERLINE', '', '1', 'c', 1, ' Admin', '2025-10-31 12:11:33', 'admin', '127.0.0.1'),
(35, 'STAGE_TEXT_FONT_LINETHROUGH', 'STAGE_TEXT_FONT_LINETHROUGH', '', '1', 'c', 1, ' Admin', '2025-10-31 12:11:34', 'admin', '127.0.0.1'),
(36, 'STAGE_TEXT_SUBSECTION_DEFAULT', 'STAGE_TEXT_SUBSECTION_DEFAULT', '', '1', 'c', 1, ' Admin', '2025-10-31 12:11:35', 'admin', '127.0.0.1'),
(37, 'STAGE_TEXT_SUBSECTION_MIN', 'STAGE_TEXT_SUBSECTION_MIN', '', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(38, 'STAGE_TEXT_SUBSECTION_MAX', 'STAGE_TEXT_SUBSECTION_MAX', '', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(39, 'STAGE_TEXT_SECTION_MIN', 'STAGE_TEXT_SECTION_MIN', '', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(40, 'STAGE_TEXT_SECTION_MAX', 'STAGE_TEXT_SECTION_MAX', '', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(41, 'STAGE_TEXT_SUBSECTION_ROW_MIN', 'STAGE_TEXT_SUBSECTION_ROW_MIN', '', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(42, 'STAGE_TEXT_SUBSECTION_ROW_MAX', 'STAGE_TEXT_SUBSECTION_ROW_MAX', '', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(43, 'STAGE_TEXT_SUBSECTION_ROW_NEW_LINE', 'STAGE_TEXT_SUBSECTION_ROW_NEW_LINE', '', '0', 'c', 1, ' Admin', '2025-10-31 12:10:17', 'admin', '127.0.0.1'),
(44, 'STAGE_TEXT_TABSTOP', 'STAGE_TEXT_TABSTOP', '', '1', 'n', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(45, 'STAGE_TEXT_TABSTOP_POSITION', 'STAGE_TEXT_TABSTOP_POSITION', '', 'LEFT', 'sa', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(46, 'STAGE_TEXT_TABSTOP_MEASUREMENT', 'STAGE_TEXT_TABSTOP_MEASUREMENT', '', 'px', 'sa', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(47, 'STAGE_TEXT_TABSTOP_ALIGN', 'STAGE_TEXT_TABSTOP_ALIGN', '', 'LEFT', 't', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(48, 'STAGE_TEXT_TABSTOP_LEADING_SIGN', 'STAGE_TEXT_TABSTOP_LEADING_SIGN', '', 'dot', 't', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(49, 'STAGE_TEXT_SECTION_BACKGROUND_COLOR', 'Avocado Green', 'Avocado Green1', '#B2C248', 'sc', 1, 'admin', '2025-10-29 15:12:47', 'admin', '127.0.0.1'),
(50, 'STAGE_TEXT_LEFT_EJECTION_MEASUREMENT', 'STAGE_TEXT_LEFT_EJECTION_MEASUREMENT', '', 'px', 'slm', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(51, 'STAGE_TEXT_RIGHT_EJECTION_MEASUREMENT', 'STAGE_TEXT_RIGHT_EJECTION_MEASUREMENT', '', 'px', 'slm', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(52, 'STAGE_TEXT_INDENTATION_MEASUREMENT', 'STAGE_TEXT_INDENTATION_MEASUREMENT', '', 'px', 'slm', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(53, 'STAGE_TEXT_SPACE_AFTER_MEASUREMENT', 'STAGE_TEXT_SPACE_AFTER_MEASUREMENT', '', 'px', 'slm', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(54, 'STAGE_TEXT_SPACE_BEFORE_MEASUREMENT', 'STAGE_TEXT_SPACE_BEFORE_MEASUREMENT', '', 'px', 'slm', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(55, 'STAGE_TEXT_LINE_SPACING_MEASUREMENT', 'STAGE_TEXT_LINE_SPACING_MEASUREMENT', '', 'px', 'slm', 1, 'admin', '2022-04-12 00:00:00', 'admin', '127.0.0.1'),
(56, 'STAGE_TEXT_LINE_SPACING', 'STAGE_TEXT_LINE_SPACING', '', 'single', 'sl', 1, 'admin', '2025-10-29 15:17:25', 'admin', '127.0.0.1'),
(57, 'FORM_STAGE_SECTION_COUNT', 'FORM_STAGE_SECTION_COUNT', '', '1', 'n', 1, 'admin', '2025-10-31 07:58:06', 'admin', '127.0.0.1'),
(58, 'FORM_STAGE_SUBSECTION_COUNT', 'FORM_STAGE_SUBSECTION_COUNT', '', '1', 'n', 1, 'admin', '2025-10-31 07:58:35', 'admin', '127.0.0.1'),
(59, 'FORM_STAGE_ROW_COUNT', 'FORM_STAGE_ROW_COUNT', '', '1', 'n', 1, 'admin', '2025-10-31 07:58:56', 'admin', '127.0.0.1'),
(60, 'FORM_STAGE_ROW_FIELD', 'FORM_STAGE_ROW_FIELD', '', 'text', 't', 1, 'admin', '2025-10-31 07:59:16', 'admin', '127.0.0.1'),
(61, 'STAGE_TEXT_SECTION_NEW_LINE', 'STAGE_TEXT_SECTION_NEW_LINE', '', '0', 'c', 1, ' Admin', '2025-10-31 12:10:27', 'admin', '127.0.0.1'),
(62, 'STAGE_TEXT_FONT_SIZE_MAX', 'STAGE_TEXT_FONT_SIZE_MAX', '', '12', 'n', 1, 'admin', '2025-10-31 08:08:35', 'admin', '127.0.0.1'),
(63, 'STAGE_TEXT_LEFT_EJECTION', 'STAGE_TEXT_LEFT_EJECTION', '', '1', 'n', 1, 'admin', '2025-10-31 08:08:55', 'admin', '127.0.0.1'),
(64, 'STAGE_TEXT_LEFT_EJECTION_MIN', 'STAGE_TEXT_LEFT_EJECTION_MIN', '', '1', 'n', 1, 'admin', '2025-10-31 08:09:14', 'admin', '127.0.0.1'),
(65, 'STAGE_TEXT_LEFT_EJECTION_MAX', 'STAGE_TEXT_LEFT_EJECTION_MAX', '', '2', 'n', 1, 'admin', '2025-10-31 08:09:37', 'admin', '127.0.0.1'),
(66, 'STAGE_TEXT_RIGHT_EJECTION', 'STAGE_TEXT_RIGHT_EJECTION', '', '1', 'n', 1, 'admin', '2025-10-31 08:09:56', 'admin', '127.0.0.1'),
(67, 'STAGE_TEXT_RIGHT_EJECTION_MIN', 'STAGE_TEXT_RIGHT_EJECTION_MIN', '', '1', 'n', 1, 'admin', '2025-10-31 08:10:16', 'admin', '127.0.0.1'),
(68, 'STAGE_TEXT_RIGHT_EJECTION_MAX', 'STAGE_TEXT_RIGHT_EJECTION_MAX', '', '2', 'n', 1, 'admin', '2025-10-31 08:10:37', 'admin', '127.0.0.1'),
(69, 'STAGE_TEXT_INDENTATION', 'STAGE_TEXT_INDENTATION', '', '1', 'n', 1, 'admin', '2025-10-31 08:10:57', 'admin', '127.0.0.1'),
(70, 'STAGE_TEXT_INDENTATION_MIN', 'STAGE_TEXT_INDENTATION_MIN', '', '1', 'n', 1, 'admin', '2025-10-31 08:11:14', 'admin', '127.0.0.1'),
(71, 'STAGE_TEXT_INDENTATION_MAX', 'STAGE_TEXT_INDENTATION_MAX', '', '2', 'n', 1, 'admin', '2025-10-31 08:11:33', 'admin', '127.0.0.1'),
(72, 'STAGE_TEXT_INDENTATION_SPECIAL', 'STAGE_TEXT_INDENTATION_SPECIAL', '', 'n', 't', 1, 'admin', '2025-10-31 08:11:51', 'admin', '127.0.0.1'),
(73, 'STAGE_TEXT_SPACE_AFTER', 'STAGE_TEXT_SPACE_AFTER', '', '0', 'n', 1, 'admin', '2025-10-31 08:12:09', 'admin', '127.0.0.1'),
(74, 'STAGE_TEXT_SPACE_BEFORE', 'STAGE_TEXT_SPACE_BEFORE', '', '0', 'n', 1, 'admin', '2025-10-31 08:12:22', 'admin', '127.0.0.1'),
(75, 'STAGE_TEXT_LINE_SPACING_MIN', 'STAGE_TEXT_LINE_SPACING_MIN', '', '1', 'n', 1, 'admin', '2025-10-31 08:12:37', 'admin', '127.0.0.1'),
(76, 'STAGE_TEXT_LINE_SPACING_MAX', 'STAGE_TEXT_LINE_SPACING_MAX', '', '2', 'n', 1, 'admin', '2025-10-31 08:12:52', 'admin', '127.0.0.1'),
(77, 'STAGE_TEXT_LINE_SPACING_VALUE', 'STAGE_TEXT_LINE_SPACING_VALUE', '', '2', 'n', 1, 'admin', '2025-10-31 08:13:05', 'admin', '127.0.0.1'),
(78, 'STAGE_LIST_FONT_SIZE', 'STAGE_LIST_FONT_SIZE', '', '10', 'n', 1, 'admin', '2025-10-31 08:13:20', 'admin', '127.0.0.1'),
(79, 'STAGE_LIST_FONT_SIZE_MAX', 'STAGE_LIST_FONT_SIZE_MAX', '', '32', 'n', 1, 'admin', '2025-10-31 08:14:35', 'admin', '127.0.0.1'),
(80, 'STAGE_LIST_FONT_FAMILY', 'STAGE_LIST_FONT_FAMILY', '', 'Arial', 'sf', 1, 'admin', '2025-10-31 08:15:39', 'admin', '127.0.0.1'),
(81, 'STAGE_LIST_DEFAULT_TYPE', 'STAGE_LIST_DEFAULT_TYPE', '', 'decimal', 'sl', 1, 'admin', '2025-10-31 08:16:11', 'admin', '127.0.0.1'),
(82, 'STAGE_LIST_FONT_BOLD', 'STAGE_LIST_FONT_BOLD', '', '1', 'c', 1, ' Admin', '2025-10-31 12:10:31', 'admin', '127.0.0.1'),
(83, 'STAGE_LIST_FONT_ITALIC', 'STAGE_LIST_FONT_ITALIC', '', '1', 'c', 1, ' Admin', '2025-10-31 12:10:32', 'admin', '127.0.0.1'),
(84, 'STAGE_LIST_FONT_UNDERLINE', 'STAGE_LIST_FONT_UNDERLINE', '', '1', 'c', 1, ' Admin', '2025-10-31 12:10:34', 'admin', '127.0.0.1'),
(85, 'STAGE_LIST_FONT_LINETHROUGH', 'STAGE_LIST_FONT_LINETHROUGH', '', '1', 'c', 1, ' Admin', '2025-10-31 12:10:35', 'admin', '127.0.0.1'),
(86, 'STAGE_LIST_SPACE_AFTER', 'STAGE_LIST_SPACE_AFTER', '', '0', 'n', 1, 'admin', '2025-10-31 08:17:48', 'admin', '127.0.0.1'),
(87, 'STAGE_LIST_SPACE_BEFORE', 'STAGE_LIST_SPACE_BEFORE', '', '0', 'n', 1, 'admin', '2025-10-31 08:18:02', 'admin', '127.0.0.1'),
(88, 'STAGE_LIST_CHAPTER_DEFAULT', 'STAGE_LIST_CHAPTER_DEFAULT', '', '0', 'c', 1, 'admin', '2025-10-31 08:18:18', 'admin', '127.0.0.1'),
(89, 'STAGE_LIST_CHAPTER_MULTIPLIER', 'STAGE_LIST_CHAPTER_MULTIPLIER', '', '0', 'c', 1, 'admin', '2025-10-31 08:18:32', 'admin', '127.0.0.1'),
(90, 'STAGE_LIST_CHAPTER_DEFAULT_LVL', 'STAGE_LIST_CHAPTER_DEFAULT_LVL', '', '1', 'n', 1, 'admin', '2025-10-31 08:19:01', 'admin', '127.0.0.1'),
(91, 'STAGE_LIST_CHAPTER_MAX_LVL', 'STAGE_LIST_CHAPTER_MAX_LVL', '', '5', 'n', 1, 'admin', '2025-10-31 08:19:22', 'admin', '127.0.0.1'),
(92, 'STAGE_LIST_MULTIPLIER', 'STAGE_LIST_MULTIPLIER', '', '1', 'n', 1, 'admin', '2025-10-31 08:22:13', 'admin', '127.0.0.1'),
(93, 'STAGE_LIST_PAGE_FROM_NEW', 'STAGE_LIST_PAGE_FROM_NEW', '', '1', 'c', 1, ' Admin', '2025-10-31 12:11:50', 'admin', '127.0.0.1'),
(94, 'STAGE_LIST_SECTION_MIN', 'STAGE_LIST_SECTION_MIN', '', '1', 'n', 1, 'admin', '2025-10-31 08:26:05', 'admin', '127.0.0.1'),
(95, 'STAGE_LIST_SECTION_NEW_LINE', 'STAGE_LIST_SECTION_NEW_LINE', '', '1', 'c', 1, ' Admin', '2025-10-31 12:11:47', 'admin', '127.0.0.1'),
(96, 'STAGE_LIST_SUBSECTION_MIN', 'STAGE_LIST_SUBSECTION_MIN', '', '1', 'n', 1, 'admin', '2025-10-31 08:26:39', 'admin', '127.0.0.1'),
(97, 'STAGE_LIST_SUBSECTION_ROW_MIN', 'STAGE_LIST_SUBSECTION_ROW_MIN', '', '1', 'n', 1, 'admin', '2025-10-31 08:26:53', 'admin', '127.0.0.1'),
(98, 'STAGE_LIST_LEFT_EJECTION', 'STAGE_LIST_LEFT_EJECTION', '', '0', 'n', 1, 'admin', '2025-10-31 08:27:07', 'admin', '127.0.0.1'),
(99, 'STAGE_LIST_LEFT_EJECTION_MIN', 'STAGE_LIST_LEFT_EJECTION_MIN', '', '0', 'n', 1, 'admin', '2025-10-31 08:27:20', 'admin', '127.0.0.1'),
(100, 'STAGE_LIST_LEFT_EJECTION_MAX', 'STAGE_LIST_LEFT_EJECTION_MAX', '', '10', 'n', 1, 'admin', '2025-10-31 08:27:42', 'admin', '127.0.0.1'),
(101, 'STAGE_LIST_RIGHT_EJECTION', 'STAGE_LIST_RIGHT_EJECTION', '', '0', 'n', 1, 'admin', '2025-10-31 08:27:58', 'admin', '127.0.0.1'),
(102, 'STAGE_LIST_RIGHT_EJECTION_MIN', 'STAGE_LIST_RIGHT_EJECTION_MIN', '', '0', 'n', 1, 'admin', '2025-10-31 08:28:09', 'admin', '127.0.0.1'),
(103, 'STAGE_LIST_RIGHT_EJECTION_MAX', 'STAGE_LIST_RIGHT_EJECTION_MAX', '', '10', 'n', 1, 'admin', '2025-10-31 08:28:23', 'admin', '127.0.0.1'),
(104, 'STAGE_LIST_INDENTATION_MIN', 'STAGE_LIST_INDENTATION_MIN', '', '0', 'n', 1, 'admin', '2025-10-31 08:28:37', 'admin', '127.0.0.1'),
(105, 'STAGE_LIST_INDENTATION_MAX', 'STAGE_LIST_INDENTATION_MAX', '', '10', 'n', 1, 'admin', '2025-10-31 08:28:53', 'admin', '127.0.0.1'),
(106, 'STAGE_LIST_INDENTATION_SPECIAL', 'STAGE_LIST_INDENTATION_SPECIAL', '', '1', 'n', 1, 'admin', '2025-10-31 08:29:09', 'admin', '127.0.0.1'),
(107, 'STAGE_LIST_LINE_SPACING_MIN', 'STAGE_LIST_LINE_SPACING_MIN', '', '1', 'n', 1, 'admin', '2025-10-31 08:29:23', 'admin', '127.0.0.1'),
(108, 'STAGE_LIST_LINE_SPACING_MAX', 'STAGE_LIST_LINE_SPACING_MAX', '', '12', 'n', 1, 'admin', '2025-10-31 08:29:36', 'admin', '127.0.0.1'),
(109, 'STAGE_LIST_LINE_SPACING_VALUE', 'STAGE_LIST_LINE_SPACING_VALUE', '', '1', 'n', 1, 'admin', '2025-10-31 08:29:49', 'admin', '127.0.0.1'),
(110, 'STAGE_LIST_SUBSECTION_ROW_NEW_LINE', 'STAGE_LIST_SUBSECTION_ROW_NEW_LINE', '', 'y', 'c', 1, 'admin', '2025-10-31 08:30:08', 'admin', '127.0.0.1');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownia`
--

CREATE TABLE `pracownia` (
  `id` int NOT NULL,
  `nazwa` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WSK_U` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project`
--

CREATE TABLE `project` (
  `id` bigint NOT NULL,
  `rodzaj_umowy` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `rodzaj_umowy_id` int NOT NULL,
  `rodzaj_umowy_alt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `numer_umowy` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `klient` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `temat_umowy` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `typ` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `typ_id` int NOT NULL,
  `nadzor` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nadzor_id` bigint NOT NULL,
  `kier_grupy` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kier_grupy_id` bigint NOT NULL,
  `kier_osr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kier_osr_id` bigint NOT NULL,
  `technolog` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `technolog_id` bigint NOT NULL,
  `term_realizacji` datetime DEFAULT NULL,
  `harm_data` datetime NOT NULL,
  `koniec_proj` datetime DEFAULT NULL,
  `status` enum('n','c','d','m') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'n' COMMENT 'n - nowy; c - zamkniety; d - uniety; m - w trakcie;',
  `status_info` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Nowy',
  `quota` int NOT NULL,
  `r_dane` int NOT NULL,
  `j_dane` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `system` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `system_id` int NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 - aktywny; 1 - usuniety',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hide_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hide_date` datetime DEFAULT NULL,
  `hide_reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `project`
--

INSERT INTO `project` (`id`, `rodzaj_umowy`, `rodzaj_umowy_id`, `rodzaj_umowy_alt`, `numer_umowy`, `klient`, `temat_umowy`, `typ`, `typ_id`, `nadzor`, `nadzor_id`, `kier_grupy`, `kier_grupy_id`, `kier_osr`, `kier_osr_id`, `technolog`, `technolog_id`, `term_realizacji`, `harm_data`, `koniec_proj`, `status`, `status_info`, `quota`, `r_dane`, `j_dane`, `system`, `system_id`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`, `hide_status`, `hide_date`, `hide_reason`) VALUES
(65912441115, 'umowa', 1, 'Umowa', 'asd', 'asdsad', 'asdsadsa', 'Jednorazowe zlecenie jednorazowe_zlecenie', 1, 'Tomasz Borczynski', 961608535752, 'Tomasz Borczynski', 961608535752, 'Tomasz Borczynski', 961608535752, 'Tomasz Borczynski', 961608535752, '2025-10-29 00:00:00', '2025-10-29 00:00:00', '2025-10-29 00:00:00', 'n', 'Nowy', 10, 1000, 'TB', 'Proxmox proxmox', 1, 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-29 18:34:10', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-29 18:34:10', '127.0.0.1', '0', NULL, NULL, '0', NULL, ''),
(664341493794, 'umowa', 1, 'Umowa', 'asdsa', 'dsadsa', 'dsadsadas', 'Jednorazowe zlecenie jednorazowe_zlecenie', 1, 'Tomasz Borczynski', 961608535752, 'Tomasz Borczynski', 961608535752, 'Tomasz Borczynski', 961608535752, 'Tomasz Borczynski', 961608535752, '2025-10-29 00:00:00', '2025-10-29 00:00:00', '2025-10-29 00:00:00', 'n', 'Nowy', 10, 1000, 'TB', 'Proxmox proxmox', 1, 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-29 18:36:51', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-29 18:36:51', '127.0.0.1', '0', NULL, NULL, '0', NULL, ''),
(681137715046, 'umowa', 1, 'Umowa', 'dfsdf', 'sdfsdf', 'sdfsdf', 'Jednorazowe zlecenie jednorazowe_zlecenie', 1, '', 0, '', 0, '', 0, '', 0, '2025-10-29 00:00:00', '2025-10-29 00:00:00', '2025-10-29 00:00:00', 'c', 'Projekt spełnił wszystkie kryteria zamknięcia.', 10, 1000, 'TB', 'Proxmox proxmox', 1, 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-29 18:27:33', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 11:12:44', '127.0.0.1', '0', NULL, NULL, '0', NULL, '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_document`
--

CREATE TABLE `project_document` (
  `id` bigint NOT NULL,
  `id_project` bigint NOT NULL,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `project_document`
--

INSERT INTO `project_document` (`id`, `id_project`, `name`, `delete_status`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`) VALUES
(218293835608, 681137715046, 'sdf', '0', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 10:13:54', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 10:13:54', '127.0.0.1'),
(355410450587, 681137715046, 's', '0', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 10:13:54', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 10:13:54', '127.0.0.1'),
(450915132562, 681137715046, 'sdf', '0', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 10:13:54', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 10:13:54', '127.0.0.1'),
(770040764871, 664341493794, 'a', '0', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 10:12:35', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-30 10:12:35', '127.0.0.1');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_glossary_document`
--

CREATE TABLE `project_glossary_document` (
  `ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_glossary_implementation`
--

CREATE TABLE `project_glossary_implementation` (
  `ID` int NOT NULL,
  `rodzaj_umowy` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Nazwa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `project_glossary_implementation`
--

INSERT INTO `project_glossary_implementation` (`ID`, `rodzaj_umowy`, `Nazwa`) VALUES
(1, 'umowa', 'Umowa'),
(2, 'zlecenie', 'Zlecenie');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_glossary_system`
--

CREATE TABLE `project_glossary_system` (
  `ID` int NOT NULL,
  `Nazwa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `system_umowy` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `project_glossary_system`
--

INSERT INTO `project_glossary_system` (`ID`, `Nazwa`, `system_umowy`) VALUES
(1, 'Proxmox', 'proxmox'),
(2, 'Core', 'core');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_glossary_type`
--

CREATE TABLE `project_glossary_type` (
  `ID` int NOT NULL,
  `Nazwa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `typ_umowy` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `project_glossary_type`
--

INSERT INTO `project_glossary_type` (`ID`, `Nazwa`, `typ_umowy`) VALUES
(1, 'Jednorazowe zlecenie', 'jednorazowe_zlecenie'),
(2, 'Stałe zlecenie', 'stale_zlecenie');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo`
--

CREATE TABLE `slo` (
  `id` int NOT NULL,
  `id_app_task` int NOT NULL,
  `nazwa` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `slo`
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
  `PL` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ENG` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `HEX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `slo_color`
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
  `NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `slo_font_family`
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
  `NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `VALUE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TYPE` enum('s','l','m','ls','a') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 's' COMMENT 's - specjalne; l - interlinia; m - miara (Measurement); ls - leading sign; a - tabulacja'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `slo_list`
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
(9, 'brak', 'none', 'ls'),
(10, 'Lewo', 'left', 'a'),
(11, 'Prawo', 'right', 'a'),
(12, 'Środek', 'center', 'a'),
(13, 'Czysty', 'clear', 'a'),
(14, 'Dziesiętny', 'decimal', 'a'),
(15, 'Myslnik', 'bar', 'a'),
(16, 'Liczba', 'num', 'a');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_list_type`
--

CREATE TABLE `slo_list_type` (
  `NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `VALUE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `slo_list_type`
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
  `departmentName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('tx') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'tx',
  `new_page` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `part` enum('b','f','h') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'b' COMMENT 'b - body; f - fotter; h - header',
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

--
-- Zrzut danych tabeli `slo_project_stage_const`
--

INSERT INTO `slo_project_stage_const` (`id`, `delete_status`, `delete_reason`, `name`, `value`, `buffer_user_id`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `hide_status`, `hide_reason`) VALUES
(4, '0', '', 'TEST', 'TEST', NULL, 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 11:05:16', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 11:05:16', '127.0.0.1', '0', '');

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

-- --------------------------------------------------------

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

-- --------------------------------------------------------

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

-- --------------------------------------------------------

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

-- --------------------------------------------------------

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

-- --------------------------------------------------------

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

-- --------------------------------------------------------

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

-- --------------------------------------------------------

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

-- --------------------------------------------------------

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

--
-- Zrzut danych tabeli `slo_project_stage_variable`
--

INSERT INTO `slo_project_stage_variable` (`id`, `delete_status`, `delete_reason`, `name`, `value`, `buffer_user_id`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `hide_status`, `hide_reason`) VALUES
(4, '0', '', 'TEST', 'TEST', NULL, 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 11:05:27', '127.0.0.1', 1, 'admin', ' Admin', 'admin@tomftb.pl', '2025-10-31 11:05:27', '127.0.0.1', '0', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_rola`
--

CREATE TABLE `slo_rola` (
  `ID` int NOT NULL,
  `SKROT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `NAZWA` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `OPIS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `WSK_U` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `create_user_id` int NOT NULL,
  `create_user` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int DEFAULT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mod_user_full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mod_user_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slo_style`
--

CREATE TABLE `slo_style` (
  `PL` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ENG` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `GROUP` int NOT NULL,
  `NUMBER` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `slo_style`
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
-- Struktura tabeli dla tabeli `uprawnienia`
--

CREATE TABLE `uprawnienia` (
  `ID` int NOT NULL,
  `SKROT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAZWA` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `OPIS` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `uprawnienia`
--

INSERT INTO `uprawnienia` (`ID`, `SKROT`, `NAZWA`, `OPIS`) VALUES
(1, 'LOG_INTO_APP', 'LOG_INTO_APP', ''),
(2, 'ADD_PROJ', 'ADD_PROJ', ''),
(3, 'DEL_PROJ', 'DEL_PROJ', ''),
(4, 'SHOW_TEAM_PROJ', 'SHOW_TEAM_PROJ', ''),
(5, 'SHOW_PROJ', 'SHOW_PROJ', ''),
(6, 'EDIT_TEAM_PROJ', 'EDIT_TEAM_PROJ', ''),
(7, 'SHOW_DOK_PROJ', 'SHOW_DOK_PROJ', ''),
(8, 'CLOSE_PROJ', 'CLOSE_PROJ', ''),
(9, 'EDIT_DOK_PROJ', 'EDIT_DOK_PROJ', ''),
(10, 'GEN_PDF_PROJ', 'GEN_PDF_PROJ', ''),
(11, 'EMAIL_PROJ', 'EMAIL_PROJ', ''),
(12, 'LOG_INTO_PARM', 'LOG_INTO_PARM', ''),
(13, 'EDIT_PARM', 'EDIT_PARM', ''),
(14, 'LOG_INTO_PERM', 'LOG_INTO_PERM', ''),
(15, 'SHOW_PERM_USER', 'SHOW_PERM_USER', ''),
(16, 'EDIT_PERM_USER', 'EDIT_PERM_USER', ''),
(17, 'LOG_INTO_ROLE', 'LOG_INTO_ROLE', ''),
(18, 'ADD_ROLE', 'ADD_ROLE', ''),
(19, 'EDIT_ROLE', 'EDIT_ROLE', ''),
(20, 'SHOW_ROLE', 'SHOW_ROLE', ''),
(21, 'DEL_ROLE', 'DEL_ROLE', ''),
(22, 'LOG_INTO_USER', 'LOG_INTO_USER', ''),
(23, 'ADD_USER', 'ADD_USER', ''),
(24, 'DEL_USER', 'DEL_USER', ''),
(25, 'SHOW_USER', 'SHOW_USER', ''),
(26, 'EDIT_USER', 'EDIT_USER', ''),
(27, 'LOG_INTO_EMPL', 'LOG_INTO_EMPL', ''),
(28, 'ADD_EMPL', 'ADD_EMPL', ''),
(29, 'SHOW_PROJ_EMPL', 'SHOW_PROJ_EMPL', ''),
(30, 'DEL_EMPL', 'DEL_EMPL', ''),
(31, 'SHOW_ALLOC_EMPL', 'SHOW_ALLOC_EMPL', ''),
(32, 'EDIT_ALLOC_EMPL', 'EDIT_ALLOC_EMPL', ''),
(33, 'SHOW_EMPL', 'SHOW_EMPL', ''),
(34, 'EDIT_EMPL', 'EDIT_EMPL', ''),
(35, 'LOG_INTO_STAGE', 'LOG_INTO_STAGE', ''),
(36, 'ADD_STAGE', 'ADD_STAGE', ''),
(37, 'EDIT_STAGE', 'EDIT_STAGE', ''),
(38, 'DEL_STAGE', 'DEL_STAGE', ''),
(39, 'HIDE_STAGE', 'HIDE_STAGE', ''),
(40, 'SHOW_STAGE', 'SHOW_STAGE', ''),
(41, 'GEN_PROJECT_REPORT', 'GEN_PROJECT_REPORT', ''),
(42, 'GEN_DOC_PROJ', 'GEN_DOC_PROJ', ''),
(43, 'LOG_INTO_CLUSTR', 'LOG_INTO_CLUSTR', ''),
(44, 'EDIT_CLUSTR', 'EDIT_CLUSTR', ''),
(45, 'LOG_INTO_PROJ', 'LOG_INTO_PROJ', ''),
(46, 'LOG_INTO_FORM', 'LOG_INTO_FORM', ''),
(47, 'SHOW_LIST_FILLED_FORM', 'SHOW_LIST_FILLED_FORM', ''),
(48, 'EXCEL_FILLED_FORM', 'EXCEL_FILLED_FORM', ''),
(49, 'HIDE_FORM', 'HIDE_FORM', ''),
(50, 'REMOVE_FORM', 'REMOVE_FORM', ''),
(51, 'LOG_INTO_FORM_STAGE', 'LOG_INTO_FORM_STAGE', ''),
(52, 'CREATE_FORM_STAGE', 'Dodaj etap formularza.', ''),
(53, 'SHOW_FORM_STAGE', 'Wyświetl etap formularza.', ''),
(54, 'HIDE_FORM_STAGE', 'Ukryj etap formularza.', ''),
(55, 'REMOVE_FORM_STAGE', 'Usuń etap formularza.', ''),
(56, 'SHOW_PROJ_REPORT', 'Wyświetl podgląd raportu projektu.', ''),
(57, 'SAVE_PROJ_REPORT', 'Zapis aktualnego stanu raportu projektu.', ''),
(58, 'GEN_PROJ_REP_DOC', 'Wygenerowanie raportu projektu w formacie MS DOC.', ''),
(59, 'EDIT_FORM_STAGE', 'Edycja etapu formularza.', ''),
(60, 'CREATE_FORM', 'Dodaj formularz.', ''),
(61, 'SAVE_FORM', 'Zapis formularza.', ''),
(62, 'SHOW_FORM', 'Wyświetl formularz/Uruchom kreator.', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `upr_i_slo_rola`
--

CREATE TABLE `upr_i_slo_rola` (
  `id_rola` int NOT NULL,
  `id_upr` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownik`
--

CREATE TABLE `uzytkownik` (
  `id` int NOT NULL,
  `imie` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nazwisko` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `login` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `haslo` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `typ` int NOT NULL,
  `city` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `department` int NOT NULL,
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int DEFAULT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mod_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mod_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `wsk_u` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `id_rola` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `uzytkownik`
--

INSERT INTO `uzytkownik` (`id`, `imie`, `nazwisko`, `login`, `haslo`, `email`, `typ`, `city`, `department`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `wsk_u`, `id_rola`) VALUES
(1, 'Admin', '', 'admin', '$2y$10$K5EUOPqsZkM8ehwsI26j/.2HVMOEdN7HRM6vhJeSJnb0NZJiLRsIS', 'admin@tomftb.pl', 1, 'Toruń', 1, 1, 'admin', 'Admin', 'admin@tomftb.pl', '2025-10-27 17:00:00', '127.0.0.1', NULL, NULL, NULL, NULL, '2025-10-29 14:25:29', NULL, '0', '0', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzyt_i_upr`
--

CREATE TABLE `uzyt_i_upr` (
  `id_uzytkownik` int NOT NULL,
  `id_uprawnienie` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `uzyt_i_upr`
--

INSERT INTO `uzyt_i_upr` (`id_uzytkownik`, `id_uprawnienie`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 18),
(1, 19),
(1, 20),
(1, 21),
(1, 22),
(1, 23),
(1, 24),
(1, 25),
(1, 26),
(1, 27),
(1, 28),
(1, 29),
(1, 30),
(1, 31),
(1, 32),
(1, 33),
(1, 34),
(1, 35),
(1, 36),
(1, 37),
(1, 38),
(1, 39),
(1, 40),
(1, 41),
(1, 42),
(1, 43),
(1, 44),
(1, 45),
(1, 46),
(1, 47),
(1, 48),
(1, 49),
(1, 50),
(1, 51),
(1, 52),
(1, 53),
(1, 54),
(1, 55),
(1, 56),
(1, 57),
(1, 58),
(1, 59),
(1, 60),
(1, 61),
(1, 62);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_all_prac_v4`
--

CREATE TABLE `v_all_prac_v4` (
  `id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `v_all_prac_v4`
--

INSERT INTO `v_all_prac_v4` (`id`) VALUES
(96636218987);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_all_prac_v5`
-- (Zobacz poniżej rzeczywisty widok)
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
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `v_all_user` (
`ID` int
,`Imie` varchar(100)
,`Nazwisko` varchar(200)
,`Login` varchar(200)
,`Email` varchar(300)
,`wskU` enum('0','1')
,`IdRola` int
,`TypKontaValue` int
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_parm_v2`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `v_parm_v2` (
`ID` int
,`Skrót` varchar(100)
,`Nazwa` varchar(200)
,`Opis` varchar(200)
,`Wartość` varchar(300)
,`Typ` enum('t','p','s','c','a','n','sc','sa','sf','sm','sl','slm')
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
-- Zrzut danych tabeli `v_slo_glow_tech_proj`
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
-- Zrzut danych tabeli `v_slo_kier_osr_proj`
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
-- Zrzut danych tabeli `v_slo_kier_proj`
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
  `ImieNazwisko` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `v_slo_lider_proj`
--

INSERT INTO `v_slo_lider_proj` (`id`, `ImieNazwisko`) VALUES
(1, 'Admin'),
(2, 'Adam Borczyński');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_slo_rola`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `v_slo_rola` (
`ID` int
,`NAZWA` varchar(100)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_slo_rola_all`
-- (Zobacz poniżej rzeczywisty widok)
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
  `Nazwa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `v_slo_sys_um`
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
  `Nazwa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `v_slo_typ_um`
--

INSERT INTO `v_slo_typ_um` (`ID`, `Nazwa`) VALUES
(1, 'zlecenie');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `v_slo_um_proj`
--

CREATE TABLE `v_slo_um_proj` (
  `ID` int NOT NULL,
  `Nazwa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NazwaAlt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `v_slo_um_proj`
--

INSERT INTO `v_slo_um_proj` (`ID`, `Nazwa`, `NazwaAlt`) VALUES
(1, 'Test Nazwa', 'Test Nazwa Alt'),
(2, 'Test Nazwa 2', 'Test Nazwa Alt 2');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_slo_upr`
-- (Zobacz poniżej rzeczywisty widok)
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
  `NAZWA` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DEFAULT` enum('n','t') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `v_slo_u_spec`
--

INSERT INTO `v_slo_u_spec` (`ID`, `NAZWA`, `DEFAULT`) VALUES
(1, 'Technik', 'n'),
(2, 'Kierownik', 'n');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_upr_i_uzyt_v3`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `v_upr_i_uzyt_v3` (
`id` int
,`idUprawnienie` int
,`ImieNazwisko` varchar(301)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_uzyt_i_upr`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `v_uzyt_i_upr` (
`idUzytkownik` int
,`idUprawnienie` int
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_uzyt_i_upr_v2`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `v_uzyt_i_upr_v2` (
`idUzytkownik` int
,`idUprawnienie` int
,`SKROT` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktura widoku `v_all_prac_v5`
--
DROP TABLE IF EXISTS `v_all_prac_v5`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_all_prac_v5`  AS SELECT `e`.`id` AS `ID`, concat(`e`.`imie`,' ',`e`.`nazwisko`) AS `ImieNazwisko`, `e`.`stanowisko` AS `Stanowisko`, '0' AS `Procent`, `e`.`email` AS `Email` FROM `employee` AS `e` ORDER BY `e`.`nazwisko` ASC  ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_all_user`
--
DROP TABLE IF EXISTS `v_all_user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_all_user`  AS SELECT `u`.`id` AS `ID`, `u`.`imie` AS `Imie`, `u`.`nazwisko` AS `Nazwisko`, `u`.`login` AS `Login`, `u`.`email` AS `Email`, `u`.`wsk_u` AS `wskU`, `u`.`id_rola` AS `IdRola`, `u`.`typ` AS `TypKontaValue` FROM `uzytkownik` AS `u` WHERE (0 <> 1)  ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_parm_v2`
--
DROP TABLE IF EXISTS `v_parm_v2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_parm_v2`  AS SELECT `parametry`.`ID` AS `ID`, `parametry`.`SKROT` AS `Skrót`, `parametry`.`NAZWA` AS `Nazwa`, `parametry`.`OPIS` AS `Opis`, `parametry`.`WARTOSC` AS `Wartość`, `parametry`.`TYP` AS `Typ`, `parametry`.`MOD_DAT` AS `ModDat`, `parametry`.`MOD_USER` AS `ModUser` FROM `parametry` ORDER BY `parametry`.`ID` ASC  ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_slo_rola`
--
DROP TABLE IF EXISTS `v_slo_rola`;

CREATE ALGORITHM=UNDEFINED DEFINER=`forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_slo_rola`  AS SELECT `slo_rola`.`ID` AS `ID`, `slo_rola`.`NAZWA` AS `NAZWA` FROM `slo_rola` WHERE (`slo_rola`.`WSK_U` = '0')  ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_slo_rola_all`
--
DROP TABLE IF EXISTS `v_slo_rola_all`;

CREATE ALGORITHM=UNDEFINED DEFINER=`forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_slo_rola_all`  AS SELECT `r`.`ID` AS `ID`, `r`.`NAZWA` AS `Nazwa`, `r`.`WSK_U` AS `WSK_U` FROM `slo_rola` AS `r` WHERE (0 <> 1)  ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_slo_upr`
--
DROP TABLE IF EXISTS `v_slo_upr`;

CREATE ALGORITHM=UNDEFINED DEFINER=`forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_slo_upr`  AS SELECT `u`.`ID` AS `ID`, `u`.`NAZWA` AS `NAZWA` FROM `uprawnienia` AS `u` WHERE (0 <> 1)  ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_upr_i_uzyt_v3`
--
DROP TABLE IF EXISTS `v_upr_i_uzyt_v3`;

CREATE ALGORITHM=UNDEFINED DEFINER=`forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_upr_i_uzyt_v3`  AS SELECT `uu`.`id_uzytkownik` AS `id`, `uu`.`id_uprawnienie` AS `idUprawnienie`, concat(`u`.`imie`,' ',`u`.`nazwisko`) AS `ImieNazwisko` FROM (`uzyt_i_upr` `uu` join `uzytkownik` `u`) WHERE (`uu`.`id_uzytkownik` = `u`.`id`)  ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_uzyt_i_upr`
--
DROP TABLE IF EXISTS `v_uzyt_i_upr`;

CREATE ALGORITHM=UNDEFINED DEFINER=`forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_uzyt_i_upr`  AS SELECT `u`.`id_uzytkownik` AS `idUzytkownik`, `u`.`id_uprawnienie` AS `idUprawnienie` FROM `uzyt_i_upr` AS `u` WHERE (0 <> 1)  ;

-- --------------------------------------------------------

--
-- Struktura widoku `v_uzyt_i_upr_v2`
--
DROP TABLE IF EXISTS `v_uzyt_i_upr_v2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`forms`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_uzyt_i_upr_v2`  AS SELECT `up`.`id_uzytkownik` AS `idUzytkownik`, `up`.`id_uprawnienie` AS `idUprawnienie`, `u`.`SKROT` AS `SKROT` FROM (`uzyt_i_upr` `up` join `uprawnienia` `u`) WHERE (`up`.`id_uprawnienie` = `u`.`ID`)  ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `allocation`
--
ALTER TABLE `allocation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_AllocationName` (`name`);

--
-- Indeksy dla tabeli `app_account_type`
--
ALTER TABLE `app_account_type`
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
  ADD UNIQUE KEY `UNIQUE_EmployeeAllocation` (`id_employee`,`id_allocation`),
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
-- Indeksy dla tabeli `filled_form`
--
ALTER TABLE `filled_form`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FilledFormCreateUser` (`create_user_id`),
  ADD KEY `FK_FilledFormModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `filled_form_field`
--
ALTER TABLE `filled_form_field`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FilledFormFieldCreateUser` (`create_user_id`),
  ADD KEY `FK_FilledFormFieldModifyUser` (`mod_user_id`),
  ADD KEY `FK_FilledFormFieldParent` (`id_filled_form`);

--
-- Indeksy dla tabeli `filled_form_field_question`
--
ALTER TABLE `filled_form_field_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FilledFormFieldQuestionCreateUser` (`create_user_id`),
  ADD KEY `FK_FilledFormFieldQuestionModifyUser` (`mod_user_id`),
  ADD KEY `FK_FilledFormFieldQuestionParent` (`id_filled_form_field`);

--
-- Indeksy dla tabeli `form`
--
ALTER TABLE `form`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormCreateUser` (`create_user_id`),
  ADD KEY `FK_FormModifyUser` (`mod_user_id`),
  ADD KEY `FK_FormDepartment` (`department_id`);

--
-- Indeksy dla tabeli `form_chosen_stage`
--
ALTER TABLE `form_chosen_stage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormChosenStageCreateUser` (`create_user_id`),
  ADD KEY `FK_FormChosenStageModifyUser` (`mod_user_id`),
  ADD KEY `FK_FormChosenStageDepartment` (`department_id`),
  ADD KEY `FK_FormChosenStageParent` (`id_parent`);

--
-- Indeksy dla tabeli `form_chosen_stage_row`
--
ALTER TABLE `form_chosen_stage_row`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormChosenStageRowCreateUser` (`create_user_id`),
  ADD KEY `FK_FormChosenStageRowModifyUser` (`mod_user_id`),
  ADD KEY `FK_FormChosenStageRowParent` (`id_parent`);

--
-- Indeksy dla tabeli `form_chosen_stage_row_glossary`
--
ALTER TABLE `form_chosen_stage_row_glossary`
  ADD KEY `FK_FormChosenStageRowGlossaryParent` (`id_row`),
  ADD KEY `FK_FormChosenStageRowGlossary` (`id_glossary`),
  ADD KEY `FK_FormChosenStageRowGlossaryPosition` (`id_glossary_position`);

--
-- Indeksy dla tabeli `form_chosen_stage_row_property`
--
ALTER TABLE `form_chosen_stage_row_property`
  ADD KEY `FK_FormChosenStageRowPropertyParent` (`id_row`);

--
-- Indeksy dla tabeli `form_chosen_stage_row_style`
--
ALTER TABLE `form_chosen_stage_row_style`
  ADD KEY `FK_FormChosenStageRowStyleParent` (`id_row`);

--
-- Indeksy dla tabeli `form_chosen_stage_section`
--
ALTER TABLE `form_chosen_stage_section`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormChosenStageSectionCreateUser` (`create_user_id`),
  ADD KEY `FK_FormChosenStageSectionModifyUser` (`mod_user_id`),
  ADD KEY `FK_FormChosenStageSectionParent` (`id_parent`);

--
-- Indeksy dla tabeli `form_chosen_stage_subsection`
--
ALTER TABLE `form_chosen_stage_subsection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormChosenStageSubsectionCreateUser` (`create_user_id`),
  ADD KEY `FK_FormChosenStageSubsectionModifyUser` (`mod_user_id`),
  ADD KEY `FK_FormChosenStageSubsectionParent` (`id_parent`);

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
-- Indeksy dla tabeli `form_stage`
--
ALTER TABLE `form_stage`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `form_stage_row`
--
ALTER TABLE `form_stage_row`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormStageRowCreateUser` (`create_user_id`),
  ADD KEY `FK_FormStageRowModifyUser` (`mod_user_id`),
  ADD KEY `FK_FormStageRowParent` (`id_parent`);

--
-- Indeksy dla tabeli `form_stage_row_glossary`
--
ALTER TABLE `form_stage_row_glossary`
  ADD KEY `FK_FormStageRowGlossaryParent` (`id_row`),
  ADD KEY `FK_FormStageRowGlossary` (`id_glossary`),
  ADD KEY `FK_FormStageRowGlossaryPosition` (`id_glossary_position`);

--
-- Indeksy dla tabeli `form_stage_row_property`
--
ALTER TABLE `form_stage_row_property`
  ADD KEY `FK_FormStageRowPropertyParent` (`id_row`);

--
-- Indeksy dla tabeli `form_stage_row_style`
--
ALTER TABLE `form_stage_row_style`
  ADD KEY `FK_FormStageRowStyleParent` (`id_row`);

--
-- Indeksy dla tabeli `form_stage_section`
--
ALTER TABLE `form_stage_section`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormStageSectionCreateUser` (`create_user_id`),
  ADD KEY `FK_FormStageSectionModifyUser` (`mod_user_id`),
  ADD KEY `FK_FormStageSectionParent` (`id_parent`);

--
-- Indeksy dla tabeli `form_stage_subsection`
--
ALTER TABLE `form_stage_subsection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FormStageSubsectionCreateUser` (`create_user_id`),
  ADD KEY `FK_FormStageSubsectionModifyUser` (`mod_user_id`),
  ADD KEY `FK_FormStageSubsectionParent` (`id_parent`);

--
-- Indeksy dla tabeli `form_style`
--
ALTER TABLE `form_style`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_FormStyleProperty` (`id_parent`,`property`),
  ADD KEY `FK_FormStyleCreateUser` (`create_user_id`),
  ADD KEY `FK_FormStyleModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `glossary`
--
ALTER TABLE `glossary`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_GlossaryCreateUser` (`create_user_id`),
  ADD KEY `FK_GlossaryModifyUser` (`mod_user_id`),
  ADD KEY `FK_GlossaryBufferUser` (`buffer_user_id`);

--
-- Indeksy dla tabeli `glossary_position`
--
ALTER TABLE `glossary_position`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_GlossaryPositionCreateUser` (`create_user_id`),
  ADD KEY `FK_GlossaryPositionModifyUser` (`mod_user_id`),
  ADD KEY `FK_GlossaryPositionParent` (`id_glossary`),
  ADD KEY `FK_GlossaryPositionBufferUser` (`buffer_user_id`);

--
-- Indeksy dla tabeli `klaster`
--
ALTER TABLE `klaster`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_klaster_nod` (`nod`),
  ADD UNIQUE KEY `unique_klaster_pracownia` (`pracownia`);

--
-- Indeksy dla tabeli `parametry`
--
ALTER TABLE `parametry`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `SKROT` (`SKROT`),
  ADD KEY `FK_ParametrUzytkownik` (`MOD_USER_ID`);

--
-- Indeksy dla tabeli `pracownia`
--
ALTER TABLE `pracownia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_pracownia_name` (`nazwa`);

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
-- Indeksy dla tabeli `project_glossary_document`
--
ALTER TABLE `project_glossary_document`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksy dla tabeli `project_glossary_implementation`
--
ALTER TABLE `project_glossary_implementation`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`),
  ADD UNIQUE KEY `rodzaj_umowy` (`rodzaj_umowy`);

--
-- Indeksy dla tabeli `project_glossary_system`
--
ALTER TABLE `project_glossary_system`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UC_ProjectGlossarySystem_Nazwa` (`Nazwa`),
  ADD UNIQUE KEY `UC_ProjectGlossarySystem_SystemUmowy` (`system_umowy`);

--
-- Indeksy dla tabeli `project_glossary_type`
--
ALTER TABLE `project_glossary_type`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UC_ProjectGlossaryType_Nazwa` (`Nazwa`),
  ADD UNIQUE KEY `UC_ProjectGlossaryType_TypeUmowy` (`typ_umowy`);

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
-- Indeksy dla tabeli `slo_rola`
--
ALTER TABLE `slo_rola`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_SloRolaCreateUser` (`create_user_id`),
  ADD KEY `FK_SloRolaModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `uprawnienia`
--
ALTER TABLE `uprawnienia`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `SKROT` (`SKROT`),
  ADD UNIQUE KEY `NAZWA` (`NAZWA`);

--
-- Indeksy dla tabeli `upr_i_slo_rola`
--
ALTER TABLE `upr_i_slo_rola`
  ADD KEY `FK_UprSloRolaRola` (`id_rola`),
  ADD KEY `FK_UprSloRolauprawnienie` (`id_upr`);

--
-- Indeksy dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_AppAccountType` (`typ`);

--
-- Indeksy dla tabeli `uzyt_i_upr`
--
ALTER TABLE `uzyt_i_upr`
  ADD UNIQUE KEY `UNIQUE_UzytUpr` (`id_uzytkownik`,`id_uprawnienie`),
  ADD KEY `FK_UzytUprUprawnienie` (`id_uprawnienie`);

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
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `allocation`
--
ALTER TABLE `allocation`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `app_account_type`
--
ALTER TABLE `app_account_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `app_task`
--
ALTER TABLE `app_task`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT dla tabeli `department`
--
ALTER TABLE `department`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `dictionary_measurement_units`
--
ALTER TABLE `dictionary_measurement_units`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `form`
--
ALTER TABLE `form`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `form_chosen_stage`
--
ALTER TABLE `form_chosen_stage`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `form_chosen_stage_row`
--
ALTER TABLE `form_chosen_stage_row`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `form_chosen_stage_section`
--
ALTER TABLE `form_chosen_stage_section`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `form_chosen_stage_subsection`
--
ALTER TABLE `form_chosen_stage_subsection`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `form_col`
--
ALTER TABLE `form_col`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT dla tabeli `form_col_property`
--
ALTER TABLE `form_col_property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT dla tabeli `form_col_style`
--
ALTER TABLE `form_col_style`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `form_property`
--
ALTER TABLE `form_property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `form_row`
--
ALTER TABLE `form_row`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT dla tabeli `form_row_property`
--
ALTER TABLE `form_row_property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `form_row_style`
--
ALTER TABLE `form_row_style`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `form_stage`
--
ALTER TABLE `form_stage`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `form_stage_row`
--
ALTER TABLE `form_stage_row`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `form_stage_section`
--
ALTER TABLE `form_stage_section`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `form_stage_subsection`
--
ALTER TABLE `form_stage_subsection`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `form_style`
--
ALTER TABLE `form_style`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `glossary`
--
ALTER TABLE `glossary`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `glossary_position`
--
ALTER TABLE `glossary_position`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=411;

--
-- AUTO_INCREMENT dla tabeli `klaster`
--
ALTER TABLE `klaster`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `parametry`
--
ALTER TABLE `parametry`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT dla tabeli `pracownia`
--
ALTER TABLE `pracownia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `project_glossary_document`
--
ALTER TABLE `project_glossary_document`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `project_glossary_implementation`
--
ALTER TABLE `project_glossary_implementation`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `project_glossary_system`
--
ALTER TABLE `project_glossary_system`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `project_glossary_type`
--
ALTER TABLE `project_glossary_type`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `slo`
--
ALTER TABLE `slo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT dla tabeli `slo_list`
--
ALTER TABLE `slo_list`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT dla tabeli `slo_project_stage_const`
--
ALTER TABLE `slo_project_stage_const`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `slo_project_stage_variable`
--
ALTER TABLE `slo_project_stage_variable`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `slo_rola`
--
ALTER TABLE `slo_rola`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `uprawnienia`
--
ALTER TABLE `uprawnienia`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT dla tabeli `v_all_prac_v4`
--
ALTER TABLE `v_all_prac_v4`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96636218988;

--
-- AUTO_INCREMENT dla tabeli `v_slo_glow_tech_proj`
--
ALTER TABLE `v_slo_glow_tech_proj`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `v_slo_kier_osr_proj`
--
ALTER TABLE `v_slo_kier_osr_proj`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `v_slo_kier_proj`
--
ALTER TABLE `v_slo_kier_proj`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `v_slo_lider_proj`
--
ALTER TABLE `v_slo_lider_proj`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `v_slo_sys_um`
--
ALTER TABLE `v_slo_sys_um`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `v_slo_typ_um`
--
ALTER TABLE `v_slo_typ_um`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `v_slo_um_proj`
--
ALTER TABLE `v_slo_um_proj`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `v_slo_u_spec`
--
ALTER TABLE `v_slo_u_spec`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `FK_EmployeeCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_EmployeeModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Ograniczenia dla tabeli `employee_allocation`
--
ALTER TABLE `employee_allocation`
  ADD CONSTRAINT `FK_EmployeeAllocationEmployee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `FK_EmployeeAllocationSpecialization` FOREIGN KEY (`id_allocation`) REFERENCES `allocation` (`id`);

--
-- Ograniczenia dla tabeli `employee_project`
--
ALTER TABLE `employee_project`
  ADD CONSTRAINT `FK_EmployeeProjectCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_EmployeeProjectEmployee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `FK_EmployeeProjectModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_EmployeeProjectProject` FOREIGN KEY (`id_project`) REFERENCES `project` (`id`);

--
-- Ograniczenia dla tabeli `filled_form`
--
ALTER TABLE `filled_form`
  ADD CONSTRAINT `FK_FilledFormCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FilledFormModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Ograniczenia dla tabeli `filled_form_field`
--
ALTER TABLE `filled_form_field`
  ADD CONSTRAINT `FK_FilledFormFieldCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FilledFormFieldModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FilledFormFieldParent` FOREIGN KEY (`id_filled_form`) REFERENCES `filled_form` (`id`);

--
-- Ograniczenia dla tabeli `filled_form_field_question`
--
ALTER TABLE `filled_form_field_question`
  ADD CONSTRAINT `FK_FilledFormFieldQuestionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FilledFormFieldQuestionModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FilledFormFieldQuestionParent` FOREIGN KEY (`id_filled_form_field`) REFERENCES `filled_form_field` (`id`);

--
-- Ograniczenia dla tabeli `form`
--
ALTER TABLE `form`
  ADD CONSTRAINT `FK_FormCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormDepartment` FOREIGN KEY (`department_id`) REFERENCES `department` (`ID`),
  ADD CONSTRAINT `FK_FormModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Ograniczenia dla tabeli `form_chosen_stage`
--
ALTER TABLE `form_chosen_stage`
  ADD CONSTRAINT `FK_FormChosenStageCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormChosenStageDepartment` FOREIGN KEY (`department_id`) REFERENCES `department` (`ID`),
  ADD CONSTRAINT `FK_FormChosenStageModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormChosenStageParent` FOREIGN KEY (`id_parent`) REFERENCES `form` (`id`);

--
-- Ograniczenia dla tabeli `form_chosen_stage_row`
--
ALTER TABLE `form_chosen_stage_row`
  ADD CONSTRAINT `FK_FormChosenStageRowCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormChosenStageRowModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormChosenStageRowParent` FOREIGN KEY (`id_parent`) REFERENCES `form_chosen_stage_subsection` (`id`);

--
-- Ograniczenia dla tabeli `form_chosen_stage_row_glossary`
--
ALTER TABLE `form_chosen_stage_row_glossary`
  ADD CONSTRAINT `FK_FormChosenStageRowGlossary` FOREIGN KEY (`id_glossary`) REFERENCES `glossary` (`id`),
  ADD CONSTRAINT `FK_FormChosenStageRowGlossaryParent` FOREIGN KEY (`id_row`) REFERENCES `form_chosen_stage_row` (`id`),
  ADD CONSTRAINT `FK_FormChosenStageRowGlossaryPosition` FOREIGN KEY (`id_glossary_position`) REFERENCES `glossary_position` (`id`);

--
-- Ograniczenia dla tabeli `form_chosen_stage_row_property`
--
ALTER TABLE `form_chosen_stage_row_property`
  ADD CONSTRAINT `FK_FormChosenStageRowPropertyParent` FOREIGN KEY (`id_row`) REFERENCES `form_chosen_stage_row` (`id`);

--
-- Ograniczenia dla tabeli `form_chosen_stage_row_style`
--
ALTER TABLE `form_chosen_stage_row_style`
  ADD CONSTRAINT `FK_FormChosenStageRowStyleParent` FOREIGN KEY (`id_row`) REFERENCES `form_chosen_stage_row` (`id`);

--
-- Ograniczenia dla tabeli `form_chosen_stage_section`
--
ALTER TABLE `form_chosen_stage_section`
  ADD CONSTRAINT `FK_FormChosenStageSectionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormChosenStageSectionModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormChosenStageSectionParent` FOREIGN KEY (`id_parent`) REFERENCES `form_chosen_stage` (`id`);

--
-- Ograniczenia dla tabeli `form_chosen_stage_subsection`
--
ALTER TABLE `form_chosen_stage_subsection`
  ADD CONSTRAINT `FK_FormChosenStageSubsectionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormChosenStageSubsectionModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormChosenStageSubsectionParent` FOREIGN KEY (`id_parent`) REFERENCES `form_chosen_stage_section` (`id`);

--
-- Ograniczenia dla tabeli `form_col`
--
ALTER TABLE `form_col`
  ADD CONSTRAINT `FK_FormColCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColParent` FOREIGN KEY (`id_parent`) REFERENCES `form_row` (`id`);

--
-- Ograniczenia dla tabeli `form_col_property`
--
ALTER TABLE `form_col_property`
  ADD CONSTRAINT `FK_FormColPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `form_col` (`id`);

--
-- Ograniczenia dla tabeli `form_col_style`
--
ALTER TABLE `form_col_style`
  ADD CONSTRAINT `FK_FormColStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormColStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `form_col` (`id`);

--
-- Ograniczenia dla tabeli `form_property`
--
ALTER TABLE `form_property`
  ADD CONSTRAINT `FK_FormPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `form` (`id`);

--
-- Ograniczenia dla tabeli `form_row`
--
ALTER TABLE `form_row`
  ADD CONSTRAINT `FK_FormRowCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowParent` FOREIGN KEY (`id_parent`) REFERENCES `form` (`id`);

--
-- Ograniczenia dla tabeli `form_row_property`
--
ALTER TABLE `form_row_property`
  ADD CONSTRAINT `FK_FormRowPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `form_row` (`id`);

--
-- Ograniczenia dla tabeli `form_row_style`
--
ALTER TABLE `form_row_style`
  ADD CONSTRAINT `FK_FormRowStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormRowStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `form_row` (`id`);

--
-- Ograniczenia dla tabeli `form_stage_row`
--
ALTER TABLE `form_stage_row`
  ADD CONSTRAINT `FK_FormStageRowCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormStageRowModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormStageRowParent` FOREIGN KEY (`id_parent`) REFERENCES `form_stage_subsection` (`id`);

--
-- Ograniczenia dla tabeli `form_stage_row_glossary`
--
ALTER TABLE `form_stage_row_glossary`
  ADD CONSTRAINT `FK_FormStageRowGlossary` FOREIGN KEY (`id_glossary`) REFERENCES `glossary` (`id`),
  ADD CONSTRAINT `FK_FormStageRowGlossaryParent` FOREIGN KEY (`id_row`) REFERENCES `form_stage_row` (`id`),
  ADD CONSTRAINT `FK_FormStageRowGlossaryPosition` FOREIGN KEY (`id_glossary_position`) REFERENCES `glossary_position` (`id`);

--
-- Ograniczenia dla tabeli `form_stage_row_property`
--
ALTER TABLE `form_stage_row_property`
  ADD CONSTRAINT `FK_FormStageRowPropertyParent` FOREIGN KEY (`id_row`) REFERENCES `form_stage_row` (`id`);

--
-- Ograniczenia dla tabeli `form_stage_row_style`
--
ALTER TABLE `form_stage_row_style`
  ADD CONSTRAINT `FK_FormStageRowStyleParent` FOREIGN KEY (`id_row`) REFERENCES `form_stage_row` (`id`);

--
-- Ograniczenia dla tabeli `form_stage_section`
--
ALTER TABLE `form_stage_section`
  ADD CONSTRAINT `FK_FormStageSectionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormStageSectionModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormStageSectionParent` FOREIGN KEY (`id_parent`) REFERENCES `form_stage` (`id`);

--
-- Ograniczenia dla tabeli `form_stage_subsection`
--
ALTER TABLE `form_stage_subsection`
  ADD CONSTRAINT `FK_FormStageSubsectionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormStageSubsectionModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormStageSubsectionParent` FOREIGN KEY (`id_parent`) REFERENCES `form_stage_section` (`id`);

--
-- Ograniczenia dla tabeli `form_style`
--
ALTER TABLE `form_style`
  ADD CONSTRAINT `FK_FormStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FormStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `form` (`id`);

--
-- Ograniczenia dla tabeli `glossary`
--
ALTER TABLE `glossary`
  ADD CONSTRAINT `FK_GlossaryBufferUser` FOREIGN KEY (`buffer_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_GlossaryCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_GlossaryModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Ograniczenia dla tabeli `glossary_position`
--
ALTER TABLE `glossary_position`
  ADD CONSTRAINT `FK_GlossaryPositionBufferUser` FOREIGN KEY (`buffer_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_GlossaryPositionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_GlossaryPositionModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_GlossaryPositionParent` FOREIGN KEY (`id_glossary`) REFERENCES `glossary` (`id`);

--
-- Ograniczenia dla tabeli `parametry`
--
ALTER TABLE `parametry`
  ADD CONSTRAINT `FK_ParametrUzytkownik` FOREIGN KEY (`MOD_USER_ID`) REFERENCES `uzytkownik` (`id`);

--
-- Ograniczenia dla tabeli `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `FK_ProjectCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Ograniczenia dla tabeli `project_document`
--
ALTER TABLE `project_document`
  ADD CONSTRAINT `FK_ProjectDocumentCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectDocumentModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectDocumentParent` FOREIGN KEY (`id_project`) REFERENCES `project` (`id`);

--
-- Ograniczenia dla tabeli `slo`
--
ALTER TABLE `slo`
  ADD CONSTRAINT `FK_AppTask` FOREIGN KEY (`id_app_task`) REFERENCES `app_task` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage`
--
ALTER TABLE `slo_project_stage`
  ADD CONSTRAINT `FK_SloStageCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_section`
--
ALTER TABLE `slo_project_stage_section`
  ADD CONSTRAINT `FK_SloSectionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSectionParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_section_property`
--
ALTER TABLE `slo_project_stage_section_property`
  ADD CONSTRAINT `FK_SloSectionPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSectionPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSectionPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_section` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_section_style`
--
ALTER TABLE `slo_project_stage_section_style`
  ADD CONSTRAINT `FK_SloSectionStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSectionStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSectionStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_section` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_style`
--
ALTER TABLE `slo_project_stage_style`
  ADD CONSTRAINT `FK_SloStageStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloStageStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloStageStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection`
--
ALTER TABLE `slo_project_stage_subsection`
  ADD CONSTRAINT `FK_SloSubsectionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_section` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_property`
--
ALTER TABLE `slo_project_stage_subsection_property`
  ADD CONSTRAINT `FK_SloSubsectionPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row`
--
ALTER TABLE `slo_project_stage_subsection_row`
  ADD CONSTRAINT `FK_SloSubsectionRowCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_i`
--
ALTER TABLE `slo_project_stage_subsection_row_i`
  ADD CONSTRAINT `FK_SloSubsectionRowICreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowIParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_i_style`
--
ALTER TABLE `slo_project_stage_subsection_row_i_style`
  ADD CONSTRAINT `FK_SloSubsectionRowIstyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowIstyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowIstyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row_i` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_l_property`
--
ALTER TABLE `slo_project_stage_subsection_row_l_property`
  ADD CONSTRAINT `FK_SloSubsectionRowLpropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowLpropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowLpropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_l_style`
--
ALTER TABLE `slo_project_stage_subsection_row_l_style`
  ADD CONSTRAINT `FK_SloSubsectionRowLstyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowLstyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowLstyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_property`
--
ALTER TABLE `slo_project_stage_subsection_row_property`
  ADD CONSTRAINT `FK_SloSubsectionRowPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_p_property`
--
ALTER TABLE `slo_project_stage_subsection_row_p_property`
  ADD CONSTRAINT `FK_SloSubsectionRowPpropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPpropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPpropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_p_style`
--
ALTER TABLE `slo_project_stage_subsection_row_p_style`
  ADD CONSTRAINT `FK_SloSubsectionRowPstyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPstyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPstyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_p_tabstop`
--
ALTER TABLE `slo_project_stage_subsection_row_p_tabstop`
  ADD CONSTRAINT `FK_SloSubsectionRowPtabstopCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPtabstopModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPtabstopParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_p_variable`
--
ALTER TABLE `slo_project_stage_subsection_row_p_variable`
  ADD CONSTRAINT `FK_SloSubsectionRowPvariableCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPvariableModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPvariableParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_style`
--
ALTER TABLE `slo_project_stage_subsection_row_style`
  ADD CONSTRAINT `FK_SloSubsectionRowStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_t_property`
--
ALTER TABLE `slo_project_stage_subsection_row_t_property`
  ADD CONSTRAINT `FK_SloSubsectionRowTpropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowTpropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowTpropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_row_t_style`
--
ALTER TABLE `slo_project_stage_subsection_row_t_style`
  ADD CONSTRAINT `FK_SloSubsectionRowTstyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowTstyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowTstyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);

--
-- Ograniczenia dla tabeli `slo_project_stage_subsection_style`
--
ALTER TABLE `slo_project_stage_subsection_style`
  ADD CONSTRAINT `FK_SloSubsectionStyleCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionStyleModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionStyleParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection` (`id`);

--
-- Ograniczenia dla tabeli `slo_rola`
--
ALTER TABLE `slo_rola`
  ADD CONSTRAINT `FK_SloRolaCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloRolaModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

--
-- Ograniczenia dla tabeli `upr_i_slo_rola`
--
ALTER TABLE `upr_i_slo_rola`
  ADD CONSTRAINT `FK_UprSloRolaRola` FOREIGN KEY (`id_rola`) REFERENCES `slo_rola` (`ID`),
  ADD CONSTRAINT `FK_UprSloRolauprawnienie` FOREIGN KEY (`id_upr`) REFERENCES `uprawnienia` (`ID`);

--
-- Ograniczenia dla tabeli `uzytkownik`
--
ALTER TABLE `uzytkownik`
  ADD CONSTRAINT `FK_AppAccountType` FOREIGN KEY (`typ`) REFERENCES `app_account_type` (`id`);

--
-- Ograniczenia dla tabeli `uzyt_i_upr`
--
ALTER TABLE `uzyt_i_upr`
  ADD CONSTRAINT `FK_UzytUprUprawnienie` FOREIGN KEY (`id_uprawnienie`) REFERENCES `uprawnienia` (`ID`),
  ADD CONSTRAINT `FK_UzytUprUzytkownik` FOREIGN KEY (`id_uzytkownik`) REFERENCES `uzytkownik` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
