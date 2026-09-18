-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Setup tables used across this session's tasks

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO products (id, product_name, price)
VALUES
(1, 'Wireless Mouse', 599.00),
(2, 'Bluetooth Speaker', 1499.00),
(3, 'Laptop Stand', 899.00),
(4, 'USB-C Cable', 199.00),
(5, 'Mechanical Keyboard', 3499.00),
(6, 'Webcam', 2199.00);

DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
    id INT PRIMARY KEY,
    title VARCHAR(100),
    release_year INT,
    rating DECIMAL(2,1)
);

INSERT INTO movies (id, title, release_year, rating)
VALUES
(1, 'Pathaan', 2023, 4.2),
(2, 'Jawan', 2023, 4.5),
(3, 'Animal', 2023, 4.0),
(4, '12th Fail', 2023, 4.8),
(5, 'RRR', 2022, 4.7);

DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO restaurants (id, name)
VALUES
(1, 'Zaika'),
(2, 'Bawarchi'),
(3, 'Annapurna'),
(4, 'Meghana Foods'),
(5, 'Domino''s'),
(6, 'Behrouz Biryani'),
(7, 'Southern Spice'),
(8, 'China Town'),
(9, 'Cafe Coffee Day'),
(10, 'Barbeque Nation'),
(11, 'Swagat');

DROP TABLE IF EXISTS songs;

CREATE TABLE songs (
    id INT PRIMARY KEY,
    song_name VARCHAR(100),
    play_count INT,
    added_date DATE
);

INSERT INTO songs (id, song_name, play_count, added_date)
VALUES
(1, 'Kesariya', 5000, '2026-08-01'),
(2, 'Excuses', 5000, '2026-08-10'),
(3, 'Tum Hi Ho', 4800, '2026-07-15'),
(4, 'Blinding Lights', 4500, '2026-08-05');


-- Task 1: Products sorted by price ascending
SELECT *
FROM products
ORDER BY price ASC;


-- Task 2: Top 5 most expensive products
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;


-- Task 3: Movies sorted by release_year (desc), then rating (desc)
SELECT *
FROM movies
ORDER BY release_year DESC, rating DESC;


-- Task 4: First 10 restaurants sorted alphabetically
SELECT *
FROM restaurants
ORDER BY name ASC
LIMIT 10;


-- Task 5: Top 3 trending songs by play_count, ties broken by most recently added
SELECT *
FROM songs
ORDER BY play_count DESC, added_date DESC
LIMIT 3;