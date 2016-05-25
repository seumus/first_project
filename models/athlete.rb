require( 'pg' )
require_relative('../db/sql_runner')
require_relative('./nation.rb')
require_relative('./event.rb')
require_relative('./flag.rb')
require('pry-byebug')

class Athlete

  attr_accessor(:id,:name,:nation_id,:picture)

  def initialize(params)
    @id = params['id'].to_i
    @name = params['name']
    @nation_id = params['nation_id'].to_i
    if params['picture'].is_a? String
        @picture = params['picture']
    else
        @picture = "images/" + params['picture'][:filename]
        File.open('public/images/'+ params['picture'][:filename], "w") do |f|
            f.write(params['picture'][:tempfile].read)
        end
    end
  end

  def save()
    sql = "INSERT INTO athletes (name,nation_id,picture) VALUES ('#{ @name }', #{ @nation_id }, '#{@picture}') RETURNING *"
    return Athlete.map_item(sql)
  end

  def self.all()
    sql = "SELECT * FROM athletes"
    return Athlete.map_items(sql)
  end

  def events()
    sql = "SELECT * FROM events INNER JOIN athletesevents ON athletesevents.event_id = event.id WHERE athlete_id = #{@id};"
    return Event.map_items(sql)
  end

  def nation()
    sql = "SELECT * FROM nations WHERE nations.id = #{@nation_id}"
    return Nation.map_item(sql).title
  end

  def self.gold_nation_ids()
    golds = Event.all_gold
    golds.map do |id|
      sql = "SELECT * FROM athletes WHERE athletes.id = #{id};"
      Athlete.map_item(sql)
    end
  end
  #
  # def gold_athletes(id)
  #   gold_athletes = Athlete.gold_nation_ids
  #   total = []
  #   binding.pry
  #   gold_athletes.map do |athlete|
  #     if athlete.id == id
  #       [] << athlete
  #     end
  #   end
  #   return total.count
  # end

  def self.silver_nation_ids()
    silvers = Event.all_silver
    silvers.map do |id|
      sql = "SELECT * FROM athletes WHERE athletes.id = #{id};"
      Athlete.map_item(sql)
    end
  end

  def self.bronze_nation_ids()
    bronze = Event.all_bronze
    bronze.map do |id|
      sql = "SELECT * FROM athletes WHERE athletes.id = #{id};"
      Athlete.map_item(sql)
    end
  end

  def self.map_items(sql)
    athletes = SqlRunner.run(sql)
    result = athletes.map { |athlete| Athlete.new( athlete ) }
    return result
  end

  def self.map_item(sql)
    result = Athlete.map_items(sql)
    return result.first
  end

  def self.delete_all
    sql = "DELETE FROM athletes"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM athletes WHERE athletes.id = #{id};"
    return Athlete.map_item(sql)
  end

  def self.update(params)
    File.open('public/images/'+ params['picture'][:filename], "w") do |f|
        f.write(params['picture'][:tempfile].read)
      end
    sql = "UPDATE athletes SET name = '#{params['name']}', nation_id = #{params['nation_id']}, picture = 'images/#{params['picture'][:filename]}' WHERE id = #{params['id']}"
    return Athlete.map_item(sql)
  end

  # def athlete_golds(id)
  #   total = 0
  #   events = Event.all
  #   events.each do |event|
  #     if event.gold_winner_id == id
  #       total += 1
  #     end
  #   end
  #   return total
  # end

  # def total_gold_per_athlete()
  #   total = 0
  #   events = Event.all
  #   events.each do |event|
  #     total += 1 if event.gold_winner_id == self.id
  #   end
  # end



  def self.destroy(id)
    sql = "DELETE FROM athletes WHERE athletes.id = #{id};"
    SqlRunner.run(sql)
  end

end
