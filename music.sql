-- from the terminal run:
-- psql < music.sql

-- DROP DATABASE IF EXISTS music;

-- CREATE DATABASE music;

-- \c music

-- CREATE TABLE songs
-- (
--   id SERIAL PRIMARY KEY,
--   title TEXT NOT NULL,
--   duration_in_seconds INTEGER NOT NULL,
--   release_date DATE NOT NULL,
--   artists TEXT[] NOT NULL,
--   album TEXT NOT NULL,
--   producers TEXT[] NOT NULL
-- );

-- INSERT INTO songs
--   (title, duration_in_seconds, release_date, artists, album, producers)
-- VALUES
--   ('MMMBop', 238, '04-15-1997', '{"Hanson"}', 'Middle of Nowhere', '{"Dust Brothers", "Stephen Lironi"}'),
--   ('Bohemian Rhapsody', 355, '10-31-1975', '{"Queen"}', 'A Night at the Opera', '{"Roy Thomas Baker"}'),
--   ('One Sweet Day', 282, '11-14-1995', '{"Mariah Cary", "Boyz II Men"}', 'Daydream', '{"Walter Afanasieff"}'),
--   ('Shallow', 216, '09-27-2018', '{"Lady Gaga", "Bradley Cooper"}', 'A Star Is Born', '{"Benjamin Rice"}'),
--   ('How You Remind Me', 223, '08-21-2001', '{"Nickelback"}', 'Silver Side Up', '{"Rick Parashar"}'),
--   ('New York State of Mind', 276, '10-20-2009', '{"Jay Z", "Alicia Keys"}', 'The Blueprint 3', '{"Al Shux"}'),
--   ('Dark Horse', 215, '12-17-2013', '{"Katy Perry", "Juicy J"}', 'Prism', '{"Max Martin", "Cirkut"}'),
--   ('Moves Like Jagger', 201, '06-21-2011', '{"Maroon 5", "Christina Aguilera"}', 'Hands All Over', '{"Shellback", "Benny Blanco"}'),
--   ('Complicated', 244, '05-14-2002', '{"Avril Lavigne"}', 'Let Go', '{"The Matrix"}'),
--   ('Say My Name', 240, '11-07-1999', '{"Destiny''s Child"}', 'The Writing''s on the Wall', '{"Darkchild"}');

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE artists
(
id SERIAL PRIMARY KEY,
name TEXT NOT NULL,
nationality TEXT NOT NULL
);

CREATE TABLE albums
(
id SERIAL PRIMARY KEY,
title TEXT NOT NULL,
release_date DATE NOT NULL,
genre TEXT NOT NULL,
artist_id INTEGER NOT NULL REFERENCES artists(id)
);

CREATE TABLE producers
(
id SERIAL PRIMARY KEY,
name TEXT NOT NULL
);

CREATE TABLE songs
(
id SERIAL PRIMARY KEY,
title TEXT NOT NULL,
duration_in_seconds INTEGER NOT NULL,
release_date DATE NOT NULL,
album_id INTEGER NOT NULL REFERENCES albums(id),
artist_id INTEGER NOT NULL REFERENCES artists(id),
producer_id INTEGER NOT NULL REFERENCES producers(id)
);

INSERT INTO artists (name, nationality) VALUES
('Hanson', 'American'),
('Queen', 'British'),
('Mariah Carey', 'American'),
('Lady Gaga', 'American'),
('Nickelback', 'Canadian'),
('Jay-Z', 'American'),
('Katy Perry', 'American'),
('Maroon 5', 'American'),
('Avril Lavigne', 'Canadian'),
('Destiny''s Child', 'American');

INSERT INTO albums (title, release_date, genre, artist_id) VALUES
('Middle of Nowhere', '1997-05-06', 'Pop', 1),
('A Night at the Opera', '1975-11-21', 'Rock', 2),
('Daydream', '1995-10-03', 'Pop', 3),
('A Star Is Born', '2018-10-05', 'Pop', 4),
('Silver Side Up', '2001-09-11', 'Rock', 5),
('The Blueprint 3', '2009-09-08', 'Hip-Hop', 6),
('Prism', '2013-10-18', 'Pop', 7),
('Hands All Over', '2010-09-15', 'Rock', 8),
('Let Go', '2002-06-04', 'Pop', 9),
('The Writing''s on the Wall', '1999-07-27', 'R&B', 10);

INSERT INTO producers (name) VALUES
('Dust Brothers'),
('Stephen Lironi'),
('Roy Thomas Baker'),
('Walter Afanasieff'),
('Benjamin Rice'),
('Rick Parashar'),
('Al Shux'),
('Max Martin'),
('Cirkut'),
('Shellback'),
('Benny Blanco'),
('The Matrix'),
('Darkchild'),
('Juicy J'),
('Christina Aguilera');

INSERT INTO songs (title, duration_in_seconds, release_date, album_id, artist_id, producer_id) VALUES
('MMMBop', 238, '1997-04-15', 1, 1, 1),
('Bohemian Rhapsody', 355, '1975-10-31', 2, 2, 3),
('One Sweet Day', 282, '1995-11-14', 3, 3, 4),
('Shallow', 216, '2018-09-27', 4, 4, 5),
('How You Remind Me', 223, '2001-08-21', 5, 5, 6),
('New York State of Mind', 276, '2009-10-20', 6, 6, 7),
('Dark Horse', 215, '2013-12-17', 7, 7, 8), 
('Moves Like Jagger', 201, '2011-06-21', 8, 8, 8),
('Complicated', 244, '2002-05-14', 9, 9, 9),
('Say My Name', 240, '1999-11-07', 10, 10, 10);

-- Retrieve all artists and their respective nationalities:

SELECT name, nationality FROM artists;

-- Retrieve all albums and their corresponding genres, sorted by release date in ascending order:

SELECT title, genre, release_date FROM albums ORDER BY release_date ASC;

-- Retrieve all songs and their durations in seconds, along with their corresponding album titles and release dates:

SELECT songs.title, songs.duration_in_seconds, albums.title, albums.release_date 
FROM songs 
INNER JOIN albums ON songs.album_id = albums.id;

-- Retrieve all producers and their associated songs, sorted by producer name:

SELECT producers.name, songs.title 
FROM producers 
INNER JOIN songs ON producers.id = songs.producer_id 
ORDER BY producers.name;

-- Retrieve all songs and their corresponding artists and album titles, sorted by artist name:

SELECT songs.title, artists.name AS artist, albums.title AS album 
FROM songs 
INNER JOIN artists ON songs.artist_id = artists.id 
INNER JOIN albums ON songs.album_id = albums.id 
ORDER BY artists.name;

-- Retrieve all songs from the "Pop" genre, along with their corresponding artist and album names:

SELECT songs.title, artists.name AS artist, albums.title AS album 
FROM songs 
INNER JOIN artists ON songs.artist_id = artists.id 
INNER JOIN albums ON songs.album_id = albums.id 
WHERE albums.genre = 'Pop';