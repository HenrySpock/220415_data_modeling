-- Drop the database if it exists
DROP DATABASE IF EXISTS leaguedb;
-- Create the database
CREATE DATABASE leaguedb;
-- Connect to the database
\c leaguedb;

-- Create the teams table
DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

-- Insert some sample teams
INSERT INTO teams (name) VALUES
  ('Team A'),
  ('Team B'),
  ('Team C'),
  ('Team D');

-- Create the players table
DROP TABLE IF EXISTS players;
CREATE TABLE players (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  team_id INTEGER,
  FOREIGN KEY (team_id) REFERENCES teams (id)
);

-- Insert some sample players
INSERT INTO players (name, team_id) VALUES
  ('Player 1', 1),
  ('Player 2', 2),
  ('Player 3', 3),
  ('Player 4', 4);

-- Create the matches table
DROP TABLE IF EXISTS matches;
CREATE TABLE matches (
  id SERIAL PRIMARY KEY,
  team1_id INTEGER,
  team2_id INTEGER,
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (team1_id) REFERENCES teams (id),
  FOREIGN KEY (team2_id) REFERENCES teams (id)
);

-- Insert some sample matches
INSERT INTO matches (team1_id, team2_id, start_date, end_date) VALUES
  (1, 2, '2022-01-01', '2022-01-02'),
  (3, 4, '2022-01-03', '2022-01-04'),
  (1, 3, '2022-01-05', '2022-01-06'),
  (2, 4, '2022-01-07', '2022-01-08');

-- Create the referees table
DROP TABLE IF EXISTS referees;
CREATE TABLE referees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

-- Insert some sample referees
INSERT INTO referees (name) VALUES
  ('Referee 1'),
  ('Referee 2'),
  ('Referee 3'),
  ('Referee 4');

-- Create the games table
DROP TABLE IF EXISTS games;
CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  match_id INTEGER,
  player_id INTEGER,
  team_id INTEGER,
  goals_scored INTEGER,
  FOREIGN KEY (match_id) REFERENCES matches (id),
  FOREIGN KEY (player_id) REFERENCES players (id),
  FOREIGN KEY (team_id) REFERENCES teams (id)
);

-- Insert some sample games
INSERT INTO games (match_id, player_id, team_id, goals_scored) VALUES
  (1, 1, 1, 2),
  (1, 2, 2, 3),
  (2, 3, 3, 1),
  (2, 4, 4, 1),
  (3, 1, 1, 1),
  (3, 3, 3, 1),
  (4, 2, 2, 2),
  (4, 4, 4, 2);
 
-- Sample queries:
-- Get a list of all teams in the league:

-- sql
-- Copy code
-- SELECT * FROM teams;

-- Get a list of all players in the league and their corresponding teams:
 
-- SELECT players.*, teams.name AS team_name
-- FROM players
-- JOIN teams ON players.team_id = teams.id;

-- Get a list of all matches played in the league:
 
-- SELECT * FROM matches;

-- Get a list of all referees who have been part of a game:
 
-- SELECT referees.*, matches.start_date, matches.end_date
-- FROM referees
-- JOIN games ON referees.id = games.id
-- JOIN matches ON games.match_id = matches.id;

-- Get a list of all games played by a specific team, including the goals scored by each player:
 
-- SELECT games.*, players.name AS player_name, players.team_id AS player_team_id
-- FROM games
-- JOIN players ON games.player_id = players.id
-- WHERE games.team_id = 1;

-- Get a list of all games played by a specific player, including the team they played for and the goals they scored:
 
-- SELECT games.*, teams.name AS team_name
-- FROM games
-- JOIN teams ON games.team_id = teams.id
-- WHERE games.player_id = 1;

-- Get a list of all games played between two specific teams:
 
-- SELECT *
-- FROM matches
-- WHERE (team1_id = 1 AND team2_id = 2) OR (team1_id = 2 AND team2_id = 1);

 