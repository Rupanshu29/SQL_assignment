-- Task 1: Create the database
CREATE DATABASE IF NOT EXISTS music_streaming_app;

-- Task 1b: Select the database so the tables below get created inside it
USE music_streaming_app;

-- Task 2: Create the playlists table
DROP TABLE IF EXISTS playlists;

CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(100),
    created_by VARCHAR(100)
);

-- Task 3: Insert three sample rows
INSERT INTO playlists (playlist_id, name, created_by)
VALUES (1, 'Bollywood Hits', 'Amit');

INSERT INTO playlists (playlist_id, name, created_by)
VALUES (2, 'Chill Vibes', 'Priya');

INSERT INTO playlists (playlist_id, name, created_by)
VALUES (3, 'Workout Mix', 'Rahul');

-- Task 4: Select all playlists created by 'Amit'
SELECT * FROM playlists
WHERE created_by = 'Amit';

-- Task 5: Table vs row vs column (Zomato example)
-- A table is like the whole spreadsheet of data, for example a
-- 'restaurants' table on Zomato that stores every restaurant.
-- A row is one single record in that table, for example one row
-- could be the details for 'Pizza Hut, Vadodara, rating 4.2'.
-- A column is one specific piece of information stored for every row,
-- for example restaurant_name, city, and rating are columns, and
-- every restaurant's row has a value for each of them.
