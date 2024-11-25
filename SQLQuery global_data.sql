----dataset overview---------
SELECT*
FROM global_inflation_data;

SELECT COUNT(*)
FROM global_inflation_data

SELECT*
FROM global_inflation_datac1;

----------------RENAMING THE COLUMN HEADER ----------------
EXEC sp_rename 'global_inflation_data.column1', 'Country_name', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column2', 'Indicator_name', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column3', '1980', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column4', '1981', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column5', '1982', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column6', '1983', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column7', '1984', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column8', '1985', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column9', '1986', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column10', '1987', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column11', '1988', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column12', '1989', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column13', '1990', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column14', '1991', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column15', '1992', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column16', '1993', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column17', '1994', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column18', '1995', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column19', '1996', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column20', '1997', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column21', '1998', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column22', '1999', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column23', '2000', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column24', '2001', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column25', '2002', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column26', '2003', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column27', '2004', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column28', '2005', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column29', '2006', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column30', '2007', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column31', '2008', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column32', '2009', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column33', '2010', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column34', '2011', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column35', '2012', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column36', '2013', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column37', '2014', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column38', '2015', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column39', '2016', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column40', '2017', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column41', '2018', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column42', '2019', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column43', '2020', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column44', '2021', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column45', '2022', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column46', '2023', 'COLUMN';
EXEC sp_rename 'global_inflation_data.column47', '2024', 'COLUMN';

----------DELETE THE FIRST ROW BECAUSE IS A DUPLICATE OF THE HEADER---------------------
DELETE FROM global_inflation_data
WHERE Country_name = 'country_name' AND Indicator_name = 'indicator_name'


----------------------CREATE A BACK UP TABLE--------------
SELECT*
INTO global_inflation_datac1
FROM global_inflation_data;

----------------CREATE SEQUECER ID COLUMN---------------------
ALTER TABLE global_inflation_datac1
ADD id INT IDENTITY(1,1) NOT NULL;

ALTER TABLE global_inflation_datac1
MODIFY COLUMN id INT FIRST;(can only work in sql);

------------------CHECKING THE DISTINCT VALUE---------------
SELECT DISTINCT (Country_name)
FROM global_inflation_datac1;

SELECT DISTINCT (Indicator_name)
FROM global_inflation_datac1;


---------------------IDENTIFY AND REMOVE DUPLICATES--------------
SELECT*,
ROW_NUMBER() OVER (PARTITION BY Country_name,Indicator_name,1980,1981,1982,1983,1984,1985,1986,1987,1988,1999,2000,2001,2002,2003,2004,2005,2006,2007,
       2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,id order by id) AS row_num
	   FROM global_inflation_datac1;

WITH duplicate_values AS (
SELECT*,
ROW_NUMBER() OVER (PARTITION BY Country_name,Indicator_name,1980,1981,1982,1983,1984,1985,1986,1987,1988,1999,2000,2001,2002,2003,2004,2005,2006,2007,
       2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,id order by id) AS row_num
	   FROM global_inflation_datac1)
SELECT*
FROM duplicate_values
WHERE row_num > 1    /* No Dupliacte Value */

--------------TO CHECK THE NULL VALUES----------------
/* WE HAVE 60 ROWS WITH NULL VALUES */
SELECT *
FROM global_inflation_datac1
WHERE Country_name IS NULL 
   OR Indicator_name IS NULL 
   OR [1980] IS NULL 
   OR [1981] IS NULL 
   OR [1982] IS NULL 
   OR [1983] IS NULL 
   OR [1984] IS NULL 
   OR [1985] IS NULL 
   OR [1986] IS NULL 
   OR [1987] IS NULL 
   OR [1988] IS NULL 
   OR [1999] IS NULL 
   OR [2000] IS NULL 
   OR [2001] IS NULL 
   OR [2002] IS NULL 
   OR [2003] IS NULL 
   OR [2004] IS NULL 
   OR [2005] IS NULL 
   OR [2006] IS NULL 
   OR [2007] IS NULL 
   OR [2008] IS NULL 
   OR [2009] IS NULL 
   OR [2010] IS NULL 
   OR [2011] IS NULL 
   OR [2012] IS NULL 
   OR [2013] IS NULL 
   OR [2014] IS NULL 
   OR [2015] IS NULL 
   OR [2016] IS NULL 
   OR [2017] IS NULL 
   OR [2018] IS NULL 
   OR [2019] IS NULL 
   OR [2020] IS NULL 
   OR [2021] IS NULL 
   OR [2022] IS NULL 
   OR [2023] IS NULL 
   OR [2024] IS NULL 
   OR id IS NULL;

