SET SCHEMA DB2MOVIE;

-- Напишете заявка, която извежда имената на актрисите, които са също и продуценти с нетна стойност по-голяма от 10 милиона.

-- I

SELECT NAME FROM MOVIESTAR
WHERE GENDER = 'F' AND NAME IN (SELECT NAME FROM MOVIEEXEC WHERE NETWORTH > 10000000);


-- II
SELECT NAME FROM MOVIEEXEC
WHERE NETWORTH > 10000000 AND NAME IN (SELECT NAME FROM MOVIESTAR WHERE GENDER = 'F');

-- III

SELECT NAME FROM MOVIEEXEC WHERE NETWORTH > 10000000
INTERSECT
SELECT NAME FROM MOVIESTAR WHERE GENDER = 'F';

-- IV

SELECT *
FROM MOVIEEXEC ME, MOVIESTAR MS
WHERE MS.NAME = ME.NAME
AND MS.GENDER = 'F'
AND ME.NETWORTH > 10000000;


-- Напишете заявка, която извежда имената на тези актьори (мъже и жени), които не са продуценти.

-- I

SELECT NAME
FROM MOVIESTAR
WHERE NAME NOT IN (SELECT NAME FROM MOVIEEXEC);

-- II

SELECT NAME FROM MOVIESTAR
EXCEPT
SELECT NAME FROM MOVIEEXEC;


-- Напишете заявка, която извежда имената на всички филми с дължина по-голяма от дължината на филма 'Gone With the Wind'

SELECT *
FROM MOVIE
WHERE LENGTH >= ANY(SELECT LENGTH FROM MOVIE WHERE TITLE = 'Gone With the Wind');


-- Напишете заявка, която извежда имената на продуцентите и имената на продукциите за които стойността им е по-голяма от продукциите на продуценти 'Merv Griffin'

SELECT ME.NAME, M.TITLE, ME.NETWORTH
FROM MOVIEEXEC ME, MOVIE M
WHERE ME.CERT# = M.PRODUCERC#
AND  ME.NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE NAME = 'Merv Griffin');


-- Напишете заявка, която извежда името на филмите с най-голяма дължина по студио
SELECT *
FROM MOVIE M
WHERE LENGTH = (SELECT MAX(LENGTH) FROM MOVIE WHERE STUDIONAME = M.STUDIONAME);




SET SCHEMA DB2PC;

-- Напишете заявка, която извежда производителите на персонални компютри с честота поне 500.

-- I
SELECT DISTINCT P.MAKER
FROM PRODUCT P, PC
WHERE P.MODEL = PC.MODEL
AND PC.SPEED >= 500;


-- II
SELECT DISTINCT MAKER
FROM PRODUCT
WHERE MODEL IN (SELECT MODEL FROM PC WHERE SPEED >= 500);


-- Напишете заявка, която извежда принтерите с най-висока цена.

-- I
SELECT *
FROM PRINTER
ORDER BY PRICE DESC
FETCH FIRST 1 ROWS ONLY;

-- II
SELECT *
FROM PRINTER
WHERE PRICE = (SELECT MAX(PRICE) FROM PRINTER);

-- III

SELECT *
FROM PRINTER
WHERE PRICE >=ALL (SELECT PRICE FROM PRINTER);


-- Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от честотата на който и да е персонален компютър.

SELECT *
FROM LAPTOP
WHERE SPEED >= ANY (SELECT SPEED FROM PC);


-- Напишете заявка, която извежда производителя на цветния принтер с най-ниска цена.

SELECT P.MAKER, PR.*
FROM PRINTER PR, PRODUCT P
WHERE PR.COLOR = 'y' AND P.MODEL = PR.MODEL
AND PR.PRICE = (SELECT MIN(PRICE) FROM PRINTER WHERE COLOR = 'y');


-- Напишете заявка, която извежда производителите на тези персонални компютри с най-малко RAM памет, които имат най-бързи процесори.

SELECT P.MAKER, T.*
FROM ( SELECT * FROM PC WHERE RAM = (SELECT MIN(RAM) FROM PC)) T, PRODUCT P
WHERE T.SPEED = (SELECT MAX(SPEED) FROM ( SELECT * FROM PC WHERE RAM = (SELECT MIN(RAM) FROM PC)) T)
AND P.MODEL = T.MODEL;



SET SCHEMA DB2SHIPS;

-- Напишете заявка, която извежда страните, чиито кораби са с най-голям брой оръжия.

-- I
SELECT DISTINCT COUNTRY
FROM CLASSES
WHERE NUMGUNS = (SELECT MAX(NUMGUNS) FROM CLASSES) ;


-- II (ПРИ ДРУГО УСЛОВИЕ)
SELECT C.COUNTRY, SUM(C.NUMGUNS) SUMGUNS, COUNT(S.NAME) CNT
FROM CLASSES C, SHIPS S
WHERE C.CLASS = S.CLASS
GROUP BY C.COUNTRY
ORDER BY SUMGUNS DESC
FETCH FIRST 1 ROWS ONLY;


-- Напишете заявка, която извежда класовете, за които поне един от корабите им е потънал в битка.

SELECT DISTINCT S.CLASS
FROM SHIPS S, OUTCOMES O
WHERE S.NAME = O.SHIP
AND O.RESULT = 'sunk';


-- Напишете заявка, която извежда имената на корабите с 16 инчови оръдия (bore).

-- I
SELECT S.NAME
FROM CLASSES C, SHIPS S
WHERE C.CLASS = S.CLASS
AND  C.BORE = 16;


-- II
SELECT NAME
FROM SHIPS
WHERE CLASS IN (SELECT CLASS FROM CLASSES WHERE BORE = 16);


-- Напишете заявка, която извежда имената на битките, в които са участвали кораби от клас ‘Kongo’.

-- I
SELECT *
FROM OUTCOMES
WHERE SHIP IN (SELECT NAME FROM SHIPS WHERE CLASS = 'Kongo');

-- II

SELECT *
FROM SHIPS S, OUTCOMES O
WHERE S.NAME = O.SHIP
AND S.CLASS = 'Kongo'


-- Напишете заявка, която извежда имената на корабите, чиито брой оръдия е най-голям в сравнение с корабите със същия калибър оръдия (bore).

SELECT C1.CLASS, NAME, C1.BORE, C1.NUMGUNS
FROM CLASSES C1, SHIPS S
WHERE NUMGUNS = (SELECT MAX(NUMGUNS) FROM CLASSES WHERE BORE = C1.BORE)
AND S.CLASS =  C1.CLASS
ORDER BY C1.CLASS;