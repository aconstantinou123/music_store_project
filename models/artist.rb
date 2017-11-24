require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def save()
    sql = 'INSERT INTO artists (
    name
    ) VALUES ( $1 )
    RETURNING *'
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

end
