-- SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE nations CASCADE;
DROP TABLE athletes CASCADE;
DROP TABLE flags CASCADE;
DROP TABLE events CASCADE;
DROP TABLE athletesevents;


CREATE TABLE nations(
  id SERIAL4 primary key,
  title VARCHAR(255),
  shorthand VARCHAR(255),
  total_gold INT4,
  total_silver INT4,
  total_bronze INT4
);

CREATE TABLE athletes(
  id SERIAL4 primary key,
  name VARCHAR(255),
  nation_id INT4 references nations(id) ON DELETE CASCADE,
  picture VARCHAR(255)
);

CREATE TABLE flags(
  id SERIAL4 primary key,
  flag_name VARCHAR(255),
  nation_id INT4 references nations(id) ON DELETE CASCADE,
  gif VARCHAR(255),
  still VARCHAR(255)
);

CREATE TABLE events(
  id SERIAL4 primary key,
  type VARCHAR(255),
  gold_winner_id INT4 references athletes(id) ON DELETE CASCADE,
  silver_winner_id INT4 references athletes(id) ON DELETE CASCADE,
  bronze_winner_id INT4 references athletes(id) ON DELETE CASCADE,
  CHECK (gold_winner_id <> silver_winner_id),
  CHECK (gold_winner_id <> bronze_winner_id),
  CHECK (bronze_winner_id <> silver_winner_id)
);

CREATE TABLE athletesevents(
  id SERIAL4 primary key,
  athlete_id INT4 references athletes(id) ON DELETE CASCADE,
  event_id INT4 references events(id) ON DELETE CASCADE
);
