require_relative('../db/sql_runner')

class Sale

  attr_reader :id, :percent

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @percent = options['percent'].to_f
  end

  def self.delete_all()
    sql = "DELETE FROM sales"
    SqlRunner.run(sql)
  end

  def save()
    sql = 'INSERT INTO sales (
    percent
    ) VALUES ( $1 )
    RETURNING *'
    values = [@percent]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end


end
