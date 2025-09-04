-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Sze 03. 21:07
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
-- Adatbázis: `kl_registration`
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

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `book_club_members`
--

CREATE TABLE `book_club_members` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `club_id` int(10) UNSIGNED NOT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `donation_clicks`
--

CREATE TABLE `donation_clicks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `target_id` int(10) UNSIGNED NOT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `clicked_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `donation_targets`
--

CREATE TABLE `donation_targets` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category` enum('háborús-sebesültek','egészség','oktatás','állatvédelem','környezet','szociális','kultúra','egyéb') NOT NULL DEFAULT 'háborús-sebesültek',
  `website_url` varchar(500) DEFAULT NULL,
  `donate_url` varchar(500) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `ertekelesek`
--

CREATE TABLE `ertekelesek` (
  `eid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `kid` int(11) NOT NULL,
  `eszoveg` varchar(255) NOT NULL,
  `edatum` date NOT NULL,
  `status` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `free_books`
--

CREATE TABLE `free_books` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `owner_user_id` int(10) UNSIGNED DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `status` enum('available','reserved','gone') NOT NULL DEFAULT 'available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `free_book_requests`
--

CREATE TABLE `free_book_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `book_id` int(10) UNSIGNED NOT NULL,
  `requester_user_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `processed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `klista`
--

CREATE TABLE `klista` (
  `klid` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `kid` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `oldal` int(11) NOT NULL,
  `ertek` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `konyvek`
--

CREATE TABLE `konyvek` (
  `konyvid` int(11) NOT NULL,
  `kcim` varchar(255) NOT NULL,
  `alcim` varchar(255) DEFAULT NULL,
  `borito` varchar(255) DEFAULT NULL,
  `iro` varchar(100) DEFAULT NULL,
  `kiado` varchar(255) DEFAULT NULL,
  `kdatum` varchar(11) DEFAULT NULL,
  `mufaj` varchar(255) NOT NULL,
  `statusz` varchar(2) NOT NULL,
  `leiras` text DEFAULT NULL,
  `ar` int(11) DEFAULT NULL,
  `oldal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kosar`
--

CREATE TABLE `kosar` (
  `koid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `kid` int(11) NOT NULL,
  `statusz` int(11) DEFAULT NULL,
  `kdatum` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `login`
--

CREATE TABLE `login` (
  `logid` int(255) NOT NULL,
  `logdate` datetime NOT NULL,
  `logip` varchar(48) NOT NULL,
  `logsession` varchar(8) NOT NULL,
  `luid` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `naplo`
--

CREATE TABLE `naplo` (
  `nid` int(255) NOT NULL,
  `ndate` datetime NOT NULL,
  `nip` varchar(48) NOT NULL,
  `nsession` varchar(8) NOT NULL,
  `nuid` int(255) NOT NULL,
  `nurl` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `support`
--

CREATE TABLE `support` (
  `supportid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `sszoveg` text NOT NULL,
  `svalasz` text DEFAULT NULL,
  `sstatusz` int(11) NOT NULL,
  `stat` int(11) NOT NULL,
  `sdatum` datetime NOT NULL DEFAULT current_timestamp(),
  `slezar` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `uid` int(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `uemail` varchar(255) NOT NULL,
  `upassword` varchar(64) NOT NULL,
  `uprofkepnev` varchar(50) NOT NULL,
  `uprofkepnev_eredetinev` varchar(250) NOT NULL,
  `udatum` datetime NOT NULL,
  `uip` varchar(48) NOT NULL,
  `usession` varchar(8) NOT NULL,
  `ustatusz` varchar(2) NOT NULL,
  `ukomment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `vasarlas`
--

CREATE TABLE `vasarlas` (
  `vid` int(11) NOT NULL,
  `koid` int(11) NOT NULL,
  `nev` varchar(40) NOT NULL,
  `cardnumber` varchar(40) NOT NULL,
  `ldatum` varchar(40) NOT NULL,
  `cvv` varchar(3) NOT NULL,
  `statusz` int(11) NOT NULL,
  `datum` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

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
-- A tábla indexei `donation_clicks`
--
ALTER TABLE `donation_clicks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `target_id` (`target_id`),
  ADD KEY `idx_clicked_at` (`clicked_at`);

--
-- A tábla indexei `donation_targets`
--
ALTER TABLE `donation_targets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category` (`category`),
  ADD KEY `verified` (`verified`);

--
-- A tábla indexei `ertekelesek`
--
ALTER TABLE `ertekelesek`
  ADD PRIMARY KEY (`eid`);

--
-- A tábla indexei `free_books`
--
ALTER TABLE `free_books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `owner_user_id` (`owner_user_id`);

--
-- A tábla indexei `free_book_requests`
--
ALTER TABLE `free_book_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`);

--
-- A tábla indexei `klista`
--
ALTER TABLE `klista`
  ADD PRIMARY KEY (`klid`);

--
-- A tábla indexei `konyvek`
--
ALTER TABLE `konyvek`
  ADD PRIMARY KEY (`konyvid`);

--
-- A tábla indexei `kosar`
--
ALTER TABLE `kosar`
  ADD PRIMARY KEY (`koid`);

--
-- A tábla indexei `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`logid`);

--
-- A tábla indexei `naplo`
--
ALTER TABLE `naplo`
  ADD PRIMARY KEY (`nid`);

--
-- A tábla indexei `support`
--
ALTER TABLE `support`
  ADD PRIMARY KEY (`supportid`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`);

--
-- A tábla indexei `vasarlas`
--
ALTER TABLE `vasarlas`
  ADD PRIMARY KEY (`vid`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `book_clubs`
--
ALTER TABLE `book_clubs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `donation_clicks`
--
ALTER TABLE `donation_clicks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `donation_targets`
--
ALTER TABLE `donation_targets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `ertekelesek`
--
ALTER TABLE `ertekelesek`
  MODIFY `eid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `free_books`
--
ALTER TABLE `free_books`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `free_book_requests`
--
ALTER TABLE `free_book_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `klista`
--
ALTER TABLE `klista`
  MODIFY `klid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `konyvek`
--
ALTER TABLE `konyvek`
  MODIFY `konyvid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `kosar`
--
ALTER TABLE `kosar`
  MODIFY `koid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `login`
--
ALTER TABLE `login`
  MODIFY `logid` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `naplo`
--
ALTER TABLE `naplo`
  MODIFY `nid` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `support`
--
ALTER TABLE `support`
  MODIFY `supportid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `vasarlas`
--
ALTER TABLE `vasarlas`
  MODIFY `vid` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `book_club_members`
--
ALTER TABLE `book_club_members`
  ADD CONSTRAINT `fk_members_club` FOREIGN KEY (`club_id`) REFERENCES `book_clubs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `donation_clicks`
--
ALTER TABLE `donation_clicks`
  ADD CONSTRAINT `fk_clicks_target` FOREIGN KEY (`target_id`) REFERENCES `donation_targets` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `free_book_requests`
--
ALTER TABLE `free_book_requests`
  ADD CONSTRAINT `fk_fbr_book` FOREIGN KEY (`book_id`) REFERENCES `free_books` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