---------- STANDARDIZING DATA ------------------
SELECT DISTINCT (Country_name)
FROM global_inflation_datac1;

SELECT DISTINCT(TRIM(Country_name))
FROM global_inflation_datac1;

SELECT Country_name,TRIM(Country_name) AS country_name
FROM global_inflation_datac1;

UPDATE global_inflation_datac1
SET Country_name = TRIM(Country_name);

UPDATE global_inflation_datac1
SET Country_name = TRIM(Country_name);

--------correcting the column name -to lower case----
sp_rename 'global_inflation_datac1.Country_name', 'country_name', 'COLUMN';
sp_rename 'global_inflation_datac1.Indicator_name', 'indicator_name', 'column';

---------------Changing the NULL values in the row to 0------------------------
UPDATE global_inflation_datac1 SET [1980] = 0 WHERE [1980] IS NULL;
UPDATE global_inflation_datac1 SET [1981] = 0 WHERE [1981] IS NULL;
UPDATE global_inflation_datac1 SET [1982] = 0 WHERE [1982] IS NULL;
UPDATE global_inflation_datac1 SET [1983] = 0 WHERE [1983] IS NULL;
UPDATE global_inflation_datac1 SET [1984] = 0 WHERE [1984] IS NULL;
UPDATE global_inflation_datac1 SET [1985] = 0 WHERE [1985] IS NULL;
UPDATE global_inflation_datac1 SET [1986] = 0 WHERE [1986] IS NULL;
UPDATE global_inflation_datac1 SET [1987] = 0 WHERE [1987] IS NULL;
UPDATE global_inflation_datac1 SET [1988] = 0 WHERE [1988] IS NULL;
UPDATE global_inflation_datac1 SET [1989] = 0 WHERE [1989] IS NULL;
UPDATE global_inflation_datac1 SET [1990] = 0 WHERE [1990] IS NULL;
UPDATE global_inflation_datac1 SET [1991] = 0 WHERE [1991] IS NULL;
UPDATE global_inflation_datac1 SET [1992] = 0 WHERE [1992] IS NULL;
UPDATE global_inflation_datac1 SET [1993] = 0 WHERE [1993] IS NULL;
UPDATE global_inflation_datac1 SET [1994] = 0 WHERE [1994] IS NULL;
UPDATE global_inflation_datac1 SET [1995] = 0 WHERE [1995] IS NULL;
UPDATE global_inflation_datac1 SET [1996] = 0 WHERE [1996] IS NULL;
UPDATE global_inflation_datac1 SET [1997] = 0 WHERE [1997] IS NULL;
UPDATE global_inflation_datac1 SET [1998] = 0 WHERE [1998] IS NULL;
UPDATE global_inflation_datac1 SET [1999] = 0 WHERE [1999] IS NULL;
UPDATE global_inflation_datac1 SET [2000] = 0 WHERE [2000] IS NULL;
UPDATE global_inflation_datac1 SET [2001] = 0 WHERE [2001] IS NULL;
UPDATE global_inflation_datac1 SET [2002] = 0 WHERE [2002] IS NULL;
UPDATE global_inflation_datac1 SET [2003] = 0 WHERE [2003] IS NULL;
UPDATE global_inflation_datac1 SET [2004] = 0 WHERE [2004] IS NULL;
UPDATE global_inflation_datac1 SET [2005] = 0 WHERE [2005] IS NULL;
UPDATE global_inflation_datac1 SET [2006] = 0 WHERE [2006] IS NULL;
UPDATE global_inflation_datac1 SET [2007] = 0 WHERE [2007] IS NULL;
UPDATE global_inflation_datac1 SET [2008] = 0 WHERE [2008] IS NULL;
UPDATE global_inflation_datac1 SET [2009] = 0 WHERE [2009] IS NULL;
UPDATE global_inflation_datac1 SET [2010] = 0 WHERE [2010] IS NULL;
UPDATE global_inflation_datac1 SET [2011] = 0 WHERE [2011] IS NULL;
UPDATE global_inflation_datac1 SET [2012] = 0 WHERE [2012] IS NULL;
UPDATE global_inflation_datac1 SET [2013] = 0 WHERE [2013] IS NULL;
UPDATE global_inflation_datac1 SET [2014] = 0 WHERE [2014] IS NULL;
UPDATE global_inflation_datac1 SET [2015] = 0 WHERE [2015] IS NULL;
UPDATE global_inflation_datac1 SET [2016] = 0 WHERE [2016] IS NULL;
UPDATE global_inflation_datac1 SET [2017] = 0 WHERE [2017] IS NULL;
UPDATE global_inflation_datac1 SET [2018] = 0 WHERE [2018] IS NULL;
UPDATE global_inflation_datac1 SET [2019] = 0 WHERE [2019] IS NULL;
UPDATE global_inflation_datac1 SET [2020] = 0 WHERE [2020] IS NULL;
UPDATE global_inflation_datac1 SET [2021] = 0 WHERE [2021] IS NULL;
UPDATE global_inflation_datac1 SET [2022] = 0 WHERE [2022] IS NULL;
UPDATE global_inflation_datac1 SET [2023] = 0 WHERE [2023] IS NULL;
UPDATE global_inflation_datac1 SET [2024] = 0 WHERE [2024] IS NULL;


