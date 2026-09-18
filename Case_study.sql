-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- SESSION 19: Case Study - Zomato Bangalore Restaurants
-- ============================================================
-- Assumption: The Kaggle Zomato Bangalore dataset is loaded into
-- a table named `zomato` using common column names:
-- name, cuisines, location, rate, online_order,
-- `approx_cost(for two people)`.


-- Task 1: Top 5 highest-rated restaurants in Koramangala
-- serving North Indian cuisine
SELECT
    name,
    cuisines,
    location,
    CAST(
        NULLIF(REGEXP_REPLACE(SUBSTRING_INDEX(rate, '/', 1), '[^0-9.]', ''), '')
        AS DECIMAL(3,1)
    ) AS rating
FROM zomato
WHERE location = 'Koramangala'
  AND cuisines LIKE '%North Indian%'
  AND NULLIF(REGEXP_REPLACE(SUBSTRING_INDEX(rate, '/', 1), '[^0-9.]', ''), '') IS NOT NULL
ORDER BY rating DESC
LIMIT 5;


-- Task 2: Average cost for two people for each cuisine type
-- and the 3 most expensive cuisines
SELECT
    cuisines,
    AVG(
        CAST(
            REPLACE(`approx_cost(for two people)`, ',', '')
            AS DECIMAL(10,2)
        )
    ) AS average_cost_for_two
FROM zomato
WHERE `approx_cost(for two people)` IS NOT NULL
  AND `approx_cost(for two people)` <> ''
GROUP BY cuisines
ORDER BY average_cost_for_two DESC
LIMIT 3;


-- Task 3: Restaurants offering online delivery with rating below 3.0
SELECT
    name,
    cuisines,
    location,
    rate,
    `approx_cost(for two people)` AS cost_for_two
FROM zomato
WHERE online_order = 'Yes'
  AND NULLIF(REGEXP_REPLACE(SUBSTRING_INDEX(rate, '/', 1), '[^0-9.]', ''), '') IS NOT NULL
  AND CAST(
        NULLIF(REGEXP_REPLACE(SUBSTRING_INDEX(rate, '/', 1), '[^0-9.]', ''), '')
        AS DECIMAL(3,1)
      ) < 3.0
ORDER BY location, rate;


-- Marketing strategy:
-- 1. Identify locations/cuisines with many low-rated restaurants.
-- 2. Improve delivery time, food consistency, packaging, and service.
-- 3. Encourage genuine reviews from satisfied customers.
-- 4. Use targeted offers after service-quality issues are addressed.


-- Task 4: Segment restaurants by average cost for two
-- Budget: below 400
-- Mid-range: 400 to 800
-- Premium: above 800
SELECT
    CASE
        WHEN CAST(
            REPLACE(`approx_cost(for two people)`, ',', '')
            AS DECIMAL(10,2)
        ) < 400 THEN 'Budget'
        WHEN CAST(
            REPLACE(`approx_cost(for two people)`, ',', '')
            AS DECIMAL(10,2)
        ) BETWEEN 400 AND 800 THEN 'Mid-range'
        WHEN CAST(
            REPLACE(`approx_cost(for two people)`, ',', '')
            AS DECIMAL(10,2)
        ) > 800 THEN 'Premium'
    END AS market_segment,
    COUNT(*) AS restaurant_count
FROM zomato
WHERE `approx_cost(for two people)` IS NOT NULL
  AND `approx_cost(for two people)` <> ''
GROUP BY market_segment
ORDER BY restaurant_count DESC;


-- Task 5: Top 10 most popular restaurant chains by number of outlets
SELECT
    name AS restaurant_chain,
    COUNT(*) AS outlet_count
FROM zomato
WHERE name IS NOT NULL
  AND name <> ''
GROUP BY name
ORDER BY outlet_count DESC
LIMIT 10;
