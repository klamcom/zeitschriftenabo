-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 03. Mai 2024 um 17:04
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
-- Datenbank: `dbreisebuero`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblanrede`
--

CREATE TABLE `tblanrede` (
  `anredeID` int(11) NOT NULL,
  `anrede` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tblanrede`
--

INSERT INTO `tblanrede` (`anredeID`, `anrede`) VALUES
(1, 'Herr'),
(2, 'Frau');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblbuchung`
--

CREATE TABLE `tblbuchung` (
  `buchungID` int(11) NOT NULL,
  `fkkundenID` int(11) NOT NULL,
  `fkreiseID` int(11) NOT NULL,
  `fkmitarbeiter` int(11) NOT NULL,
  `buchungsdatum` date NOT NULL,
  `fkzahlungsstatus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblfilialen`
--

CREATE TABLE `tblfilialen` (
  `filialenID` int(11) NOT NULL,
  `filialenname` varchar(128) NOT NULL,
  `strasse` varchar(128) NOT NULL,
  `plz` varchar(10) NOT NULL,
  `ort` varchar(128) NOT NULL,
  `telnr` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblkunden`
--

CREATE TABLE `tblkunden` (
  `KundenID` int(11) NOT NULL,
  `fkanrede` int(11) NOT NULL,
  `vorname` varchar(64) NOT NULL,
  `nachname` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `telnr` varchar(64) NOT NULL,
  `strasse` varchar(128) NOT NULL,
  `plz` varchar(10) NOT NULL,
  `ort` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `tblkunden`
--

INSERT INTO `tblkunden` (`KundenID`, `fkanrede`, `vorname`, `nachname`, `email`, `telnr`, `strasse`, `plz`, `ort`) VALUES
(1, 1, 'Markus', 'Klausriegler', 'markus@klausriegler.org', '0676 4880680', 'Ledererstraße 1/1', '4452', 'Ternberg'),
(2, 1, 'Johann', 'Kopf', 'johann.kopf@gmx.at', '0664 2376473', 'Schulstraße 3', '4452', 'Ternberg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblmitarbeiter`
--

CREATE TABLE `tblmitarbeiter` (
  `mitarbeiterID` int(11) NOT NULL,
  `fkanrede` int(11) NOT NULL,
  `vorname` varchar(64) NOT NULL,
  `nachname` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `fkfiliale` int(11) NOT NULL,
  `fkposition` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblposition`
--

CREATE TABLE `tblposition` (
  `positionID` int(11) NOT NULL,
  `position` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblreisen`
--

CREATE TABLE `tblreisen` (
  `reisenID` int(11) NOT NULL,
  `fkreiseziel` int(11) NOT NULL,
  `startdatum` date NOT NULL,
  `enddatum` date NOT NULL,
  `preis` decimal(10,2) NOT NULL,
  `beschreibung` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblreiseziel`
--

CREATE TABLE `tblreiseziel` (
  `reisezielID` int(11) NOT NULL,
  `zielname` varchar(128) NOT NULL,
  `zielland` varchar(128) NOT NULL,
  `zielbeschreibung` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tblzahlungsstatus`
--

CREATE TABLE `tblzahlungsstatus` (
  `zahlungsstatusID` int(11) NOT NULL,
  `zahlungsstatus` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tblanrede`
--
ALTER TABLE `tblanrede`
  ADD PRIMARY KEY (`anredeID`);

--
-- Indizes für die Tabelle `tblbuchung`
--
ALTER TABLE `tblbuchung`
  ADD PRIMARY KEY (`buchungID`),
  ADD KEY `fkreiseID` (`fkreiseID`),
  ADD KEY `tblbuchung_ibfk_3` (`fkkundenID`),
  ADD KEY `fkmitarbeiter` (`fkmitarbeiter`),
  ADD KEY `fkzahlungsstatus` (`fkzahlungsstatus`);

--
-- Indizes für die Tabelle `tblfilialen`
--
ALTER TABLE `tblfilialen`
  ADD PRIMARY KEY (`filialenID`);

--
-- Indizes für die Tabelle `tblkunden`
--
ALTER TABLE `tblkunden`
  ADD PRIMARY KEY (`KundenID`),
  ADD KEY `fkanrede` (`fkanrede`);

--
-- Indizes für die Tabelle `tblmitarbeiter`
--
ALTER TABLE `tblmitarbeiter`
  ADD PRIMARY KEY (`mitarbeiterID`),
  ADD KEY `fkanrede` (`fkanrede`),
  ADD KEY `fkfiliale` (`fkfiliale`),
  ADD KEY `fkposition` (`fkposition`);

--
-- Indizes für die Tabelle `tblposition`
--
ALTER TABLE `tblposition`
  ADD PRIMARY KEY (`positionID`);

--
-- Indizes für die Tabelle `tblreisen`
--
ALTER TABLE `tblreisen`
  ADD PRIMARY KEY (`reisenID`),
  ADD KEY `fkreiseziel` (`fkreiseziel`);

--
-- Indizes für die Tabelle `tblreiseziel`
--
ALTER TABLE `tblreiseziel`
  ADD PRIMARY KEY (`reisezielID`);

--
-- Indizes für die Tabelle `tblzahlungsstatus`
--
ALTER TABLE `tblzahlungsstatus`
  ADD PRIMARY KEY (`zahlungsstatusID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tblanrede`
--
ALTER TABLE `tblanrede`
  MODIFY `anredeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `tblbuchung`
--
ALTER TABLE `tblbuchung`
  MODIFY `buchungID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `tblfilialen`
--
ALTER TABLE `tblfilialen`
  MODIFY `filialenID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `tblkunden`
--
ALTER TABLE `tblkunden`
  MODIFY `KundenID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `tblmitarbeiter`
--
ALTER TABLE `tblmitarbeiter`
  MODIFY `mitarbeiterID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `tblposition`
--
ALTER TABLE `tblposition`
  MODIFY `positionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `tblreisen`
--
ALTER TABLE `tblreisen`
  MODIFY `reisenID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `tblreiseziel`
--
ALTER TABLE `tblreiseziel`
  MODIFY `reisezielID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `tblzahlungsstatus`
--
ALTER TABLE `tblzahlungsstatus`
  MODIFY `zahlungsstatusID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tblbuchung`
--
ALTER TABLE `tblbuchung`
  ADD CONSTRAINT `tblbuchung_ibfk_2` FOREIGN KEY (`fkreiseID`) REFERENCES `tblreisen` (`reisenID`),
  ADD CONSTRAINT `tblbuchung_ibfk_3` FOREIGN KEY (`fkkundenID`) REFERENCES `tblkunden` (`KundenID`),
  ADD CONSTRAINT `tblbuchung_ibfk_4` FOREIGN KEY (`fkmitarbeiter`) REFERENCES `tblmitarbeiter` (`mitarbeiterID`),
  ADD CONSTRAINT `tblbuchung_ibfk_5` FOREIGN KEY (`fkzahlungsstatus`) REFERENCES `tblzahlungsstatus` (`zahlungsstatusID`);

--
-- Constraints der Tabelle `tblkunden`
--
ALTER TABLE `tblkunden`
  ADD CONSTRAINT `tblkunden_ibfk_1` FOREIGN KEY (`fkanrede`) REFERENCES `tblanrede` (`anredeID`);

--
-- Constraints der Tabelle `tblmitarbeiter`
--
ALTER TABLE `tblmitarbeiter`
  ADD CONSTRAINT `tblmitarbeiter_ibfk_1` FOREIGN KEY (`fkanrede`) REFERENCES `tblanrede` (`anredeID`),
  ADD CONSTRAINT `tblmitarbeiter_ibfk_2` FOREIGN KEY (`fkfiliale`) REFERENCES `tblfilialen` (`filialenID`),
  ADD CONSTRAINT `tblmitarbeiter_ibfk_3` FOREIGN KEY (`fkposition`) REFERENCES `tblposition` (`positionID`);

--
-- Constraints der Tabelle `tblreisen`
--
ALTER TABLE `tblreisen`
  ADD CONSTRAINT `tblreisen_ibfk_1` FOREIGN KEY (`fkreiseziel`) REFERENCES `tblreiseziel` (`reisezielID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
