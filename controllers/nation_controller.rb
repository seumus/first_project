require_relative('../models/nation.rb')
require_relative('../models/athlete.rb')
require_relative('../models/event.rb')
require('pry-byebug')

get '/nations' do
  @nations = Nation.all
  erb(:'nation/index')
end

get '/nations/new' do
  erb(:'nation/new')
end

post '/nations' do
  @nation = Nation.new(params)
  @nation.save
  erb(:'nation/create')
end

get '/nations/:id' do
  @athletes = Athlete.all
  @nation = Nation.find(params[:id])
  erb(:'nation/show')
end

get '/nations/:id/edit' do
  @nation = Nation.find(params[:id])
  erb(:'nation/edit')
end

put '/nations/:id' do
  @nation = Nation.update(params)
  redirect to ('/nations')
end

delete '/nations' do
  @nation = Nation.destroy(params)
  redirect to ('/nations')
end
