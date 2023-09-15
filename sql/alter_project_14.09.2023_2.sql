SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_glossary_document`
--

CREATE TABLE `project_glossary_document` (
  `ID` int NOT NULL,
  `Nazwa` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Slownik dokumenty';

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `project_glossary_document`
--
ALTER TABLE `project_glossary_document`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `project_glossary_document`
--
ALTER TABLE `project_glossary_document`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;
COMMIT;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_glossary_implementation`
--

CREATE TABLE `project_glossary_implementation` (
  `ID` int NOT NULL,
  `Nazwa` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `NazwaAlt` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Slownik Do realziacji';

--
-- Dumping data for table `project_glossary_implementation`
--

INSERT INTO `project_glossary_implementation` (`ID`, `Nazwa`, `NazwaAlt`) VALUES
(1, 'Test', 'TestAlt');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `project_glossary_implementation`
--
ALTER TABLE `project_glossary_implementation`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`),
  ADD UNIQUE KEY `NazwaAlt` (`NazwaAlt`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `project_glossary_implementation`
--
ALTER TABLE `project_glossary_implementation`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_glossary_system`
--

CREATE TABLE `project_glossary_system` (
  `ID` int NOT NULL,
  `Nazwa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Slownik system umowy';

--
-- Dumping data for table `project_glossary_system`
--

INSERT INTO `project_glossary_system` (`ID`, `Nazwa`) VALUES
(1, 'Test system');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `project_glossary_system`
--
ALTER TABLE `project_glossary_system`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `project_glossary_system`
--
ALTER TABLE `project_glossary_system`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `project_glossary_type`
--

CREATE TABLE `project_glossary_type` (
  `ID` int NOT NULL,
  `Nazwa` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Slownik typ umowy';

--
-- Dumping data for table `project_glossary_type`
--

INSERT INTO `project_glossary_type` (`ID`, `Nazwa`) VALUES
(1, 'Test typ');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `project_glossary_type`
--
ALTER TABLE `project_glossary_type`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `project_glossary_type`
--
ALTER TABLE `project_glossary_type`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

-- SET DEFAULT ID

UPDATE `project` SET `typ_id`=1,`system_id`=1,`rodzaj_umowy_id`=1 WHERE 1;
COMMIT;

-- ADD NEW KEYES FOR TABLE `project`

ALTER TABLE `project`
	ADD KEY `FK_ProjectRodzajUmowyId` (`rodzaj_umowy_id`),
	ADD KEY `FK_ProjectTypId` (`typ_id`),
	ADD KEY `FK_ProjectSystemId` (`system_id`);
COMMIT;
 
-- ADD NEW CONSTRAINTS FOR TABLE `project`

ALTER TABLE `project`
	ADD CONSTRAINT `FK_ProjectRodzajUmowyId` FOREIGN KEY (`rodzaj_umowy_id`) REFERENCES `project_glossary_implementation` (`ID`),
	ADD CONSTRAINT `FK_ProjectTypId` FOREIGN KEY (`typ_id`) REFERENCES `project_glossary_type` (`ID`),
	ADD CONSTRAINT `FK_ProjectSystemId` FOREIGN KEY (`system_id`) REFERENCES `project_glossary_system` (`ID`);
COMMIT;