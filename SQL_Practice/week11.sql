SET SCHEMA DB2SHIPS;

-- Зад 1. Да се напише заявка, която извежда име на битка и име на кораб в една колона (конкатенирани) с тире между тях, както и деня и седмицата, в която се е провела битката.

--SELECT B.NAME || ' - ' || O.SHIP AS BATTLE_SHIP, B.DATE
SELECT CONCAT(CONCAT(B.NAME, ' - '), O.SHIP) AS BATTLE_SHIP, B.DATE, DAYOFWEEK_ISO(B.DATE) AS DNUM, DAYNAME(B.DATE) AS DNAME, WEEK_ISO(B.DATE) AS WEEK
FROM BATTLES B, OUTCOMES O
WHERE B.NAME = O.BATTLE

-- Зад 4. Да се напише заявка, която извежда колко години има разлика между датата, на която кораб е бил пуснат на вода и първата битка, в която е участвал.

SELECT R1.*
FROM
(SELECT S.NAME AS SNAME, S.LAUNCHED, B.NAME AS BNAME, B.DATE, YEAR(B.DATE) - S.LAUNCHED AS DIFF
FROM SHIPS S, OUTCOMES O, BATTLES B
WHERE S.NAME = O.SHIP AND O.BATTLE = B.NAME
AND YEAR(B.DATE) - S.LAUNCHED >= 0) R1
,
(SELECT O.SHIP, B.NAME, B.DATE
FROM OUTCOMES O, BATTLES B
WHERE O.BATTLE = B.NAME
AND B.DATE = ( SELECT MIN(DATE) FROM OUTCOMES, BATTLES WHERE BATTLE = NAME AND SHIP = O.SHIP))R2
WHERE R1.SNAME = R2.SHIP AND R1.BNAME = R2.NAME;

-- Зад 2. Напишете заявка, която извежда имената и рождените дати на тези актьори, за които е изпълнено, че са родени във високосна година и едновременно с това са и една
-- и съща зодия по китайския календар. Да се счита, че всички родени с 12 години разлика са една и съща зодия по китайския календар.

SET SCHEMA DB2MOVIE;


SELECT '(' || TRIM(MS1.NAME) || ', ' || TRIM(MS2.NAME) || ')' AS PAIRS, MS1.BIRTHDATE AS MS1_DATE, MS2.BIRTHDATE AS MS2_DATE
FROM MOVIESTAR MS1, MOVIESTAR MS2
WHERE MS1.BIRTHDATE > MS2.BIRTHDATE
AND   MOD(YEAR(MS1.BIRTHDATE), 4) = 0 AND (MOD(YEAR(MS1.BIRTHDATE), 400) = 0 OR MOD(YEAR(MS1.BIRTHDATE), 100) <> 0)
AND   MOD(YEAR(MS2.BIRTHDATE), 4) = 0 AND (MOD(YEAR(MS2.BIRTHDATE), 400) = 0 OR MOD(YEAR(MS2.BIRTHDATE), 100) <> 0)
AND   MOD(YEAR(MS1.BIRTHDATE) - YEAR(MS2.BIRTHDATE), 12) = 0;


-- Зад 3. Напишете заявка, която извежда рождената дата и имената на тези актьори родени на една и съща дата. Изведете имената на актьорите по шаблона (MS1_NAME, MS2_NAME).
-- Повтарящите се двойки от вида (MS1_NAME, MS2_NAME) да не се извеждат в резултата.


SELECT '(' || TRIM(MS1.NAME) || ', ' || TRIM(MS2.NAME) || ')' AS PAIRS, MS1.BIRTHDATE AS MS1_DATE, MS2.BIRTHDATE AS MS2_DATE
FROM MOVIESTAR MS1, MOVIESTAR MS2
WHERE MS1.BIRTHDATE > MS2.BIRTHDATE
AND   DAY(MS1.BIRTHDATE) = DAY(MS2.BIRTHDATE)
AND   MONTH(MS1.BIRTHDATE) = MONTH(MS2.BIRTHDATE);

-- Зад 5. Да се напише заявка, която намира филма с най-малка продължителност. Ако продължителността на филма е NULL да се извежда 0.

SELECT TITLE, YEAR, COALESCE(LENGTH, 0) AS LENGTH, COALESCE(STUDIONAME, 'Unknown') AS STUDIONAME
FROM MOVIE
WHERE COALESCE(LENGTH,0) = (SELECT MIN(COALESCE(LENGTH,0)) FROM MOVIE);