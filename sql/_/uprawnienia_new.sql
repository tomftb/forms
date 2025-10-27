-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Wrz 13, 2023 at 01:16 PM
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
-- Struktura tabeli dla tabeli `uprawnienia`
--

CREATE TABLE `uprawnienia` (
  `ID` int NOT NULL,
  `SKROT` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `NAZWA` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `OPIS` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uprawnienia`
--

INSERT INTO `uprawnienia` (`ID`, `SKROT`, `NAZWA`, `OPIS`) VALUES
(56, 'SHOW_PROJ_REPORT', 'Wyświetl podgląd raportu projektu.', ''),
(57, 'SAVE_PROJ_REPORT', 'Zapis aktualnego stanu raportu projektu.', ''),
(58, 'GEN_PROJ_REP_DOC', 'Wygenerowanie raportu projektu w formacie MS DOC.', '');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `uprawnienia`
--
ALTER TABLE `uprawnienia`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `SKROT` (`SKROT`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `uprawnienia`
--
ALTER TABLE `uprawnienia`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
