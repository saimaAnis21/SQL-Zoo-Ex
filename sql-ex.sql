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

