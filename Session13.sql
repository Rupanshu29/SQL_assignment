-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Create Playlists table, insert 8 rows, some sharing the same user_id
DROP TABLE IF EXISTS Playlists;

CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    user_id INT,
    playlist_name VARCHAR(100),
    total_likes INT
);

INSERT INTO Playlists VALUES (1, 101, 'Bollywood Hits', 500);
INSERT INTO Playlists VALUES (2, 101, 'Workout Mix', 800);
INSERT INTO Playlists VALUES (3, 101, 'Chill Vibes', 300);
INSERT INTO Playlists VALUES (4, 102, 'Party Anthems', 950);
INSERT INTO Playlists VALUES (5, 102, 'Road Trip Songs', 400);
INSERT INTO Playlists VALUES (6, 103, 'Study Focus', 600);
INSERT INTO Playlists VALUES (7, 103, 'Late Night Vibes', 750);
INSERT INTO Playlists VALUES (8, 104, 'Throwback Hits', 200);


-- Task 2: ROW_NUMBER() ordered by total_likes descending
SELECT *,
       ROW_NUMBER() OVER (ORDER BY total_likes DESC) AS row_num
FROM Playlists;


-- Task 3: RANK() to rank all playlists by total_likes
SELECT playlist_name, user_id, total_likes,
       RANK() OVER (ORDER BY total_likes DESC) AS rank_num
FROM Playlists;


-- Task 4: DENSE_RANK() with PARTITION BY user_id
SELECT playlist_name, user_id, total_likes,
       DENSE_RANK() OVER (PARTITION BY user_id ORDER BY total_likes DESC) AS dense_rank_num
FROM Playlists;


-- Task 5: Top 2 playlists per user based on total_likes
WITH RankedPlaylists AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY total_likes DESC) AS rn
    FROM Playlists
)
SELECT *
FROM RankedPlaylists
WHERE rn <= 2;
