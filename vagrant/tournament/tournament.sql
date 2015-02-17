-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE TABLE players (
	id serial PRIMARY KEY,
	name text
);

CREATE TABLE matches (
	id serial PRIMARY KEY,
	winner integer REFERENCES players(id),
	loser integer REFERENCES players(id)
);


-- Views
-- Wins view: the number of matches each player has won
CREATE VIEW matches_wins AS
SELECT players.id, players.name, count(matches.winner) AS num_wins 
FROM players LEFT JOIN matches ON players.id = matches.winner
GROUP BY players.id;

-- Losts views: the number of matches each player has lost
CREATE VIEW matches_losts AS
SELECT players.id, players.name, count(matches.loser) AS num_losts
FROM players LEFT JOIN matches ON players.id = matches.loser
GROUP BY players.id;

-- Played views: the number of matches played by each player
CREATE VIEW tournament_classification AS
SELECT players.id, players.name,
       (SELECT count(*)
        FROM matches
        WHERE matches.winner = players.id) AS num_wins,
       (SELECT count(*)
        FROM matches
        WHERE players.id IN (winner, loser)) AS num_played
FROM players
ORDER BY num_wins DESC;