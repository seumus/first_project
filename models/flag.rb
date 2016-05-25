require( 'pg' )
require_relative('../db/sql_runner')
require_relative('./nation.rb')
require('pry-byebug')
class Flag

  attr_accessor(:id,:flag_name,:nation_id,:gif,:still)

  def initialize(params)
    @id = params['id'].to_i
    @flag_name = params['flag_name']
    @nation_id = params['nation_id'].to_i
    if params['gif'].is_a? String
        @gif = params['gif']
    else
        @gif = "images/flags/gifs/#{params['gif'][:filename]}"
        File.open('public/images/flags/gifs/'+ params['gif'][:filename], "w") do |f|
            f.write(params['gif'][:tempfile].read)
        end
    end
    if params['still'].is_a? String
        @still = params['still']
    else
        @still = "images/flags/" + params['still'][:filename]
        File.open('public/images/flags/'+ params['still'][:filename], "w") do |f|
            f.write(params['still'][:tempfile].read)
        end
    end
  end

  def save()
    sql = "INSERT INTO flags (flag_name,nation_id,gif,still) VALUES ('#{ @flag_name }', #{ @nation_id }, '#{@gif}', '#{@still}') RETURNING *"
    return Flag.map_item(sql)
  end

  def self.all()
    sql = "SELECT * FROM flags"
    return Flag.map_items(sql)
  end

  def self.map_items(sql)
    flags = SqlRunner.run(sql)
    result = flags.map { |flag| Flag.new(flag) }
    return result
  end

  def self.map_item(sql)
    result = Flag.map_items(sql)
    return result.first
  end

  def self.delete_all
    sql = "DELETE FROM flags;"
    SqlRunner.run(sql)
  end

  def self.update(params)
    sql = "UPDATE nations SET flag_name = #{params['flag_name']}, nation_id = #{params['nation_id']}, gif = #{'gif'}, still = #{'still'} WHERE id = #{options['id']};"
    return Nation.map_item(sql)
  end

  def find_nation()
    sql = "SELECT * FROM nations WHERE nations.title = '#{@flag_name}'"
    result = Nation.map_item(sql).id
  end

  def add_nation()
    sql = "UPDATE flags SET nation_id = #{self.find_nation}"
    SqlRunner.run(sql)
  end

  def self.destroy(id)
    sql = "DELETE FROM flags WHERE flags.id = #{id};"
    SqlRunner.run(sql)
  end

end
