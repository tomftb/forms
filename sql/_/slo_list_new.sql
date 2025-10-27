-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Wrz 13, 2023 at 01:12 PM
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
-- Struktura tabeli dla tabeli `slo_list`
--

CREATE TABLE `slo_list` (
  `id` int NOT NULL,
  `NAME` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `VALUE` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `TYPE` enum('s','l','m','ls','a') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 's' COMMENT 's - specjalne; l - interlinia; m - miara (Measurement); ls - leading sign; a - tabulacja'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `slo_list`
--

INSERT INTO `slo_list` (`id`, `NAME`, `VALUE`, `TYPE`) VALUES
(10, 'Lewo', 'left', 'a'),
(11, 'Prawo', 'right', 'a'),
(12, 'Środek', 'center', 'a'),
(13, 'Czysty', 'clear', 'a'),
(15, 'Dziesiętny', 'decimal', 'a'),
(17, 'Myslnik', 'bar', 'a'),
(18, 'Liczba', 'num', 'a');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `slo_list`
--
ALTER TABLE `slo_list`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_NAME_SLO_LIST` (`NAME`,`TYPE`),
  ADD UNIQUE KEY `UNIQUE_VALUE_SLO_LIST` (`VALUE`,`TYPE`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `slo_list`
--
ALTER TABLE `slo_list`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
