-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: mariadb
-- Létrehozás ideje: 2024. Ápr 27. 15:43
-- Kiszolgáló verziója: 11.1.2-MariaDB-1:11.1.2+maria~ubu2204
-- PHP verzió: 8.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `WINE_DB`
--
CREATE DATABASE IF NOT EXISTS `WINE_DB_TEST` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `WINE_DB_TEST`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Borok`
--

CREATE TABLE `Borok` (
  `borok_id` int(10) UNSIGNED NOT NULL COMMENT 'bor azonosító',
  `borok_name` varchar(255) NOT NULL COMMENT 'borok neve',
  `borok_vintage` year(4) NOT NULL COMMENT 'borok évjárata évben',
  `borok_mix` tinyint(1) NOT NULL COMMENT 'borok keverékei tinyint értékekben, 0=false, 1=true',
  `borok_producer` varchar(255) NOT NULL COMMENT 'gyártó neve'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `Borok`
--

INSERT INTO `Borok` (`borok_id`, `borok_name`, `borok_vintage`, `borok_mix`, `borok_producer`) VALUES
(1, 'Egri Bikavér', '2002', 1, 'Gál Tibor'),
(2, 'Château Lafite Rothschild', '2010', 1, 'Rothschild family'),
(3, 'Tokaji Aszú', '2013', 1, 'Oremus Winery'),
(4, 'Egri Bikavér', '2018', 1, 'St. Andrea Winery'),
(5, 'Villányi Franc', '2020', 0, 'Jek Winery'),
(6, 'Tokaji Furmint', '2021', 0, 'Royal Tokaji Winery'),
(7, 'Szekszárdi Cuvée', '2019', 1, 'Gálffy Winery'),
(8, 'Badacsonyi Szürkebarát', '2020', 0, 'Laposa Winery'),
(9, 'Tokaji Hárslevelű', '2022', 0, 'Hétszőlő Winery'),
(10, 'Villányi Cabernet Sauvignon', '2017', 0, 'Vylyan Winery');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Borversenyek`
--

