DROP TABLE albums;
DROP TABLE sales;
DROP TABLE artists;

CREATE TABLE artists (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  genre VARCHAR(255),
  logo TEXT
);

CREATE TABLE sales (
  id SERIAL4 PRIMARY KEY,
  percent FLOAT
);

CREATE TABLE albums (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  buy_price FLOAT,
  mark_up FLOAT,
  artist_id INT4 REFERENCES artists(id) ON DELETE CASCADE,
  sale_id INT4 REFERENCES sales(id) ON DELETE CASCADE,
  quantity INT4
);
