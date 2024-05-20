-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 03. Mai 2024 um 15:33
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `dbzeitschriftenabo`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblabo`
--

CREATE TABLE `tblabo` (
  `aboID` int(11) NOT NULL,
  `fkkundenID` int(11) NOT NULL,
  `fkzeitschriftID` int(11) NOT NULL,
  `startdatum` date NOT NULL,
  `enddatum` date NOT NULL,
  `fkzusteller` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tblabo`
--

INSERT INTO `tblabo` (`aboID`, `fkkundenID`, `fkzeitschriftID`, `startdatum`, `enddatum`, `fkzusteller`) VALUES
(1, 1, 1, '2024-02-01', '2025-01-31', 2),
(2, 4, 3, '2023-07-01', '2024-06-30', 3),
(9, 2, 4, '2023-08-01', '2024-07-31', 1),
(10, 2, 2, '2024-06-01', '2025-05-31', 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblkunden`
--

CREATE TABLE `tblkunden` (
  `kundenID` int(11) NOT NULL,
  `vorname` varchar(32) NOT NULL,
  `nachname` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tblkunden`
--

INSERT INTO `tblkunden` (`kundenID`, `vorname`, `nachname`) VALUES
(1, 'Markus', 'Klausriegler'),
(2, 'Johann', 'Kopf'),
(3, 'Rudolf', 'Mayr'),
(4, 'Josef', 'Berger');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblzeitschriften`
--

CREATE TABLE `tblzeitschriften` (
  `zeitschriftenID` int(11) NOT NULL,
  `titel` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tblzeitschriften`
--

INSERT INTO `tblzeitschriften` (`zeitschriftenID`, `titel`) VALUES
(1, 'c\'t - magazin für computertechnik'),
(2, 'ix - magazin für professionelle IT'),
(3, 'Make – Die Zeitschrift für Selbermacher'),
(4, 'c\'t Fotografie - Das Fotomagazin für Anspruchsvolle');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblzusteller`
--

CREATE TABLE `tblzusteller` (
  `zustellerID` int(11) NOT NULL,
  `zusteller` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tblzusteller`
--

INSERT INTO `tblzusteller` (`zustellerID`, `zusteller`) VALUES
(1, 'Zusteller A'),
(2, 'Zusteller B'),
(3, 'Zusteller C');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tblabo`
--
ALTER TABLE `tblabo`
  ADD PRIMARY KEY (`aboID`),
  ADD KEY `fkkundenID` (`fkkundenID`),
  ADD KEY `fkzeitschriftID` (`fkzeitschriftID`),
  ADD KEY `fkzusteller` (`fkzusteller`);

--
-- Indizes für die Tabelle `tblkunden`
--
ALTER TABLE `tblkunden`
  ADD PRIMARY KEY (`kundenID`);

--
-- Indizes für die Tabelle `tblzeitschriften`
--
ALTER TABLE `tblzeitschriften`
  ADD PRIMARY KEY (`zeitschriftenID`);

--
-- Indizes für die Tabelle `tblzusteller`
--
ALTER TABLE `tblzusteller`
  ADD PRIMARY KEY (`zustellerID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tblabo`
--
ALTER TABLE `tblabo`
  MODIFY `aboID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `tblkunden`
--
ALTER TABLE `tblkunden`
  MODIFY `kundenID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tblzeitschriften`
--
ALTER TABLE `tblzeitschriften`
  MODIFY `zeitschriftenID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `tblzusteller`
--
ALTER TABLE `tblzusteller`
  MODIFY `zustellerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tblabo`
--
ALTER TABLE `tblabo`
  ADD CONSTRAINT `tblabo_ibfk_1` FOREIGN KEY (`fkkundenID`) REFERENCES `tblkunden` (`kundenID`),
  ADD CONSTRAINT `tblabo_ibfk_2` FOREIGN KEY (`fkzeitschriftID`) REFERENCES `tblzeitschriften` (`zeitschriftenID`),
  ADD CONSTRAINT `tblabo_ibfk_3` FOREIGN KEY (`fkzusteller`) REFERENCES `tblzusteller` (`zustellerID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
