-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Ápr 09. 13:27
-- Kiszolgáló verziója: 10.4.6-MariaDB
-- PHP verzió: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
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
-- Tábla szerkezet ehhez a táblához `ertekelesek`
--

CREATE TABLE `ertekelesek` (
  `eid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `kid` int(11) NOT NULL,
  `eszoveg` varchar(255) COLLATE utf8_hungarian_ci NOT NULL,
  `edatum` date NOT NULL,
  `status` varchar(3) COLLATE utf8_hungarian_ci NOT NULL
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
  `kcim` varchar(255) COLLATE utf8_hungarian_ci NOT NULL,
  `alcim` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `borito` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `iro` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `kiado` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `kdatum` varchar(11) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `mufaj` varchar(255) COLLATE utf8_hungarian_ci NOT NULL,
  `statusz` varchar(2) COLLATE utf8_hungarian_ci NOT NULL,
  `leiras` text COLLATE utf8_hungarian_ci DEFAULT NULL,
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
  `logip` varchar(48) COLLATE utf8_hungarian_ci NOT NULL,
  `logsession` varchar(8) COLLATE utf8_hungarian_ci NOT NULL,
  `luid` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `naplo`
--

CREATE TABLE `naplo` (
  `nid` int(255) NOT NULL,
  `ndate` datetime NOT NULL,
  `nip` varchar(48) COLLATE utf8_hungarian_ci NOT NULL,
  `nsession` varchar(8) COLLATE utf8_hungarian_ci NOT NULL,
  `nuid` int(255) NOT NULL,
  `nurl` varchar(255) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `support`
--

CREATE TABLE `support` (
  `supportid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `sszoveg` text COLLATE utf8_hungarian_ci NOT NULL,
  `svalasz` text COLLATE utf8_hungarian_ci DEFAULT NULL,
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
  `username` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `uemail` varchar(255) COLLATE utf8_hungarian_ci NOT NULL,
  `upassword` varchar(64) COLLATE utf8_hungarian_ci NOT NULL,
  `uprofkepnev` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  `uprofkepnev_eredetinev` varchar(250) COLLATE utf8_hungarian_ci NOT NULL,
  `udatum` datetime NOT NULL,
  `uip` varchar(48) COLLATE utf8_hungarian_ci NOT NULL,
  `usession` varchar(8) COLLATE utf8_hungarian_ci NOT NULL,
  `ustatusz` varchar(2) COLLATE utf8_hungarian_ci NOT NULL,
  `ukomment` text COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`uid`, `username`, `uemail`, `upassword`, `uprofkepnev`, `uprofkepnev_eredetinev`, `udatum`, `uip`, `usession`, `ustatusz`, `ukomment`) VALUES
(1, 'a', 'a@a.hu', '0cc175b9c0f1b6a831c399e269772661', '26_250123112947_fs3f78GbjO.png', '25_241216122536_XQ2ecFQUYC.png', '2025-01-16 11:21:36', '', '', 'b', ''),
(2, 'ice', 'ice@gmail.hu', 'e10adc3949ba59abbe56e057f20f883e', '25_241216122536_XQ2ecFQUYC.png', 'picon.png', '2024-12-11 13:51:56', '', '', 'b', '');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `vasarlas`
--

CREATE TABLE `vasarlas` (
  `vid` int(11) NOT NULL,
  `koid` int(11) NOT NULL,
  `nev` varchar(40) COLLATE utf8_hungarian_ci NOT NULL,
  `cardnumber` varchar(40) COLLATE utf8_hungarian_ci NOT NULL,
  `ldatum` varchar(40) COLLATE utf8_hungarian_ci NOT NULL,
  `cvv` varchar(3) COLLATE utf8_hungarian_ci NOT NULL,
  `statusz` int(11) NOT NULL,
  `datum` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- Indexek a kiírt táblákhoz
--

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
  MODIFY `logid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT a táblához `naplo`
--
ALTER TABLE `naplo`
  MODIFY `nid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2852;

--
-- AUTO_INCREMENT a táblához `support`
--
ALTER TABLE `support`
  MODIFY `supportid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT a táblához `vasarlas`
--
ALTER TABLE `vasarlas`
  MODIFY `vid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
