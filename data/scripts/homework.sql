--1.What range of years for baseball games played does the provided database cover?

/*SELECT MIN(yearid), MAX(yearid)
FROM batting;
Answer: 1871-2016*/

--2.Find the name and height of the shortest player in the database. 
--How many games did he play in? What is the name of the team for which he played?

/*SELECT p.namefirst, p.namelast, MIN(p.height), a.g_all, t.name
FROM people AS p
JOIN appearances  AS a
ON a.playerid = p.playerid
JOIN teams AS t
ON a.teamid = t.teamid
GROUP BY p.namefirst, p.namelast, a.g_all, p.height, t.name
ORDER BY p.height*/

--Answer: Eddie Gaedel at 43", played 1 game for the St. Louis Browns

--3.Find all players in the database who played at Vanderbilt University. 
--Create a list showing each player’s first and last names as well as the total salary 
--they earned in the major leagues. Sort this list in descending order by the total salary earned. 
--Which Vanderbilt player earned the most money in the majors?

/*SELECT DISTINCT CONCAT( p.namefirst,' ',  p.namelast) AS full_name, s.schoolname, sa.salary
FROM people AS p
JOIN collegeplaying AS cp
ON cp.playerid = p.playerid
JOIN schools AS s
ON s.schoolid = cp.schoolid
JOIN salaries AS sa
ON p.playerid = sa.playerid
WHERE s.schoolname = 'Vanderbilt University'
GROUP BY full_name, sa.salary, s.schoolname
ORDER BY sa.salary DESC;*/
--Answer: David Price

/*Using the fielding table, group players into three groups based on their position: 
label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", 
and those with position "P" or "C" as "Battery". 
Determine the number of putouts made by each of these three groups in 2016.*/


SELECT p.playerid, f.pos, 
	CASE WHEN f.pos = 'OF' THEN 'Outfield'
	WHEN f.pos = 'SS' THEN 'Infield'	
	WHEN f.pos = '1B' THEN 'Infield'
	WHEN f.pos = '2B' THEN 'Infield'
	WHEN f.pos = '3B' THEN 'Infield'
	WHEN f.pos = 'P' THEN 'Battery'
	 WHEN f.pos = 'C'THEN 'Battery'
	 ELSE null END AS g
	 
FROM fielding AS f
JOIN people AS p
ON p.playerid = f.playerid
WHERE f.yearid = '2016'
ORDER BY g