SELECT*
FROM global_inflation_datac1;
  
  ----------------------------------------------------Data analysis------------------------------------------

 -------- Top 10 country with the highest inflation in the year 1980---------

SELECT TOP 10 country_name,[1980] AS inflation_rate
FROM global_inflation_datac1
ORDER BY inflation_rate DESC;

---- Top 10 country with the highest inflation in the year 2024 ---------
SELECT TOP 10 country_name, [2024] AS inflation_rate
FROM global_inflation_datac1
ORDER BY [2024] DESC;

-------Inflation rate in Yaer 1980 in Afghanistan--------
SELECT country_name,[1980] AS inflation_rate
FROM global_inflation_datac1
WHERE country_name = 'Afghanistan'


------- TOP 5 countries with the highest inflation from 1980 to 2024----------

SELECT TOP 5 country_name, 
       SUM([1980] + [1981] + [1982] + [1983] + [1984] + [1985] + [1986] + [1987] + [1988] + [1989] + 
           [1990] + [1991] + [1992] + [1993] + [1994] + [1995] + [1996] + [1997] + [1998] + [1999] + 
           [2000] + [2001] + [2002] + [2003] + [2004] + [2005] + [2006] + [2007] + [2008] + [2009] + 
           [2010] + [2011] + [2012] + [2013] + [2014] + [2015] + [2016] + [2017] + [2018] + [2019] + 
           [2020] + [2021] + [2022] + [2023] + [2024]) AS Tot_inflation
FROM global_inflation_datac1
--- WHERE country_name = 'Afghanistan'
GROUP BY country_name
ORDER BY Tot_inflation DESC;


------- TOP 5 countries with the Average inflation from 1980 to 2024---------- 
SELECT TOP 5 country_name, 
       (SUM([1980]) + SUM([1981]) + SUM([1982]) + SUM([1983]) + SUM([1984]) + SUM([1985]) + SUM([1986]) + SUM([1987]) + SUM([1988]) + SUM([1989]) + 
        SUM([1990]) + SUM([1991]) + SUM([1992]) + SUM([1993]) + SUM([1994]) + SUM([1995]) + SUM([1996]) + SUM([1997]) + SUM([1998]) + SUM([1999]) + 
        SUM([2000]) + SUM([2001]) + SUM([2002]) + SUM([2003]) + SUM([2004]) + SUM([2005]) + SUM([2006]) + SUM([2007]) + SUM([2008]) + SUM([2009]) + 
        SUM([2010]) + SUM([2011]) + SUM([2012]) + SUM([2013]) + SUM([2014]) + SUM([2015]) + SUM([2016]) + SUM([2017]) + SUM([2018]) + SUM([2019]) + 
        SUM([2020]) + SUM([2021]) + SUM([2022]) + SUM([2023]) + SUM([2024])) / 45.0 AS avg_inflation
