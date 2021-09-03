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
ORDER BY p.height
LIMIT 1*/

--Answer: Eddie Gaedel at 43", played 1 game for the St. Louis Browns

--3.Find all players in the database who played at Vanderbilt University. 
--Create a list showing each player’s first and last names as well as the total salary 
--they earned in the major leagues. Sort this list in descending order by the total salary earned. 
--Which Vanderbilt player earned the most money in the majors?

/*SELECT DISTINCT CONCAT( p.namefirst,' ',  p.namelast) AS full_name, s.schoolname, 
SUM(sa.salary)
FROM people AS p
JOIN collegeplaying AS cp
ON cp.playerid = p.playerid
JOIN schools AS s
ON s.schoolid = cp.schoolid
JOIN salaries AS sa
ON p.playerid = sa.playerid
WHERE s.schoolname = 'Vanderbilt University'
GROUP BY full_name,  s.schoolname
ORDER BY SUM(sa.salary) DESC;*/
--Answer: David Price

/* 4. Using the fielding table, group players into three groups based on their position: 
label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", 
and those with position "P" or "C" as "Battery". 
Determine the number of putouts made by each of these three groups in 2016.*/

/*WITH positions AS (
	SELECT
	po,
	yearid,
	CASE WHEN pos IN ('OF') THEN 'Outfield'
		WHEN pos IN ('SS','1B','2B','3B') THEN 'Infield'
	 	WHEN pos IN ('P', 'C') THEN 'Battery'
	 	END AS position_group
FROM fielding)

SELECT
	p.position_group,
	SUM(po) AS total_putouts
FROM positions as p
WHERE yearid = '2016'
GROUP BY position_group;*/
--Answer: Battery 41424, Infield 58934, Outfield 29560



/*5. Find the average number of strikeouts per game by decade since 1920. 
Round the numbers you report to 2 decimal places. 
Do the same for home runs per game. Do you see any trends?*/

/*SELECT ROUND(AVG(t.so),2) AS avg_so, ROUND(AVG(t.hr),2) AS hr_avg,
FLOOR(yearid/10) * 10 AS decades

FROM teams AS t

GROUP BY decades
ORDER BY decades;*/

/* ANSWER: 32.04	1.86	"1920s"
37.47	2.57	"1930s"
35.75	2.23	"1940s"
41.82	3.40	"1950s"
56.30	3.46	"1960s"
53.56	3.23	"1970s"
50.70	3.30	"1980s"
47.44	3.53	"1990s"
46.55	3.83	"2000s"
48.98	3.36	"2010s"*/

/* 6.Find the player who had the most success stealing bases in 2016, where success 
is measured as the percentage of stolen base attempts which are successful. 
(A stolen base attempt results either in a stolen base or being caught stealing.) 
Consider only players who attempted at least 20 stolen bases*/

/*SELECT DISTINCT p.playerid, CONCAT(p.namefirst, ' ', p.namelast),
t.sb , t.cs, ROUND(t.sb/(t.sb + t.cs),2) AS base_avg

FROM teams AS t
JOIN appearances AS a
ON t.yearid = a.yearid
JOIN people AS p 
ON a.playerid = p.playerid
WHERE a.yearid = '2016' AND t.sb >= 20
GROUP BY p.playerid, t.sb, t.cs
ORDER BY t.sb DESC
--Need help!!!!*/

/* 7. From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
What is the smallest number of wins for a team that did win the world series? 
Doing this will probably result in an unusually small number of wins for a world series champion 
– determine why this is the case. Then redo your query, excluding the problem year. 
How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
What percentage of the time?*/

/*SELECT teamid, MAX(w), WSWin, yearid
FROM teams
WHERE wswin IS NOT null AND yearid BETWEEN '1970' AND '2016' AND wswin = 'N'
GROUP BY teamid, wswin, yearid
ORDER BY MAX(w) DESC*/

/*SELECT teamid, MIN(w), wswin, yearid
FROM teams
WHERE wswin IS NOT null AND yearid BETWEEN '1970' AND '2016' AND yearid <> '1981' AND wswin = 'Y'
GROUP BY teamid, wswin, yearid
ORDER BY yearid*/

/*SELECT MAX(w), COUNT(w), ROUND(AVG(w),2)
FROM teams
WHERE yearid IS NOT NULL AND yearid BETWEEN '1970' AND '2016' AND yearid <> '1981' AND wswin = 'Y'*/

--Answer: Seattle had the most wins without a world series win. In 2001 they won 116 games.
		--Los Angeles won the 1981 World Series with only 63 wins. A player's strike led to the season
		--being divided into halves. 
		--The team with the most wins won the world series 45 times or 95.87%
			
/* 8. Using the attendance figures from the homegames table, find the teams and parks which had the top 5 
average attendance per game in 2016 (where average attendance is defined as total attendance 
divided by number of games). Only consider parks where there were at least 10 games played. 
Report the park name, team name, and average attendance. Repeat for the lowest 5 average
attendance.*/

/*SELECT h.team, p.park_name, ROUND(AVG(h.attendance/h.games),2) AS avg_attendance
FROM homegames AS h
JOIN parks AS p
ON h.park = p.park
WHERE year = '2016' AND h.games >= '10'
GROUP BY h.team, p.park_name
ORDER BY avg_attendance DESC*/

--Answer Part 1: 
--Dodger Stadium, Los Angeles Dodgers w/45719
--Busch Stadium III, St. Louis w/42524
--Rogers Centre, Toronto w/41877
--At&T Park, San Fransisco w/41546
--Wrigley Field, Chicago Cubs w/39906

/*SELECT h.team, p.park_name, ROUND(AVG(h.attendance/h.games),2) AS avg_attendance
FROM homegames AS h
JOIN parks AS p
ON h.park = p.park
WHERE year = '2016' AND h.games >= '10'
GROUP BY h.team, p.park_name
ORDER BY avg_attendance ASC
LIMIT 5*/

--Answer: Tropicana Field, Tampa Bay w/15878
--Oakland-Alameda County Coliseum, Oakland w/18784
--Progressive Field, Cleveland w/19650
--Marlins Park, Miami w/21405
--US Cellular Field Chicago White Sox w/21559

--8. Which managers have won the TSN Manager of the Year award in both the National League (NL) and 
--the American League (AL)? Give their full name and the teams that they were managing when they 
--won the award.

WITH awardsmanagers AS (SELECT playerid, lgid FROM awardsmanagers WHERE lgid = 'NL') 
SELECT  CONCAT(p.namefirst, ' ', p.namelast) AS name,
	   am.awardid,
	   m.teamid,
	   m.lgid,
	   m.yearid
	   
FROM awardsmanagers AS am
JOIN people AS p
ON am.playerid = p.playerid
JOIN managershalf AS mh
ON p.playerid = mh.playerid
JOIN managers AS m
ON m.teamid = mh.teamid
JOIN awardsmanagers AS amtwo
ON p.playerid = amtwo.playerid
WHERE am.awardid = 'TSN Manager of the Year'
GROUP BY name, am.awardid, m.teamid, m.lgid, m.yearid
ORDER BY  m.yearid

