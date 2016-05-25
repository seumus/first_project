require( 'pg' )
require_relative('../db/sql_runner')
require_relative('./flag.rb')
require_relative('./event.rb')
require_relative('./athlete.rb')


class Nation

  attr_accessor(:id,:title,:shorthand,:total_gold,:total_silver,:total_bronze)

  def initialize(params)
    @id = params['id'].to_i
    @title = params['title']
    @shorthand = params['shorthand']
    @total_gold = params['total_gold'].to_i
    @total_silver = params['total_silver'].to_i
    @total_bronze = params['total_bronze'].to_i
  end

  def save()
    sql = "INSERT INTO nations (title,shorthand,total_gold,total_silver,total_bronze) VALUES ('#{ @title }', '#{ @shorthand }', #{@total_gold}, #{@total_silver}, #{@total_bronze}) RETURNING *"
    return Nation.map_item(sql)
  end

  def flag_gif()
    sql = "SELECT * FROM flags WHERE #{@id} = flags.nation_id;"
    return Flag.map_item(sql).gif
  end

  def flag_still()
    sql = "SELECT * FROM flags WHERE #{@id} = flags.nation_id;"
    return Flag.map_item(sql).still
  end

  # def self.update_total_gold()
  #   nations = Athlete.gold_nation_ids()
  #   nations.each do |nation|
  #     sql = "UPDATE nations SET total_gold = total_gold + 1 WHERE nations.id = #{nation};"
  #     SqlRunner.run(sql)
  #   end
  # end

  def self.update_athlete_gold(athlete)
   sql = "UPDATE nations SET total_gold = total_gold + 1 WHERE nations.id = #{athlete.nation_id};"
   SqlRunner.run(sql)
  end

  def self.update_all_gold()
   gold_winners = Athlete.gold_nation_ids()
   gold_winners.each do |athlete|
     Nation.update_athlete_gold(athlete)
   end
  end

  def self.update_athlete_silver(athlete)
   sql = "UPDATE nations SET total_silver = total_silver + 1 WHERE nations.id = #{athlete.nation_id};"
   SqlRunner.run(sql)
  end

  def self.update_all_silver()
   silver_winners = Athlete.silver_nation_ids()
   silver_winners.each do |athlete|
     Nation.update_athlete_silver(athlete)
   end
  end

  def self.update_athlete_bronze(athlete)
   sql = "UPDATE nations SET total_bronze = total_bronze + 1 WHERE nations.id = #{athlete.nation_id};"
   SqlRunner.run(sql)
  end

  def self.update_all_bronze()
   bronze_winners = Athlete.bronze_nation_ids()
   bronze_winners.each do |athlete|
     Nation.update_athlete_bronze(athlete)
   end
  end

  # def self.update_total_silver()
  #   nations = Athlete.silver_nation_ids()
  #   nations.each do |nation|
  #     sql = "UPDATE nations SET total_silver = total_silver + 1 WHERE nations.id = #{nation};"
  #     SqlRunner.run(sql)
  #   end
  # end
  #
  # def self.update_total_bronze()
  #   nations = Athlete.bronze_nation_ids()
  #   nations.each do |nation|
  #     sql = "UPDATE nations SET total_bronze = total_bronze + 1 WHERE nations.id = #{nation};"
  #     SqlRunner.run(sql)
  #   end
  # end

  def total_points()
    total = (5 * @total_gold) + (3 * @total_silver) + (1 * @total_bronze)
    return total
  end


  def self.all()
    sql = "SELECT * FROM nations"
    return Nation.map_items(sql)
  end

  def self.sorted_all()
    nations = Nation.all
    nations.sort {|x,y| y.total_points <=> x.total_points}
  end

  # def nation_sort()
  #   @nations = Nation.all
  #   @nations.map do |nation|
  #     nation.total_points
  #   end
  # end

  def self.map_items(sql)
    nations = SqlRunner.run(sql)
    result = nations.map {|nation| Nation.new(nation)}
    return result
  end

  def self.map_item(sql)
    result = Nation.map_items(sql)
    return result.first
  end

  def self.update(params)
    sql = "UPDATE nations SET title = #{params['title']}, shorthand = #{params['shorthand']}, total_gold = #{'total_gold'}, total_silver = #{'total_silver'}, total_bronze = #{'total_bronze'} WHERE id = #{options['id']}"
    return Nation.map_item(sql)
  end

  def self.delete_all
    sql = "DELETE FROM nations"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM nations WHERE nations.id = #{id};"
    return Nation.map_item(sql)
  end

  def self.destroy(id)
    sql = "DELETE FROM nations WHERE nations.id = #{id};"
    SqlRunner.run(sql)
  end


end
