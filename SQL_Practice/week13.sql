-- 1. За таблицата Movies, да се изведе номер на продуцент, брой на филми за този продуцент.

SELECT ME.NAME, COUNT(*) AS CNT
FROM MOVIE M, MOVIEEXEC ME
WHERE M.PRODUCERC# = ME.CERT#
GROUP BY ME.CERT#, ME.NAME;


-- 2. Като задача 1, но искаме и име на продуцент и networth.


SELECT ME.NAME, ME.NETWORTH, COUNT(*) AS CNT
FROM MOVIE M, MOVIEEXEC ME
WHERE M.PRODUCERC# = ME.CERT#
AND ME.NETWORTH > 120000000
GROUP BY ME.CERT#, ME.NAME, ME.NETWORTH ;


-- 3. Заявка, която ни връща име на актьор, рождена дата и броя на филмите, в които е участвал

SELECT MS.NAME, MS.BIRTHDATE, COUNT(*) CNT
FROM MOVIESTAR MS, STARSIN S
WHERE MS.NAME = S.STARNAME
GROUP BY MS.NAME, MS.BIRTHDATE;


-- 4. Заявка, която ни връща имената на актьорите, рождена дата и броя на филмите,
-- в които са участвали за тези актьори с най-много филми.

SELECT MS.NAME, MS.BIRTHDATE, COUNT(*) CNT
FROM MOVIESTAR MS, STARSIN S
WHERE MS.NAME = S.STARNAME
GROUP BY MS.NAME, MS.BIRTHDATE
HAVING COUNT(*) >= ALL (SELECT COUNT(*) CNT FROM  STARSIN S GROUP BY S.STARNAME);

SELECT S.STARNAME, MIN(S.MOVIEYEAR) AS FIRST_MOVIE, MAX(S.MOVIEYEAR) AS LAST_FILM, COUNT(*) AS CNT
FROM STARSIN S
GROUP BY S.STARNAME
HAVING COUNT(*) >= 2;


-- 5. За Movies, име на продуцент, име на студио, и брой на филми за всички продуцент, според студиото.

SELECT MO.NAME, M.STUDIONAME, COUNT(*) AS CNT
FROM MOVIEEXEC MO, MOVIE M
WHERE MO.CERT# = M.PRODUCERC#
GROUP BY MO.CERT#, MO.NAME, M.STUDIONAME;


-- 6. Име на филм и име на най-възрастния актьор участвал във филма

SELECT M.NAME, T.*
FROM MOVIESTAR M, STARSIN SI, (SELECT S.MOVIETITLE, MIN(MS.BIRTHDATE) AS MIN_STAR
                  FROM STARSIN S, MOVIESTAR MS
                  WHERE S.STARNAME = MS.NAME
                  GROUP BY S.MOVIETITLE, S.MOVIEYEAR) T
WHERE M.NAME = SI.STARNAME
AND   M.BIRTHDATE = T.MIN_STAR
AND   SI.MOVIETITLE = T.MOVIETITLE;

--II

SELECT S.MOVIETITLE, MS.NAME, MS.BIRTHDATE
FROM STARSIN S, MOVIESTAR MS
WHERE S.STARNAME = MS.NAME
AND MS.BIRTHDATE = (SELECT MIN(BIRTHDATE) FROM MOVIESTAR, STARSIN
                    WHERE NAME = STARNAME AND MOVIETITLE=S.MOVIETITLE AND MOVIEYEAR = S.MOVIEYEAR);


-- 7. Намира най-възрастният актьор участвал в филм. Извежда имената му и филма, в който е участвал

SELECT MS.NAME, S.MOVIETITLE, MS.BIRTHDATE
FROM STARSIN S, MOVIESTAR MS
WHERE S.STARNAME = MS.NAME
AND MS.BIRTHDATE = (SELECT MIN(BIRTHDATE) FROM MOVIESTAR WHERE GENDER = 'M')
AND MS.GENDER = 'M';