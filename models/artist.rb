require_relative('../db/sql_runner.rb')

class Artist

  attr_accessor :id, :name, :logo

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
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
      name, logo
      ) VALUES ( $1, $2 )
      RETURNING *'
      values = [@name, @logo]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end
  end


  def update()
    sql = "UPDATE artists SET (
    name, logo) = ($1, $2) WHERE id = $3"
    values = [@name, @logo, @id]
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

end
