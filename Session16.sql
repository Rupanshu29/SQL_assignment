-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Import a CSV of food delivery orders into a FoodOrders table
-- This step is normally done manually in MySQL Workbench:
--   Right-click your schema -> Table Data Import Wizard -> select your CSV file
--   -> map the columns (order_id, restaurant_name, customer_name, order_amount,
--   order_date) -> let it create/load the FoodOrders table.
-- Below is the equivalent table structure and data, so this file also works
-- standalone without needing the wizard.
DROP TABLE IF EXISTS FoodOrders;

CREATE TABLE FoodOrders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    customer_name VARCHAR(100),
    order_amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO FoodOrders VALUES (1, 'Swagat', 'Amit', 450.00, '2026-09-01');
INSERT INTO FoodOrders VALUES (2, 'Mainland China', 'Priya', 620.00, '2026-09-02');
INSERT INTO FoodOrders VALUES (3, 'Swagat', 'Rahul', 300.00, '2026-09-03');
INSERT INTO FoodOrders VALUES (4, 'Pizza Bella', 'Amit', 700.00, '2026-09-04');
INSERT INTO FoodOrders VALUES (5, 'Mainland China', 'Priya', 250.00, '2026-09-05');
INSERT INTO FoodOrders VALUES (6, 'Swagat', 'Amit', 380.00, '2026-09-06');
INSERT INTO FoodOrders VALUES (7, 'Pizza Bella', 'Sneha', 550.00, '2026-09-07');
INSERT INTO FoodOrders VALUES (8, 'Mainland China', 'Rahul', 410.00, '2026-09-08');


-- Task 2: Create TopSongs table with 5 popular Spotify tracks
DROP TABLE IF EXISTS TopSongs;

CREATE TABLE TopSongs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(100),
    artist VARCHAR(100),
    streams BIGINT,
    release_date DATE
);

INSERT INTO TopSongs VALUES (1, 'Kesariya', 'Arijit Singh', 500000000, '2022-07-17');
INSERT INTO TopSongs VALUES (2, 'Blinding Lights', 'The Weeknd', 3900000000, '2019-11-29');
INSERT INTO TopSongs VALUES (3, 'Levitating', 'Dua Lipa', 1800000000, '2020-03-27');
INSERT INTO TopSongs VALUES (4, 'Excuses', 'AP Dhillon', 300000000, '2021-05-28');
INSERT INTO TopSongs VALUES (5, 'Apna Bana Le', 'Arijit Singh', 400000000, '2023-06-16');


-- Task 3: Top 3 customers by total order_amount
SELECT customer_name, SUM(order_amount) AS total_spent
FROM FoodOrders
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 3;


-- Task 4: Product performance report by restaurant
SELECT restaurant_name, COUNT(*) AS number_of_orders, SUM(order_amount) AS total_order_amount
FROM FoodOrders
GROUP BY restaurant_name
ORDER BY total_order_amount DESC;


-- Task 5: Two KPIs formatted for dashboard display (kpi_name, kpi_value)
SELECT 'Average Order Amount' AS kpi_name, AVG(order_amount) AS kpi_value
FROM FoodOrders

UNION ALL

SELECT 'Total Unique Customers' AS kpi_name, COUNT(DISTINCT customer_name) AS kpi_value
FROM FoodOrders;
