require('pry')
require_relative('../db/sql_runner.rb')
require_relative('album.rb')


class Album

  attr_accessor :id, :title, :artist_id, :sale_id, :buy_price, :mark_up, :quantity

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @artist_id = options['artist_id'].to_i
    @sale_id = options['sale_id'].to_i
    @buy_price = options['buy_price'].to_f
    @mark_up = options['mark_up'].to_f
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
    buy_price,
    mark_up,
    quantity
    ) VALUES ( $1, $2, $3, $4, $5, $6 )
    RETURNING *'
    values = [@title, @artist_id, @sale_id, @buy_price, @mark_up, @quantity]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end
  end

  def update()
    sql = "UPDATE albums SET (
    title, artist_id, sale_id, buy_price, mark_up, quantity) = ($1, $2, $3, $4, $5, $6) WHERE id = $7"
    values = [@title, @artist_id, @sale_id, @buy_price, @mark_up, @quantity, @id]
    SqlRunner.run(sql, values)
  end

  def adjust_sell_price(sale)
    @mark_up = @mark_up + 10
    @mark_up = ((@mark_up * sale.percent)/ 100).round(2)
    update()
    return @mark_up
  end

  def adjust_price
    sql = "SELECT sales.percent
          FROM sales
          INNER JOIN albums
          ON albums.sale_id = sales.id
          WHERE albums.id = $1"
    values = [@id]
    percent = SqlRunner.run(sql, values).first['percent'].to_f
    @mark_up = (((10 + @buy_price) * percent) / 100).round(2)
    update()
    return @mark_up
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

  def mark_up_percent
    sql = "SELECT sales.percent
          FROM sales
          INNER JOIN albums
          ON albums.sale_id = sales.id
          WHERE albums.id = $1"
    values = [@id]
    price = adjust_price
    percent = SqlRunner.run(sql, values).first['percent'].to_f
    return "#{percent.round}%"
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
