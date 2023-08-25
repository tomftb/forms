-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: mariadb105.server101661.nazwa.pl:3306
-- Czas generowania: 18 Sie 2023, 07:55
-- Wersja serwera: 10.5.21-MariaDB-log
-- Wersja PHP: 7.2.24-0ubuntu0.18.04.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `server101661_autos-forms`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `filled_form`
--

CREATE TABLE `filled_form` (
  `id` bigint(20) NOT NULL,
  `id_form` bigint(20) DEFAULT NULL,
  `name` varchar(300) NOT NULL,
  `create_user_id` int(11) NOT NULL,
  `create_user_login` varchar(100) NOT NULL,
  `create_user_full_name` varchar(200) NOT NULL,
  `create_user_email` varchar(100) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) NOT NULL,
  `mod_user_id` int(11) NOT NULL,
  `mod_user_login` varchar(100) NOT NULL,
  `mod_user_full_name` varchar(200) NOT NULL,
  `mod_user_email` varchar(100) NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT current_timestamp(),
  `mod_host` varchar(100) NOT NULL,
  `delete_status` enum('0','1') NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `filled_form`
--

INSERT INTO `filled_form` (`id`, `id_form`, `name`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `delete_status`, `delete_date`, `delete_reason`) VALUES
(485156859713, NULL, 'Formularz dostawcy kwalifikowanego', 1, 'aplikacjaAutos', 'Aplikacja autos.com.pl', 'powiadomienia@autos.com.pl', '2023-08-16 14:55:23', 'autos.com.pl', 1, 'aplikacjaAutos', 'Aplikacja autos.com.pl', 'powiadomienia@autos.com.pl', '2023-08-16 14:55:23', 'autos.com.pl', '0', NULL, NULL),
(1056400312577, NULL, 'Formularz dostawcy kwalifikowanego', 1, 'aplikacjaAutos', 'Aplikacja autos.com.pl', 'powiadomienia@autos.com.pl', '2023-08-16 14:15:13', 'autos.com.pl', 1, 'aplikacjaAutos', 'Aplikacja autos.com.pl', 'powiadomienia@autos.com.pl', '2023-08-16 14:15:13', 'autos.com.pl', '0', NULL, NULL);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `filled_form`
--
ALTER TABLE `filled_form`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_FilledFormCreateUser` (`create_user_id`),
  ADD KEY `FK_FilledFormModifyUser` (`mod_user_id`);

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `filled_form`
--
ALTER TABLE `filled_form`
  ADD CONSTRAINT `FK_FilledFormCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_FilledFormModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
