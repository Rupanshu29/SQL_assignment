-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Influencers and Collaborations, FULL JOIN
-- MySQL does not have a FULL JOIN keyword, so it is simulated by combining
-- a LEFT JOIN and a RIGHT JOIN with UNION.
DROP TABLE IF EXISTS Collaborations;
DROP TABLE IF EXISTS Influencers;

CREATE TABLE Influencers (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Collaborations (
    id INT PRIMARY KEY,
    influencer1_id INT,
    influencer2_id INT,
    collab_date DATE
);

INSERT INTO Influencers VALUES (1, 'Riya Sharma');
INSERT INTO Influencers VALUES (2, 'Karan Mehta');
INSERT INTO Influencers VALUES (3, 'Sneha Patel');
INSERT INTO Influencers VALUES (4, 'Vikram Rao');
-- Vikram Rao has no collaborations yet

INSERT INTO Collaborations VALUES (1, 1, 2, '2026-08-01');
INSERT INTO Collaborations VALUES (2, 1, 3, '2026-08-15');

SELECT i.name AS influencer, i2.name AS partner_name
FROM Influencers i
LEFT JOIN Collaborations c ON i.id = c.influencer1_id
LEFT JOIN Influencers i2 ON c.influencer2_id = i2.id

UNION

SELECT i.name AS influencer, i2.name AS partner_name
FROM Influencers i
RIGHT JOIN Collaborations c ON i.id = c.influencer1_id
LEFT JOIN Influencers i2 ON c.influencer2_id = i2.id;


-- Task 2: SELF JOIN on Playlists to show each playlist with its parent playlist
DROP TABLE IF EXISTS Playlists;

CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    user_id INT,
    playlist_name VARCHAR(100),
    parent_playlist_id INT
);

INSERT INTO Playlists VALUES (1, 101, 'My Music', NULL);
INSERT INTO Playlists VALUES (2, 101, 'My Music - Workout', 1);
INSERT INTO Playlists VALUES (3, 101, 'My Music - Chill', 1);
INSERT INTO Playlists VALUES (4, 102, 'Party Mix', NULL);

SELECT p1.playlist_name AS playlist, p2.playlist_name AS parent_playlist
FROM Playlists p1
LEFT JOIN Playlists p2 ON p1.parent_playlist_id = p2.id;


-- Task 3: Users, Orders, Payments - show all users even without orders/payments
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(100)
);

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    user_id INT,
    order_date DATE
);

CREATE TABLE Payments (
    id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2)
);

INSERT INTO Users VALUES (1, 'amit01');
INSERT INTO Users VALUES (2, 'priya_k');
INSERT INTO Users VALUES (3, 'new_user');
-- new_user has never placed an order

INSERT INTO Orders VALUES (1, 1, '2026-09-01');
INSERT INTO Orders VALUES (2, 2, '2026-09-02');

INSERT INTO Payments VALUES (1, 1, 450.00);
-- Order 2 has no payment yet

SELECT u.username, o.order_date, pay.amount
FROM Users u
LEFT JOIN Orders o ON u.id = o.user_id
LEFT JOIN Payments pay ON o.id = pay.order_id;


-- Task 4: Fix duplicate rows in Restaurants JOIN Reviews
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Reviews (
    id INT PRIMARY KEY,
    restaurant_id INT,
    rating INT
);

INSERT INTO Restaurants VALUES (1, 'Swagat');
INSERT INTO Restaurants VALUES (2, 'Mainland China');

INSERT INTO Reviews VALUES (1, 1, 5);
INSERT INTO Reviews VALUES (2, 1, 4);
INSERT INTO Reviews VALUES (3, 1, 5);
INSERT INTO Reviews VALUES (4, 2, 3);

-- Duplicates happen because each restaurant has multiple reviews (a
-- one-to-many relationship), so the plain JOIN returns one row per review.
-- GROUP BY collapses these back down to one row per restaurant.
SELECT r.name, COUNT(rev.id) AS review_count
FROM Restaurants r
JOIN Reviews rev ON r.id = rev.restaurant_id
GROUP BY r.name;


-- Task 5: Products and Categories, two join conditions compared
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;

CREATE TABLE Categories (
    id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE Products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    category_name VARCHAR(100)
);

INSERT INTO Categories VALUES (1, 'Mobiles');
INSERT INTO Categories VALUES (2, 'Laptops');

INSERT INTO Products VALUES (1, 'iPhone 15', 1, 'Mobiles');
INSERT INTO Products VALUES (2, 'MacBook Air', 2, 'Laptops');

-- Query A: join on the id column (a numeric, indexed foreign key)
SELECT p.product_name, c.category_name
FROM Products p
JOIN Categories c ON p.category_id = c.id;

-- Query B: join on the text category_name column
SELECT p.product_name, c.category_name
FROM Products p
JOIN Categories c ON p.category_name = c.category_name;

-- Query A (joining on category_id) is more efficient, because integer
-- columns are smaller and faster to compare than text, and id columns
-- are usually indexed (especially primary/foreign keys), which makes
-- the join much quicker on large tables.
