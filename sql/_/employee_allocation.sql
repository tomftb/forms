-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Wrz 13, 2023 at 03:54 PM
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
-- Struktura tabeli dla tabeli `employee_allocation`
--

CREATE TABLE `employee_allocation` (
  `id_employee` bigint NOT NULL,
  `id_allocation` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `employee_allocation`
--
ALTER TABLE `employee_allocation`
  ADD KEY `FK_EmployeeAllocationEmployee` (`id_employee`),
  ADD KEY `FK_EmployeeAllocationAllocation` (`id_allocation`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee_allocation`
--
ALTER TABLE `employee_allocation`
  ADD CONSTRAINT `FK_EmployeeAllocationEmployee` FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id`),
  ADD CONSTRAINT `FK_EmployeeAllocationSpecialization` FOREIGN KEY (`id_allocation`) REFERENCES `allocation` (`id`);
COMMIT;

ALTER TABLE `employee_allocation`
ADD CONSTRAINT `UNIQUE_EmployeeAllocation` UNIQUE KEY(`id_employee`,`id_allocation`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
