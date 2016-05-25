require( 'pg' )
require_relative('../db/sql_runner')
require_relative('event.rb')
require_relative('athlete.rb')

class AthleteEvent

  attr_accessor(:id,:athlete_id,:event_id)

  def initialize(params)
    @id = params['id'].to_i
    @athlete_id = params['athlete_id'].to_i
    @event_id = params['event_id'].to_i
  end

  def save()
    sql = "INSERT INTO athletesevents(athlete_id,event_id) VALUES (#{@athlete_id}, #{@event_id}) RETURNING *;"
    return AthleteEvent.map_item(sql)
  end

  def self.all()
    sql = "SELECT * FROM athletesevents"
    return AthleteEvent.map_items(sql)
  end

  def self.map_items(sql)
    athletes_events = SqlRunner.run(sql)
    result = athletes_events.map { |athlete_event| AthleteEvent.new( athlete_event ) }
    return result
  end

  def self.map_item(sql)
    result = AthleteEvent.map_items(sql)
    return result.first
  end

  def self.delete_all
    sql = "DELETE FROM athletesevents"
    SqlRunner.run(sql)
  end

  def self.destroy(id)
    sql = "DELETE FROM athletesevents WHERE albums.id = #{id};"
    SqlRunner.run(sql)
  end

end
