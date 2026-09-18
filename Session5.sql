-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Create Restaurants table and insert 5 sample records
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    rating DECIMAL(2,1),
    city VARCHAR(50)
);

INSERT INTO Restaurants (id, name, cuisine, rating, city)
VALUES
(1, 'Swagat', 'Gujarati', 4.5, 'Ahmedabad'),
(2, 'Swadisht', 'North Indian', 4.2, 'Surat'),
(3, 'Domino''s', 'Italian', 3.8, 'Vadodara'),
(4, 'China Town', 'Chinese', 4.1, 'Surat'),
(5, 'Southern Spice', 'South Indian', 4.6, 'Ahmedabad');


-- Task 2: Rating greater than 4.0, in Ahmedabad or Surat
SELECT *
FROM Restaurants
WHERE rating > 4.0 AND city IN ('Ahmedabad', 'Surat');


-- Task 3: Names starting with 'Swa'
SELECT *
FROM Restaurants
WHERE name LIKE 'Swa%';


-- Task 4: Rating between 3.5 and 4.5 (inclusive)
SELECT *
FROM Restaurants
WHERE rating BETWEEN 3.5 AND 4.5;


-- Task 5: Cuisine is Chinese, Italian, or South Indian
SELECT *
FROM Restaurants
WHERE cuisine IN ('Chinese', 'Italian', 'South Indian');