-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Sze 11. 20:22
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

--
-- A tábla adatainak kiíratása `donation_clicks`
--

INSERT INTO `donation_clicks` (`id`, `user_id`, `target_id`, `ip`, `user_agent`, `clicked_at`) VALUES
(6, 28, 33, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-03 17:05:13'),
(7, 28, 33, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-03 17:05:32'),
(8, 28, 68, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-03 17:12:33'),
(9, 28, 66, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-03 17:12:42'),
(10, 28, 63, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-03 17:12:51'),
(11, 28, 51, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-03 17:13:00');

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

--
-- A tábla adatainak kiíratása `donation_targets`
--

INSERT INTO `donation_targets` (`id`, `name`, `description`, `category`, `website_url`, `donate_url`, `city`, `country`, `verified`, `created_by`, `created_at`) VALUES
(33, 'Magyar Ökumenikus Segélyszervezet', 'Válság- és háború sújtotta térségek, rászorulók támogatása.', 'háborús-sebesültek', 'https://segelyszervezet.hu', 'https://segelyszervezet.hu/adomanyozas/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(34, 'Magyar Vöröskereszt', 'Humanitárius segítségnyújtás belföldön és nemzetközileg.', 'háborús-sebesültek', 'https://voroskereszt.hu', 'https://voroskereszt.hu/adomanyozas/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(35, 'Katolikus Karitász – Caritas Hungarica', 'Szociális és krízishelyzetek támogatása országosan.', 'háborús-sebesültek', 'https://karitasz.hu', 'https://karitasz.hu/segitene/onlineadomany', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(36, 'Magyar Református Szeretetszolgálat', 'Kárpátaljai és hazai rászorulók, háború érintettek segítése.', 'háborús-sebesültek', 'https://jobbadni.hu', 'https://jobbadni.hu/adomanyozas/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(37, 'Baptista Szeretetszolgálat', 'Hazai és nemzetközi humanitárius, szociális támogatás.', 'szociális', 'https://www.baptistasegely.hu', 'https://adomany.baptistasegely.hu/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(38, 'Országos Mentőszolgálat Alapítvány', 'Életmentés támogatása, eszközfejlesztés.', 'egészség', 'https://www.mentoalapitvany.hu', 'https://mentoalapitvany.hu/tamogatom', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(39, 'Magyar Hospice Alapítvány', 'Méltó életvégi ellátás támogatása.', 'egészség', 'https://hospicehaz.hu', 'https://hospicehaz.hu/adomanyozas/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(40, 'Bethesda Kórház Alapítvány', 'Gyermekgyógyászat fejlesztése, eszközbeszerzés.', 'egészség', 'https://www.bethesda.hu', 'https://www.bethesda.hu/adomanyok/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(41, 'Heim Pál Kórház Fejlesztéséért Alapítvány', 'Gyermekkórház fejlesztése, betegellátás támogatása.', 'egészség', 'https://heimalap.hu', 'https://heimalap.hu/adomanyozok/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(42, 'Bátor Tábor', 'Súlyosan beteg gyerekek élményterápiája.', 'egészség', 'https://batortabor.org/hu', 'https://batortabor.org/hu/tamogass/maganszemelyek/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(43, 'Csodalámpa Alapítvány', 'Életveszélyesen beteg gyerekek kívánságteljesítése.', 'egészség', 'https://www.csodalampa.hu', 'https://www.csodalampa.hu/csodalampa/Adom%C3%A1nyoz%C3%A1s', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(44, 'UNICEF Magyarország', 'Gyermekek védelme, oktatás, egészség világszerte.', 'szociális', 'https://unicef.hu', 'https://unicef.hu/igy-segithetsz/maganszemelykent/egyedi-adomanyozas', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(45, 'SOS Gyermekfalvak Magyarország', 'Hátrányos helyzetű gyermekek családi környezetben.', 'szociális', 'https://www.sos.hu', 'https://www.sos.hu/adomany/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(46, 'Hintalovon Gyermekjogi Alapítvány', 'Gyermekjogok érvényesítése, szemléletformálás.', 'oktatás', 'https://hintalovon.hu', 'https://hintalovon.hu/category/adomanyozas/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(47, 'Igazgyöngy Alapítvány', 'Esélyteremtés, oktatás és közösségfejlesztés Kelet-Mo.-n.', 'oktatás', 'https://igazgyongyalapitvany.hu', 'https://igazgyongyalapitvany.hu/tamogatas/penzadomany/', 'Berettyóújfalu', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(48, 'Utcáról Lakásba! Egyesület', 'Lakhatási szegénység csökkentése, lakhatási programok.', 'szociális', 'https://utcarollakasba.hu', 'https://utcarollakasba.hu/adomanyozas/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(49, 'Menhely Alapítvány', 'Hajléktalan emberek támogatása.', 'szociális', 'https://www.menhely.hu', 'https://www.menhely.hu/most-adok/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(50, 'Budapest Bike Maffia', 'Közösségi segítség a rászorulóknak, élelmiszer- és tárgyi adományok.', 'szociális', 'https://bikemaffia.com', 'https://bikemaffia.com/adomanyozz/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(51, 'Rex Kutyaotthon Alapítvány', 'Állatmentés, felelős állattartás népszerűsítése.', 'állatvédelem', 'https://www.rex.hu', 'https://www.rex.hu/hu/tamogatas', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(52, 'NOÉ Állatotthon Alapítvány', 'Elhagyott állatok mentése, örökbeadás.', 'állatvédelem', 'https://noeallatotthon.hu', 'https://noeallatotthon.hu/index.php?pid=2', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(53, 'WWF Magyarország', 'Természetvédelem, biodiverzitás védelme.', 'környezet', 'https://wwf.hu', 'https://wwf.hu/adomanyozz/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(54, 'Greenpeace Magyarország', 'Környezetvédelmi kampányok, klímavédelem.', 'környezet', 'https://greenpeace.hu', 'https://sites.greenpeace.hu/tamogatas/', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(55, 'Magyar Madártani és Természetvédelmi Egyesület (MME)', 'Madarak és élőhelyeik védelme.', 'környezet', 'https://mme.hu', 'https://dep.mme.hu/adomanyozas', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 17:04:59'),
(56, 'Budapesti Fesztiválzenekar Alapítvány', 'Nemzetközi hírű zenekar, közösségi és ifjúsági programokkal.', 'kultúra', 'https://www.bfz.hu/', 'https://www.bfz.hu/en/support-us', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18'),
(57, 'Petőfi Irodalmi Múzeum', 'Irodalmi hagyatékok őrzése, kutatás és közművelődés.', 'kultúra', 'https://pim.hu/', 'https://pim.hu/rolunk/tamogasson-minket', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18'),
(58, 'Magyar Zenei Kulturális Alapítvány', 'Zenei tehetségek és projektek támogatása.', 'kultúra', 'https://www.magyarzeneikultura.hu/', 'https://www.magyarzeneikultura.hu/kozvetlen-adomany/', '', 'HU', 1, 1, '2025-09-03 17:12:18'),
(59, 'Magyar Zene Háza – Támogatói Kör', 'A zenei közművelődés és programok támogatása.', 'kultúra', 'https://zenehaza.hu/', 'https://zenehaza.hu/tamogatoi-kor', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18'),
(60, 'Színház Alapítvány (Színház folyóirat)', 'A Színház folyóirat működésének támogatása.', 'kultúra', 'https://szinhaz.net/', 'https://szinhaz.net/tamogatas/', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18'),
(61, 'Alapítvány a Magyar Színházakért (eSzínház)', 'Közösségi gyűjtések a független színházakért.', 'kultúra', 'https://eszinhaz.hu/', 'https://eszinhaz.hu/hu/fuggetlenek', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18'),
(62, 'Könyvmentők Kulturális Egyesület', 'Használt könyvek megmentése, olvasás népszerűsítése.', 'kultúra', 'https://konyvmentok.hu/', 'https://konyvmentok.hu/tamogatas', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18'),
(63, 'NIOK Alapítvány', 'A hazai civil és adományozási ökoszisztéma fejlesztése.', 'egyéb', 'https://www.niok.hu/', 'https://www.niok.hu/tamogass', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18'),
(64, 'Önkéntes Központ Alapítvány (ÖKA)', 'Önkéntesség fejlesztése, programok, képzések.', 'egyéb', 'https://www.onkenteskozpontalapitvany.hu/', 'https://www.onkenteskozpontalapitvany.hu/tamogass/', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18'),
(65, 'Uccu Roma Informális Oktatási Alapítvány', 'Párbeszéd és érzékenyítés roma és nem roma fiatalok közt.', 'egyéb', 'https://www.uccualapitvany.hu/', 'https://www.uccualapitvany.hu/tamogass/', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18'),
(66, 'Autistic Art Alapítvány', 'Autista lakóotthonok és művészeti programok támogatása.', 'egyéb', 'https://autisticart.hu/', 'https://autisticart.hu/segitesz/adomanyozas/', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18'),
(67, 'InDaHouse Hungary Egyesület', 'Hátrányos helyzetű gyerekek fejlesztése Borsodban.', 'egyéb', 'https://indahousehungary.hu/', 'https://indahousehungary.hu/adomanyozas', 'Hernádszentandrás', 'HU', 1, 1, '2025-09-03 17:12:18'),
(68, 'Háttér Társaság', 'LMBTQI közösség támogatása jogi és segítő szolgáltatásokkal.', 'egyéb', 'https://hatter.hu/', 'https://hatter.hu/hogyan-segithetsz/adomany', 'Budapest', 'HU', 1, 1, '2025-09-03 17:12:18');

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
-- Tábla szerkezet ehhez a táblához `events`
--

CREATE TABLE `events` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `cities` varchar(100) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `start_at` datetime NOT NULL,
  `end_at` datetime NOT NULL,
  `capacity` int(10) UNSIGNED DEFAULT NULL,
  `is_cancelled` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `cities`, `location`, `start_at`, `end_at`, `capacity`, `is_cancelled`, `created_at`) VALUES
(1, 'Olvasóklub – kortárs próza', 'Közös beszélgetés friss magyar prózáról.', 'Kecskemét', NULL, '2025-09-26 18:00:00', '2025-09-26 20:00:00', 30, 0, '2025-09-11 17:05:53'),
(2, 'Író–olvasó találkozó', 'Kérdezz-felelek egy meghívott szerzővel.', 'Budapest', NULL, '2025-09-27 17:00:00', '2025-09-27 18:30:00', 60, 0, '2025-09-11 17:05:53'),
(3, 'Nyelvművelő est', 'Szép magyar beszéd és helyesírás játékosan.', 'Debrecen', NULL, '2025-09-28 18:00:00', '2025-09-28 19:30:00', 40, 0, '2025-09-11 17:05:53'),
(4, 'Könyvkötészeti bemutató', 'Hogyan készül a kézműves kötés? Gyakorlati bemutató.', 'Szeged', NULL, '2025-09-29 16:00:00', '2025-09-29 18:00:00', 25, 0, '2025-09-11 17:05:53'),
(5, 'Versklub - kortárs líra estje', 'Felolvasás és közös beszélgetés a mai magyar líráról.', 'Budapest', NULL, '2025-10-02 18:00:00', '2025-10-02 19:30:00', 40, 0, '2025-09-11 17:10:09'),
(6, 'Mesedélután családoknak', 'Közös meseolvasás és kézműves foglalkozás gyerekeknek.', 'Debrecen', NULL, '2025-10-03 17:00:00', '2025-10-03 18:30:00', 50, 0, '2025-09-11 17:10:09'),
(7, 'Könyvcsere piknik', 'Hozz egy könyvet, vigyél egy könyvet! Szabad csere-bere.', 'Szeged', NULL, '2025-10-04 19:00:00', '2025-10-04 21:00:00', 60, 0, '2025-09-11 17:10:09'),
(8, 'Fantasy olvasókör', 'Kedvenc fantasy világaink közös átbeszélése, ajánlók.', 'Pécs', NULL, '2025-10-05 16:30:00', '2025-10-05 18:00:00', 30, 0, '2025-09-11 17:10:09'),
(9, 'Krimi est - skandináv krimik', 'Hideg tájak forró ügyekkel: skandináv krimikről kötetlenül.', 'Győr', NULL, '2025-10-06 18:00:00', '2025-10-06 20:00:00', 45, 0, '2025-09-11 17:10:09'),
(10, 'Ismeretterjesztő előadás - űrkutatás', 'Hol tart ma az űrkutatás? Képek, sztorik, könyvajánlók.', 'Miskolc', NULL, '2025-10-07 17:30:00', '2025-10-07 19:00:00', 80, 0, '2025-09-11 17:10:09'),
(11, 'Fordítói műhely', 'Hogyan lesz a kéziratból magyar kiadás? Gyakorlati példák.', 'Nyíregyháza', NULL, '2025-10-08 18:30:00', '2025-10-08 20:00:00', 25, 0, '2025-09-11 17:10:09'),
(12, 'Könyvtári beavatás - kezdőknek', 'Tippek a gyors kereséshez és az online katalógushoz.', 'Kecskemét', NULL, '2025-10-09 17:00:00', '2025-10-09 19:00:00', 35, 0, '2025-09-11 17:10:09'),
(13, 'Sci-fi film és könyv klub', 'Klasszikus sci-fi filmek és alapművek párhuzamai.', 'Székesfehérvár', NULL, '2025-10-10 18:00:00', '2025-10-10 19:30:00', 50, 0, '2025-09-11 17:10:09'),
(14, 'Képregény klub', 'Európai és amerikai képregények: stílusok és irányzatok.', 'Szombathely', NULL, '2025-10-11 18:00:00', '2025-10-11 20:30:00', 40, 0, '2025-09-11 17:10:09'),
(15, 'Kreatív írás kezdőknek', 'Karakter, nézőpont, jelenetek: gyakorlat és visszajelzés.', 'Eger', NULL, '2025-10-12 17:00:00', '2025-10-12 18:30:00', 20, 0, '2025-09-11 17:10:09'),
(16, 'Kreatív írás haladóknak', 'Struktúra, ív és stílus: haladó műhelymunka.', 'Veszprém', NULL, '2025-10-13 19:00:00', '2025-10-13 21:00:00', 18, 0, '2025-09-11 17:10:09'),
(17, 'Esszé workshop', 'Rövid non-fiction szövegek hatásos felépítése.', 'Zalaegerszeg', NULL, '2025-10-14 16:00:00', '2025-10-14 18:00:00', 22, 0, '2025-09-11 17:10:09'),
(18, 'Olvasd újra a klasszikusokat', 'Miért aktuálisak ma is? Új olvasatok, viták.', 'Tatabánya', NULL, '2025-10-15 17:30:00', '2025-10-15 19:30:00', 45, 0, '2025-09-11 17:10:09'),
(19, 'Költészet és zene', 'Versek megzenésítve – élő előadással.', 'Kaposvár', NULL, '2025-10-16 18:00:00', '2025-10-16 19:00:00', 70, 0, '2025-09-11 17:10:09'),
(20, 'Irodalmi kvíz est', 'Csapatkvíz könyvmolyoknak – nyereményekkel.', 'Sopron', NULL, '2025-10-17 17:00:00', '2025-10-17 19:00:00', 60, 0, '2025-09-11 17:10:09'),
(21, 'Könyvbarátok reggelije', 'Könnyed beszélgetés kávé mellett, új megjelenésekről.', 'Szolnok', NULL, '2025-10-18 18:00:00', '2025-10-18 20:00:00', 28, 0, '2025-09-11 17:10:09'),
(22, 'Ifjúsági regények klubja', 'Kortárs YA-kötetek – ajánlók és vita.', 'Salgótarján', NULL, '2025-10-19 17:30:00', '2025-10-19 19:00:00', 35, 0, '2025-09-11 17:10:09'),
(23, 'Történelmi regények estje', 'Időutazás regényekkel – hitelesség és fikció.', 'Békéscsaba', NULL, '2025-10-20 19:00:00', '2025-10-20 21:00:00', 45, 0, '2025-09-11 17:10:09'),
(24, 'Könyv és kávé - beszélgetős délután', 'Kötetlen közösségi délután, könyvtippekkel.', 'Baja', NULL, '2025-10-21 16:30:00', '2025-10-21 18:00:00', 24, 0, '2025-09-11 17:10:09'),
(25, 'Helytörténeti est', 'Régi fotók, térképek és helyi történetek.', 'Dunaújváros', NULL, '2025-10-22 18:00:00', '2025-10-22 20:00:00', 55, 0, '2025-09-11 17:10:09'),
(26, 'Drámaolvasó kör', 'Rövid drámák felolvasása és megbeszélése.', 'Siófok', NULL, '2025-10-23 17:00:00', '2025-10-23 18:30:00', 26, 0, '2025-09-11 17:10:09'),
(27, 'Tudományos fantasztikum est', 'Hard és soft sci-fi – mi a különbség?', 'Esztergom', NULL, '2025-10-24 18:30:00', '2025-10-24 20:30:00', 48, 0, '2025-09-11 17:10:09'),
(28, 'Utazós irodalom klub', 'Világjárás könyvekkel: memoárok és útikönyvek.', 'Vác', NULL, '2025-10-25 16:00:00', '2025-10-25 17:30:00', 32, 0, '2025-09-11 17:10:09'),
(29, 'Gasztroirodalom est', 'Receptek és történetek – kulináris könyvajánlók.', 'Gödöllő', NULL, '2025-10-26 19:00:00', '2025-10-26 21:00:00', 36, 0, '2025-09-11 17:10:09'),
(30, 'Női írók estje', 'Kiemelkedő női szerzők műveiről beszélgetünk.', 'Pápa', NULL, '2025-10-27 17:30:00', '2025-10-27 19:00:00', 40, 0, '2025-09-11 17:10:09'),
(31, 'Elsőkönyvesek bemutatkozása', 'Debütáló szerzők mesélnek az írásról és kiadásról.', 'Hódmezővásárhely', NULL, '2025-10-28 18:00:00', '2025-10-28 19:30:00', 50, 0, '2025-09-11 17:10:09'),
(32, 'Book swapping night', 'Angol nyelvű könyvcsere est – hozd el kedvenceid!', 'Nagykanizsa', NULL, '2025-10-29 17:00:00', '2025-10-29 18:30:00', 30, 0, '2025-09-11 17:10:09'),
(33, 'Könyvtrailerek készítése', 'Videós ajánló készítése egyszerű eszközökkel.', 'Budaörs', NULL, '2025-10-30 18:00:00', '2025-10-30 20:00:00', 20, 0, '2025-09-11 17:10:09'),
(34, 'Hangoskönyv klub', 'Melyik narráció működik? Ajánlók és vélemények.', 'Mosonmagyaróvár', NULL, '2025-10-31 16:30:00', '2025-10-31 18:00:00', 42, 0, '2025-09-11 17:10:09'),
(35, 'Nyitott mikrofon - felolvasóest', 'Hozd a saját szöveged és olvasd fel!', 'Érd', NULL, '2025-11-01 19:00:00', '2025-11-01 21:00:00', 45, 0, '2025-09-11 17:10:09'),
(36, 'Költő a könyvtárban - beszélgetés', 'Vendégünk egy kortárs költő – kérdezz-felelek.', 'Dunakeszi', NULL, '2025-11-02 17:30:00', '2025-11-02 19:00:00', 70, 0, '2025-09-11 17:10:09'),
(37, 'Novellapályázat eredményhirdetés', 'Felolvasás a díjazott művekből és beszélgetés a zsűrivel.', 'Cegléd', NULL, '2025-11-03 18:00:00', '2025-11-03 19:30:00', 60, 0, '2025-09-11 17:10:09'),
(38, 'Irodalomterápia beszélgetés', 'Olvasás lélekemelő ereje – tapasztalatcsere.', 'Kiskunfélegyháza', NULL, '2025-11-04 17:00:00', '2025-11-04 18:30:00', 25, 0, '2025-09-11 17:10:09'),
(39, 'Könyvkötészeti miniworkshop', 'Egyszerű fűzött jegyzetfüzet készítése otthonra.', 'Kiskunhalas', NULL, '2025-11-05 18:00:00', '2025-11-05 20:00:00', 22, 0, '2025-09-11 17:10:09');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `event_registrations`
--

CREATE TABLE `event_registrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `registered_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `org_only` tinyint(1) NOT NULL DEFAULT 0,
  `recipient_org_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `free_books`
--

INSERT INTO `free_books` (`id`, `title`, `author`, `description`, `city`, `image_url`, `owner_user_id`, `contact_email`, `contact_phone`, `status`, `org_only`, `recipient_org_id`, `created_at`) VALUES
(1, 'Egri csillagok', 'Gárdonyi Géza', 'Jó állapot, budai átvétel.', 'Budapest', NULL, NULL, 'hirdeto1@example.com', '+36 30 111 1111', 'available', 0, NULL, '2025-09-03 11:28:40'),
(2, 'A Pál utcai fiúk', 'Molnár Ferenc', 'Költözés miatt elvihető.', 'Debrecen', NULL, NULL, 'hirdeto2@example.com', NULL, 'available', 0, NULL, '2025-09-03 11:28:40'),
(3, 'Galaxis útikalauz stopposoknak', 'Douglas Adams', 'Használt, de vállalható.', 'Szeged', NULL, NULL, NULL, '+36 20 222 2222', 'available', 0, NULL, '2025-09-03 11:28:40'),
(4, 'Egri csillagok', 'Gárdonyi Géza', 'Jó állapot, budai átvétel.', 'Budapest', NULL, NULL, 'hirdeto1@example.com', '+36 30 111 1111', 'available', 0, NULL, '2025-09-03 12:39:03'),
(5, 'A Pál utcai fiúk', 'Molnár Ferenc', 'Költözés miatt elvihető.', 'Debrecen', NULL, NULL, 'hirdeto2@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(6, 'Galaxis útikalauz stopposoknak', 'Douglas Adams', 'Használt, de vállalható.', 'Szeged', NULL, NULL, NULL, '+36 20 222 2222', 'available', 0, NULL, '2025-09-03 12:39:03'),
(7, 'A kis herceg', 'Antoine de Saint-Exupéry', 'Pár jegyzet a margón.', 'Győr', NULL, NULL, 'konyv@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(8, '1984', 'George Orwell', 'Keménykötés, kissé sárgult lapok.', 'Pécs', NULL, NULL, 'orwell@example.com', '+36 70 333 3333', 'available', 0, NULL, '2025-09-03 12:39:03'),
(9, 'Fahrenheit 451', 'Ray Bradbury', 'Klasszikus sci-fi.', 'Miskolc', NULL, NULL, NULL, '+36 30 444 4444', 'available', 0, NULL, '2025-09-03 12:39:03'),
(10, 'A Gyűrűk Ura I.', 'J. R. R. Tolkien', 'Hiánytalan, fóliázás nincs.', 'Sopron', NULL, NULL, 'tolkien@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(11, 'Száz év magány', 'Gabriel García Márquez', 'Ajándékba kaptam, nem olvastam.', 'Kecskemét', NULL, NULL, NULL, '+36 20 555 5555', 'available', 0, NULL, '2025-09-03 12:39:03'),
(12, 'Bűn és bűnhődés', 'Fjodor Dosztojevszkij', 'Keménykötés, hibátlan.', 'Nyíregyháza', NULL, NULL, 'oroszklasz@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(13, 'Pride and Prejudice', 'Jane Austen', 'Angol nyelvű kiadás.', 'Veszprém', NULL, NULL, 'austen@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(14, 'Verne válogatott művei', 'Jules Verne', 'Több kisregény egy kötetben.', 'Székesfehérvár', NULL, NULL, NULL, '+36 70 666 6666', 'available', 0, NULL, '2025-09-03 12:39:03'),
(15, 'A kőszívű ember fiai', 'Jókai Mór', 'Használt, de szép állapot.', 'Zalaegerszeg', NULL, NULL, 'jokai@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(16, 'Utazás a Föld középpontja felé', 'Jules Verne', 'Illusztrált kiadás.', 'Kaposvár', NULL, NULL, NULL, '+36 30 777 7777', 'available', 0, NULL, '2025-09-03 12:39:03'),
(17, 'Dűne', 'Frank Herbert', 'Filmes borítóval.', 'Tatabánya', NULL, NULL, 'scifi@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(18, 'A mester és Margarita', 'Mihail Bulgakov', 'Kissé kopott borító.', 'Szombathely', NULL, NULL, 'bulgakov@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(19, 'A fekete város', 'Mikszáth Kálmán', 'Régi kiadás.', 'Békéscsaba', NULL, NULL, NULL, '+36 20 888 8888', 'available', 0, NULL, '2025-09-03 12:39:03'),
(20, 'Mester és tanítványa', 'Feldmár András', 'Pár aláhúzás benne.', 'Salgótarján', NULL, NULL, 'pszicho@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(21, 'A bibliai történetek', '—', 'Gyerekeknek szóló válogatás.', 'Eger', NULL, NULL, NULL, '+36 70 999 9999', 'available', 0, NULL, '2025-09-03 12:39:03'),
(22, 'A nagy Gatsby', 'F. Scott Fitzgerald', 'Vadonatúj állapot.', 'Esztergom', NULL, NULL, 'gatsby@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(23, 'Édes Anna', 'Kosztolányi Dezső', 'Jó állapot, tiszta lapok.', 'Dunaújváros', NULL, NULL, 'magyar@example.com', NULL, 'available', 0, NULL, '2025-09-03 12:39:03'),
(24, 'asd', 'Testo Lajos', 'asd', 'Buda', NULL, 28, 'asd@gmail.com', '+36306636753', 'available', 0, NULL, '2025-09-03 16:41:24'),
(25, 'Egri csillagok', 'Gárdonyi Géza', 'Klasszikus, jó állapot.', 'Budapest', NULL, 40, NULL, NULL, 'available', 0, NULL, '2025-09-09 17:56:22'),
(26, 'Pál utcai fiúk', 'Molnár Ferenc', 'Kis kopás a sarkokon.', 'Pécs', NULL, 41, NULL, NULL, 'available', 0, NULL, '2025-09-09 17:56:22'),
(27, 'A nagy könyvmentés I.', 'Válogatás', 'Iskolai könyvtárnak ajánlott csomag.', 'Budapest', NULL, 32, NULL, NULL, 'available', 1, NULL, '2025-09-09 17:56:22'),
(28, 'Természettudomány csomag', 'Válogatás', 'Középiskolai termtud. könyvek.', 'Szeged', NULL, 33, NULL, NULL, 'available', 1, NULL, '2025-09-09 17:56:22'),
(29, 'Ifjúsági könyvcsomag', 'Válogatás', 'Fiataloknak, 10-14 év.', 'Pécs', NULL, 36, NULL, NULL, 'available', 1, NULL, '2025-09-09 17:56:22'),
(30, 'Nyelvkönyv csomag', 'Válogatás', 'Angol/német alapfok, vegyes kiadás.', 'Debrecen', NULL, 39, NULL, NULL, 'available', 1, NULL, '2025-09-09 17:56:22'),
(31, 'Gyermekirodalmi csomag', 'Válogatás', 'Hátrányos helyzetű gyerekeknek.', 'Budapest', NULL, 32, NULL, NULL, 'available', 1, 33, '2025-09-09 17:56:22'),
(32, 'Irodalmi klasszikusok csomag', 'Válogatás', 'Szépirodalmi válogatás.', 'Budapest', NULL, 37, NULL, NULL, 'available', 1, 34, '2025-09-09 17:56:22'),
(33, 'Történelem csomag', 'Válogatás', 'Középiskolai történelem könyvek.', 'Szeged', NULL, 35, NULL, NULL, 'available', 1, 38, '2025-09-09 17:56:22'),
(34, 'A kőszívű ember fiai', 'Jókai Mór', 'Keményfedeles, tiszta.', 'Budapest', NULL, 41, NULL, NULL, 'available', 0, NULL, '2025-09-09 17:56:22'),
(35, 'Tüskevár', 'Fekete István', 'Kissé sárgult lapok.', 'Szeged', NULL, 40, NULL, NULL, 'available', 0, NULL, '2025-09-09 17:56:22');

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

--
-- A tábla adatainak kiíratása `free_book_requests`
--

INSERT INTO `free_book_requests` (`id`, `book_id`, `requester_user_id`, `name`, `email`, `phone`, `message`, `created_at`, `processed`) VALUES
(1, 1, NULL, 'Lakovich Richard', 'lariz200120@gmail.com', '06306636753', '', '2025-09-03 11:48:26', 0),
(2, 4, 28, 'Lakovich Richard', 'lariz200120@gmail.com', '06306636753', 'asfhdfg', '2025-09-03 16:39:36', 0),
(3, 24, 28, 'Lakovich Richard', 'lariz200120@gmail.com', '06306636753', '', '2025-09-03 16:42:11', 0);

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

--
-- A tábla adatainak kiíratása `konyvek`
--

INSERT INTO `konyvek` (`konyvid`, `kcim`, `alcim`, `borito`, `iro`, `kiado`, `kdatum`, `mufaj`, `statusz`, `leiras`, `ar`, `oldal`) VALUES
(1, 'Research in action', 'Theories and practices for innovation and social change', 'http://books.google.com/books/content?id=Gs_7EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', 'Conny Almekinders, Leni Beukema, Coyan Tromp', 'BRILL', '2023-09-04', 'Social Science', 'a', 'Research in action engages the researcher who wants to live up to the challenges of contemporary science and to contribute to innovation and social change. This ambition to contribute to change raises many questions. How to define the main target group of the research? What role does this group play in the research? Which methods of data collection are most appropriate? Who are the commissioners of the research and do their interests match with those of the prime target group? How to deal with power relations in research situations? What do these issues mean for the relation of researcher with the people in the researched situation? And, last but not least, what does it all imply for the researcher him- or herself? These questions have to be dealt with in situations in which the design and organization of the research is still open but also in situations where these have already been preformatted through the research proposal or earlier developments. In any case, they have to be framed in the theoretical considerations of what is science. This book aims to assist scholars and practitioners who would want to deal with this kind of research and questions. The book does not offer recipes, nor fixed scenarios. It presents a series of practical research cases and theoretical insights by experienced researchers who themselves struggled with what is probably the most meaningful questions of the science today. The practical examples of research in action are from different disciplines and include themes from health care, policy research, agricultural technology and education, in Northern and Southern context. Four leading themes of research in action are introduced in the first chapter. In the last chapter the editors return to the dilemmas research in action and try to clarify the options and responses that are possible in different situations.', 2999, 272),
(2, 'Controversies in Affirmative Action', 'volumes', 'http://books.google.com/books/content?id=HEXPEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', 'James A. Beckman', 'Bloomsbury Publishing USA', '2014-07-23', 'Social Science', 'b', 'An engaging and eclectic collection of essays from leading scholars on the subject, which looks at affirmative action past and present, analyzes its efficacy, its legacy, and its role in the future of the United States. This comprehensive, three-volume set explores the ways the United States has interpreted affirmative action and probes the effects of the policy from the perspectives of economics, law, philosophy, psychology, sociology, political science, and race relations. Expert contributors tackle a host of knotty issues, ranging from the history of affirmative action to the theories underpinning it. They show how affirmative action has been implemented over the years, discuss its legality and constitutionality, and speculate about its future. Volume one traces the origin and evolution of affirmative action. Volume two discusses modern applications and debates, and volume three delves into such areas as international practices and critical race theory. Standalone essays link cause and effect and past and present as they tackle intriguing—and important—questions. When does affirmative action become \"reverse discrimination\"? How many decades are too many for a temporary\r\npolicy to remain in existence? Does race- or gender-based affirmative action violate the equal protection of law guaranteed by the Fourteenth Amendment? In raising such issues, the work encourages readers to come to their own conclusions about the policy and its future application.', 2999, 973),
(3, 'The Affirmative Action Debate', 'nincs', 'http://books.google.com/books/content?id=uT_jAQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', 'Steven M. Cahn', 'Routledge', '2013-10-31', 'Business & Economics', 'a', 'First Published in 1996. Routledge is an imprint of Taylor & Francis, an informa company.', 2999, 236),
(4, 'Action Learning in Health, Social and Community Care', 'Principles, Practices and Resources', 'http://books.google.com/books/content?id=EuM2DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', 'John Edmonstone', 'CRC Press', '2017-09-22', 'Medical', 'a', 'This comprehensive guide covers all aspects of action learning, one of the most widely used development methods in health, social and community care. The book addresses the theory and practice of action learning in these fields, and considers action learning as an adult educational ethos as well as a helpful tool. Based upon emerging experience, it identifies good practice in action learning and offers a wide range of resources to enable individuals and organisations extract maximum benefit from this approach. Offering practical tips grounded in sound educational principles, this book is invaluable reading for all senior managers and professionals considering using action learning for leadership, management and organisation development purposes, including organisation development practitioners and action learning facilitators, and for medical and healthcare educators and their counterparts in social and community care looking for a general introduction to this growing field.', 3000, 319),
(5, 'Romantic Love', NULL, 'http://books.google.com/books/content?id=b1yOJtOwvWIC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', 'Yolanda van Ede', 'LIT Verlag Munster', '2006', 'Family & Relationships', 'a', 'A book about romantic love.', 2881, 138),
(6, 'Women\'s Romantic Theatre and Drama', 'History, Agency, and Performativity', 'http://books.google.com/books/content?id=1s2MeSIsk3oC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', 'Lilla Maria Crisafulli, Keir Elam', 'Ashgate Publishing, Ltd.', '2010', 'Literary Collections', 'a', 'Bringing together leading British, North American, and Italian critics, this collection makes a crucial intervention in the reclamation of women\'s theatrical activities during the Romantic period.', 2699, 308);

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

--
-- A tábla adatainak kiíratása `login`
--

INSERT INTO `login` (`logid`, `logdate`, `logip`, `logsession`, `luid`) VALUES
(65, '2025-09-02 12:34:02', '::1', 'smr6b9b3', 28),
(66, '2025-09-02 14:45:13', '::1', 'smr6b9b3', 28),
(67, '2025-09-02 15:12:55', '::1', 'smr6b9b3', 28),
(68, '2025-09-02 15:32:45', '::1', 'smr6b9b3', 28),
(69, '2025-09-03 09:49:48', '::1', '4lt5dn6v', 28),
(70, '2025-09-03 13:48:43', '::1', '4lt5dn6v', 28),
(71, '2025-09-03 14:22:46', '::1', '4lt5dn6v', 28),
(72, '2025-09-03 18:05:13', '::1', '4lt5dn6v', 28),
(73, '2025-09-04 10:26:46', '::1', '4p0g65lp', 28),
(74, '2025-09-04 12:21:08', '::1', '4p0g65lp', 28),
(75, '2025-09-04 12:55:20', '::1', '4p0g65lp', 30),
(76, '2025-09-07 11:30:32', '::1', 'd78igo7s', 31),
(77, '2025-09-10 13:01:06', '::1', '28258b6d', 42),
(78, '2025-09-10 19:22:12', '::1', 'clggkkm6', 42),
(79, '2025-09-10 19:22:47', '::1', 'clggkkm6', 28),
(80, '2025-09-11 10:19:45', '::1', '5tc643pm', 28),
(81, '2025-09-11 10:20:25', '::1', '5tc643pm', 42),
(82, '2025-09-11 18:11:24', '::1', '5tc643pm', 42),
(83, '2025-09-11 18:16:32', '::1', '5tc643pm', 42),
(84, '2025-09-11 19:06:16', '::1', '5tc643pm', 42);

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

--
-- A tábla adatainak kiíratása `naplo`
--

INSERT INTO `naplo` (`nid`, `ndate`, `nip`, `nsession`, `nuid`, `nurl`) VALUES
(2852, '2025-08-28 16:39:13', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/'),
(2853, '2025-08-28 16:39:22', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=login'),
(2854, '2025-08-28 16:39:27', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=reg'),
(2855, '2025-08-28 16:39:32', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=reg'),
(2856, '2025-08-28 16:39:34', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p='),
(2857, '2025-08-28 16:39:35', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p='),
(2858, '2025-08-28 16:39:38', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=kosar'),
(2859, '2025-08-28 16:39:40', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p='),
(2860, '2025-08-28 16:39:41', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p='),
(2861, '2025-08-28 16:41:10', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=kosar'),
(2862, '2025-08-28 16:41:11', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p='),
(2863, '2025-08-28 16:41:11', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=reg'),
(2864, '2025-08-28 16:41:12', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=login'),
(2865, '2025-08-28 16:41:13', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/'),
(2866, '2025-08-28 16:41:15', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/'),
(2867, '2025-08-28 16:41:29', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=login'),
(2868, '2025-08-28 16:41:30', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=reg'),
(2869, '2025-08-28 16:41:54', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=reg'),
(2870, '2025-08-28 16:42:06', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/?p=login'),
(2871, '2025-08-28 16:42:06', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/'),
(2872, '2025-08-28 16:42:09', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/'),
(2873, '2025-08-28 16:42:24', '::1', 'ffqj8f6j', 0, '/vizsgaremek-main/vizsgaremek-main/vizsgaremek/'),
(2874, '2025-09-02 12:33:30', '::1', 'smr6b9b3', 0, '/vizsgaremek/'),
(2875, '2025-09-02 12:33:34', '::1', 'smr6b9b3', 0, '/vizsgaremek/?p=login'),
(2876, '2025-09-02 12:33:37', '::1', 'smr6b9b3', 0, '/vizsgaremek/?p=reg'),
(2877, '2025-09-02 12:33:54', '::1', 'smr6b9b3', 0, '/vizsgaremek/?p=login'),
(2878, '2025-09-02 12:34:02', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvek'),
(2879, '2025-09-02 12:34:08', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvek'),
(2880, '2025-09-02 12:34:08', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyv_lista'),
(2881, '2025-09-02 12:34:09', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=support'),
(2882, '2025-09-02 12:34:10', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyv_lista'),
(2883, '2025-09-02 12:34:11', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2884, '2025-09-02 12:34:13', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=adatlapom'),
(2885, '2025-09-02 12:34:49', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2886, '2025-09-02 12:34:49', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2887, '2025-09-02 12:34:50', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvek'),
(2888, '2025-09-02 12:34:51', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyv_lista'),
(2889, '2025-09-02 12:34:51', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=support'),
(2890, '2025-09-02 12:34:52', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyv_lista'),
(2891, '2025-09-02 12:34:52', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvek'),
(2892, '2025-09-02 12:48:37', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=support'),
(2893, '2025-09-02 12:48:38', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyv_lista'),
(2894, '2025-09-02 12:48:39', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvek'),
(2895, '2025-09-02 12:48:40', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2896, '2025-09-02 12:48:41', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2897, '2025-09-02 12:48:41', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2898, '2025-09-02 12:48:41', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2899, '2025-09-02 12:55:33', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2900, '2025-09-02 12:55:36', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2901, '2025-09-02 12:55:37', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2902, '2025-09-02 12:55:38', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2903, '2025-09-02 12:55:38', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2904, '2025-09-02 12:55:38', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2905, '2025-09-02 13:20:50', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2906, '2025-09-02 13:20:51', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2907, '2025-09-02 13:22:33', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2908, '2025-09-02 13:23:39', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2909, '2025-09-02 13:25:39', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2910, '2025-09-02 13:39:17', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2911, '2025-09-02 13:49:07', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2912, '2025-09-02 13:49:50', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2913, '2025-09-02 13:49:58', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2914, '2025-09-02 13:50:57', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2915, '2025-09-02 14:39:05', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2916, '2025-09-02 14:40:13', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2917, '2025-09-02 14:44:46', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2918, '2025-09-02 14:44:55', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2919, '2025-09-02 14:45:11', '::1', 'smr6b9b3', 0, '/vizsgaremek/?='),
(2920, '2025-09-02 14:45:12', '::1', 'smr6b9b3', 0, '/vizsgaremek/?p=login'),
(2921, '2025-09-02 14:45:13', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvek'),
(2922, '2025-09-02 14:45:15', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2923, '2025-09-02 14:52:13', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2924, '2025-09-02 14:53:43', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2925, '2025-09-02 14:58:45', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2926, '2025-09-02 15:00:30', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=support'),
(2927, '2025-09-02 15:00:32', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2928, '2025-09-02 15:00:41', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2929, '2025-09-02 15:00:44', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2930, '2025-09-02 15:02:25', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2931, '2025-09-02 15:06:12', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2932, '2025-09-02 15:06:36', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2933, '2025-09-02 15:06:40', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2934, '2025-09-02 15:06:44', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2935, '2025-09-02 15:06:51', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2936, '2025-09-02 15:06:55', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2937, '2025-09-02 15:08:03', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2938, '2025-09-02 15:12:36', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2939, '2025-09-02 15:12:40', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2940, '2025-09-02 15:12:44', '::1', 'smr6b9b3', 0, '/vizsgaremek/?='),
(2941, '2025-09-02 15:12:45', '::1', 'smr6b9b3', 0, '/vizsgaremek/?p=konyvklub'),
(2942, '2025-09-02 15:12:53', '::1', 'smr6b9b3', 0, '/vizsgaremek/?p=login'),
(2943, '2025-09-02 15:12:55', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvek'),
(2944, '2025-09-02 15:12:59', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2945, '2025-09-02 15:13:02', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2946, '2025-09-02 15:13:04', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2947, '2025-09-02 15:13:06', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2948, '2025-09-02 15:13:07', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2949, '2025-09-02 15:20:16', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvklub'),
(2950, '2025-09-02 15:20:18', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=gyik'),
(2951, '2025-09-02 15:25:54', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=gyik'),
(2952, '2025-09-02 15:30:53', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=gyik'),
(2953, '2025-09-02 15:32:34', '::1', 'smr6b9b3', 0, '/vizsgaremek/?='),
(2954, '2025-09-02 15:32:35', '::1', 'smr6b9b3', 0, '/vizsgaremek/?p=konyvek'),
(2955, '2025-09-02 15:32:36', '::1', 'smr6b9b3', 0, '/vizsgaremek/?p=konyvklub'),
(2956, '2025-09-02 15:32:40', '::1', 'smr6b9b3', 0, '/vizsgaremek/?p=gyik'),
(2957, '2025-09-02 15:32:44', '::1', 'smr6b9b3', 0, '/vizsgaremek/?p=login'),
(2958, '2025-09-02 15:32:45', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvek'),
(2959, '2025-09-02 15:33:15', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p=konyvek'),
(2960, '2025-09-02 15:33:16', '::1', 'smr6b9b3', 28, '/vizsgaremek/?p='),
(2961, '2025-09-03 08:38:54', '::1', '4lt5dn6v', 0, '/vizsgaremek/'),
(2962, '2025-09-03 08:38:56', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=konyvklub'),
(2963, '2025-09-03 09:12:47', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=konyvklub'),
(2964, '2025-09-03 09:19:51', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=konyvklub'),
(2965, '2025-09-03 09:19:53', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=konyvklub'),
(2966, '2025-09-03 09:21:11', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=konyvklub'),
(2967, '2025-09-03 09:21:13', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2968, '2025-09-03 09:21:50', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2969, '2025-09-03 09:21:51', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2970, '2025-09-03 09:21:51', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=gyik'),
(2971, '2025-09-03 09:21:52', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2972, '2025-09-03 09:21:52', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2973, '2025-09-03 09:21:53', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2974, '2025-09-03 09:21:53', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2975, '2025-09-03 09:21:53', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2976, '2025-09-03 09:21:53', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2977, '2025-09-03 09:22:37', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=gyik'),
(2978, '2025-09-03 09:22:38', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2979, '2025-09-03 09:22:47', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2980, '2025-09-03 09:22:55', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2981, '2025-09-03 09:22:56', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2982, '2025-09-03 09:22:58', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2983, '2025-09-03 09:23:06', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(2984, '2025-09-03 09:23:15', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=oktat%C3%A1s'),
(2985, '2025-09-03 09:23:17', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(2986, '2025-09-03 09:23:20', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=k%C3%B6rnyezet'),
(2987, '2025-09-03 09:23:22', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=szoci%C3%A1lis'),
(2988, '2025-09-03 09:23:24', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=kult%C3%BAra'),
(2989, '2025-09-03 09:23:25', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(2990, '2025-09-03 09:23:28', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(2991, '2025-09-03 09:23:41', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(2992, '2025-09-03 09:24:06', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(2993, '2025-09-03 09:27:42', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(2994, '2025-09-03 09:27:44', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(2995, '2025-09-03 09:27:44', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(2996, '2025-09-03 09:27:44', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(2997, '2025-09-03 09:27:44', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(2998, '2025-09-03 09:27:44', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(2999, '2025-09-03 09:27:44', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3000, '2025-09-03 09:27:58', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3001, '2025-09-03 09:28:30', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3002, '2025-09-03 09:28:31', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3003, '2025-09-03 09:28:31', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3004, '2025-09-03 09:28:42', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3005, '2025-09-03 09:29:18', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3006, '2025-09-03 09:34:57', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3007, '2025-09-03 09:34:59', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3008, '2025-09-03 09:35:00', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3009, '2025-09-03 09:35:00', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3010, '2025-09-03 09:35:00', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3011, '2025-09-03 09:35:00', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3012, '2025-09-03 09:35:00', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3013, '2025-09-03 09:35:01', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3014, '2025-09-03 09:35:01', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3015, '2025-09-03 09:35:01', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3016, '2025-09-03 09:35:31', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3017, '2025-09-03 09:35:50', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=szoci%C3%A1lis'),
(3018, '2025-09-03 09:35:52', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3019, '2025-09-03 09:38:27', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3020, '2025-09-03 09:38:28', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3021, '2025-09-03 09:38:37', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3022, '2025-09-03 09:39:59', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3023, '2025-09-03 09:40:00', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3024, '2025-09-03 09:40:28', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3025, '2025-09-03 09:46:08', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3026, '2025-09-03 09:46:53', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3027, '2025-09-03 09:46:57', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(3028, '2025-09-03 09:46:58', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3029, '2025-09-03 09:47:26', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3030, '2025-09-03 09:47:42', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3031, '2025-09-03 09:47:56', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3032, '2025-09-03 09:49:07', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3033, '2025-09-03 09:49:31', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(3034, '2025-09-03 09:49:33', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3035, '2025-09-03 09:49:39', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3036, '2025-09-03 09:49:42', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(3037, '2025-09-03 09:49:44', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=adomanyozz'),
(3038, '2025-09-03 09:49:47', '::1', '4lt5dn6v', 0, '/vizsgaremek/?p=login'),
(3039, '2025-09-03 09:49:48', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=konyvek'),
(3040, '2025-09-03 09:49:51', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz'),
(3041, '2025-09-03 09:49:54', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz'),
(3042, '2025-09-03 09:49:56', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz'),
(3043, '2025-09-03 09:50:06', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz'),
(3044, '2025-09-03 09:51:35', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz'),
(3045, '2025-09-03 09:51:52', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz&q=budapest&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3046, '2025-09-03 09:51:57', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz&q=budapest&cat=eg%C3%A9szs%C3%A9g'),
(3047, '2025-09-03 09:52:06', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz'),
(3048, '2025-09-03 10:07:48', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz'),
(3049, '2025-09-03 10:07:49', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz'),
(3050, '2025-09-03 10:07:50', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=konyv_lista'),
(3051, '2025-09-03 10:07:50', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=support'),
(3052, '2025-09-03 10:07:51', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=konyvklub'),
(3053, '2025-09-03 10:07:53', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=konyvek'),
(3054, '2025-09-03 11:59:48', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=konyvklub'),
(3055, '2025-09-03 12:00:23', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=konyvklub'),
(3056, '2025-09-03 12:00:36', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=konyvklub'),
(3057, '2025-09-03 12:06:02', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=gyik'),
(3058, '2025-09-03 12:06:08', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=adomanyozz'),
(3059, '2025-09-03 13:09:06', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3060, '2025-09-03 13:09:08', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p='),
(3061, '2025-09-03 13:33:16', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p='),
(3062, '2025-09-03 13:33:19', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3063, '2025-09-03 13:33:30', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3064, '2025-09-03 13:33:37', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyveim'),
(3065, '2025-09-03 13:33:39', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_kereseim'),
(3066, '2025-09-03 13:33:42', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyveim'),
(3067, '2025-09-03 13:33:43', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3068, '2025-09-03 13:33:43', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3069, '2025-09-03 13:48:17', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?='),
(3070, '2025-09-03 13:48:20', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3071, '2025-09-03 13:48:21', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyv_igenyles&id=1'),
(3072, '2025-09-03 13:48:23', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyv_igenyles&id=1'),
(3073, '2025-09-03 13:48:26', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyv_igenyles&id=1'),
(3074, '2025-09-03 13:48:39', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3075, '2025-09-03 13:48:42', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=login'),
(3076, '2025-09-03 13:48:43', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvek'),
(3077, '2025-09-03 13:48:46', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_kereseim'),
(3078, '2025-09-03 13:48:47', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyveim'),
(3079, '2025-09-03 13:48:47', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3080, '2025-09-03 13:50:33', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3081, '2025-09-03 13:50:37', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3082, '2025-09-03 13:50:52', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3083, '2025-09-03 13:58:06', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3084, '2025-09-03 13:58:10', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3085, '2025-09-03 13:58:54', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3086, '2025-09-03 13:59:00', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3087, '2025-09-03 13:59:02', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3088, '2025-09-03 13:59:03', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyveim'),
(3089, '2025-09-03 14:03:07', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?='),
(3090, '2025-09-03 14:03:12', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=login'),
(3091, '2025-09-03 14:03:14', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3092, '2025-09-03 14:19:28', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3093, '2025-09-03 14:19:57', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3094, '2025-09-03 14:20:21', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3095, '2025-09-03 14:21:06', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3096, '2025-09-03 14:21:23', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3097, '2025-09-03 14:22:35', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3098, '2025-09-03 14:22:45', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=login'),
(3099, '2025-09-03 14:22:46', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvek'),
(3100, '2025-09-03 14:22:51', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3101, '2025-09-03 14:22:54', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3102, '2025-09-03 14:29:56', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3103, '2025-09-03 14:32:30', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3104, '2025-09-03 14:32:37', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3105, '2025-09-03 14:33:02', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3106, '2025-09-03 14:33:21', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3107, '2025-09-03 14:38:26', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3108, '2025-09-03 14:39:05', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3109, '2025-09-03 14:41:40', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3110, '2025-09-03 14:42:59', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3111, '2025-09-03 14:43:00', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3112, '2025-09-03 14:43:00', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3113, '2025-09-03 14:43:00', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3114, '2025-09-03 14:46:41', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3115, '2025-09-03 14:47:20', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3116, '2025-09-03 14:47:21', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3117, '2025-09-03 14:47:21', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3118, '2025-09-03 14:47:21', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3119, '2025-09-03 14:47:21', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3120, '2025-09-03 14:47:36', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3121, '2025-09-03 14:47:37', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3122, '2025-09-03 14:47:37', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3123, '2025-09-03 14:47:43', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3124, '2025-09-03 14:48:45', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3125, '2025-09-03 14:49:08', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3126, '2025-09-03 14:49:09', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3127, '2025-09-03 14:49:09', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3128, '2025-09-03 14:49:19', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3129, '2025-09-03 14:49:26', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3130, '2025-09-03 14:49:45', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3131, '2025-09-03 14:50:10', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3132, '2025-09-03 14:53:19', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3133, '2025-09-03 14:53:52', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3134, '2025-09-03 14:54:02', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3135, '2025-09-03 14:54:03', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3136, '2025-09-03 14:54:03', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3137, '2025-09-03 14:54:15', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3138, '2025-09-03 14:58:33', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3139, '2025-09-03 14:59:58', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3140, '2025-09-03 15:00:12', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3141, '2025-09-03 17:14:40', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3142, '2025-09-03 17:14:43', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3143, '2025-09-03 17:14:44', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3144, '2025-09-03 17:14:46', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyveim'),
(3145, '2025-09-03 17:14:47', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_kereseim'),
(3146, '2025-09-03 18:04:21', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?='),
(3147, '2025-09-03 18:04:27', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3148, '2025-09-03 18:05:12', '::1', '4lt5dn6v', 0, '/vizsgaremek_teszt/?p=login'),
(3149, '2025-09-03 18:05:13', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvek'),
(3150, '2025-09-03 18:05:18', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3151, '2025-09-03 18:05:36', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyveim'),
(3152, '2025-09-03 18:05:54', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_kereseim'),
(3153, '2025-09-03 18:06:03', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvklub'),
(3154, '2025-09-03 18:06:07', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3155, '2025-09-03 18:06:54', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=support'),
(3156, '2025-09-03 18:07:10', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvklub'),
(3157, '2025-09-03 18:07:11', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3158, '2025-09-03 18:07:13', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3159, '2025-09-03 18:07:17', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=szoci%C3%A1lis'),
(3160, '2025-09-03 18:07:20', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyv_lista'),
(3161, '2025-09-03 18:07:21', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3162, '2025-09-03 18:07:24', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3163, '2025-09-03 18:07:45', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3164, '2025-09-03 18:07:58', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=oktat%C3%A1s'),
(3165, '2025-09-03 18:08:00', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(3166, '2025-09-03 18:08:01', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=k%C3%B6rnyezet'),
(3167, '2025-09-03 18:08:16', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyv_lista'),
(3168, '2025-09-03 18:08:17', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=support'),
(3169, '2025-09-03 18:08:57', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=support'),
(3170, '2025-09-03 18:09:01', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3171, '2025-09-03 18:09:08', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=support'),
(3172, '2025-09-03 18:09:12', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyv_lista'),
(3173, '2025-09-03 18:11:33', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvklub'),
(3174, '2025-09-03 18:11:35', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvklub'),
(3175, '2025-09-03 18:12:20', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvklub'),
(3176, '2025-09-03 18:16:13', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvklub'),
(3177, '2025-09-03 18:16:15', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvklub'),
(3178, '2025-09-03 18:16:18', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3179, '2025-09-03 18:16:21', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3180, '2025-09-03 18:16:25', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3181, '2025-09-03 18:16:28', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(3182, '2025-09-03 18:16:31', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3183, '2025-09-03 18:16:33', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(3184, '2025-09-03 18:16:35', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=kult%C3%BAra'),
(3185, '2025-09-03 18:16:38', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3186, '2025-09-03 18:16:41', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3187, '2025-09-03 18:16:45', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(3188, '2025-09-03 18:16:49', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3189, '2025-09-03 18:16:55', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3190, '2025-09-03 18:17:01', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3191, '2025-09-03 18:23:25', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3192, '2025-09-03 18:24:08', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3193, '2025-09-03 18:24:16', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3194, '2025-09-03 18:25:27', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3195, '2025-09-03 18:25:48', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3196, '2025-09-03 18:26:04', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3197, '2025-09-03 18:27:17', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3198, '2025-09-03 18:27:28', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3199, '2025-09-03 18:28:45', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3200, '2025-09-03 18:35:19', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3201, '2025-09-03 18:39:30', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3202, '2025-09-03 18:39:32', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_igenyles&id=4'),
(3203, '2025-09-03 18:39:36', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_igenyles&id=4'),
(3204, '2025-09-03 18:39:55', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_kereseim'),
(3205, '2025-09-03 18:40:00', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3206, '2025-09-03 18:40:16', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3207, '2025-09-03 18:41:24', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3208, '2025-09-03 18:42:07', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3209, '2025-09-03 18:42:09', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_igenyles&id=24'),
(3210, '2025-09-03 18:42:11', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_igenyles&id=24'),
(3211, '2025-09-03 18:42:17', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyv_lista'),
(3212, '2025-09-03 18:44:28', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3213, '2025-09-03 18:47:47', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3214, '2025-09-03 18:55:04', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_feladas'),
(3215, '2025-09-03 18:55:12', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3216, '2025-09-03 18:55:13', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_igenyles&id=24'),
(3217, '2025-09-03 18:55:16', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_igenyles&id=24'),
(3218, '2025-09-03 18:56:28', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyv_igenyles&id=24'),
(3219, '2025-09-03 19:05:09', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=ingyen_konyvek'),
(3220, '2025-09-03 19:05:11', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3221, '2025-09-03 19:05:18', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3222, '2025-09-03 19:05:34', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3223, '2025-09-03 19:05:45', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3224, '2025-09-03 19:05:50', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=oktat%C3%A1s'),
(3225, '2025-09-03 19:05:51', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(3226, '2025-09-03 19:05:53', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=k%C3%B6rnyezet'),
(3227, '2025-09-03 19:05:54', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=szoci%C3%A1lis'),
(3228, '2025-09-03 19:05:56', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=kult%C3%BAra'),
(3229, '2025-09-03 19:05:58', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3230, '2025-09-03 19:06:01', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3231, '2025-09-03 19:12:21', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3232, '2025-09-03 19:12:24', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=kult%C3%BAra'),
(3233, '2025-09-03 19:12:25', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3234, '2025-09-03 19:12:40', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3235, '2025-09-03 19:12:47', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3236, '2025-09-03 19:12:54', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3237, '2025-09-03 19:12:59', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(3238, '2025-09-03 19:13:05', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=%C3%A1llatv%C3%A9delem'),
(3239, '2025-09-03 19:13:18', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3240, '2025-09-03 19:13:21', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3241, '2025-09-03 19:13:25', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3242, '2025-09-03 19:14:16', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3243, '2025-09-03 19:21:08', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3244, '2025-09-03 19:21:09', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3245, '2025-09-03 19:21:09', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3246, '2025-09-03 19:21:09', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3247, '2025-09-03 19:21:10', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3248, '2025-09-03 19:21:12', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=eg%C3%A9szs%C3%A9g'),
(3249, '2025-09-03 19:21:32', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3250, '2025-09-03 19:21:33', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3251, '2025-09-03 19:21:47', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3252, '2025-09-03 19:21:48', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3253, '2025-09-03 19:21:48', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3254, '2025-09-03 19:21:51', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=szoci%C3%A1lis'),
(3255, '2025-09-03 19:21:53', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=egy%C3%A9b'),
(3256, '2025-09-03 19:21:56', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3257, '2025-09-03 19:22:11', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3258, '2025-09-03 19:22:11', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3259, '2025-09-03 19:22:11', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3260, '2025-09-03 19:22:40', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3261, '2025-09-03 19:23:12', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3262, '2025-09-03 19:27:33', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz&q=&cat=h%C3%A1bor%C3%BAs-sebes%C3%BCltek'),
(3263, '2025-09-03 19:27:38', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3264, '2025-09-03 19:27:41', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=konyvek'),
(3265, '2025-09-03 19:27:42', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3266, '2025-09-03 19:27:48', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3267, '2025-09-03 19:27:49', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3268, '2025-09-03 19:29:14', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3269, '2025-09-03 19:30:19', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3270, '2025-09-03 19:32:15', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3271, '2025-09-03 19:34:05', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3272, '2025-09-03 19:34:16', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3273, '2025-09-03 19:40:51', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3274, '2025-09-03 19:43:39', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3275, '2025-09-03 19:45:18', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3276, '2025-09-03 19:49:34', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3277, '2025-09-03 19:50:21', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=adomanyozz'),
(3278, '2025-09-03 19:50:24', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3279, '2025-09-03 19:50:41', '::1', '4lt5dn6v', 28, '/vizsgaremek_teszt/?p=gyik'),
(3280, '2025-09-04 09:01:10', '::1', '4p0g65lp', 0, '/vizsgaremek_teszt/'),
(3281, '2025-09-04 09:01:54', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/'),
(3282, '2025-09-04 09:01:57', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=gyik'),
(3283, '2025-09-04 09:01:57', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=konyvklub'),
(3284, '2025-09-04 09:01:58', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=adomanyozz'),
(3285, '2025-09-04 09:01:58', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=gyik'),
(3286, '2025-09-04 10:26:44', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=login'),
(3287, '2025-09-04 10:26:46', '::1', '4p0g65lp', 28, '/vizsgaremek_vegleges_2.0/?p=konyvek'),
(3288, '2025-09-04 12:19:03', '::1', '4p0g65lp', 28, '/vizsgaremek_vegleges_2.0/?p=konyvklub'),
(3289, '2025-09-04 12:20:03', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?='),
(3290, '2025-09-04 12:20:05', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=konyvklub'),
(3291, '2025-09-04 12:21:07', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=login'),
(3292, '2025-09-04 12:21:08', '::1', '4p0g65lp', 28, '/vizsgaremek_vegleges_2.0/?p=konyvek'),
(3293, '2025-09-04 12:44:36', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?='),
(3294, '2025-09-04 12:44:38', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=login'),
(3295, '2025-09-04 12:44:39', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=reg'),
(3296, '2025-09-04 12:44:58', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=login'),
(3297, '2025-09-04 12:45:15', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=reg'),
(3298, '2025-09-04 12:55:15', '::1', '4p0g65lp', 0, '/vizsgaremek_vegleges_2.0/?p=login'),
(3299, '2025-09-04 12:55:20', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=konyvek'),
(3300, '2025-09-04 12:55:34', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=adomanyozz'),
(3301, '2025-09-04 12:56:37', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=support'),
(3302, '2025-09-04 12:56:40', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyvek'),
(3303, '2025-09-04 12:57:15', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyv_feladas'),
(3304, '2025-09-04 12:57:43', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyveim'),
(3305, '2025-09-04 12:57:45', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyv_feladas'),
(3306, '2025-09-04 12:57:48', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyv_kereseim'),
(3307, '2025-09-04 12:57:52', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyveim'),
(3308, '2025-09-04 12:58:13', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyv_kereseim'),
(3309, '2025-09-04 13:28:12', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=support'),
(3310, '2025-09-04 14:37:47', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/'),
(3311, '2025-09-04 14:37:49', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=adomanyozz'),
(3312, '2025-09-04 14:37:50', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=gyik'),
(3313, '2025-09-04 14:37:51', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=konyvklub'),
(3314, '2025-09-04 14:37:53', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyv_feladas'),
(3315, '2025-09-04 14:37:55', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyvek'),
(3316, '2025-09-04 14:37:56', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyv_kereseim'),
(3317, '2025-09-04 14:37:58', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_2.0/?p=ingyen_konyveim'),
(3318, '2025-09-04 14:45:43', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/'),
(3319, '2025-09-04 14:45:45', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/?p=adomanyozz'),
(3320, '2025-09-04 14:45:50', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/?p=konyv_lista'),
(3321, '2025-09-04 14:45:51', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/?p=adomanyozz'),
(3322, '2025-09-04 14:45:52', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/?p=gyik'),
(3323, '2025-09-04 14:45:52', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/?p=konyvklub'),
(3324, '2025-09-04 14:48:39', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/?p=konyvklub'),
(3325, '2025-09-04 14:48:40', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/?p=konyvek'),
(3326, '2025-09-04 14:48:45', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/?p=konyvklub'),
(3327, '2025-09-04 14:48:46', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/?p=gyik'),
(3328, '2025-09-04 14:48:46', '::1', '4p0g65lp', 30, '/vizsgaremek_vegleges_3.0/?p=adomanyozz'),
(3329, '2025-09-07 11:27:00', '::1', 'd78igo7s', 0, '/vizsgaremek_vegleges_4.0/'),
(3330, '2025-09-07 11:27:04', '::1', 'd78igo7s', 0, '/vizsgaremek_vegleges_4.0/?p=login'),
(3331, '2025-09-07 11:29:52', '::1', 'd78igo7s', 0, '/vizsgaremek_vegleges_4.0/?p=reg'),
(3332, '2025-09-07 11:30:28', '::1', 'd78igo7s', 0, '/vizsgaremek_vegleges_4.0/?p=login'),
(3333, '2025-09-07 11:30:32', '::1', 'd78igo7s', 31, '/vizsgaremek_vegleges_4.0/?p=konyvek'),
(3334, '2025-09-09 19:54:09', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/'),
(3335, '2025-09-09 20:32:15', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/'),
(3336, '2025-09-09 20:32:16', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=login'),
(3337, '2025-09-09 20:32:17', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg'),
(3338, '2025-09-09 20:38:54', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg'),
(3339, '2025-09-09 20:39:27', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg'),
(3340, '2025-09-09 20:39:37', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3341, '2025-09-09 21:11:47', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3342, '2025-09-09 21:12:01', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p='),
(3343, '2025-09-09 21:12:03', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=konyvek'),
(3344, '2025-09-09 21:12:06', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3345, '2025-09-09 21:13:28', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3346, '2025-09-09 21:13:29', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3347, '2025-09-09 21:13:29', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3348, '2025-09-09 21:13:29', '::1', 'n5oqdtml', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3349, '2025-09-10 12:59:46', '::1', '28258b6d', 0, '/vizsgaremek_vegleges_4.0_test/'),
(3350, '2025-09-10 12:59:49', '::1', '28258b6d', 0, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3351, '2025-09-10 13:01:03', '::1', '28258b6d', 0, '/vizsgaremek_vegleges_4.0_test/?p=login'),
(3352, '2025-09-10 13:01:06', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=konyvek'),
(3353, '2025-09-10 13:01:11', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3354, '2025-09-10 13:01:13', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=ingyen_konyvek'),
(3355, '2025-09-10 13:01:15', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3356, '2025-09-10 13:01:19', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=ingyen_konyvek'),
(3357, '2025-09-10 13:01:19', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=reg_org'),
(3358, '2025-09-10 13:01:21', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=ingyen_konyv_feladas'),
(3359, '2025-09-10 13:01:41', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=ingyen_konyveim'),
(3360, '2025-09-10 13:01:43', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=ingyen_konyv_kereseim'),
(3361, '2025-09-10 13:01:45', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=ingyen_konyvek'),
(3362, '2025-09-10 13:01:46', '::1', '28258b6d', 42, '/vizsgaremek_vegleges_4.0_test/?p=ingyen_konyv_kereseim'),
(3363, '2025-09-10 19:21:58', '::1', 'clggkkm6', 0, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyv_kereseim'),
(3364, '2025-09-10 19:22:02', '::1', 'clggkkm6', 0, '/vizsgaremek_vegleges_4.1/?p='),
(3365, '2025-09-10 19:22:08', '::1', 'clggkkm6', 0, '/vizsgaremek_vegleges_4.1/?p=adomanyozz'),
(3366, '2025-09-10 19:22:09', '::1', 'clggkkm6', 0, '/vizsgaremek_vegleges_4.1/?p=reg_org'),
(3367, '2025-09-10 19:22:11', '::1', 'clggkkm6', 0, '/vizsgaremek_vegleges_4.1/?p=login'),
(3368, '2025-09-10 19:22:12', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3369, '2025-09-10 19:22:14', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3370, '2025-09-10 19:22:15', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3371, '2025-09-10 19:22:17', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyv_feladas'),
(3372, '2025-09-10 19:22:27', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyveim'),
(3373, '2025-09-10 19:22:29', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyv_kereseim'),
(3374, '2025-09-10 19:22:31', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3375, '2025-09-10 19:22:33', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyv_kereseim'),
(3376, '2025-09-10 19:22:35', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=reg_org'),
(3377, '2025-09-10 19:22:36', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=adomanyozz'),
(3378, '2025-09-10 19:22:36', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=gyik'),
(3379, '2025-09-10 19:22:37', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=konyvklub'),
(3380, '2025-09-10 19:22:38', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3381, '2025-09-10 19:22:40', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p='),
(3382, '2025-09-10 19:22:41', '::1', 'clggkkm6', 42, '/vizsgaremek_vegleges_4.1/?p='),
(3383, '2025-09-10 19:22:42', '::1', 'clggkkm6', 0, '/vizsgaremek_vegleges_4.1/?='),
(3384, '2025-09-10 19:22:44', '::1', 'clggkkm6', 0, '/vizsgaremek_vegleges_4.1/?p=login'),
(3385, '2025-09-10 19:22:47', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3386, '2025-09-10 19:22:49', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3387, '2025-09-10 19:22:51', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=konyvek');
INSERT INTO `naplo` (`nid`, `ndate`, `nip`, `nsession`, `nuid`, `nurl`) VALUES
(3388, '2025-09-10 19:23:04', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3389, '2025-09-10 19:23:29', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3390, '2025-09-10 19:31:00', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3391, '2025-09-10 19:31:02', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3392, '2025-09-10 19:31:03', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3393, '2025-09-10 19:31:05', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3394, '2025-09-10 19:31:05', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3395, '2025-09-10 19:31:07', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3396, '2025-09-10 19:31:10', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3397, '2025-09-10 19:31:15', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3398, '2025-09-10 19:31:16', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3399, '2025-09-10 19:31:17', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3400, '2025-09-10 19:31:28', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3401, '2025-09-10 19:31:30', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3402, '2025-09-10 19:31:32', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3403, '2025-09-10 19:31:33', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3404, '2025-09-10 19:31:35', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3405, '2025-09-10 19:32:17', '::1', 'clggkkm6', 28, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3406, '2025-09-11 10:07:59', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.1/'),
(3407, '2025-09-11 10:08:02', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3408, '2025-09-11 10:08:03', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.1/'),
(3409, '2025-09-11 10:19:42', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.1/'),
(3410, '2025-09-11 10:19:44', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.1/?p=login'),
(3411, '2025-09-11 10:19:45', '::1', '5tc643pm', 28, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3412, '2025-09-11 10:19:48', '::1', '5tc643pm', 28, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3413, '2025-09-11 10:20:20', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.1/?='),
(3414, '2025-09-11 10:20:22', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.1/?p=login'),
(3415, '2025-09-11 10:20:25', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.1/?p=konyvek'),
(3416, '2025-09-11 10:20:27', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3417, '2025-09-11 10:20:30', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyv_igenyles&id=25'),
(3418, '2025-09-11 10:20:31', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3419, '2025-09-11 10:20:33', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyv_igenyles&id=28'),
(3420, '2025-09-11 10:20:37', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.1/?p=ingyen_konyvek'),
(3421, '2025-09-11 10:20:40', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.1/?p=adomanyozz'),
(3422, '2025-09-11 11:09:06', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=adomanyozz'),
(3423, '2025-09-11 11:18:47', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=adomanyozz'),
(3424, '2025-09-11 11:24:57', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=adomanyozz'),
(3425, '2025-09-11 11:25:00', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=ingyen_konyvek'),
(3426, '2025-09-11 11:25:04', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?='),
(3427, '2025-09-11 11:25:06', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=login'),
(3428, '2025-09-11 11:25:07', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=reg'),
(3429, '2025-09-11 11:27:37', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=reg'),
(3430, '2025-09-11 15:20:45', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=konyvklub'),
(3431, '2025-09-11 15:20:53', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=konyvklub'),
(3432, '2025-09-11 18:07:11', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p='),
(3433, '2025-09-11 18:07:12', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p='),
(3434, '2025-09-11 18:07:13', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p='),
(3435, '2025-09-11 18:07:14', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=login'),
(3436, '2025-09-11 18:07:16', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p='),
(3437, '2025-09-11 18:07:17', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=konyvek'),
(3438, '2025-09-11 18:07:41', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2/'),
(3439, '2025-09-11 18:11:14', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2/?p=reg_org'),
(3440, '2025-09-11 18:11:23', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2/?p=login'),
(3441, '2025-09-11 18:11:24', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=konyvek'),
(3442, '2025-09-11 18:11:27', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3443, '2025-09-11 18:12:01', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyv_igenyles&id=27'),
(3444, '2025-09-11 18:12:03', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3445, '2025-09-11 18:12:06', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyv_igenyles&id=28'),
(3446, '2025-09-11 18:12:08', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3447, '2025-09-11 18:12:10', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyv_igenyles&id=34'),
(3448, '2025-09-11 18:12:11', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3449, '2025-09-11 18:12:29', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyv_igenyles&id=29'),
(3450, '2025-09-11 18:12:30', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3451, '2025-09-11 18:12:33', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyv_igenyles&id=30'),
(3452, '2025-09-11 18:12:34', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3453, '2025-09-11 18:12:35', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyv_igenyles&id=30'),
(3454, '2025-09-11 18:12:36', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3455, '2025-09-11 18:12:37', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyv_igenyles&id=29'),
(3456, '2025-09-11 18:12:38', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3457, '2025-09-11 18:12:39', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyv_igenyles&id=27'),
(3458, '2025-09-11 18:12:40', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3459, '2025-09-11 18:12:41', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyv_igenyles&id=28'),
(3460, '2025-09-11 18:12:42', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3461, '2025-09-11 18:12:53', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyvek'),
(3462, '2025-09-11 18:12:56', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2/?p=ingyen_konyveim'),
(3463, '2025-09-11 18:14:17', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=login'),
(3464, '2025-09-11 18:14:23', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=ingyen_konyvek'),
(3465, '2025-09-11 18:14:31', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?='),
(3466, '2025-09-11 18:14:34', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=login'),
(3467, '2025-09-11 18:14:35', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=reg'),
(3468, '2025-09-11 18:15:04', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2/?p=reg_org'),
(3469, '2025-09-11 18:15:20', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=login'),
(3470, '2025-09-11 18:15:32', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p='),
(3471, '2025-09-11 18:15:33', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=konyvek'),
(3472, '2025-09-11 18:16:00', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=gyik'),
(3473, '2025-09-11 18:16:31', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=login'),
(3474, '2025-09-11 18:16:32', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=konyvek'),
(3475, '2025-09-11 18:17:13', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?='),
(3476, '2025-09-11 18:17:19', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p='),
(3477, '2025-09-11 18:17:21', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=login'),
(3478, '2025-09-11 18:17:27', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=reg'),
(3479, '2025-09-11 18:18:18', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=login'),
(3480, '2025-09-11 18:19:26', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=gyik'),
(3481, '2025-09-11 18:19:27', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=konyvklub'),
(3482, '2025-09-11 18:43:34', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=konyvklub'),
(3483, '2025-09-11 18:43:35', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3484, '2025-09-11 18:44:11', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3485, '2025-09-11 18:44:15', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3486, '2025-09-11 18:45:15', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3487, '2025-09-11 18:46:16', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3488, '2025-09-11 18:47:17', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3489, '2025-09-11 18:48:18', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3490, '2025-09-11 18:49:19', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3491, '2025-09-11 18:50:05', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3492, '2025-09-11 18:51:05', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3493, '2025-09-11 18:52:06', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3494, '2025-09-11 18:53:07', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3495, '2025-09-11 18:54:08', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3496, '2025-09-11 18:55:09', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3497, '2025-09-11 18:56:10', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3498, '2025-09-11 18:57:11', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3499, '2025-09-11 18:58:12', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3500, '2025-09-11 18:58:15', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3501, '2025-09-11 18:59:15', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3502, '2025-09-11 19:00:16', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3503, '2025-09-11 19:01:17', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3504, '2025-09-11 19:02:18', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3505, '2025-09-11 19:03:19', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3506, '2025-09-11 19:04:20', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3507, '2025-09-11 19:05:21', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3508, '2025-09-11 19:05:59', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3509, '2025-09-11 19:06:15', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=login'),
(3510, '2025-09-11 19:06:16', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=konyvek'),
(3511, '2025-09-11 19:06:17', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3512, '2025-09-11 19:06:19', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3513, '2025-09-11 19:06:21', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3514, '2025-09-11 19:06:23', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3515, '2025-09-11 19:06:24', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3516, '2025-09-11 19:06:25', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3517, '2025-09-11 19:06:25', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3518, '2025-09-11 19:07:25', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3519, '2025-09-11 19:08:26', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3520, '2025-09-11 19:09:27', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3521, '2025-09-11 19:10:12', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3522, '2025-09-11 19:10:20', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=2'),
(3523, '2025-09-11 19:10:25', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=3'),
(3524, '2025-09-11 19:10:26', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=4'),
(3525, '2025-09-11 19:10:28', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=5'),
(3526, '2025-09-11 19:10:29', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=6'),
(3527, '2025-09-11 19:10:31', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=7'),
(3528, '2025-09-11 19:10:32', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=8'),
(3529, '2025-09-11 19:10:33', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=7'),
(3530, '2025-09-11 19:10:35', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=6'),
(3531, '2025-09-11 19:10:36', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=5'),
(3532, '2025-09-11 19:10:37', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=4'),
(3533, '2025-09-11 19:10:38', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=3'),
(3534, '2025-09-11 19:10:39', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3535, '2025-09-11 19:11:05', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3536, '2025-09-11 19:11:06', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3537, '2025-09-11 19:12:07', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3538, '2025-09-11 19:13:08', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3539, '2025-09-11 19:14:09', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3540, '2025-09-11 19:15:10', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3541, '2025-09-11 19:16:11', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3542, '2025-09-11 19:17:12', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3543, '2025-09-11 19:18:13', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3544, '2025-09-11 19:18:40', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3545, '2025-09-11 19:22:34', '::1', '5tc643pm', 42, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek&page=1'),
(3546, '2025-09-11 19:22:43', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?='),
(3547, '2025-09-11 19:22:44', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3548, '2025-09-11 19:30:24', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=gyik'),
(3549, '2025-09-11 19:34:19', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=gyik'),
(3550, '2025-09-11 19:35:14', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=login'),
(3551, '2025-09-11 19:35:15', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=reg'),
(3552, '2025-09-11 19:37:55', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3553, '2025-09-11 19:57:02', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3554, '2025-09-11 19:57:03', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3555, '2025-09-11 19:57:03', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3556, '2025-09-11 19:57:03', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3557, '2025-09-11 19:57:04', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3558, '2025-09-11 19:57:04', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3559, '2025-09-11 19:57:04', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3560, '2025-09-11 19:57:04', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3561, '2025-09-11 19:57:04', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3562, '2025-09-11 19:57:05', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3563, '2025-09-11 19:57:05', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3564, '2025-09-11 19:57:05', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3565, '2025-09-11 19:57:05', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=esemenyek'),
(3566, '2025-09-11 19:57:21', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p='),
(3567, '2025-09-11 19:57:22', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p='),
(3568, '2025-09-11 20:17:11', '::1', '5tc643pm', 0, '/vizsgaremek_vegleges_4.2_test/?p=gyik');

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
  `uid` int(10) UNSIGNED NOT NULL,
  `username` varchar(100) NOT NULL,
  `is_org` tinyint(1) NOT NULL DEFAULT 0,
  `org_name` varchar(255) DEFAULT NULL,
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

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`uid`, `username`, `is_org`, `org_name`, `uemail`, `upassword`, `uprofkepnev`, `uprofkepnev_eredetinev`, `udatum`, `uip`, `usession`, `ustatusz`, `ukomment`) VALUES
(1, 'a', 0, NULL, 'a@a.hu', '0cc175b9c0f1b6a831c399e269772661', '26_250123112947_fs3f78GbjO.png', '25_241216122536_XQ2ecFQUYC.png', '2025-01-16 11:21:36', '', '', 'b', ''),
(2, 'ice', 0, NULL, 'ice@gmail.hu', 'e10adc3949ba59abbe56e057f20f883e', '25_241216122536_XQ2ecFQUYC.png', 'picon.png', '2024-12-11 13:51:56', '', '', 'b', ''),
(28, 'Ricsi', 0, NULL, 'lariz200120@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '', '', '2025-09-02 12:33:52', '', '', 'a', ''),
(29, 'Ricsike', 0, NULL, 'lariz200120@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', '', '', '2025-09-04 12:44:53', '', '', 'a', ''),
(31, 'Vizsgaremek01', 0, NULL, 'remekvizsga01@gmail.com', 'd84ebdde1677c42785f2bf86f110bb40', '', '', '2025-09-07 11:30:26', '', '', 'a', ''),
(32, 'zoldkonyvtar', 1, 'Zöld Könyvtár Egyesület', 'info@zoldkonyvtar.hu', 'jelszo123', '', '', '2025-09-09 19:56:21', '127.0.0.1', 'orgA0001', 'a', ''),
(33, 'konyvmentok', 1, 'Könyvmentők Alapítvány', 'kapcsolat@konyvmentok.hu', 'jelszo123', '', '', '2025-09-09 19:56:21', '127.0.0.1', 'orgA0002', 'a', ''),
(34, 'olvasokert', 1, 'Olvasókért Egyesület', 'hello@olvasokert.hu', 'jelszo123', '', '', '2025-09-09 19:56:21', '127.0.0.1', 'orgA0003', 'a', ''),
(35, 'tiszakonyv', 1, 'Tisza-parti Könyvbarátok', 'info@tiszakonyv.hu', 'jelszo123', '', '', '2025-09-09 19:56:21', '127.0.0.1', 'orgA0004', 'a', ''),
(36, 'konyvkucko_pecs', 1, 'Pécsi Könyvkuckó', 'pecs@konyvkucko.hu', 'jelszo123', '', '', '2025-09-09 19:56:21', '127.0.0.1', 'orgA0005', 'a', ''),
(37, 'budai_olvasokor', 1, 'Budai Olvasókör', 'kapcsolat@budaiolvasokor.hu', 'jelszo123', '', '', '2025-09-09 19:56:21', '127.0.0.1', 'orgA0006', 'a', ''),
(38, 'olvasohid_szeged', 1, 'Szegedi Olvasóhíd', 'hello@olvasohid.hu', 'jelszo123', '', '', '2025-09-09 19:56:21', '127.0.0.1', 'orgA0007', 'a', ''),
(39, 'karpatkonyv', 1, 'Kárpát Könyvbarátai', 'info@karpatkonyv.hu', 'jelszo123', '', '', '2025-09-09 19:56:21', '127.0.0.1', 'orgA0008', 'a', ''),
(40, 'janos', 0, NULL, 'janos@example.com', 'jelszo123', '', '', '2025-09-09 19:56:21', '127.0.0.1', 'user0001', 'a', ''),
(41, 'emma', 0, NULL, 'emma@example.com', 'jelszo123', '', '', '2025-09-09 19:56:21', '127.0.0.1', 'user0002', 'a', ''),
(42, 'Lajos', 1, 'Koppenhágai Világbéke szervezet', 'lariz@gmail.com', '202cb962ac59075b964b07152d234b70', '', '', '2025-09-10 13:00:59', '::1', '28258b6d', 'a', ''),
(43, 'Lajos', 0, NULL, 'lariz200120@gmail.com', '202cb962ac59075b964b07152d234b70', '', '', '2025-09-11 18:15:18', '', '', 'a', ''),
(44, 'Lajos', 0, NULL, 'v@gmail.com', '202cb962ac59075b964b07152d234b70', '', '', '2025-09-11 18:18:12', '', '', 'a', '');

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
-- A tábla indexei `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_start` (`start_at`),
  ADD KEY `idx_end` (`end_at`);

--
-- A tábla indexei `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_event_user` (`event_id`,`user_id`),
  ADD KEY `fk_er_user` (`user_id`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT a táblához `donation_clicks`
--
ALTER TABLE `donation_clicks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `donation_targets`
--
ALTER TABLE `donation_targets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT a táblához `ertekelesek`
--
ALTER TABLE `ertekelesek`
  MODIFY `eid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `events`
--
ALTER TABLE `events`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT a táblához `event_registrations`
--
ALTER TABLE `event_registrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `free_books`
--
ALTER TABLE `free_books`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT a táblához `free_book_requests`
--
ALTER TABLE `free_book_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `klista`
--
ALTER TABLE `klista`
  MODIFY `klid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `konyvek`
--
ALTER TABLE `konyvek`
  MODIFY `konyvid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `kosar`
--
ALTER TABLE `kosar`
  MODIFY `koid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT a táblához `login`
--
ALTER TABLE `login`
  MODIFY `logid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT a táblához `naplo`
--
ALTER TABLE `naplo`
  MODIFY `nid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3569;

--
-- AUTO_INCREMENT a táblához `support`
--
ALTER TABLE `support`
  MODIFY `supportid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `vasarlas`
--
ALTER TABLE `vasarlas`
  MODIFY `vid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
-- Megkötések a táblához `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD CONSTRAINT `fk_er_event` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_er_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `free_book_requests`
--
ALTER TABLE `free_book_requests`
  ADD CONSTRAINT `fk_fbr_book` FOREIGN KEY (`book_id`) REFERENCES `free_books` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
