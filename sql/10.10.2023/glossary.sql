-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Paź 10, 2023 at 07:57 AM
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
-- Dumping data for table `glossary`
--

INSERT INTO `glossary` (`id`, `name`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`, `buffer_user_id`, `hide_status`, `hide_reason`, `hide_date`, `delete_status`, `delete_reason`, `delete_date`) VALUES
(1, 'Kraj', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 11:18:34', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 11:19:43', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(2, 'Waluta rozliczenia', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:31:13', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:32:23', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(3, 'Kraj fakturowania towaru', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:58:36', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:59:27', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL),
(4, 'Waluta', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:58:36', '127.0.0.1', 1, 'tborczynski', 'Tomasz Borczyński', 't.borczynski@autos.com.pl', '2023-09-28 12:59:58', '127.0.0.1', NULL, '0', NULL, NULL, '0', NULL, NULL);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `glossary`
--
ALTER TABLE `glossary`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_GlossaryCreateUser` (`create_user_id`),
  ADD KEY `FK_GlossaryModifyUser` (`mod_user_id`),
  ADD KEY `FK_GlossaryBufferUser` (`buffer_user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `glossary`
--
ALTER TABLE `glossary`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `glossary`
--
ALTER TABLE `glossary`
  ADD CONSTRAINT `FK_GlossaryBufferUser` FOREIGN KEY (`buffer_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_GlossaryCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_GlossaryModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
