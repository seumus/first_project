require_relative('../models/athlete.rb')
require_relative('../models/nation.rb')
require('pry-byebug')

get '/athletes' do
  @athletes = Athlete.all
  erb(:'athlete/index')
end

get '/athletes/new' do
  @nations = Nation.all
  erb(:'athlete/new')
end

post '/athletes' do
  @athlete = Athlete.new(params)
  # binding.pry
  @athlete.save
  erb(:'athlete/create')
end

get '/athletes/:id' do
  @athlete = Athlete.find(params[:id])
  erb(:'athlete/show')
end

get '/athletes/:id/edit' do
  @nations = Nation.all
  @athlete = Athlete.find(params[:id])
  erb(:'athlete/edit')
end

put '/athletes/:id' do
  @athlete = Athlete.update(params)
  redirect to ('/athletes')
end

delete '/athletes/:id' do
  @athlete = Athlete.destroy(params[:id])
  redirect '/athletes'
end
