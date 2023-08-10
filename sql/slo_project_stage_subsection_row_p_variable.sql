-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Aug 08, 2023 at 11:56 AM
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
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_p_variable`
--

CREATE TABLE `slo_project_stage_subsection_row_p_variable` (
	`id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `id_variable` bigint NOT NULL,
  `name` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL,
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

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_p_variable`
--
ALTER TABLE `slo_project_stage_subsection_row_p_variable`
  ADD KEY `FK_SloSubsectionRowPvariableCreateUser` (`create_user_id`),
  ADD KEY `FK_SloSubsectionRowPvariableModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloSubsectionRowPvariableParent` (`id_parent`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `slo_project_stage_subsection_row_p_variable`
--
ALTER TABLE `slo_project_stage_subsection_row_p_variable`
  ADD CONSTRAINT `FK_SloSubsectionRowPvariableCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPvariableModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloSubsectionRowPvariableParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row` (`id`);
COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
