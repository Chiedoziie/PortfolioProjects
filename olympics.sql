use Olympics

SELECT *
FROM athlete_events$

SELECT COUNT(*)
FROM athlete_events$

SELECT *
FROM noc_regions$

SELECT COUNT(*)
FROM noc_regions$

--How many men and women have participated in the olympic games

SELECT sex, COUNT(*) as gender_count
FROM athlete_events$
WHERE Season = 'summer'
GROUP BY Sex
ORDER BY gender_count desc

--AVERAGE AGE AND AGE DISTRIBUTION

SELECT sex, age
FROM athlete_events$
WHERE Age is not NULL and Season = 'summer'

SELECT sex, age
FROM athlete_events$
WHERE Age is not NULL and Season = 'summer'
AND Sex = 'M'

SELECT sex, age
FROM athlete_events$
WHERE Age is not NULL and Season = 'summer'
AND Sex = 'F'

SELECT AVG(age) as average_age, Sex
FROM athlete_events$
WHERE Season = 'summer'
GROUP BY Sex
ORDER BY average_age desc

--TOP 10 countries by athlete participation

SELECT TOP (10) COUNT(Sex) as gender_count, NOC
FROM athlete_events$
WHERE Season = 'summer'
GROUP BY NOC
ORDER BY gender_count desc;

--Participation per sex over the years

SELECT year, COUNT(CASE WHEN Sex = 'm' THEN 1 END) AS Male, 
    COUNT(CASE WHEN Sex = 'f' THEN 1 END) AS Female
FROM athlete_events$
WHERE Season = 'summer'
GROUP BY Year
ORDER BY Year

--TOP 10 sports by athlete participation

SELECT TOP (10) COUNT(Sex) as gender_count, Sport
FROM athlete_events$
WHERE Season = 'summer'
GROUP BY Sport
ORDER BY gender_count desc

--Gold Medal distribution by age

SELECT TOP (10) COUNT(*) as medal_count, age
FROM athlete_events$
WHERE Medal = 'gold' and Season = 'summer'
GROUP BY Age
ORDER BY medal_count desc

--Top 10 Gold Medal distribution by country

SELECT TOP (10) COUNT(*) as medal_count, NOC
FROM athlete_events$
WHERE Medal = 'Gold' and Season = 'summer'
GROUP BY NOC
ORDER BY medal_count desc

--Top 10 Gold Medal distribution by Sport

SELECT TOP (10) COUNT(*) as medal_count, Sport
FROM athlete_events$
WHERE Medal = 'Gold' and Season = 'summer'
GROUP BY Sport
ORDER BY medal_count desc


--Top 10 Medal distribution by country

SELECT TOP (10) NOC, COUNT(CASE WHEN Medal = 'gold' THEN 1 END) AS Gold, 
    COUNT(CASE WHEN Medal = 'silver' THEN 1 END) AS Silver,
	COUNT(CASE WHEN Medal = 'bronze' THEN 1 END) AS Bronze
FROM athlete_events$
WHERE Season = 'summer'
GROUP BY NOC
ORDER BY Gold DESC

--Top 5 gold medal Athletes 

SELECT TOP (5) COUNT(*) as Medals, Name
FROM athlete_events$
WHERE Medal = 'Gold' and Season = 'summer' and Sex = 'M'
GROUP BY Name
ORDER BY Medals desc

SELECT TOP (5) COUNT(*) as Medals, Name
FROM athlete_events$
WHERE Medal = 'Gold' and Season = 'summer' and Sex = 'F'
GROUP BY Name
ORDER BY Medals desc










