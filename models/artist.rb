require_relative('../db/sql_runner.rb')

class Artist

  attr_accessor :id, :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
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

  def self.find(id)
    sql = "SELECT * FROM artists
          WHERE id = $1"
    values = [id]
    artist = SqlRunner.run(sql, values).first
    return Artist.new(artist)
  end

  def save()
    sql = 'INSERT INTO artists (
    name
    ) VALUES ( $1 )
    RETURNING *'
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE artists SET (
    name) = ($1) WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def albums
    sql = "SELECT *
          FROM albums
          INNER JOIN artists
          ON albums.artist_id = artists.id
          WHERE artists.id = $1
          ORDER BY albums.title ASC"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map{|album| Album.new(album)}
  end



end
