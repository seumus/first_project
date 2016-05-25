require( 'pg' )
require_relative('../db/sql_runner')
require_relative('./athlete.rb')
require_relative('./nation.rb')

class Event

  attr_accessor(:id,:type,:gold_winner_id,:silver_winner_id,:bronze_winner_id)

  def initialize(params)
    @id = params['id'].to_i
    @type = params['type']
    @gold_winner_id = params['gold_winner_id'].to_i
    @silver_winner_id = params['silver_winner_id'].to_i
    @bronze_winner_id = params['bronze_winner_id'].to_i
  end

  def save()
    sql = "INSERT INTO events (type,gold_winner_id,silver_winner_id,bronze_winner_id) VALUES ('#{ @type }', #{ @gold_winner_id }, #{@silver_winner_id}, #{@bronze_winner_id}) RETURNING *"
    return Event.map_item(sql)
  end

  def athletes()
    sql = "SELECT * FROM athletes INNER JOIN athletesevents ON athletesevents.athlete_id = athlete.id WHERE event_id = #{@id};"
    return Event.map_items(sql)
  end


  def gold_athlete()
    sql = "SELECT * FROM athletes WHERE athletes.id = #{@gold_winner_id}"
    result = Athlete.map_item(sql)
    return result.name
  end



  def self.all()
    sql = "SELECT * FROM events"
    return Event.map_items(sql)
  end

  def self.map_items(sql)
    events = SqlRunner.run(sql)
    result = events.map { |event| Event.new( event ) }
    return result
  end

  def self.map_item(sql)
    result = Event.map_items(sql)
    return result.first
  end

  def self.delete_all
    sql = "DELETE FROM events"
    SqlRunner.run(sql)
  end

  def self.all_gold()
    sql = "SELECT * FROM events;"
    g = Event.map_items(sql)
    g.map {|m| m.gold_winner_id}
  end

  def self.all_silver()
    sql = "SELECT * FROM events;"
    s = Event.map_items(sql)
    s.map {|m| m.silver_winner_id}
  end

  def self.all_bronze()
    sql = "SELECT * FROM events;"
    b = Event.map_items(sql)
    b.map {|m| m.bronze_winner_id}
  end
end

def self.destroy(id)
  sql = "DELETE FROM events WHERE events.id = #{id};"
  SqlRunner.run(sql)
end
