require_relative('../db/sql_runner.rb')

class Album

  attr_reader :id, :title, :artist_id, :quantity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @artist_id = options['artist_id'].to_i
    @quantity = options['quantity']
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.list_all()
    sql = "SELECT * FROM albums"
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

  def save()
    sql = 'INSERT INTO albums (
    title,
    artist_id,
    quantity
    ) VALUES ( $1, $2, $3 )
    RETURNING *'
    values = [@title, @artist_id, @quantity]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE albums SET (
    title, artist_id, quantity) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @artist_id, @quantity, @id]
    SqlRunner.run(sql, values)
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


end
