-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Sze 02. 15:35
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `konyvklub`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `book_clubs`
--

CREATE TABLE `book_clubs` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `book_clubs`
--

INSERT INTO `book_clubs` (`id`, `name`, `description`, `latitude`, `longitude`) VALUES
(7, 'Pesti Klasszikusok Kör', 'Havi találkozók klasszikus irodalomról.', 47.5040000, 19.0610000),
(8, 'Margit-szigeti Olvasók', 'Nyári piknik + könyvcsere a szigeten.', 47.5316000, 19.0493000),
(9, 'Budai Krimik Klubja', 'Kortárs és klasszikus krimik megbeszélése.', 47.5019000, 19.0259000),
(10, 'Ifjúsági Sci-Fi Klub', 'YA sci-fi és fantasy, kéthetente.', 47.4807000, 19.0685000),
(11, 'Kávéházi Versbarátok', 'Felolvasás és beszélgetés kávé mellett.', 47.4973000, 19.0534000),
(12, 'Nyelvmolyok Köre', 'Fordítások, nyelvi érdekességek, műfordítás.', 47.4931000, 19.0348000),
(13, 'Történelem és Tea', 'Történelmi regények és esszék.', 47.5088000, 19.0409000);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `book_club_members`
--

CREATE TABLE `book_club_members` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `club_id` int(10) UNSIGNED NOT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `book_clubs`
--
ALTER TABLE `book_clubs`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `book_club_members`
--
ALTER TABLE `book_club_members`
  ADD PRIMARY KEY (`user_id`,`club_id`),
  ADD KEY `idx_club` (`club_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `book_clubs`
--
ALTER TABLE `book_clubs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `book_club_members`
--
ALTER TABLE `book_club_members`
  ADD CONSTRAINT `fk_members_club` FOREIGN KEY (`club_id`) REFERENCES `book_clubs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
