-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Wrz 13, 2023 at 03:52 PM
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
(1, 'Lider'),
(2, 'Manager'),
(3, 'Kierownik ośrodka'),
(4, 'Główny technolog');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `allocation`
--
ALTER TABLE `allocation`
  ADD PRIMARY KEY (`id`);
COMMIT;

ALTER TABLE `allocation`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;
  
ALTER TABLE `allocation`
 ADD CONSTRAINT `UNIQUE_AllocationName` UNIQUE KEY(`name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
