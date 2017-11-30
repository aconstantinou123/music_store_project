require_relative('../db/sql_runner.rb')

class Artist

  attr_accessor :id, :name, :genre, :logo

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @genre = options['genre'].to_s
    @logo = options['logo'].to_s
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.list_all()
    sql = "SELECT * FROM artists
          ORDER BY artists.name ASC"
    artists = SqlRunner.run(sql)
    return artists.map{|artist| Artist.new(artist)}
  end

  def self.list_by_genre()
    sql = "SELECT *
          FROM artists
          ORDER BY genre ASC"
    artists = SqlRunner.run(sql)
    return artists.map{|artist| Artist.new(artist)}
  end

  def self.list_by_albums_quant()
    sql = "SELECT artists.*
          FROM albums
          INNER JOIN artists
          ON albums.artist_id = artists.id
          GROUP BY artists.id
          ORDER BY SUM(quantity) DESC"
    artists = SqlRunner.run(sql)
    return artists.map{|artist| Artist.new(artist)}
  end

  def self.find(id)
    sql = "SELECT * FROM artists
          WHERE id = $1"
    values = [id]
    artist = SqlRunner.run(sql, values).first
    return Artist.new(artist)
  end

  def check_name
    result = false
    sql = "SELECT artists.name FROM artists
          ORDER BY artists.name ASC"
    artists = SqlRunner.run(sql)
    artist_name = artists.map{|artist| artist['name']}
    artist_name.each do |artist|
        if artist == @name
          result = true
        end
      end
      return result
  end

  def save()
      if check_name == true
        return
      else
      sql = 'INSERT INTO artists (
      name, genre, logo
      ) VALUES ( $1, $2, $3 )
      RETURNING *'
      values = [@name, @genre, @logo]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end
  end


  def update()
    sql = "UPDATE artists SET (
    name, genre, logo) = ($1, $2, $3) WHERE id = $4"
    values = [@name, @genre, @logo, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def albums
    sql = "SELECT albums.*
          FROM albums
          INNER JOIN artists
          ON albums.artist_id = artists.id
          WHERE artists.id = $1
          ORDER BY albums.title ASC"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map{|album| Album.new(album)}
  end

  def self.search_artist(search)
    sql = "SELECT *
            FROM artists
            WHERE (name LIKE $1 OR name LIKE lower($1))"
    values = ["%#{search}%"]
    artists = SqlRunner.run(sql, values)
    return artists.map{|artist| Artist.new(artist)}
  end

  def select_sales_id
    sql = "SELECT sales.id
          FROM sales
          INNER JOIN albums
          ON albums.sale_id = sales.id
          INNER JOIN artists
          ON albums.artist_id = artists.id
          WHERE artists.id = $1
          LIMIT 1 OFFSET 0
          "
    values = [@id]
    id = SqlRunner.run(sql, values)[0]['id'].to_i
    return id
  end

  def self.search_genre(search)
    sql = "SELECT *
            FROM artists
            WHERE (genre LIKE $1 OR genre LIKE lower($1))"
    values = ["%#{search}%"]
    artists = SqlRunner.run(sql, values)
    return artists.map{|artist| Artist.new(artist)}
  end

end
