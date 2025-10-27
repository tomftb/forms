-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Wrz 28, 2023 at 11:04 AM
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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `glossary`
--
ALTER TABLE `glossary`
  ADD CONSTRAINT `FK_GlossaryCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_GlossaryModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_GlossaryBufferUser` FOREIGN KEY (`buffer_user_id`) REFERENCES `uzytkownik` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
