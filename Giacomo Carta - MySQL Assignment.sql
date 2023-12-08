# Task 3: Using COUNT, get the number of cities in the USA

USE world;

SELECT * FROM city;

SELECT * FROM country;

SELECT COUNT(*) FROM city
WHERE CountryCode = "USA";

# extension to task 3 - use AND function

SELECT COUNT(*) FROM city
WHERE CountryCode = "USA" AND District = "California";

# Task 3 : Find out what the population and life expectancy for people in Argentina (ARG) is

SELECT * FROM country;

SELECT Name, Population, LifeExpectancy 
FROM country
WHERE Name = "Argentina";

# Task 5: Using ORDER BY, LIMIT, what country has the highest life expectancy?

SELECT Name, LifeExpectancy
FROM country
ORDER BY LifeExpectancy DESC
LIMIT 1;

# extension for task 5 - showing the lowest life expectancy and filtering out NULL values

SELECT Name, LifeExpectancy
FROM country
ORDER BY LifeExpectancy ASC
LIMIT 1;

SELECT Name, LifeExpectancy
FROM country
WHERE LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy ASC
LIMIT 1;

# extension2 for task 5 - show NULL values to identify trends

SELECT Name, LifeExpectancy, Population
FROM country
WHERE LifeExpectancy IS NULL
ORDER BY LifeExpectancy ASC;

# Task 6: Select 25 cities around the world that start with the letter 'F' in a single SQL query.

SELECT Name 
FROM city 
WHERE Name LIKE "F%" 
LIMIT 25;

# Task 7: Create a SQL statement to display columns Id, Name, Population from the city table and limit results to first 10 rows only.

SELECT ID, Name, Population 
FROM city
LIMIT 10; 

# extension to task 7 - use different cases for columns and table

SELECT iD, Name, PopUlAtIon 
FROM CITy
LIMIT 10; 

# Task 8: Create a SQL statement to find only those cities from city table whose population is larger than 2000000.

SELECT Name, Population
FROM CiTY
WHERE Population > 2000000
ORDER BY Population DESC;

# Task 9 (Optional): Create a SQL statement to find all city names from city table whose name begins with “Be” prefix.

SELECT Name
FROM city
WHERE Name LIKE "Be%";

# extension to task 9 - use different wildcards combined

SELECT Name
FROM city
WHERE Name LIKE "Be______";

# Task 10 (Optional): Create a SQL statement to find only those cities from city table whose population is between 500000-1000000.

SELECT Name, Population
FROM city
WHERE Population
BETWEEN 500000 AND 1000000;

# Task 11 (Optional): Create a SQL statement to find a city with the lowest population in the city table.

SELECT Name, Population
FROM city
ORDER BY Population
LIMIT 1;

# extension to task 11 - join tables to show country name and city name

SELECT 
    city.Name,
    city.Population,
    country.Name AS Country,
    country.Continent,
    country.Region,
    country.SurfaceArea AS Area,
    city.Population / country.SurfaceArea AS Density
FROM
    city
        JOIN
    country ON city.CountryCode = country.Code
ORDER BY Population
LIMIT 1;

# Task 12 (Optional): Create a SQL statement to show the population of Switzerland and all the languages spoken there.

SELECT 
    c.Name,
    c.Population,
    cl.Language,
    cl.IsOfficial,
    cl.Percentage
FROM
    country c
        JOIN
    countrylanguage cl ON cl.CountryCode = c.Code
WHERE
    c.Name = 'Switzerland';
    
    # extension to task 12 (Optional) - calculate the population reflected by the percentage

SELECT
	c.Name,
    c.Population,
    cl.Language,
    cl.IsOfficial,
    cl.Percentage,
    ROUND(c.Population * (cl.Percentage / 100)) AS NumberOfSpeakers
FROM
    country c
    JOIN
    countrylanguage cl ON cl.CountryCode = c.Code
WHERE
    c.Name = 'Switzerland';
    
    # extension2 to task 12 - adding row to show other percentages
    
    SELECT 
    c.Name,
    c.Population,
    cl.Language,
    cl.IsOfficial,
    cl.Percentage,
    ROUND(c.Population * (cl.Percentage / 100)) AS NumberOfSpeakers
FROM
    country c
        JOIN
    countrylanguage cl ON cl.CountryCode = c.Code
WHERE
    c.Name = 'Switzerland' 
UNION 
SELECT 
    'Switzerland',
    7160400,
    'Others',
    'F' AS IsOfficial,
    ROUND(100 - SUM(cl.Percentage)) AS Percentage,
    ROUND(7160400 * (100 - SUM(cl.Percentage)) / 100) AS NumberOfSpeakers
FROM
    country c
        JOIN
    countrylanguage cl ON cl.CountryCode = c.Code
WHERE
    c.Name = 'Switzerland';