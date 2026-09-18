-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: CTE for products with a rating above 4.5
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    rating DECIMAL(2,1)
);

INSERT INTO Products VALUES (1, 'Wireless Earbuds', 4.7);
INSERT INTO Products VALUES (2, 'Phone Case', 4.1);
INSERT INTO Products VALUES (3, 'Smart Watch', 4.6);
INSERT INTO Products VALUES (4, 'Charger Cable', 3.9);

WITH TopProducts AS (
    SELECT * FROM Products WHERE rating > 4.5
)
SELECT * FROM TopProducts;


-- Task 2: Restaurants in Ahmedabad with delivery_charge under 50
-- written first as a subquery, then as a CTE
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    delivery_charge DECIMAL(6,2)
);

INSERT INTO Restaurants VALUES (1, 'Swagat', 'Ahmedabad', 30.00);
INSERT INTO Restaurants VALUES (2, 'Cafe Delight', 'Ahmedabad', 60.00);
INSERT INTO Restaurants VALUES (3, 'Mainland China', 'Surat', 40.00);

-- Subquery version (query nested inside another query)
SELECT *
FROM (
    SELECT * FROM Restaurants WHERE city = 'Ahmedabad' AND delivery_charge < 50
) AS cheap_restaurants;

-- CTE version (named up front with WITH, then used like a normal table)
WITH CheapRestaurants AS (
    SELECT * FROM Restaurants WHERE city = 'Ahmedabad' AND delivery_charge < 50
)
SELECT * FROM CheapRestaurants;

-- The CTE version is easier to read because the filtering logic is named
-- and defined once at the top, instead of being buried inside a nested
-- FROM clause. This becomes even more useful if the same filtered data
-- needs to be reused more than once in the same query.


-- Task 3: Two CTEs in one query - top 3 followed users and top 3 liked posts
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(100),
    followers_count INT
);

CREATE TABLE Posts (
    id INT PRIMARY KEY,
    user_id INT,
    caption VARCHAR(200),
    likes_count INT
);

INSERT INTO Users VALUES (1, 'riya.shares', 15000);
INSERT INTO Users VALUES (2, 'karan.travels', 22000);
INSERT INTO Users VALUES (3, 'sneha.eats', 9000);
INSERT INTO Users VALUES (4, 'vikram.fit', 30000);

INSERT INTO Posts VALUES (1, 1, 'Sunset at the beach', 500);
INSERT INTO Posts VALUES (2, 2, 'Trip to Manali', 1200);
INSERT INTO Posts VALUES (3, 3, 'Best street food in town', 800);
INSERT INTO Posts VALUES (4, 4, 'Morning workout routine', 1500);

WITH TopUsers AS (
    SELECT username, followers_count
    FROM Users
    ORDER BY followers_count DESC
    LIMIT 3
),
TopPosts AS (
    SELECT caption, likes_count
    FROM Posts
    ORDER BY likes_count DESC
    LIMIT 3
)
SELECT username AS item_name, followers_count AS item_value, 'top_user' AS item_type
FROM TopUsers
UNION ALL
SELECT caption AS item_name, likes_count AS item_value, 'top_post' AS item_type
FROM TopPosts;


-- Task 4: Recursive CTE for the next 7 days starting from today
WITH RECURSIVE NextDates AS (
    SELECT CURDATE() AS date_value
    UNION ALL
    SELECT date_value + INTERVAL 1 DAY
    FROM NextDates
    WHERE date_value < CURDATE() + INTERVAL 6 DAY
)
SELECT * FROM NextDates;


-- Task 5: Refactor a messy query to use a CTE
-- Messy version (subquery wrapped inside another filter on the same condition)
SELECT *
FROM (SELECT * FROM Users WHERE followers_count > 1000) AS sub
WHERE sub.followers_count > 1000;

-- Refactored, cleaner version using a CTE
WITH PopularUsers AS (
    SELECT * FROM Users WHERE followers_count > 1000
)
SELECT * FROM PopularUsers;
