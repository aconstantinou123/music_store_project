require_relative('../db/sql_runner.rb')
require_relative('album.rb')


class Album

  attr_reader :id, :title, :artist_id, :sale_id, :sell_price, :quantity

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @artist_id = options['artist_id'].to_i
    @sale_id = options['sale_id'].to_i
    @sell_price = options['sell_price'].to_f
    @quantity = options['quantity'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.list_all()
    sql = "SELECT * FROM albums
          ORDER BY albums.title ASC"
    albums = SqlRunner.run(sql)
    return albums.map{|artist| Album.new(artist)}
  end

  def self.find(id)
    sql = "SELECT * FROM albums
          WHERE id = $1"
    values = [id]
    album = SqlRunner.run(sql, values).first
    return Album.new(album)
  end

  def self.total_stock
    sql = "SELECT SUM(quantity)
          FROM albums"
    total = SqlRunner.run(sql)[0]["sum"].to_i
    return total
  end

  def self.albums_per_artist(id)
    sql = "SELECT SUM(quantity)
          FROM albums
          WHERE albums.artist_id = $1"
    values = [id]
    total = SqlRunner.run(sql, values)[0]['sum'].to_i
    return total
  end

  def check_name
    result = false
    sql = "SELECT albums.title FROM albums
          ORDER BY albums.title ASC"
    albums = SqlRunner.run(sql)
    album_name = albums.map{|album| album['title']}
    album_name.each do |album|
        if album == @title
          result = true
        end
      end
      return result
  end

  def save()
    if check_name == true
      return
    else
    sql = 'INSERT INTO albums (
    title,
    artist_id,
    sale_id,
    sell_price,
    quantity
    ) VALUES ( $1, $2, $3, $4, $5 )
    RETURNING *'
    values = [@title, @artist_id, @sale_id, @sell_price, @quantity]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end
  end

  def update()
    sql = "UPDATE albums SET (
    title, artist_id, sale_id, sell_price, quantity) = ($1, $2, $3, $4, $5) WHERE id = $6"
    values = [@title, @artist_id, @sale_id, @sell_price, @quantity, @id]
    SqlRunner.run(sql, values)
  end

  def buy_price
    sql = "SELECT sales.percent
          FROM sales
          INNER JOIN albums
          ON albums.sale_id = sales.id
          WHERE albums.sale_id = $1
          LIMIT 1 OFFSET 0"
    values = [@artist_id]
    percent = SqlRunner.run(sql, values)[0]['percent'].to_f
    buy_price = 3 + (@sell_price * percent)
    return buy_price.round(2)
  end

  def delete()
    sql = "DELETE FROM albums
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def artist
    sql = "SELECT *
          FROM artists
          INNER JOIN albums
          ON albums.artist_id = artists.id
          WHERE albums.id = $1"
    values = [@id]
    artist = SqlRunner.run(sql, values).first
    return Artist.new(artist)
  end

  def stock_level
    if @quantity == 0
      return 'Out of Stock'
  elsif @quantity >= 10
      return 'High'
    elsif @quantity >= 5
      return 'Medium'
    elsif @quantity < 5
      return 'Low'
    end
  end

  def mark_up
    result = buy_price / @sell_price
    return "#{(result * 100).to_i}%"
  end

  def self.search_album(search)
    sql = "SELECT *
            FROM albums
            WHERE (title LIKE $1 OR title LIKE lower($1))"
    values = ["%#{search}%"]
    albums = SqlRunner.run(sql, values)
    return albums.map{|album| Album.new(album)}
  end


end
