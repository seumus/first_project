require_relative('../models/flag.rb')
require_relative('../models/nation.rb')

get '/flags' do
  @flags = Flag.all
  erb(:'flag/index')
end

get '/flags/new' do
  @nations = Nation.all
  erb(:'flag/new')
end

post '/flags' do
  @flag = Flag.new(params)
  @flag.save
  erb(:'flag/create')
end

get '/flags/:id' do
  @flag = Flag.find(params[:id])
  erb(:'nation/show')
end

get '/flags/:id/edit' do
  @flag = Flag.find(params[:id])
  erb(:'flag/edit')
end

put '/flags/:id' do
  @flag = Flag.update(params)
  redirect to ('/flags')
end

delete '/flags' do
  @flag = Flag.destroy(params)
  redirect to ('/flags')
end
