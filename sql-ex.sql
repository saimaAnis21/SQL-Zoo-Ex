-- 0 SELECT basics
SELECT world.population FROM world WHERE name = 'Germany'
SELECT world.name, population FROM world WHERE name IN ('Sweden', 'Norway','Denmark');
SELECT world.name, area FROM world  WHERE area BETWEEN 200000 AND 250000
-- 1 SELECT name
SELECT name FROM world WHERE name LIKE 'Y%'
SELECT name FROM world WHERE name LIKE '%y'
SELECT name FROM world WHERE name LIKE '%x%'
SELECT name FROM world WHERE name LIKE '%land'
SELECT name FROM world WHERE name LIKE 'C%ia'
SELECT name FROM world WHERE name LIKE '%oo%'
SELECT name FROM world WHERE name LIKE '%a%a%a%'
SELECT name FROM world WHERE name LIKE '_t%' ORDER BY name
SELECT name FROM world WHERE name LIKE '%o__o%'
SELECT name FROM world WHERE name LIKE '____'
SELECT name FROM world WHERE name  = capital
SELECT name FROM world WHERE capital LIKE concat(name,' City')
SELECT capital, name FROM world WHERE capital LIKE concat(name,'%')
SELECT capital, name FROM world WHERE capital LIKE concat(name,'%') AND capital <> name
SELECT name, REPLACE(capital,name,'') FROM world WHERE capital LIKE concat(name,'%') AND capital <> name
-- 2 SELECT from World
SELECT world.name, continent, population FROM world
SELECT world.name FROM world WHERE population > 200000000
SELECT world.name, gdp/population FROM world WHERE population > 200000000
SELECT world.name, population/1000000 FROM world WHERE continent = 'South America'
SELECT world.name, population FROM world WHERE name IN ( 'France', 'Germany', 'Italy')
SELECT world.name FROM world WHERE name LIKE '%United%'
SELECT world.name, population, area FROM world WHERE area > 3000000 OR population > 250000000
SELECT world.name, population, area FROM world WHERE (area > 3000000 OR population > 250000000) AND NOT (area > 3000000 AND population > 250000000)
SELECT world.name, ROUND(population/1000000,2), ROUND(gdp/1000000000,2) FROM world WHERE continent = 'South America'
SELECT world.name, ROUND(gdp/population,-3) FROM world WHERE gdp > 1000000000000
SELECT world.name, capital FROM world WHERE LENGTH(name) = LENGTH(capital)
SELECT world.name, capital FROM world WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital
SELECT world.name FROM world WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %'
-- 3 SELECT from Nobel
SELECT yr, subject, winner FROM nobel WHERE yr = 1950
SELECT winner FROM nobel WHERE yr = 1962 AND subject = 'Literature'
SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein'
SELECT winner FROM nobel WHERE subject =  'Peace' AND yr >= 2000
SELECT yr, subject, winner FROM nobel WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989
SELECT * FROM nobel WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson','Jimmy Carter', 'Barack Obama')
SELECT winner FROM nobel WHERE winner LIKE 'John%'
SELECT * FROM nobel WHERE (subject='Physics' AND yr=1980) OR (subject = 'Chemistry' AND yr=1984)
SELECT yr, subject , winner FROM nobel WHERE yr = 1980 AND subject NOT IN ('Chemistry','Medicine')
SELECT yr, subject, winner FROM nobel WHERE (subject = 'Medicine' AND yr < 1910) OR (subject =  'Literature' AND yr >= 2004)
SELECT * FROM nobel WHERE winner = 'PETER GRÜNBERG'
SELECT * FROM nobel WHERE winner = "EUGENE O\'NEILL"
SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%' ORDER BY yr DESC
SELECT winner, subject FROM nobel WHERE yr=1984 ORDER BY subject IN ('Physics','Chemistry'),subject,winner
-- 4 SELECT within SELECT
SELECT world.name FROM world WHERE population > (SELECT population FROM world WHERE name='Russia')
SELECT world.name FROM world WHERE (gdp/population) > (SELECT gdp/population FROM world WHERE name =  'United Kingdom') AND continent = 'Europe'
SELECT world.name, continent FROM world WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina','Australia')) ORDER BY name
SELECT world.name, population FROM world WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')
SELECT world.name, Concat(ROUND(100*population/(SELECT population FROM world WHERE name = 'Germany')),'%') FROM world WHERE continent = 'Europe'
SELECT world.name FROM world WHERE GDP > (SELECT MAX(GDP) FROM world WHERE continent = 'Europe')
SELECT continent, name , area FROM world WHERE area IN (SELECT MAX(area) FROM world GROUP BY continent)
SELECT continent, MIN(name) FROM world GROUP BY continent
SELECT world.name, continent, population FROM world WHERE continent IN (SELECT continent FROM world GROUP BY continent HAVING MAX(population) <=25000000)
SELECT name, continent FROM world x WHERE population > ALL (SELECT 3*population FROM world y WHERE x.continent = y.continent AND x.name <> y.name)
-- 5 SUM and COUNT
SELECT SUM(population) FROM world
SELECT DISTINCT continent FROM world
SELECT SUM(gdp) FROM world WHERE continent = 'Africa'
SELECT COUNT(name) FROM world WHERE area > 1000000
SELECT SUM(population) FROM world WHERE name IN ('Estonia', 'Latvia', 'Lithuania')
SELECT continent, COUNT(name) FROM world GROUP BY continent
SELECT continent, COUNT(population) FROM world WHERE population > 10000000 GROUP BY continent
SELECT continent FROM world GROUP BY continent HAVING SUM(population) > 100000000
-- 6 JOIN
SELECT matchid, player FROM goal WHERE teamid = 'GER'
SELECT id, stadium, team1,team2 FROM game WHERE id = 1012
SELECT goal.player, goal.teamid, game.stadium, game.mdate FROM game JOIN goal ON (game.id=goal.matchid) WHERE goal.teamid = 'GER'
SELECT game.team1, game.team2, goal.player FROM game JOIN goal ON (game.id=goal.matchid) WHERE goal.player LIKE 'Mario%'
SELECT goal.player, goal.teamid, eteam.coach, goal.gtime FROM goal JOIN eteam on  eteam.id = goal.teamid WHERE goal.gtime<=10
SELECT game.mdate, eteam.teamname FROM game JOIN eteam ON (team1=eteam.id) WHERE eteam.coach LIKE 'Fernando Santos'
SELECT player FROM goal JOIN game ON game.id = goal.matchid WHERE game.stadium LIKE 'National Stadium, Warsaw'
SELECT DISTINCT player FROM game JOIN goal ON matchid = id WHERE (game.team2='GER' OR game.team1='GER') AND goal.teamid <> 'GER'
SELECT teamname, COUNT(teamid) FROM eteam JOIN goal ON id=teamid GROUP BY teamname
SELECT stadium, COUNT(goal.matchid) FROM game JOIN goal ON id=matchid GROUP BY stadium
SELECT matchid,  mdate, COUNT(matchid) FROM game JOIN goal ON matchid = id WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid, mdate
SELECT matchid, mdate, COUNT(teamid) FROM goal JOIN game ON matchid=id WHERE teamid= 'GER' GROUP BY matchid, mdate
13- SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1, team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game JOIN goal ON matchid = id
GROUP BY mdate, team1, team2
ORDER BY mdate,matchid, team1, team2
-- 7 More JOIN operations
SELECT id, title FROM movie WHERE yr=1962
SELECT yr FROM movie WHERE title =  'Citizen Kane'
SELECT id,title,yr FROM movie WHERE title LIKE '%Star Trek%' ORDER BY yr
SELECT id FROM actor WHERE name =  'Glenn Close'
SELECT id FROM movie WHERE title =  'Casablanca'
SELECT actor.name FROM actor JOIN casting ON id=actorid WHERE casting.movieid=11768
SELECT actor.name FROM actor JOIN casting ON id=actorid WHERE casting.movieid= (SELECT id FROM movie WHERE title = 'Alien')
SELECT title FROM movie JOIN casting ON movieid = id WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford' )
SELECT title FROM movie JOIN casting ON movieid = id WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford' ) AND casting.ord > 1
SELECT movie.title, actor.name  FROM actor JOIN casting ON casting.actorid = actor.id JOIN movie ON movie.id=casting.movieid WHERE movie.yr=1962 AND casting.ord=1
SELECT yr,COUNT(title) FROM  movie JOIN casting ON movie.id=movieid  JOIN actor   ON actorid=actor.id WHERE name='Rock Hudson' GROUP BY yr HAVING COUNT(title) > 2
SELECT  movie.title, actor.name FROM movie JOIN casting  ON casting.movieid=movie.id JOIn actor ON actor.id = casting.actorid WHERE movieid IN (SELECT movieid FROM casting WHERE actorid = (SELECT id from actor where name ='Julie Andrews')) AND casting.ord = 1
SELECT actor.name FROM actor JOIN casting ON actor.id = casting.actorid WHERE casting.ord = 1 GROUP BY actor.name HAVING COUNT(ord) > 14
SELECT title, COUNT(casting.movieid) AS cast FROM movie JOIN casting ON movie.id = casting.movieid WHERE movie.yr = 1978 GROUP BY movie.title ORDER BY cast DESC, movie.title
SELECT actor.name FROM actor JOIN casting ON actor.id = casting.actorid WHERE casting.movieid in (SELECT casting.movieid FROM casting JOIN actor ON actor.id = casting.actorid WHERE name = 'Art Garfunkel') AND actor.name <> 'Art Garfunkel'
-- 8 Using Null
SELECT teacher.name FROM teacher where dept IS NULL
SELECT teacher.name, dept.name FROM teacher INNER JOIN dept ON (teacher.dept=dept.id)
SELECT teacher.name, dept.name FROM teacher LEFT OUTER JOIN dept ON (teacher.dept=dept.id)
SELECT teacher.name, dept.name FROM teacher RIGHT OUTER JOIN dept ON (teacher.dept=dept.id)
SELECT teacher.name, COALESCE(mobile,'07986 444 2266') AS mob FROM teacher
SELECT teacher.name, COALESCE(dept.name,'None') FROM teacher LEFT OUTER JOIN dept ON (teacher.dept=dept.id)
SELECT COUNT(name), COUNT(mobile) FROM teacher
SELECT dept.name, COUNT(teacher.name) from dept LEFT OUTER JOIN teacher ON teacher.dept = dept.id GROUP BY dept.name
SELECT name, CASE WHEN dept IN (1,2) THEN 'Sci' ELSE 'Art' END  FROM teacher
SELECT name, CASE WHEN dept IN (1,2) THEN 'Sci' WHEN dept = 3 THEN 'Art' ELSE 'None' END FROM teacher
-- 8+ Numeric Examples
SELECT A_STRONGLY_AGREE  FROM nss WHERE question='Q01' AND institution='Edinburgh Napier University'  AND subject='(8) Computer Science'
SELECT institution, subject FROM nss WHERE question='Q15' AND score > 99
SELECT institution,score  FROM nss WHERE question='Q15' AND subject='(8) Computer Science' AND score < 50
SELECT subject, SUM(response) FROM nss WHERE question='Q22' AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design') GROUP BY subject
SELECT subject, SUM(response*A_STRONGLY_AGREE/100) FROM nss WHERE question='Q22' AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design') GROUP BY subject
SELECT subject, ROUND((SUM(response*A_STRONGLY_AGREE/100)/SUM(response))*100) FROM nss WHERE question='Q22' AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design') GROUP BY subject
SELECT institution,ROUND((SUM(response*score/100)/SUM(response))*100) FROM nss WHERE question='Q22' AND (institution LIKE '%Manchester%') GROUP BY institution
8-SELECT institution,SUM(sample) AS comp
  FROM nss
 WHERE question='Q01'
   AND (institution LIKE '%Manchester%') AND (subject = '(8) Computer Science' )