FROM global_inflation_datac1
GROUP BY country_name
ORDER BY avg_inflation DESC; 


SELECT TOP 5 country_name, 
       (SUM([1980]) + SUM([1981]))/2 AS avg_inflation
FROM global_inflation_datac1
WHERE country_name = 'Israel'
GROUP BY country_name
ORDER BY avg_inflation DESC; 

SELECT*
FROM global_inflation_datac1; 









































------------Another way to convert all NULL to 0---------------
SELECT*
INTO #Temp_global
FROM Database_class..global_inflation_datac1;

SELECT*
FROM #Temp_global;


DECLARE @sql NVARCHAR(MAX) = N'';
DECLARE @#Temp_global NVARCHAR(128) = '#Temp_global';

-- Loop through each year from 1980 to 2024
DECLARE @year INT = 1980;
WHILE @year <= 2024
BEGIN
    SET @sql += 'UPDATE ' + @#Temp_global + ' SET [' + CAST(@year AS NVARCHAR(4)) + '] = 0 WHERE [' + CAST(@year AS NVARCHAR(4)) + '] IS NULL; ';
    SET @year += 1;
END

-- Execute the generated SQL
EXEC sp_executesql @sql;



/*
SELECT*
FROM imf_dm;

DELETE FROM imf_dm
WHERE country_name = 'country_name' AND 1980 = '1980';


------------join downloaded table to the main table-------------
SELECT t1.country_name,t1.indicator_name,t1.[1980],t1.[1981],t1.[1982],t1.[1983],t1.[1984],t1.[1985],t1.[1986],t1.[1987],t1.[1988],t1.[1989],
t1.[1990],t1.[1991],t1.[1992],t1.[1993],t1.[1994],t1.[1995],t1.[1996],t1.[1997],t1.[1998],t1.[1999],t1.[2000],t1.[2001],t1.[2002],t1.[2003],t1.[2004],
t1.[2005],t1.[2006],t1.[2007],t1.[2008],t1.[2009],t1.[2010],t1.[2011],t1.[2012],t1.[2013],t1.[2014],t1.[2015],t1.[2016],t1.[2017],t1.[2018],t1.[2019],
t1.[2020],t1.[2021],t1.[2022],t1.[2022],t1.[2023],t1.[2024],t1.id
FROM Database_class..global_inflation_datac1 t1
LEFT JOIN imf_dm t2 on t1.country_name = t2.country_name;


ALTER TABLE imf_dm
ADD id INT IDENTITY(1,1) NOT NULL;
*/


----------- used the join to create another table named global_inflation_datac4--------------------
/* SELECT*
INTO global_inflation_datac4
FROM (
SELECT t1.country_name,t1.indicator_name,t1.[1980],t1.[1981],t1.[1982],t1.[1983],t1.[1984],t1.[1985],t1.[1986],t1.[1987],t1.[1988],t1.[1989],
t1.[1990],t1.[1991],t1.[1992],t1.[1993],t1.[1994],t1.[1995],t1.[1996],t1.[1997],t1.[1998],t1.[1999],t1.[2000],t1.[2001],t1.[2002],t1.[2003],t1.[2004],
t1.[2005],t1.[2006],t1.[2007],t1.[2008],t1.[2009],t1.[2010],t1.[2011],t1.[2012],t1.[2013],t1.[2014],t1.[2015],t1.[2016],t1.[2017],t1.[2018],t1.[2019],
t1.[2020],t1.[2021],t1.[2022],t1.[2023],t1.[2024],t1.id
FROM Database_class..global_inflation_datac1 t1
LEFT JOIN imf_dm t2 on t1.country_name = t2.country_name
) AS subquery; */



























DELETE global_inflation_data;
TRUNCATE global_inflation_data;
DROP TABLE global_inflation_datac1;