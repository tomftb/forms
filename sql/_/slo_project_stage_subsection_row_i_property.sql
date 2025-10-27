-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Wrz 13, 2023 at 01:14 PM
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
-- Struktura tabeli dla tabeli `slo_project_stage_subsection_row_i_property`
--

CREATE TABLE `slo_project_stage_subsection_row_i_property` (
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

--
-- Dumping data for table `slo_project_stage_subsection_row_i_property`
--

INSERT INTO `slo_project_stage_subsection_row_i_property` (`id_parent`, `property`, `value`, `create_user_id`, `create_user_login`, `create_user_full_name`, `create_user_email`, `create_date`, `create_host`, `mod_user_id`, `mod_user_login`, `mod_user_full_name`, `mod_user_email`, `mod_date`, `mod_host`) VALUES
(33464980120, 'height', '573', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'lastModified', '1681809995288', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'lastModifiedDate', '2023-04-18T09:26:35.288Z', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'mime', 'image/jpeg', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'name', '6391d7734ee48_124.jpg', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'order', 'beforetext', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'orderName', 'Przed tekstem', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'size', '428574', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'tmpid', 'new4500196', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'type', 'image/jpeg', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'uri', 'stageImage_65005225debfc.jpg', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(33464980120, 'width', '860', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 08:36:01', '127.0.0.1'),
(288186557906, 'height', '573', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'lastModified', '1681809995288', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'lastModifiedDate', '2023-04-18T09:26:35.288Z', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'mime', 'image/jpeg', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'name', '6391d7734ee48_124.jpg', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'order', 'beforetext', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'orderName', 'Przed tekstem', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'size', '428574', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'tmpid', 'new3656482', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'type', 'image/jpeg', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'uri', 'stageImage_65004e44f378b.jpg', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1'),
(288186557906, 'width', '860', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1', 1, 'tborczynski', 'Borczyński Tomasz', 't.borczynski@autos.com.pl', '2023-09-13 12:02:01', '127.0.0.1');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `slo_project_stage_subsection_row_i_property`
--
ALTER TABLE `slo_project_stage_subsection_row_i_property`
  ADD UNIQUE KEY `UNIQUE_SloProjectStageSubsectionRowIProperty` (`id_parent`,`property`),
  ADD KEY `FK_SloProjectStageSubsectionRowIPropertyCreateUser` (`create_user_id`),
  ADD KEY `FK_SloProjectStageSubsectionRowIPropertyModifyUser` (`mod_user_id`),
  ADD KEY `FK_SloProjectStageSubsectionRowIPropertyParent` (`id_parent`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `slo_project_stage_subsection_row_i_property`
--
ALTER TABLE `slo_project_stage_subsection_row_i_property`
  ADD CONSTRAINT `FK_SloProjectStageSubsectionRowIPropertyCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloProjectStageSubsectionRowIPropertyModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_SloProjectStageSubsectionRowIPropertyParent` FOREIGN KEY (`id_parent`) REFERENCES `slo_project_stage_subsection_row_i` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
