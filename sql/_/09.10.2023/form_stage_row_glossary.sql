-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Paź 09, 2023 at 10:31 AM
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
-- Struktura tabeli dla tabeli `form_stage_row_glossary`
--

CREATE TABLE `form_stage_row_glossary` (
  `id_row` bigint NOT NULL,
  `id_glossary` bigint NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_glossary_position` bigint NOT NULL,
  `position_name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `form_stage_row_glossary`
--
ALTER TABLE `form_stage_row_glossary`
  ADD KEY `FK_FormStageRowGlossaryParent` (`id_row`),
  ADD KEY `FK_FormStageRowGlossary` (`id_glossary`),
  ADD KEY `FK_FormStageRowGlossaryPosition` (`id_glossary_position`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `form_stage_row_glossary`
--
ALTER TABLE `form_stage_row_glossary`
  ADD CONSTRAINT `FK_FormStageRowGlossary` FOREIGN KEY (`id_glossary`) REFERENCES `glossary` (`id`),
  ADD CONSTRAINT `FK_FormStageRowGlossaryParent` FOREIGN KEY (`id_row`) REFERENCES `form_stage_row` (`id`),
  ADD CONSTRAINT `FK_FormStageRowGlossaryPosition` FOREIGN KEY (`id_glossary_position`) REFERENCES `glossary_position` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
