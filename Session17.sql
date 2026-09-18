-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- SESSION 17: SQL Project - HR Analysis
-- ============================================================

-- Task 1: Create Restaurant table and insert at least 5 sample rows
-- Review is dropped first since it has a foreign key pointing at Restaurant
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Restaurant;

CREATE TABLE Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(150),
    cuisine VARCHAR(100),
    location VARCHAR(100),
    average_rating DECIMAL(3,1)
);

INSERT INTO Restaurant (id, name, cuisine, location, average_rating)
VALUES
(1, 'Truffles', 'Continental', 'Koramangala', 4.5),
(2, 'Meghana Foods', 'Biryani', 'Koramangala', 4.3),
(3, 'MTR', 'South Indian', 'Lalbagh', 4.6),
(4, 'Toit', 'Italian', 'Indiranagar', 4.4),
(5, 'Empire Restaurant', 'North Indian', 'Koramangala', 4.1);


-- Task 2: Number of restaurants for each cuisine type
SELECT cuisine, COUNT(*) AS restaurant_count
FROM Restaurant
GROUP BY cuisine
ORDER BY restaurant_count DESC;


-- Task 3: Create Review table and insert at least 10 sample reviews
DROP TABLE IF EXISTS Review;

CREATE TABLE Review (
    id INT PRIMARY KEY,
    restaurant_id INT,
    user_name VARCHAR(100),
    rating DECIMAL(3,1),
    review_date DATE,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(id)
);

INSERT INTO Review (id, restaurant_id, user_name, rating, review_date)
VALUES
(1, 1, 'Amit', 4.5, '2026-01-05'),
(2, 1, 'Priya', 4.0, '2026-01-12'),
(3, 2, 'Rahul', 4.5, '2026-01-15'),
(4, 2, 'Neha', 4.0, '2026-01-20'),
(5, 3, 'Karan', 5.0, '2026-02-02'),
(6, 3, 'Riya', 4.5, '2026-02-10'),
(7, 4, 'Vishal', 4.0, '2026-02-15'),
(8, 4, 'Sneha', 4.5, '2026-02-18'),
(9, 5, 'Arjun', 3.5, '2026-02-22'),
(10, 5, 'Pooja', 4.0, '2026-02-25');


-- Task 4: Restaurant name, cuisine, and average review rating
SELECT
    r.name,
    r.cuisine,
    AVG(rv.rating) AS average_review_rating
FROM Restaurant AS r
JOIN Review AS rv
    ON r.id = rv.restaurant_id
GROUP BY r.id, r.name, r.cuisine
ORDER BY average_review_rating DESC;


-- Task 5: Rank restaurants by average review rating within each cuisine
WITH restaurant_avg AS (
    SELECT
        r.name,
        r.cuisine,
        AVG(rv.rating) AS average_rating
    FROM Restaurant AS r
    JOIN Review AS rv
        ON r.id = rv.restaurant_id
    GROUP BY r.id, r.name, r.cuisine
)
SELECT
    name,
    cuisine,
    average_rating,
    RANK() OVER (
        PARTITION BY cuisine
        ORDER BY average_rating DESC
    ) AS restaurant_rank
FROM restaurant_avg
ORDER BY cuisine, restaurant_rank;
