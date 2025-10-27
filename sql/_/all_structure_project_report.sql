-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Wrz 13, 2023 at 01:10 PM
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
-- Struktura tabeli dla tabeli `project_report`
--

CREATE TABLE `project_report` (
  `id` bigint NOT NULL,
  `id_project` bigint NOT NULL,
  `departmentId` int NOT NULL,
  `departmentName` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL,
  `buffer_user_id` int DEFAULT NULL,
  `delete_status` enum('0','1') COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage`
--

CREATE TABLE `project_report_stage` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `ordinal_number` int NOT NULL,
  `title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `part` enum('b','h','f') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'b' COMMENT 'b - body, h - head, f - footer',
  `new_page` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_property`
--

CREATE TABLE `project_report_stage_property` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_section`
--

CREATE TABLE `project_report_stage_section` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_section_property`
--

CREATE TABLE `project_report_stage_section_property` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_section_style`
--

CREATE TABLE `project_report_stage_section_style` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_style`
--

CREATE TABLE `project_report_stage_style` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection`
--

CREATE TABLE `project_report_stage_subsection` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_property`
--

CREATE TABLE `project_report_stage_subsection_property` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row`
--

CREATE TABLE `project_report_stage_subsection_row` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_i`
--

CREATE TABLE `project_report_stage_subsection_row_i` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `delete_status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `delete_date` datetime DEFAULT NULL,
  `delete_reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_user_id` int NOT NULL,
  `create_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `create_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_id` int NOT NULL,
  `mod_user_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_full_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_user_email` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mod_host` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_i_property`
--

CREATE TABLE `project_report_stage_subsection_row_i_property` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_i_style`
--

CREATE TABLE `project_report_stage_subsection_row_i_style` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_l_property`
--

CREATE TABLE `project_report_stage_subsection_row_l_property` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_l_style`
--

CREATE TABLE `project_report_stage_subsection_row_l_style` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_p_property`
--

CREATE TABLE `project_report_stage_subsection_row_p_property` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_p_style`
--

CREATE TABLE `project_report_stage_subsection_row_p_style` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_p_tabstop`
--

CREATE TABLE `project_report_stage_subsection_row_p_tabstop` (
  `lp` bigint NOT NULL,
  `position` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `measurement` int NOT NULL,
  `measurementName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `alignment` int NOT NULL,
  `alignmentName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `leadingSign` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `leadingSignName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `id_parent` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_p_variable`
--

CREATE TABLE `project_report_stage_subsection_row_p_variable` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `id_variable` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('v','t') COLLATE utf8mb4_general_ci NOT NULL COMMENT 'v - zmienna; t - tekst'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_t_property`
--

CREATE TABLE `project_report_stage_subsection_row_t_property` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_row_t_style`
--

CREATE TABLE `project_report_stage_subsection_row_t_style` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_report_stage_subsection_style`
--

CREATE TABLE `project_report_stage_subsection_style` (
  `id` bigint NOT NULL,
  `id_parent` bigint NOT NULL,
  `property` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `project_report`
--
ALTER TABLE `project_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportProject` (`id_project`),
  ADD KEY `FK_ProjectReportBufferUser` (`buffer_user_id`),
  ADD KEY `FK_ProjectReportCreateUser` (`create_user_id`),
  ADD KEY `FK_ProjectReportModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `project_report_stage`
--
ALTER TABLE `project_report_stage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageParent` (`id_parent`),
  ADD KEY `FK_ProjectReportStageCreateUser` (`create_user_id`),
  ADD KEY `FK_ProjectReportStageModifyUser` (`mod_user_id`);

--
-- Indeksy dla tabeli `project_report_stage_property`
--
ALTER TABLE `project_report_stage_property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageStyleCreateUser` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_section`
--
ALTER TABLE `project_report_stage_section`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSectionModifyUser` (`mod_user_id`),
  ADD KEY `FK_ProjectReportStageSectionParent` (`id_parent`),
  ADD KEY `FK_ProjectReportStageSectionCreateUser` (`create_user_id`) USING BTREE;

--
-- Indeksy dla tabeli `project_report_stage_section_property`
--
ALTER TABLE `project_report_stage_section_property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSectionPropertyIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_section_style`
--
ALTER TABLE `project_report_stage_section_style`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSectionStyleIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_style`
--
ALTER TABLE `project_report_stage_style`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageStyleCreateUser` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection`
--
ALTER TABLE `project_report_stage_subsection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionParent` (`id_parent`),
  ADD KEY `FK_ProjectReportStageSubsectionModifyUser` (`mod_user_id`) USING BTREE,
  ADD KEY `FK_ProjectReportStageSubsectionCreateUser` (`create_user_id`) USING BTREE;

--
-- Indeksy dla tabeli `project_report_stage_subsection_property`
--
ALTER TABLE `project_report_stage_subsection_property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionPropertyIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_row`
--
ALTER TABLE `project_report_stage_subsection_row`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowParent` (`id_parent`),
  ADD KEY `FK_ProjectReportStageSubsectionRowModifyUser` (`mod_user_id`) USING BTREE,
  ADD KEY `FK_ProjectReportStageSubsectionRowCreateUser` (`create_user_id`) USING BTREE;

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_i`
--
ALTER TABLE `project_report_stage_subsection_row_i`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowIParent` (`id_parent`),
  ADD KEY `FK_ProjectReportStageSubsectionRowIModifyUser` (`mod_user_id`) USING BTREE,
  ADD KEY `FK_ProjectReportStageSubsectionRowICreateUser` (`create_user_id`) USING BTREE;

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_i_property`
--
ALTER TABLE `project_report_stage_subsection_row_i_property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowIPropertyIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_i_style`
--
ALTER TABLE `project_report_stage_subsection_row_i_style`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowIStyleIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_l_property`
--
ALTER TABLE `project_report_stage_subsection_row_l_property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowLPropertyIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_l_style`
--
ALTER TABLE `project_report_stage_subsection_row_l_style`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowLStyleIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_p_property`
--
ALTER TABLE `project_report_stage_subsection_row_p_property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowPPropertyIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_p_style`
--
ALTER TABLE `project_report_stage_subsection_row_p_style`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowPStyleIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_p_tabstop`
--
ALTER TABLE `project_report_stage_subsection_row_p_tabstop`
  ADD PRIMARY KEY (`lp`),
  ADD KEY `FK_ProjectReportStageSubsectionRowPTabStopIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_p_variable`
--
ALTER TABLE `project_report_stage_subsection_row_p_variable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowVariableIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_t_property`
--
ALTER TABLE `project_report_stage_subsection_row_t_property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowTPropertyIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_row_t_style`
--
ALTER TABLE `project_report_stage_subsection_row_t_style`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionRowTStyleIdParent` (`id_parent`);

--
-- Indeksy dla tabeli `project_report_stage_subsection_style`
--
ALTER TABLE `project_report_stage_subsection_style`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ProjectReportStageSubsectionStyleIdParent` (`id_parent`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `project_report`
--
ALTER TABLE `project_report`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage`
--
ALTER TABLE `project_report_stage`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_property`
--
ALTER TABLE `project_report_stage_property`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_section`
--
ALTER TABLE `project_report_stage_section`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_section_property`
--
ALTER TABLE `project_report_stage_section_property`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_section_style`
--
ALTER TABLE `project_report_stage_section_style`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_style`
--
ALTER TABLE `project_report_stage_style`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection`
--
ALTER TABLE `project_report_stage_subsection`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_property`
--
ALTER TABLE `project_report_stage_subsection_property`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row`
--
ALTER TABLE `project_report_stage_subsection_row`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_i`
--
ALTER TABLE `project_report_stage_subsection_row_i`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_i_property`
--
ALTER TABLE `project_report_stage_subsection_row_i_property`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_i_style`
--
ALTER TABLE `project_report_stage_subsection_row_i_style`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_l_property`
--
ALTER TABLE `project_report_stage_subsection_row_l_property`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_l_style`
--
ALTER TABLE `project_report_stage_subsection_row_l_style`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_p_property`
--
ALTER TABLE `project_report_stage_subsection_row_p_property`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_p_style`
--
ALTER TABLE `project_report_stage_subsection_row_p_style`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_p_tabstop`
--
ALTER TABLE `project_report_stage_subsection_row_p_tabstop`
  MODIFY `lp` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_p_variable`
--
ALTER TABLE `project_report_stage_subsection_row_p_variable`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_t_property`
--
ALTER TABLE `project_report_stage_subsection_row_t_property`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_row_t_style`
--
ALTER TABLE `project_report_stage_subsection_row_t_style`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_report_stage_subsection_style`
--
ALTER TABLE `project_report_stage_subsection_style`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `project_report`
--
ALTER TABLE `project_report`
  ADD CONSTRAINT `FK_ProjectReportBufferUser` FOREIGN KEY (`buffer_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportProject` FOREIGN KEY (`id_project`) REFERENCES `project` (`id`);

--
-- Constraints for table `project_report_stage`
--
ALTER TABLE `project_report_stage`
  ADD CONSTRAINT `FK_ProjectReportStageCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportStageModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportStageParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report` (`id`);

--
-- Constraints for table `project_report_stage_section`
--
ALTER TABLE `project_report_stage_section`
  ADD CONSTRAINT `FK_ProjectReportStageSectionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportStageSectionModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportStageSectionParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage` (`id`);

--
-- Constraints for table `project_report_stage_section_property`
--
ALTER TABLE `project_report_stage_section_property`
  ADD CONSTRAINT `FK_ProjectReportStageSectionPropertyIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_section` (`id`);

--
-- Constraints for table `project_report_stage_section_style`
--
ALTER TABLE `project_report_stage_section_style`
  ADD CONSTRAINT `FK_ProjectReportStageSectionStyleIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_section` (`id`);

--
-- Constraints for table `project_report_stage_style`
--
ALTER TABLE `project_report_stage_style`
  ADD CONSTRAINT `FK_ProjectReportStageStyleCreateUser` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage` (`id`);

--
-- Constraints for table `project_report_stage_subsection`
--
ALTER TABLE `project_report_stage_subsection`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_section` (`id`);

--
-- Constraints for table `project_report_stage_subsection_property`
--
ALTER TABLE `project_report_stage_subsection_property`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionPropertyIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row`
--
ALTER TABLE `project_report_stage_subsection_row`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowCreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_i`
--
ALTER TABLE `project_report_stage_subsection_row_i`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowICreateUser` FOREIGN KEY (`create_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowIModifyUser` FOREIGN KEY (`mod_user_id`) REFERENCES `uzytkownik` (`id`),
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowIParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_i_property`
--
ALTER TABLE `project_report_stage_subsection_row_i_property`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowIPropertyIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row_i` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_i_style`
--
ALTER TABLE `project_report_stage_subsection_row_i_style`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowIStyleIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row_i` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_l_property`
--
ALTER TABLE `project_report_stage_subsection_row_l_property`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowLPropertyIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_l_style`
--
ALTER TABLE `project_report_stage_subsection_row_l_style`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowLStyleIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_p_property`
--
ALTER TABLE `project_report_stage_subsection_row_p_property`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowPPropertyIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_p_style`
--
ALTER TABLE `project_report_stage_subsection_row_p_style`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowPStyleIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_p_tabstop`
--
ALTER TABLE `project_report_stage_subsection_row_p_tabstop`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowPTabStopIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_p_variable`
--
ALTER TABLE `project_report_stage_subsection_row_p_variable`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowVariableIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_t_property`
--
ALTER TABLE `project_report_stage_subsection_row_t_property`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowTPropertyIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row` (`id`);

--
-- Constraints for table `project_report_stage_subsection_row_t_style`
--
ALTER TABLE `project_report_stage_subsection_row_t_style`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionRowTStyleIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection_row` (`id`);

--
-- Constraints for table `project_report_stage_subsection_style`
--
ALTER TABLE `project_report_stage_subsection_style`
  ADD CONSTRAINT `FK_ProjectReportStageSubsectionStyleIdParent` FOREIGN KEY (`id_parent`) REFERENCES `project_report_stage_subsection` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
