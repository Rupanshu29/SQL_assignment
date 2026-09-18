-- Make sure a database is selected before creating any tables
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Task 1: Create the Playlist table and insert one favorite song
DROP TABLE IF EXISTS Playlist;

CREATE TABLE Playlist (
    id INT PRIMARY KEY,
    song_name VARCHAR(100),
    artist VARCHAR(100),
    duration INT
);

INSERT INTO Playlist (id, song_name, artist, duration)
VALUES (1, 'Kesariya', 'Arjit Singh', 268);


-- Task 2: Insert 3 more songs
INSERT INTO Playlist (id, song_name, artist, duration)
VALUES (2, 'Excuses', 'AP Dhillon', 176);

INSERT INTO Playlist (id, song_name, artist, duration)
VALUES (3, 'Tera Hone Laga Hoon', 'Atif Aslam', 300);

INSERT INTO Playlist (id, song_name, artist, duration)
VALUES (4, 'Brown Munde', 'AP Dhillon', 202);


-- Task 3: Fix artist name typo (Arjit Singh -> Arijit Singh)
UPDATE Playlist
SET artist = 'Arijit Singh'
WHERE id = 1;


-- Task 4: Delete a song with duration less than 120 seconds
DELETE FROM Playlist
WHERE duration < 120;


-- Task 5: Add '(Remix)' to song_name for AP Dhillon songs longer than 180 seconds
UPDATE Playlist
SET song_name = CONCAT(song_name, ' (Remix)')
WHERE artist = 'AP Dhillon' AND duration > 180;
