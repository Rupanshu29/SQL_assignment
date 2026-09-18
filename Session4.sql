-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Create MusicPlaylist table, insert 5 songs, select everything
DROP TABLE IF EXISTS MusicPlaylist;

CREATE TABLE MusicPlaylist (
    id INT PRIMARY KEY,
    song_name VARCHAR(100),
    artist VARCHAR(100),
    genre VARCHAR(50),
    duration INT
);

INSERT INTO MusicPlaylist (id, song_name, artist, genre, duration)
VALUES
(1, 'Kesariya', 'Arijit Singh', 'Bollywood', 268),
(2, 'Excuses', 'AP Dhillon', 'Punjabi', 176),
(3, 'Tum Hi Ho', 'Arijit Singh', 'Bollywood', 262),
(4, 'Blinding Lights', 'The Weeknd', 'Pop', 200),
(5, 'Levitating', 'Dua Lipa', 'Pop', 203);

SELECT * FROM MusicPlaylist;


-- Task 2: Show song_name and artist for the first 3 records
SELECT song_name, artist
FROM MusicPlaylist
LIMIT 3;


-- Task 3: FoodOrders table and unique restaurant names
DROP TABLE IF EXISTS FoodOrders;

CREATE TABLE FoodOrders (
    id INT PRIMARY KEY,
    restaurant VARCHAR(100),
    food_item VARCHAR(100),
    order_date DATE
);

INSERT INTO FoodOrders (id, restaurant, food_item, order_date)
VALUES
(1, 'Domino''s', 'Pizza', '2026-09-01'),
(2, 'Domino''s', 'Garlic Bread', '2026-09-02'),
(3, 'McDonald''s', 'Burger', '2026-09-03'),
(4, 'Behrouz Biryani', 'Chicken Biryani', '2026-09-04'),
(5, 'McDonald''s', 'Fries', '2026-09-05');

SELECT DISTINCT restaurant
FROM FoodOrders;


-- Task 4: Column aliases
SELECT food_item AS Dish, order_date AS 'Date Ordered'
FROM FoodOrders;


-- Task 5: Fix the mistake in the query
-- Broken version (LIMIT placed in the wrong position, before FROM):
-- SELECT DISTINCT food_item, restaurant LIMIT 2 FROM FoodOrders;

-- Corrected version (LIMIT must come after FROM, at the end of the query):
SELECT DISTINCT food_item, restaurant
FROM FoodOrders
LIMIT 2;