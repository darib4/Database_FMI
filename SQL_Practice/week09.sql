SET SCHEMA DB2MOVIE;

-- Напишете заявка, която извежда имената на актьорите мъже участвали в 'Terms of Endearment'

SELECT MS.NAME AS STAR_NAME, S.MOVIETITLE
FROM STARSIN S , MOVIESTAR MS
WHERE S.STARNAME = MS.NAME
AND MS.GENDER = 'M'
AND S.MOVIETITLE = 'Terms of Endearment';


--  Напишете заявка, която извежда имената на актьорите участвали във филми продуцирани от 'MGM' през 1995 г.

SELECT S.STARNAME, M.TITLE
FROM MOVIE M, STARSIN S
WHERE M.TITLE = S.MOVIETITLE
AND M.YEAR = S.MOVIEYEAR
AND M.STUDIONAME = 'MGM'
AND M.YEAR = 1995;


--  Напишете заявка, която извежда името на ппродуцента на филми със студио 'MGM'

SELECT ME.NAME, M.TITLE, M.STUDIONAME
FROM MOVIE M, MOVIEEXEC ME
WHERE M.PRODUCERC# = ME.CERT#
AND M.STUDIONAME = 'MGM';


-- Напишете заявка, която извежда имената на всички филми с дължина по-голяма от дължината на филма 'Gone With the Wind'

SELECT ALLM.TITLE, ALLM.LENGTH, GWTW.TITLE, GWTW.LENGTH
FROM MOVIE ALLM, MOVIE GWTW
WHERE GWTW.TITLE = 'Gone With the Wind'
AND ALLM.LENGTH > GWTW.LENGTH;


-- Напишете заявка, която извежда имената на тези продуценти с продукции на стойност поголяма от продукциите на
-- продуценти 'Merv Griffin'

SELECT ALLP.NAME, ALLP.NETWORTH, MV.NAME, MV.NETWORTH
FROM MOVIEEXEC ALLP, MOVIEEXEC MV
WHERE MV.NAME = 'Merv Griffin'
AND ALLP.NETWORTH > MV.NETWORTH;



SET SCHEMA DB2SHIPS;

-- Напишете заявка, която извежда името на корабите по-тежки от 35000

SELECT S.NAME AS SHIP_NAME, C.DISPLACEMENT
FROM CLASSES C, SHIPS S
WHERE C.CLASS = S.CLASS
AND C.DISPLACEMENT > 50000;


-- Напишете заявка, която извежда имената, водоизместимостта и броя оръжия на
-- всички кораби участвали в битката при 'Guadalcanal'

SELECT O.BATTLE, S.NAME AS SHIP_NAME, C.DISPLACEMENT, C.NUMGUNS, O.RESULT
FROM CLASSES C, SHIPS S, OUTCOMES O
WHERE C.CLASS = S.CLASS AND S.NAME = O.SHIP
AND O.BATTLE =   'Guadalcanal';


-- Напишете заявка, която извежда имената на тези държави, които имат кораби от тип 'bb' и 'bc' едновременно

SELECT CBB.COUNTRY
FROM CLASSES CBB, CLASSES CBC
WHERE CBB.COUNTRY = CBC.COUNTRY
AND   CBB.TYPE = 'bb' AND CBC.TYPE = 'bc';

-- II

SELECT COUNTRY
FROM CLASSES
WHERE TYPE = 'bb'
INTERSECT
SELECT COUNTRY
FROM CLASSES
WHERE TYPE = 'bc';


-- Напишете заявка, която извежда имената на тези битки с три кораби на една и съща държава

SELECT DISTINCT  O1.BATTLE, C1.COUNTRY
FROM CLASSES C1, SHIPS S1, OUTCOMES O1,
     CLASSES C2, SHIPS S2, OUTCOMES O2,
     CLASSES C3, SHIPS S3, OUTCOMES O3
WHERE C1.CLASS = S1.CLASS AND S1.NAME = O1.SHIP
AND   C2.CLASS = S2.CLASS AND S2.NAME = O2.SHIP
AND   C3.CLASS = S3.CLASS AND S3.NAME = O3.SHIP
AND   C1.COUNTRY = C2.COUNTRY AND C2.COUNTRY = C3.COUNTRY
AND   O1.BATTLE = O2.BATTLE AND O2.BATTLE = O3.BATTLE
AND   S1.NAME <> S2.NAME AND S1.NAME <> S3.NAME AND S2.NAME <> S3.NAME

EXCEPT

SELECT DISTINCT O1.BATTLE, C1.COUNTRY
FROM CLASSES C1, SHIPS S1, OUTCOMES O1,
     CLASSES C2, SHIPS S2, OUTCOMES O2,
     CLASSES C3, SHIPS S3, OUTCOMES O3,
     CLASSES C4, SHIPS S4, OUTCOMES O4
WHERE C1.CLASS = S1.CLASS AND S1.NAME = O1.SHIP
AND   C2.CLASS = S2.CLASS AND S2.NAME = O2.SHIP
AND   C3.CLASS = S3.CLASS AND S3.NAME = O3.SHIP
AND   C4.CLASS = S4.CLASS AND S4.NAME = O4.SHIP
AND   C1.COUNTRY = C2.COUNTRY AND C2.COUNTRY = C3.COUNTRY AND C3.COUNTRY = C4.COUNTRY
AND   O1.BATTLE = O2.BATTLE AND O2.BATTLE = O3.BATTLE AND O3.BATTLE = O4.BATTLE
AND   S1.NAME <> S2.NAME AND S1.NAME <> S3.NAME AND S2.NAME <> S3.NAME AND S1.NAME <> S4.NAME AND S4.NAME <> S2.NAME AND S3.NAME <> S4.NAME;

-- II

SELECT O1.BATTLE, C1.COUNTRY, COUNT(S1.NAME)
FROM CLASSES C1, SHIPS S1, OUTCOMES O1
WHERE C1.CLASS = S1.CLASS AND S1.NAME = O1.SHIP
GROUP BY O1.BATTLE, C1.COUNTRY
HAVING COUNT(S1.NAME) = 3
ORDER BY 1;


-- Напишете заявка, която извежда имената на тези кораби, които са били
-- повредени в една битка, но по късно са участвали в друга битка

SELECT O1.SHIP, O1.BATTLE, B1.DATE, O2.SHIP, O2.BATTLE, B2.DATE
FROM OUTCOMES O1, BATTLES B1,
     OUTCOMES O2, BATTLES B2
WHERE O1.BATTLE = B1.NAME
AND   O2.BATTLE = B2.NAME
AND   O1.RESULT = 'damaged'
AND   B1.DATE < B2.DATE
AND   O1.SHIP = O2.SHIP;