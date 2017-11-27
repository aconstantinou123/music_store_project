DROP TABLE albums;
DROP TABLE sales;
DROP TABLE artists;

CREATE TABLE artists (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
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
  sell_price FLOAT,
  artist_id INT4 REFERENCES artists(id) ON DELETE CASCADE,
  quantity INT4,
  sale_id INT4 REFERENCES sales(id) ON DELETE CASCADE
);
