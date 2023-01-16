use Olympics

select 
[ID],
[Name] AS 'Competitor Name',
CASE WHEN Sex = 'M' Then 'Male' Else 'Female' End AS Sex,
[Age],
CASE WHEN [Age] < 18 Then 'Under 18'
	 When [Age] Between 18 and 25 Then '18-25'
	 When [Age] Between 25 and 30 Then '25-30'
	 When [Age] > 30 Then 'Over 30'
	 End AS [Age Grouping],
	 [Height],
	 [Weight],
	 [NOC] AS 'Nation Code',
--	 CHARINDEX(' ', Games)-1 AS 'Example 1',
--	 CHARINDEX(' ', REVERSE(Games))-1 AS 'Example 2',
	 LEFT(Games, CHARINDEX(' ', Games) -1) AS 'Year',
----	 RIGHT(Games, CHARINDEX(' ', REVERSE(Games))-1) AS 'Season',
	--- [Games],
	 [Sport],
	 [Event],
	 CASE WHEN Medal = 'NA' Then 'Not Registered' Else Medal End AS Medal
from athlete_events$
Where RIGHT(Games, CHARINDEX(' ', REVERSE(Games))-1) = 'Summer'
