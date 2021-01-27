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
10-
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
13- 
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

