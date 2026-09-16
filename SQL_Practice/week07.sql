SET SCHEMA DB2MOVIE;

SELECT * FROM MOVIE;

SELECT * FROM DB2MOVIE.MOVIE;

SELECT TITLE, YEAR, INCOLOR AS YORN
FROM MOVIE;

SELECT DISTINCT TITLE,  LENGTH/60 AS HOUR
FROM MOVIE
WHERE LENGTH IS NOT NULL;



-- 1. Напишете заявка, която извежда адресът на студио 'MGM'

SELECT NAME, ADDRESS
FROM STUDIO
WHERE NAME = 'MGM';
-- WHERE LOWER(NAME) = 'mgm';

-- 2. Напишете заявка, която извежда рождената дата на актрисата Sandra Bullock

SELECT NAME, BIRTHDATE
FROM MOVIESTAR
WHERE NAME = 'Sandra Bullock';

SELECT NAME, BIRTHDATE
FROM MOVIESTAR
WHERE NAME LIKE 'J%';

-- 3. Напишете заявка, която извежда имената на всички актьори, които са
-- участвали във филм през 1980 в заглавието на които има думата ‘Love’

SELECT STARNAME
FROM STARSIN
WHERE MOVIEYEAR = 1980 AND MOVIETITLE LIKE '%Love%';

-- 4. Напишете заявка, която извежда имената на всички продуценти на
-- филми на стойност над 10 000 000 долара

SELECT NAME
FROM MOVIEEXEC
WHERE NETWORTH > 100000000;

-- 5. Напишете заявка, която извежда имената на всички актьори, които са
-- мъже или живеят в Malibu

SELECT *
FROM MOVIESTAR
WHERE GENDER = 'M' OR ADDRESS LIKE '%Malibu%';



SET SCHEMA DB2SHIPS;

-- 1. Напишете заявка, която извежда името на класа и страната за всички
-- класове с брой на оръдията по-малък от 10

SELECT CLASS, COUNTRY
FROM CLASSES
WHERE NUMGUNS < 10;

-- 2. Напишете заявка, която извежда имената на всички кораби, пуснати на
-- вода преди 1918. Задайте псевдоним на колоната shipName

SELECT NAME AS SHIPNAME
FROM SHIPS
WHERE LAUNCHED < 1918;

-- 3. Напишете заявка, която извежда имената на корабите потънали в битка
-- и имената на битките в които са потънали

SELECT SHIP, BATTLE
FROM OUTCOMES
WHERE RESULT='sunk'
ORDER BY BATTLE;

-- 4. Напишете заявка, която извежда имената на корабите с име съвпадащо
-- с името на техния клас

SELECT NAME
FROM SHIPS
WHERE NAME = CLASS;

-- 5. Напишете заявка, която извежда имената на всички кораби започващи с буквата R

SELECT NAME
FROM SHIPS
WHERE NAME LIKE 'R%';

-- 6. Напишете заявка, която извежда имената на всички кораби, чието име е
-- съставено от точно две думи.

SELECT *
FROM SHIPS
WHERE NAME NOT LIKE '_% _% _%' AND NAME LIKE '_% _%' ;