CREATE TABLE `Borversenyek` (
  `borverseny_name` varchar(255) NOT NULL COMMENT 'A borverseny neve',
  `borverseny_date` date NOT NULL COMMENT ' A borverseny dátuma',
  `borverseny_borid` int(10) UNSIGNED NOT NULL COMMENT 'A díjazott bor azonosítója (idegen kulcs a Borok táblázatból)',
  `borverseny_dij` varchar(255) NOT NULL COMMENT 'A bor által elnyert díj (aranyérem, ezüstérem, bronzérem , stb.)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `Borversenyek`
--

INSERT INTO `Borversenyek` (`borverseny_name`, `borverseny_date`, `borverseny_borid`, `borverseny_dij`) VALUES
('Decanter World Wine Awards', '2023-04-12', 2, 'aranyérem'),
('Vinofed', '2020-04-16', 2, 'aranyérem'),
('Decanter World Wine Awards', '2018-05-17', 3, 'ezüstérem'),
('VinAgora Nemzetközi Borverseny', '2017-04-13', 4, 'ezüstérem'),
('Budapest National Országos Borverseny', '2014-06-27', 5, 'aranyérem'),
('Budapest National Országos Borverseny', '2019-04-01', 6, 'aranyérem'),
('VinAgora Nemzetközi Borverseny', '2016-01-12', 7, 'aranyérem'),
('Balaton Borverseny', '2016-04-11', 8, 'bronzérem'),
('VinAgora Nemzetközi Borverseny', '2020-11-18', 9, 'aranyérem'),
('Budapest National Országos Borverseny', '2018-09-18', 10, 'ezüstérem');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Borvidekek`
--

CREATE TABLE `Borvidekek` (
  `borvidekek_id` int(11) UNSIGNED NOT NULL COMMENT 'Borvidékek egyedi azonosítója',
  `borvidekek_name` varchar(255) NOT NULL COMMENT 'A borvidékek nevei',
  `borvidekek_area` double UNSIGNED NOT NULL COMMENT 'A borvidékek területei hektárban'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `Borvidekek`
--

INSERT INTO `Borvidekek` (`borvidekek_id`, `borvidekek_name`, `borvidekek_area`) VALUES
(1, 'Bordeaux', 61700),
(2, 'Tokaj', 11150),
(3, 'Tolna', 11300),
(4, 'Eger', 21600),
(5, 'Badacsony', 4200),
(6, 'Szekszárd', 6000),
(7, 'Villány', 1500),
(8, 'Bükk', 17600),
(9, 'Sopron', 4300);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Borvidekek_Parcellai`
--

CREATE TABLE `Borvidekek_Parcellai` (
  `parcellak_borvidekid` int(11) UNSIGNED NOT NULL COMMENT 'A borvidékek azonosítói melyek nem egyediek.',
  `parcellak_parcellaid` int(10) UNSIGNED NOT NULL COMMENT 'A parcellák számai és egyben azonosító melyek nem egyediek.',
  `parcellak_szolotipus` varchar(255) NOT NULL COMMENT 'A szőlőtípus melyet adott parcellában termesztettek.(pl.:vörös)',
  `parcellak_szolofajta` varchar(255) NOT NULL COMMENT 'A szőlőfajta melyet adott parcellában termesztettek.(pl.:Kadarka)',
  `parcellak_terulet` double UNSIGNED NOT NULL COMMENT 'parcella területe hektárban'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `Borvidekek_Parcellai`
--

INSERT INTO `Borvidekek_Parcellai` (`parcellak_borvidekid`, `parcellak_parcellaid`, `parcellak_szolotipus`, `parcellak_szolofajta`, `parcellak_terulet`) VALUES
(1, 1, 'vörös', 'Cabernet Sauvignon', 10000),
(1, 2, 'vörös', 'Merlot', 10000),
(1, 3, 'vörös', 'Cabernet Franc', 10000),
(1, 4, 'vörös', 'Petit Verdot', 10000),
(1, 5, 'fehér', 'Sauvignon Blanc', 10000),
(1, 6, 'fehér', 'Sémillon', 11700),
(2, 1, 'fehér', 'Hárslevelű', 3000),
(2, 2, 'fehér', 'Furmint', 6000),
(2, 3, 'vörös', 'Szürkebarát', 2150),
(3, 1, 'fehér', 'Chardonnay', 2000),
(3, 2, 'fehér', 'Cserszegi fűszeres', 5500),
(3, 3, 'fehér', 'Olaszrizling', 1800),
(3, 4, 'fehér', 'Zöldveltelini', 2000),
(4, 1, 'vörös', 'Cabernet Sauvignon', 1600),
(4, 2, 'vörös', 'Kadarka', 4500),
(4, 3, 'vörös', 'Pinot Noir', 1500),
(4, 4, 'vörös', 'Kékfrankos', 8000),
(4, 5, 'fehér', 'Hárslevelű', 3000),
(4, 6, 'fehér', 'Leányka', 3000),
(5, 1, 'fehér', 'Rózsakő', 2200),
(5, 2, 'vörös', 'Pinot Noir', 2000),
(6, 1, 'vörös', 'Kékfrankos', 2000),
(6, 2, 'vörös', 'Merlot', 2000),
(6, 3, 'vörös', 'Zweigelt', 2000),
(7, 1, 'vörös', 'Cabernet Sauvignon', 1000),
(7, 2, 'vörös', 'Pinot Noir', 500),
(8, 1, 'vörös', 'Kékfrankos', 7600),
(8, 2, 'fehér', 'Furmint', 7000),
(8, 3, 'fehér', 'Zalagyöngye', 3000),
(9, 1, 'vörös', 'Merlot', 1300),
(9, 2, 'vörös', 'Kékfrankos', 3000);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Bor_Borvidek_Linker`
--

CREATE TABLE `Bor_Borvidek_Linker` (
  `linker_bor_id` int(10) UNSIGNED NOT NULL COMMENT 'A Borok Táblából a borok egyedi azonosítója',
  `linker_borvidek_id` int(11) UNSIGNED NOT NULL COMMENT 'A Borvidekek Táblából a Vidékek egyedi azonosítója'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `Bor_Borvidek_Linker`
--

INSERT INTO `Bor_Borvidek_Linker` (`linker_bor_id`, `linker_borvidek_id`) VALUES
(2, 1),
(1, 4),
(3, 2),
(4, 4),
(5, 7),
(7, 6),
(9, 2),
(6, 2),
(10, 7),
(8, 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Szolofajtak`
--

CREATE TABLE `Szolofajtak` (
  `szolofajtak_borid` int(10) UNSIGNED NOT NULL COMMENT 'A Borok Táblából az egyedi azonosító boronként mely itt nem egyedi.',
  `szolofajtak_szolotipus` varchar(255) NOT NULL COMMENT 'Pl.:vörös',
  `szolofajtak_szoloneve` varchar(255) NOT NULL COMMENT 'Pl.:Kadarka'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Gyorsabb lekérdezések miatt létezik';

--
-- A tábla adatainak kiíratása `Szolofajtak`
--

INSERT INTO `Szolofajtak` (`szolofajtak_borid`, `szolofajtak_szolotipus`, `szolofajtak_szoloneve`) VALUES
(2, 'vörös', 'Cabernet Sauvignon'),
(2, 'vörös', 'Merlot'),
(2, 'vörös', 'Cabernet Franc'),
(2, 'vörös', 'Petit Verdot'),
(1, 'vörös', 'Kékfrankos'),
(1, 'vörös', 'Kadarka'),
(1, 'vörös', 'Pinot Noir'),
(4, 'vörös', 'Kadarka'),
(4, 'vörös', 'Kékfrankos'),
(4, 'vörös', 'Pinot Noir'),
(3, 'fehér', 'Hárslevelű'),
(3, 'fehér', 'Sárgamuskotály'),
(5, 'vörös', 'Cabernet Franc'),
(7, 'vörös', 'Kékfrankos'),
(7, 'vörös', 'Merlot'),
(7, 'vörös', 'Cabernet Sauvignon'),
(8, 'vörös', 'Szürkebarát'),
(9, 'fehér', 'Hárslevelű'),
(10, 'vörös', 'Cabernet Sauvignon');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `Borok`
--
ALTER TABLE `Borok`
  ADD PRIMARY KEY (`borok_id`);

--
-- A tábla indexei `Borversenyek`
--
ALTER TABLE `Borversenyek`
  ADD KEY `borverseny_borid` (`borverseny_borid`);

--
-- A tábla indexei `Borvidekek`
--
ALTER TABLE `Borvidekek`
  ADD PRIMARY KEY (`borvidekek_id`);

--
-- A tábla indexei `Borvidekek_Parcellai`
--
ALTER TABLE `Borvidekek_Parcellai`
  ADD KEY `parcellak_borvidekid` (`parcellak_borvidekid`);

--
-- A tábla indexei `Bor_Borvidek_Linker`
--
ALTER TABLE `Bor_Borvidek_Linker`
  ADD KEY `linker_bor_id` (`linker_bor_id`),
  ADD KEY `linker_borvidek_id` (`linker_borvidek_id`);

--
-- A tábla indexei `Szolofajtak`
--
ALTER TABLE `Szolofajtak`
  ADD KEY `szolofajtak_borid` (`szolofajtak_borid`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `Borok`
--
ALTER TABLE `Borok`
  MODIFY `borok_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'bor azonosító', AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `Borvidekek`
--
ALTER TABLE `Borvidekek`
  MODIFY `borvidekek_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Borvidékek egyedi azonosítója', AUTO_INCREMENT=10;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `Borversenyek`
--
ALTER TABLE `Borversenyek`
  ADD CONSTRAINT `borversenyek_ibfk_1` FOREIGN KEY (`borverseny_borid`) REFERENCES `Borok` (`borok_id`);

--
-- Megkötések a táblához `Borvidekek_Parcellai`
--
ALTER TABLE `Borvidekek_Parcellai`
  ADD CONSTRAINT `borvidekek_parcellai_ibfk_1` FOREIGN KEY (`parcellak_borvidekid`) REFERENCES `Borvidekek` (`borvidekek_id`);

--
-- Megkötések a táblához `Bor_Borvidek_Linker`
--
ALTER TABLE `Bor_Borvidek_Linker`
  ADD CONSTRAINT `bor_borvidek_linker_ibfk_1` FOREIGN KEY (`linker_bor_id`) REFERENCES `Borok` (`borok_id`),
  ADD CONSTRAINT `bor_borvidek_linker_ibfk_2` FOREIGN KEY (`linker_borvidek_id`) REFERENCES `Borvidekek` (`borvidekek_id`);

--
-- Megkötések a táblához `Szolofajtak`
--
ALTER TABLE `Szolofajtak`
  ADD CONSTRAINT `szolofajtak_ibfk_1` FOREIGN KEY (`szolofajtak_borid`) REFERENCES `Borok` (`borok_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
