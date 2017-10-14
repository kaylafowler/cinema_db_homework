require_relative('../db/sql_runner.rb')

class Film

attr_reader(:id, :title)
attr_accessor(:price)

  def initialize(options)
    #  id, title price
    @id = options['id'].to_i()
    @title = options['title']
    @price = options['price'].to_i()
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES ($1, $2)
    RETURNING *"
    values = [@title, @price]
    film = SqlRunner.run(sql, values)
    @id = film[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql,values)
    result = films.map{|film| Film.new(film)}
    return result
  end

  def update()
    sql = "UPDATE films
    SET (
      title,
      price
    ) =
    ($1, $2)
    WHERE id = $3
    "
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end



end
