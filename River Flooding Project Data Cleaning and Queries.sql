-- Data sourced from The Department for Environment Food & Rural Affairs, URL: https://environment.data.gov.uk/hydrology/explore																

-- Looking at the data to determine what I want to clean up.

SELECT * 
FROM Lintonmaxleveldaily LML

SELECT * 
FROM Babrahammaxleveldaily BML

SELECT * 
FROM Staplefordmaxleveldaily SML

-- I have decided I don't want the measure, dateTime, completeness or qcode column.

ALTER TABLE Lintonmaxleveldaily
DROP COLUMN measure,dateTime,completeness,qcode;

ALTER TABLE Babrahammaxleveldaily
DROP COLUMN measure,dateTime,completeness,qcode;

ALTER TABLE Staplefordmaxleveldaily
DROP COLUMN measure,dateTime,completeness,qcode;

-- I now want to add a location column to distinguish the data in the final table.

	-- Adding the column.

ALTER TABLE Lintonmaxleveldaily
ADD Location varchar(50);

ALTER TABLE Babrahammaxleveldaily
ADD Location varchar(50);

ALTER TABLE Staplefordmaxleveldaily
ADD Location varchar(50);

	-- Filling in the values.

SELECT Location 
FROM Lintonmaxleveldaily
UPDATE Lintonmaxleveldaily
SET Location = 'Linton'

SELECT Location 
FROM Babrahammaxleveldaily
UPDATE Babrahammaxleveldaily
SET Location = 'Babraham'

SELECT Location 
FROM Staplefordmaxleveldaily
UPDATE Staplefordmaxleveldaily
SET Location = 'Stapleford'

-- Checking what the tables look like after cleaning.

SELECT * 
FROM Lintonmaxleveldaily LML

SELECT * 
FROM Babrahammaxleveldaily BML

SELECT * 
FROM Staplefordmaxleveldaily SML

-- Required to show max level data from 2018 to 2023.

	-- I am starting by inserting all the data into one table.
	   
DROP TABLE if exists Maxleveldaily
CREATE TABLE Maxleveldaily
(Date date,
Value decimal(18,10),
Quality varchar(50),
Location varchar(50)
)

INSERT INTO Maxleveldaily (Date, Value, Quality, Location)
SELECT date, value, quality, Location
FROM Lintonmaxleveldaily
 
INSERT INTO Maxleveldaily (Date, Value, Quality, Location)
SELECT date, value, quality, Location
FROM Babrahammaxleveldaily
 
INSERT INTO Maxleveldaily (Date, Value, Quality, Location)
SELECT date, value, quality, Location
FROM Staplefordmaxleveldaily

SELECT *
FROM Maxleveldaily

	-- Now I can use the WHERE Clause to specify the date.

SELECT *
FROM Maxleveldaily
WHERE Date >= '2018-01-01'

-- Selecting Data Between Start and 2002

SELECT *
FROM Maxleveldaily
WHERE Date <= '2002-01-01'

-- Selecting Data Between 2002 and 2018

SELECT *
FROM Maxleveldaily
WHERE Date >= '2002-01-01' AND DATE <= '2018-01-01'

-- Selecting Data for count of specific river height per year in m for 2018.

WITH CTE_COUNTValue as 
(SELECT DATEPART(YEAR, Date) as Year, Location, Value
FROM Maxleveldaily
WHERE Date >= '2018' AND Date < '2019' AND Location = 'Linton'
)
SELECT Year, COUNT(CAST(Value as decimal(18,3))) as Similar_Value_Count, Location, CAST(Value as decimal(18,3)) as Value
FROM CTE_COUNTValue
GROUP BY Location, Year, Value
ORDER BY Value ASC

-- Selecting Data for count of specific river height per year in m for 2019.

WITH CTE_COUNTValue as 
(SELECT DATEPART(YEAR, Date) as Year, Location, Value
FROM Maxleveldaily
WHERE Date >= '2019' AND Date < '2020' AND Location = 'Linton'
)
SELECT Year, COUNT(CAST(Value as decimal(18,3))) as Similar_Value_Count, Location, CAST(Value as decimal(18,3)) as Value
FROM CTE_COUNTValue
GROUP BY Location, Year, Value
ORDER BY Value ASC

-- Selecting Data for count of specific river height per year in m for 2020.

WITH CTE_COUNTValue as 
(SELECT DATEPART(YEAR, Date) as Year, Location, Value
FROM Maxleveldaily
WHERE Date >= '2020' AND Date < '2021' AND Location = 'Linton'
)
SELECT Year, COUNT(CAST(Value as decimal(18,3))) as Similar_Value_Count, Location, CAST(Value as decimal(18,3)) as Value
FROM CTE_COUNTValue
GROUP BY Location, Year, Value
ORDER BY Value ASC

-- Selecting Data for count of specific river height per year in m for 2021.

WITH CTE_COUNTValue as 
(SELECT DATEPART(YEAR, Date) as Year, Location, Value
FROM Maxleveldaily
WHERE Date >= '2021' AND Date < '2022' AND Location = 'Linton'
)
SELECT Year, COUNT(CAST(Value as decimal(18,3))) as Similar_Value_Count, Location, CAST(Value as decimal(18,3)) as Value
FROM CTE_COUNTValue
GROUP BY Location, Year, Value
ORDER BY Value ASC

-- Selecting Data for count of specific river height per year in m for 2022.

WITH CTE_COUNTValue as 
(SELECT DATEPART(YEAR, Date) as Year, Location, Value
FROM Maxleveldaily
WHERE Date >= '2022' AND Date < '2023' AND Location = 'Linton'
)
SELECT Year, COUNT(CAST(Value as decimal(18,3))) as Similar_Value_Count, Location, CAST(Value as decimal(18,3)) as Value
FROM CTE_COUNTValue
GROUP BY Location, Year, Value
ORDER BY Value ASC

-- Selecting Data for count of specific river height per year in m for 2023.

WITH CTE_COUNTValue as 
(SELECT DATEPART(YEAR, Date) as Year, Location, Value
FROM Maxleveldaily
WHERE Date >= '2023' AND Location = 'Linton'
)
SELECT Year, COUNT(CAST(Value as decimal(18,3))) as Similar_Value_Count, Location, CAST(Value as decimal(18,3)) as Value
FROM CTE_COUNTValue
GROUP BY Location, Year, Value
ORDER BY Value ASC
