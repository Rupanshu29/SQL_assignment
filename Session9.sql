-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Create restaurants and dishes tables with sample data
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO restaurants (id, name, city)
VALUES
(1, 'Swagat', 'Ahmedabad'),
(2, 'China Town', 'Surat'),
(3, 'Southern Spice', 'Vadodara'),
(4, 'New Café', 'Ahmedabad');   -- this restaurant will have no dishes, for Task 3

DROP TABLE IF EXISTS dishes;

CREATE TABLE dishes (
    id INT PRIMARY KEY,
    restaurant_id INT,
    dish_name VARCHAR(100),
    price DECIMAL(8,2)
);

INSERT INTO dishes (id, restaurant_id, dish_name, price)
VALUES
(1, 1, 'Dhokla', 80.00),
(2, 1, 'Thepla', 60.00),
(3, 2, 'Manchurian', 220.00),
(4, 2, 'Fried Rice', 180.00),
(5, 2, 'Noodles', 190.00),
(6, 3, 'Masala Dosa', 120.00),
(7, 3, 'Idli Sambhar', 90.00),
(8, 99, 'Mystery Dish', 150.00);   -- restaurant_id 99 doesn't exist, for Task 4


-- Task 2: INNER JOIN - each dish with its restaurant name and city
SELECT dishes.dish_name, restaurants.name AS restaurant_name, restaurants.city
FROM dishes
INNER JOIN restaurants ON dishes.restaurant_id = restaurants.id;


-- Task 3: LEFT JOIN - all restaurants, even ones with no dishes
SELECT restaurants.name AS restaurant_name, dishes.dish_name
FROM restaurants
LEFT JOIN dishes ON restaurants.id = dishes.restaurant_id;


-- Task 4: RIGHT JOIN - all dishes, even ones not linked to a valid restaurant
SELECT dishes.dish_name, restaurants.name AS restaurant_name
FROM restaurants
RIGHT JOIN dishes ON restaurants.id = dishes.restaurant_id;


-- Task 5: Showing all playlists and their songs, even empty playlists
-- I would use a LEFT JOIN with playlists as the left (first) table, so every
-- playlist shows up even if it currently has no songs in it.

DROP TABLE IF EXISTS playlists;

CREATE TABLE playlists (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO playlists (id, name)
VALUES
(1, 'Bollywood Hits'),
(2, 'Chill Vibes'),
(3, 'Workout Mix');   -- this one will have no songs

DROP TABLE IF EXISTS songs;

CREATE TABLE songs (
    id INT PRIMARY KEY,
    playlist_id INT,
    song_name VARCHAR(100)
);

INSERT INTO songs (id, playlist_id, song_name)
VALUES
(1, 1, 'Kesariya'),
(2, 1, 'Tum Hi Ho'),
(3, 2, 'Levitating');

SELECT playlists.name AS playlist_name, songs.song_name
FROM playlists
LEFT JOIN songs ON playlists.id = songs.playlist_id;