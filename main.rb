require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/event_controller')
require_relative('controllers/athlete_controller')
require_relative('controllers/nation_controller')
require_relative('controllers/ae_controller')
require_relative('controllers/flag_controller')

get '/' do
  @nations = Nation.sorted_all
  erb :home
end
