-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


-- Create database called tournament, then connect to that database
create database tournament;
	\c tournament;

-- Create a table of players using
-- Id (tpye serial) and name (type text)

	create table players (
		id serial primary key,
		name text
		);


-- Create table of matches with winner and losers
-- Winner and Loser reference serial from players

	create table matches (
		winner serial references players,
		loser serial references players
		);


-- Create a view for number of matches for players
-- Order in descending order
-- Counts the winner/loser column using a join

	create view num_matches AS
		select players.id, players.name, count(winner) AS num_matches 
		from players 
			left join matches on players.id = winner OR players.id = loser 
			group by players.id
			order by num_matches desc;

-- Create a view for number of wins for players
-- Order in descending order by wins
-- Counts the winner column using a join to get player ID

	create view num_wins AS
		select players.id as id, players.name, count(winner) AS num_wins
		from players 
			left join matches on players.id = winner 
			group by players.id
			order by num_wins desc;

-- Create a view for player standings
-- Order in descending order by wins then matches
-- Combines num_wins and num_matches

	create view player_standings AS
		select num_matches.id, num_matches.name, num_wins.num_wins, num_matches.num_matches 
		from num_matches, num_wins 
		where num_wins.id = num_matches.id 
		order by num_wins desc, num_matches desc


	

