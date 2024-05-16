
-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values

SELECT
    *
FROM
    corona
WHERE 
    province        IS NULL OR            
    country_region  IS NULL OR    
    latitude        IS NULL OR    
    longitude       IS NULL OR    
    date            IS NULL OR    
    confirmed       IS NULL OR    
    deaths          IS NULL OR    
    recovered       IS NULL;

--?----------------------------------------------------------------------------------------------
--Q2. If NULL values are present, update them with zeros for all columns. 

ALTER TABLE
    corona
alter column province SET DEFAULT '0',
alter column province set not null,
alter column country_region SET DEFAULT '0',
alter column country_region set not null,
alter column date SET DEFAULT now(),
alter column date set not null,
alter column deaths SET DEFAULT 0,
alter column deaths set not null,
alter column confirmed SET DEFAULT 0,
alter column confirmed set not null,
alter column recovered SET DEFAULT 0,
alter column recovered set not null,
alter column latitude SET DEFAULT 0,
alter column latitude set not null,
alter column longitude SET DEFAULT 0,
alter column longitude set not null;
--  -- setting a default value to zero then adding a constraint to remove nulls and for future use

--?----------------------------------------------------------------------------------------------
-- Q3. check total number of rows
SELECT
    COUNT(*) AS total_num_rows
FROM
    corona;

--?----------------------------------------------------------------------------------------------
-- Q4. Check what is start_date and end_date
SELECT
    MIN(date) start_date,
    MAX(date) end_date
FROM
    corona;

--?----------------------------------------------------------------------------------------------
-- Q5. Number of month present in dataset
SELECT
    COUNT(
        DISTINCT (
                    extract(year from date) * 100 +
                    EXTRACT(month from date)
                )
         ) AS number_of_months
FROM
    corona;

--?----------------------------------------------------------------------------------------------
-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT
    DATE_TRUNC('month', date) as month,
    AVG(confirmed) AS monthly_average_confirmed,
    AVG(deaths) as monthly_average_deaths,
    AVG(recovered) as monthly_average_recovered
FROM
    corona
GROUP BY
    date_trunc( 'month', date )
ORDER BY
    month;

--?----------------------------------------------------------------------------------------------
-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
SELECT 
    DATE_TRUNC('month', date) AS month,
    MODE() WITHIN GROUP (ORDER BY confirmed) AS mode_confirmed,
    MODE() WITHIN GROUP (ORDER BY deaths) AS mode_deaths,
    MODE() WITHIN GROUP (ORDER BY recovered) AS mode_recovered
FROM 
    corona
GROUP BY 
    DATE_TRUNC('month', date);

--?----------------------------------------------------------------------------------------------
-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT
    EXTRACT( YEAR FROM date) AS year,
    MIN(confirmed) AS min_confirmed,
    MIN(deaths) AS min_deaths,
    MIN(recovered) AS min_recovered
FROM
    corona
GROUP BY
    EXTRACT( YEAR FROM date);

--?----------------------------------------------------------------------------------------------
-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT
    EXTRACT( YEAR FROM date) AS year,
    MAX(confirmed) AS max_confirmed,
    MAX(deaths) AS max_deaths,
    MAX(recovered) AS max_recovered
FROM
    corona
GROUP BY
    EXTRACT( YEAR FROM date);

--?----------------------------------------------------------------------------------------------
-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT
    DATE_TRUNC('month', date) as month,
    SUM(confirmed) as total_confirmed,
    SUM(deaths) as total_deaths,
    SUM(recovered) as total_recovered
FROM
    corona
GROUP BY
    DATE_TRUNC('month', date)
ORDER BY
    month;

--?----------------------------------------------------------------------------------------------
-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
    DATE_TRUNC('month', date) as month,
    SUM(confirmed) as monthly_total_confirmed,
    AVG(confirmed) AS monthly_average_confirmed,
    VARIANCE(confirmed) as monthly_variance_confirmed,
    STDDEV(confirmed) as monthly_std_dev_confirmed
FROM
    corona
GROUP BY
    date_trunc( 'month', date )
ORDER BY
    month;

--?----------------------------------------------------------------------------------------------
-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
    DATE_TRUNC('month', date) as month,
    SUM(deaths) as monthly_total_deaths,
    AVG(deaths) AS monthly_average_deaths,
    VARIANCE(deaths) as monthly_variance_deaths,
    STDDEV(deaths) as monthly_std_dev_deaths
FROM
    corona
GROUP BY
    date_trunc( 'month', date )
ORDER BY
    month;

--?----------------------------------------------------------------------------------------------
-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT
    DATE_TRUNC('month', date) as month,
    SUM(recovered) as monthly_total_recovered,
    AVG(recovered) AS monthly_average_recovered,
    VARIANCE(recovered) as monthly_variance_recovered,
    STDDEV(recovered) as monthly_std_dev_recovered
FROM
    corona
GROUP BY
    date_trunc( 'month', date )
ORDER BY
    month;

--?----------------------------------------------------------------------------------------------
-- Q14. Find Country having highest number of the Confirmed case
SELECT
    country_region,
    SUM(confirmed) AS confirmed_cases
FROM
    corona
GROUP BY
    country_region
ORDER BY
    confirmed_cases DESC
LIMIT 1;

--?----------------------------------------------------------------------------------------------
-- Q15. Find Country having lowest number of the death case
SELECT
    country_region,
    SUM(deaths) AS death_cases
FROM
    corona
GROUP BY
    country_region
ORDER BY
    death_cases
LIMIT 4;

--?----------------------------------------------------------------------------------------------
-- Q16. Find top 5 countries having highest recovered case
SELECT
    country_region,
    SUM(recovered) AS recovered_cases
FROM
    corona
GROUP BY
    country_region
ORDER BY
    recovered_cases DESC
LIMIT 5;