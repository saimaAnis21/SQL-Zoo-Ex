-- 0 SELECT basics
SELECT population FROM world WHERE name = 'Germany'
SELECT name, population FROM world WHERE name IN ('Sweden', 'Norway','Denmark');
SELECT name, area FROM world  WHERE area BETWEEN 200000 AND 250000
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
SELECT name, continent, population FROM world
SELECT name FROM world WHERE population > 200000000
SELECT name, gdp/population FROM world WHERE population > 200000000
SELECT name, population/1000000 FROM world WHERE continent = 'South America'
SELECT name, population FROM world WHERE name IN ( 'France', 'Germany', 'Italy')
SELECT name FROM world WHERE name LIKE '%United%'
SELECT name, population, area FROM world WHERE area > 3000000 OR population > 250000000
SELECT name, population, area FROM world WHERE (area > 3000000 OR population > 250000000) AND NOT (area > 3000000 AND population > 250000000)
SELECT name, ROUND(population/1000000,2), ROUND(gdp/1000000000,2) FROM world WHERE continent = 'South America'
SELECT name, ROUND(gdp/population,-3) FROM world WHERE gdp > 1000000000000
SELECT name, capital FROM world WHERE LENGTH(name) = LENGTH(capital)
SELECT name, capital FROM world WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital
SELECT name FROM world WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %'
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
SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name='Russia')
SELECT name FROM world WHERE (gdp/population) > (SELECT gdp/population FROM world WHERE name =  'United Kingdom') AND continent = 'Europe'
SELECT name, continent FROM world WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina','Australia')) ORDER BY name
SELECT name, population FROM world WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')
SELECT name, Concat(ROUND(100*population/(SELECT population FROM world WHERE name = 'Germany')),'%') FROM world WHERE continent = 'Europe'
SELECT name FROM world WHERE GDP > (SELECT MAX(GDP) FROM world WHERE continent = 'Europe')
SELECT continent, name , area FROM world WHERE area IN (SELECT MAX(area) FROM world GROUP BY continent)
SELECT continent, MIN(name) FROM world GROUP BY continent
SELECT name, continent, population FROM world WHERE continent IN (SELECT continent FROM world GROUP BY continent HAVING MAX(population) <=25000000)
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