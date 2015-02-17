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