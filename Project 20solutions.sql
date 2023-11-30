--1-total games held
select COUNT(distinct Games) totalgames
from athlete_events

--2-list of games held
select distinct Year, City, Season
from athlete_events
order by Year asc

--3-no of nations in each oly games
select Games,count(distinct nr.region) gamespernation
from athlete_events ae
join noc_regions nr
on ae.NOC = nr.NOC
group by Games

--4-highest/lowest regions per event
select top 1 count (distinct NR.region) regionperevent , Games
from athlete_events AE
join noc_regions NR
on AE.NOC = NR.NOC
group by Games
order by regionperevent desc

--5-nations that has participated in all games
select NR.region, count (distinct Games) numofgames
from athlete_events AE
join noc_regions NR
on AE.NOC = NR.NOC
group by NR.region
having count (distinct Games) = 
(select  count (distinct Games) from athlete_events)

--6-games played in all summer
select Sport, count (distinct games) summergames
from athlete_events 
where season = 'summer'
group by Sport
having count(distinct Games) = 
(select count (distinct Games) 
from athlete_events where season = 'summer')

--7-Sports played only once
select Sport, MIN(games) season, count (distinct sport) countsport
from athlete_events 
group by Sport
having count(distinct Games) = 1

--8-no of games played per olympic
select count (distinct Sport) numsofports, Games 
from athlete_events 
group by Games
order by numsofports desc

--9-oldest athlete to win a gold medal
select name, sex, Age, Team, City, Games, Sport, Medal
from athlete_events
where Medal = 'gold'
group by Name, Sex, Team, Games, Sport, Medal, Age, City
order by Age desc

--10-ratio of males/females in all games
select sex, count (*) totalsex
from athlete_events
group by Sex ------ undetermined

--11-top 5 people that won the most gold medal
select Medal,  Name, COUNT (*) totalgold 
from athlete_events
where Medal = 'gold'
group by Medal, Name
order by totalgold desc

--12- top 5 people that won the medal
select Name, Team, COUNT (Medal) totalmedal
from athlete_events
where Medal <> 'na'
group by Team, Name
order by totalmedal desc

--13- top 5 successfull countries in the oly-game
select top 5 nr.region, COUNT(medal) totalmedal
from athlete_events ae
join noc_regions nr
on ae.NOC = nr.NOC
where Medal <> 'na'
group by nr.region
order by totalmedal desc

--14- total gold, silver and bronze
select Medal, count (*) countmedal, nr.region
from athlete_events ae
join  noc_regions nr
on ae.NOC = nr.NOC
where Medal <> 'na'
group by Medal, nr.region
order by nr.region

--14- in pivot format
select Team,
SUM(case when medal = 'gold' then 1 else 0 end) total_gold,
SUM(case when medal = 'silver' then 1 else 0 end) total_silver,
SUM(case when medal = 'bronze' then 1 else 0 end) total_bronze
from athlete_events
group by Team
order by total_gold desc

--15-total gold, silver and bronze medal won by each country in each oly year
select Games, Team,
SUM(case when medal = 'gold' then 1 else 0 end) count_gold,
SUM(case when medal = 'silver' then 1 else 0 end) count_silver,
SUM(case when medal = 'bronze' then 1 else 0 end) count_bronze
from athlete_events
group by Games, Team
order by Games 
--revisit Q10,Q16-20

--18-which country has never won a gold medal but has won others
--select nr.region, Games, Medal, COUNT (*)
--from athlete_events ae
--join noc_regions nr
--on ae.NOC = nr.NOC
--where Medal <> 'NA' 
--group by nr.region, Games, Medal


