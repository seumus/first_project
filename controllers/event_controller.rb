require_relative('../models/event.rb')
require_relative('../models/nation.rb')

get '/events' do
  @events = Event.all
  erb(:'event/index')
end

get '/events/new' do
  @athletes = Athlete.all
  erb(:'event/new')
end

post '/events' do
  @event = Event.new(params)
  @event.save
  erb(:'event/create')
end

get '/events/:id' do
  @event = Event.find(params[:id])
  erb(:'event/show')
end

get '/events/:id/edit' do
  @event = Event.find(params[:id])
  erb(:'event/edit')
end

put '/events/:id' do
  @event = Event.update(params)
  redirect to ('/events')
end

delete '/events' do
  @event = Event.destroy(params)
  redirect to ('/events')
end
