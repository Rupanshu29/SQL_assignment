-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Restaurants whose rating is higher than the average rating in their city
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    rating DECIMAL(2,1)
);

INSERT INTO Restaurants VALUES (1, 'Swagat', 'Ahmedabad', 4.5);
INSERT INTO Restaurants VALUES (2, 'Cafe Delight', 'Ahmedabad', 3.8);
INSERT INTO Restaurants VALUES (3, 'Mainland China', 'Surat', 4.2);
INSERT INTO Restaurants VALUES (4, 'Spice Hub', 'Surat', 3.9);

SELECT *
FROM Restaurants r1
WHERE r1.rating > (
    SELECT AVG(r2.rating)
    FROM Restaurants r2
    WHERE r2.city = r1.city
);


-- Task 2: Each user's name with their total number of orders (subquery in SELECT)
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(100)
);

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    user_id INT
);

INSERT INTO Users VALUES (1, 'amit01');
INSERT INTO Users VALUES (2, 'priya_k');

INSERT INTO Orders VALUES (1, 1);
INSERT INTO Orders VALUES (2, 1);
INSERT INTO Orders VALUES (3, 2);

SELECT u.username,
       (SELECT COUNT(*) FROM Orders o WHERE o.user_id = u.id) AS total_orders
FROM Users u;


-- Task 3: Movies with at least one 5-star review, using IN with a subquery
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Movies;

CREATE TABLE Movies (
    id INT PRIMARY KEY,
    title VARCHAR(100)
);

CREATE TABLE Reviews (
    id INT PRIMARY KEY,
    movie_id INT,
    rating INT
);

INSERT INTO Movies VALUES (1, 'RRR');
INSERT INTO Movies VALUES (2, 'Brahmastra');
INSERT INTO Movies VALUES (3, 'Jawan');

INSERT INTO Reviews VALUES (1, 1, 5);
INSERT INTO Reviews VALUES (2, 1, 4);
INSERT INTO Reviews VALUES (3, 2, 3);
INSERT INTO Reviews VALUES (4, 3, 5);

SELECT *
FROM Movies
WHERE id IN (SELECT movie_id FROM Reviews WHERE rating = 5);


-- Task 4: Sellers who have sold products in every category
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Sellers;

CREATE TABLE Sellers (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Categories (
    id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE Products (
    id INT PRIMARY KEY,
    seller_id INT,
    category_id INT
);

INSERT INTO Sellers VALUES (1, 'TechWorld');
INSERT INTO Sellers VALUES (2, 'GadgetHub');

INSERT INTO Categories VALUES (1, 'Mobiles');
INSERT INTO Categories VALUES (2, 'Laptops');

-- TechWorld has sold in both categories, GadgetHub only in Mobiles
INSERT INTO Products VALUES (1, 1, 1);
INSERT INTO Products VALUES (2, 1, 2);
INSERT INTO Products VALUES (3, 2, 1);

SELECT s.name
FROM Sellers s
WHERE NOT EXISTS (
    SELECT c.id
    FROM Categories c
    WHERE NOT EXISTS (
        SELECT 1
        FROM Products p
        WHERE p.seller_id = s.id AND p.category_id = c.id
    )
);
