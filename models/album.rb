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


end
