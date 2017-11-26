DROP TABLE albums;
DROP TABLE artists;

CREATE TABLE artists (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  logo TEXT
);

CREATE TABLE albums (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  buy_price FLOAT,
  sell_price FLOAT,
  artist_id INT4 REFERENCES artists(id) ON DELETE CASCADE,
  quantity INT4
);