GROUP BY institution
-- 9- Window function
SELECT lastName, party, votes  FROM ge WHERE constituency = 'S14000024' AND yr = 2017 ORDER BY votes DESC
SELECT party,votes, RANK() OVER (ORDER BY votes DESC) as posn FROM ge WHERE constituency = 'S14000024' AND yr = 2017 ORDER BY party
SELECT yr,party, votes, RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn FROM ge WHERE constituency = 'S14000021' ORDER BY party,yr 
SELECT constituency,party, votes,RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as posn  FROM ge WHERE constituency BETWEEN 'S14000021' AND 'S14000026' AND yr  = 2017 ORDER BY posn, constituency
SELECT constituency,party FROM (SELECT constituency,party, RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as posn from ge WHERE constituency BETWEEN 'S14000021' AND 'S14000026' AND yr  = 2017 ORDER BY constituency,votes DESC) AS tbl WHERE posn = 1
6-
-- 9+ COVID 19
SELECT name, DAY(whn),confirmed, deaths, recovered FROM covidWHERE name = 'Spain'AND MONTH(whn) = 3 ORDER BY whn
SELECT  name, DAY(whn), confirmed - (LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)) AS new FROM covid WHERE name = 'Italy' AND MONTH(whn) = 3 ORDER BY whn
3-
4-
5-
6-
7-
8-
-- 9 Self join
SELECT COUNT(id) FROM stops
SELECT id FROM stops WHERE name = 'Craiglockhart'
SELECT id, name FROM stops JOIN route ON stops.id = route.stop WHERE route.company = 'LRT' AND route.num = '4'
SELECT company, num, COUNT(*)FROM route WHERE stop=149 OR stop=53 GROUP BY company, num HAVING COUNT(*) = 2
SELECT a.company, a.num, a.stop, b.stop FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) WHERE a.stop=53 AND b.stop = 149
SELECT a.company, a.num, stopa.name, stopb.name FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops stopa ON (a.stop=stopa.id) JOIN stops stopb ON (b.stop=stopb.id) WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'
SELECT DISTINCT a.company, a.num FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops stopa ON (a.stop=stopa.id) JOIN stops stopb ON (b.stop=stopb.id) WHERE stopa.name='Haymarket' AND stopb.name='Leith'
SELECT DISTINCT a.company, a.num FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num) JOIN stops stopa ON (a.stop=stopa.id) JOIN stops stopb ON (b.stop=stopb.id) WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross'
10- SELECT DISTINCT x.num, x.company,b.name,r.num,r.company FROM
    stops a JOIN route x ON a.id=x.stop
    JOIN route y ON (x.num=y.num AND x.company=y.company)
    JOIN stops b ON b.id=y.stop
    JOIN route z ON b.id=z.stop
    JOIN route r ON (z.num=r.num AND z.company=r.company)
    JOIN stops c ON c.id=r.stop
    WHERE a.name='Craiglockhart'
    AND c.name='Lochend'

