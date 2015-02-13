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
	player1 integer REFERENCES players(id),
	player2 integer REFERENCES players(id)
);

CREATE TABLE wins (
	match integer REFERENCES matches(id),
	winner integer REFERENCES players(id),
	PRIMARY KEY (match, winner)
);
