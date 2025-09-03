-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Sze 03. 10:14
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
(1, 28, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-03 07:49:53'),
(2, 28, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-03 07:49:55'),
(3, 28, 3, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-03 07:50:02'),
(4, 28, 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-03 07:51:33');

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
(1, 'Nemzetközi Segély – Sebesültek', 'Sürgősségi ellátás és szállítás.', 'háborús-sebesültek', 'https://pelda-sebesultek.hu', 'https://pelda-sebesultek.hu/adomany', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(2, 'Rehab Protézis Program', 'Protézisek és rehabilitáció.', 'háborús-sebesültek', 'https://pelda-rehab.hu', 'https://pelda-rehab.hu/tamogatas', 'Debrecen', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(3, 'Frontvonal Orvosi Csapat', 'Orvosi eszközök konfliktusövezetekben.', 'háborús-sebesültek', 'https://pelda-frontmed.hu', 'https://pelda-frontmed.hu/support', 'Szeged', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(4, 'Veteránok Újra Kezdik', 'Visszailleszkedési támogatás.', 'háborús-sebesültek', 'https://pelda-veteran.hu', 'https://pelda-veteran.hu/adomany', 'Pécs', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(5, 'EgészségMindenkinek', 'Megelőző szűrések, egészségnevelés.', 'egészség', 'https://pelda-health.hu', 'https://pelda-health.hu/tamogatas', 'Győr', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(6, 'Szűrőprogram Alapítvány', 'Ingyenes szűrések vidéken.', 'egészség', 'https://pelda-szuro.hu', 'https://pelda-szuro.hu/adomany', 'Miskolc', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(7, 'Mentőangyalok', 'Mentőfelszerelések és képzés.', 'egészség', 'https://pelda-mento.hu', 'https://pelda-mento.hu/tamogatas', 'Kecskemét', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(8, 'Véradókért Egyesület', 'Véradási kampányok.', 'egészség', 'https://pelda-verado.hu', 'https://pelda-verado.hu/adomany', 'Székesfehérvár', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(9, 'Esély az Iskolában', 'Tanoda program.', 'oktatás', 'https://pelda-iskola.hu', 'https://pelda-iskola.hu/tamogatas', 'Nyíregyháza', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(10, 'Digitális Jövő', 'Eszköz- és net-hozzáférés.', 'oktatás', 'https://pelda-digitalis.hu', 'https://pelda-digitalis.hu/adomany', 'Sopron', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(11, 'Tanoda Program', 'Felzárkóztatás, pályaorientáció.', 'oktatás', 'https://pelda-tanoda.hu', 'https://pelda-tanoda.hu/tamogatas', 'Eger', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(12, 'Olvasó Körök', 'Ifjúsági olvasókörök.', 'oktatás', 'https://pelda-olvas.hu', 'https://pelda-olvas.hu/adomany', 'Tatabánya', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(13, 'Bundás Barátok', 'Kutyák/cicák mentése.', 'állatvédelem', 'https://pelda-allat.hu', 'https://pelda-allat.hu/adomany', 'Pécs', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(14, 'Macskamentők', 'Örökbeadás és ellátás.', 'állatvédelem', 'https://pelda-macska.hu', 'https://pelda-macska.hu/tamogatas', 'Veszprém', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(15, 'Vadászmadár Rehabilitáció', 'Ragadozómadarak gyógyítása.', 'állatvédelem', 'https://pelda-madar.hu', 'https://pelda-madar.hu/support', 'Szombathely', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(16, 'Kutyamenhely Hálózat', 'Ivartalanítási programok.', 'állatvédelem', 'https://pelda-kutya.hu', 'https://pelda-kutya.hu/adomany', 'Békéscsaba', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(17, 'Zöld Város', 'Városi zöldítések.', 'környezet', 'https://pelda-zoldvaros.hu', 'https://pelda-zoldvaros.hu/tamogatas', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(18, 'Tiszta Vizek', 'Folyó- és tópart takarítás.', 'környezet', 'https://pelda-vizek.hu', 'https://pelda-vizek.hu/adomany', 'Szeged', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(19, 'Fásítsunk Együtt', 'Őshonos facsemeték ültetése.', 'környezet', 'https://pelda-fasitas.hu', 'https://pelda-fasitas.hu/support', 'Zalaegerszeg', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(20, 'Hulladékmentes Jövő', 'Újrahasznosítás, hulladékcsökkentés.', 'környezet', 'https://pelda-hulladek.hu', 'https://pelda-hulladek.hu/tamogatas', 'Kaposvár', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(21, 'Hajléktalan Segítő Hálózat', 'Meleg étel, ruha, szálló.', 'szociális', 'https://pelda-hajlektalan.hu', 'https://pelda-hajlektalan.hu/adomany', 'Budapest', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(22, 'Példa Élelmiszersegély', 'Élelmiszercsomagok rászorulóknak.', 'szociális', 'https://pelda-elelmiszer.hu', 'https://pelda-elelmiszer.hu/tamogatas', 'Miskolc', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(23, 'Családtámogatás Egyesület', 'Krízisben lévő családok segítése.', 'szociális', 'https://pelda-csalad.hu', 'https://pelda-csalad.hu/adomany', 'Kecskemét', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(24, 'Idősek Gondozása', 'Házi segítségnyújtás.', 'szociális', 'https://pelda-idosek.hu', 'https://pelda-idosek.hu/tamogatas', 'Győr', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(25, 'Olvasásért Mozgalom', 'Könyvtámogatás, olvasás.', 'kultúra', 'https://pelda-olvasas.hu', 'https://pelda-olvasas.hu/adomany', 'Pécs', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(26, 'Kis Színház Alapítvány', 'Független színházi műhelyek.', 'kultúra', 'https://pelda-szinhaz.hu', 'https://pelda-szinhaz.hu/tamogatas', 'Debrecen', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(27, 'Közösségi Zene', 'Ifjúsági zenekarok.', 'kultúra', 'https://pelda-zene.hu', 'https://pelda-zene.hu/support', 'Szeged', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(28, 'Fiatal Alkotók', 'Tehetséggondozás.', 'kultúra', 'https://pelda-alkotok.hu', 'https://pelda-alkotok.hu/adomany', 'Székesfehérvár', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(29, 'Közösségi Fejlesztések', 'Játszóterek, közösségi terek.', 'egyéb', 'https://pelda-kozosseg.hu', 'https://pelda-kozosseg.hu/tamogatas', 'Tatabánya', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(30, 'Önkéntesek Klubja', 'Önkéntes programok és képzés.', 'egyéb', 'https://pelda-onkentes.hu', 'https://pelda-onkentes.hu/adomany', 'Eger', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(31, 'Segítünk Együtt', 'Gyorssegély alap.', 'egyéb', 'https://pelda-segitunk.hu', 'https://pelda-segitunk.hu/support', 'Sopron', 'Magyarország', 1, NULL, '2025-09-03 07:10:26'),
(32, 'Innováció a Közösségért', 'Közösségi ötletpályázatok.', 'egyéb', 'https://pelda-innovacio.hu', 'https://pelda-innovacio.hu/tamogatas', 'Zalaegerszeg', 'Magyarország', 1, NULL, '2025-09-03 07:10:26');

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
(69, '2025-09-03 09:49:48', '::1', '4lt5dn6v', 28);

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
(3053, '2025-09-03 10:07:53', '::1', '4lt5dn6v', 28, '/vizsgaremek/?p=konyvek');

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

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`uid`, `username`, `uemail`, `upassword`, `uprofkepnev`, `uprofkepnev_eredetinev`, `udatum`, `uip`, `usession`, `ustatusz`, `ukomment`) VALUES
(1, 'a', 'a@a.hu', '0cc175b9c0f1b6a831c399e269772661', '26_250123112947_fs3f78GbjO.png', '25_241216122536_XQ2ecFQUYC.png', '2025-01-16 11:21:36', '', '', 'b', ''),
(2, 'ice', 'ice@gmail.hu', 'e10adc3949ba59abbe56e057f20f883e', '25_241216122536_XQ2ecFQUYC.png', 'picon.png', '2024-12-11 13:51:56', '', '', 'b', ''),
(28, 'Ricsi', 'lariz200120@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '', '', '2025-09-02 12:33:52', '', '', 'a', '');

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
-- AUTO_INCREMENT a táblához `donation_clicks`
--
ALTER TABLE `donation_clicks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `donation_targets`
--
ALTER TABLE `donation_targets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT a táblához `ertekelesek`
--
ALTER TABLE `ertekelesek`
  MODIFY `eid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  MODIFY `logid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT a táblához `naplo`
--
ALTER TABLE `naplo`
  MODIFY `nid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3054;

--
-- AUTO_INCREMENT a táblához `support`
--
ALTER TABLE `support`
  MODIFY `supportid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT a táblához `vasarlas`
--
ALTER TABLE `vasarlas`
  MODIFY `vid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `donation_clicks`
--
ALTER TABLE `donation_clicks`
  ADD CONSTRAINT `fk_clicks_target` FOREIGN KEY (`target_id`) REFERENCES `donation_targets` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
