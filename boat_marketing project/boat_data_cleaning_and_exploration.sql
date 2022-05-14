SELECT *
FROM boat_data;

SELECT COUNT(*)
FROM boat_data;

-- checking for missing values in the column of interest
SELECT COUNT(Numberofviewslast7days)
FROM boat_data;

-- Number of boats grouped by year the boats were built
SELECT YearBuilt, COUNT(YearBuilt) AS count
FROM boat_data
GROUP BY YearBuilt
ORDER BY count DESC;

-- further exploring the yearbuilt column in the dataset.
SELECT YearBuilt, COUNT(*) 
FROM boat_data 
WHERE yearbuilt > 1960
GROUP BY YearBuilt
ORDER BY YearBuilt;

-- Exploring the price column
SELECT DISTINCT SUBSTR(price, 1,3)
FROM boat_data;

SELECT *
FROM boat_data 
WHERE SUBSTR(price, 1,3) = 'Â£ ';

-- Converting the price to a unified currency for easier comparison (Euro)
-- At the time of this analysis: 1 Euro = 0.98 CHF, 1 Euro = 0.13 DKK, 1 Euro = 1.20 GBP
ALTER TABLE boat_data
ADD Price_cleaned NUMERIC;

UPDATE boat_data
SET price_cleaned  = 0.98 * CAST(SUBSTR(price, 4) AS NUMERIC)
WHERE SUBSTR(price, 1,3) = 'CHF';
UPDATE boat_data
SET price_cleaned = CAST(SUBSTR(price, 4) AS NUMERIC)
WHERE SUBSTR(price, 1,3) = 'EUR';
UPDATE boat_data
SET price_cleaned = 0.13 * CAST(SUBSTR(price, 4) AS NUMERIC)
WHERE SUBSTR(price, 1,3) = 'DKK';
UPDATE boat_data
SET price_cleaned = 1.20 * CAST(SUBSTR(price, 4) AS NUMERIC)
WHERE SUBSTR(price, 1,3) = 'Â£ ';

-- Creating a country column to extract the country from the location column
ALTER TABLE boat_data
ADD country CHAR;

-- populating the country column from the location column
SELECT location, 
	  CASE WHEN INSTR(location, 'Â') = 0 THEN location
	  ELSE SUBSTR(location, 1, INSTR(location, 'Â')-1) END  AS country
FROM boat_data;

-- updating the country column and correcting values to the countries they represent.
UPDATE boat_data
SET country = CASE WHEN INSTR(location, 'Â') = 0 THEN location
					ELSE SUBSTR(location, 1, INSTR(location, 'Â')-1) END;
					
UPDATE boat_data
SET country = 'Germany'
WHERE country IN ('24782 BÃ¼delsdorf', '83278 Traunstein', 'baden baden', 'Barssel', 'Beilngries', 'Berlin Wannsee', 'Berlin Wannsee', 'bodensee',
					'Brandenburg', 'Brandenburg an derHavel', 'Bremen', 'Donau', 'Greetsile/ KrummhÃ¶rn', 'Heilbronn', 'Lake Constance',
					'Neustadt in Holstein (Ostsee)', 'Niederrhein', 'NordseekÃ¼ste', 'Rostock', 'Steinwiesen', 'Stralsund', 'TravemÃ¼nde', 
					'waren mÃ¼ritz', 'Germany ', 'Bielefeld')
	 OR location LIKE '%Ostsee Â» Zingst%';
					
UPDATE boat_data
SET country = 'Austria'
WHERE country IN ('Neusiedl am See', 'Austria ');

UPDATE boat_data 
SET country = 'Belgium'
WHERE country IN ('BelgiÃ«, Zulte', 'Lommel', 'Opwijk', 'Belgium ');

UPDATE boat_data
SET country = 'Croatia'
WHERE country IN ('Croatia (Hrvatska) ','Croatia (Hrvatska)', 'Dalmatien', 'Kroatien Krk', 'Marina Punat', 'Novi Vinodolski', 'Rovinij', 'Split', 'Croatia ');

UPDATE boat_data 
SET country = 'Denmark'
WHERE country IN ('Juelsminde Havn', 'PT Ã¸stkysten ellers Esbjerg', 'Denmark ');

UPDATE boat_data 
SET country = 'France'
WHERE country IN ('annecy', 'France ', 'Martinique');

UPDATE boat_data 
SET country = 'Italy'
WHERE country IN ('Adria', 'Angera', 'FuÃach', 'Lago di Garda', 'lago maggiore', 'Lago Maggiore','Lago Maggiore ',  'Porto Rotondo', 'Toscana', 'Italy ',
					'Italien', 'Italie' );

UPDATE boat_data
SET country = 'Netherlands'
WHERE country IN ('Katwijk', 'Wijdenes', 'Zevenbergen', 'Netherlands ');

UPDATE boat_data
SET country = 'Spain'
WHERE country IN ('Calanova Mallorca', 'espa?a', 'Ibiza', 'Mallorca', 'Spain ');

UPDATE boat_data 
SET country = 'Switzerland'
WHERE country IN ('Avenches', 'Faoug', 'Lago Maggiore, Minusio', 'Rheinfelden', 'Rolle', 'Tenero, lago Maggiore', 'Thalwil', 'Thun', 
					'VierwaldstÃ¤ttersee - Buochs', 'Welschenrohr', 'ZÃ¼richse, 8855 Wangen SZ', 'Switzerland ');
UPDATE boat_data 
SET country = 'United States'
WHERE country IN ('United States', 'Lake Geneva', 'Lake Geneva',  'United States ');

UPDATE boat_data 
SET country = 'United Kingdom'
WHERE country IN ('United Kingdom', 'United Kingdom ', 'Jersey', 'Isle of Man', 'Gibraltar' );

UPDATE boat_data
SET country = 'Finland'
WHERE location LIKE '%Ostsee Â» Naantali%';

UPDATE boat_data 
SET country = 'Poland'
WHERE country LIKE '%Oder%';

UPDATE boat_data 
SET country = 'Slovenia'
WHERE country LIKE '%Izola%'; 

UPDATE boat_data
SET country = TRIM(country);

-- viewing the country column
SELECT country, COUNT(*) AS count
FROM boat_data 
GROUP BY country
ORDER BY country DESC;

-- Exploring the boattype column
SELECT boattype, COUNT(*)
FROM boat_data
GROUP BY BoatType
ORDER BY boattype

-- Creating a column to group the boat type using  the first boat type mentioned in the boattype column
ALTER TABLE boat_data
ADD BoatTypeGrouped CHAR;

UPDATE boat_data
SET BoatTypeGrouped = CASE WHEN INSTR(boattype, ',') = 0 THEN boattype 
					  ELSE SUBSTR(boattype, 1, INSTR(boattype, ',')-1) END;
					  
-- Viewing the newly created column and comparing to the original column
SELECT BoatTypeGrouped, boattype, COUNT(*)
FROM boat_data
GROUP BY BoatTypeGrouped, boattype
ORDER BY BoatTypeGrouped;




