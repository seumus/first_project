require 'pry-byebug'
require_relative('models/athlete.rb')
require_relative('models/event.rb')
require_relative('models/nation.rb')
require_relative('models/athletesevents.rb')
require_relative('models/flag.rb')


Nation.delete_all()
Athlete.delete_all()
Event.delete_all()
AthleteEvent.delete_all()
Flag.delete_all()


nation1 = Nation.new('title' => 'Scotland', 'shorthand' => 'Sco', 'total_gold' => 0, 'total_silver' => 0, 'total_bronze' => 0)
nation2 = Nation.new('title' => 'France', 'shorthand' => 'Fra', 'total_gold' => 0, 'total_silver' => 0, 'total_bronze' => 0)
nation3 = Nation.new('title' => 'Germany', 'shorthand' => 'Ger', 'total_gold' => 0, 'total_silver' => 0, 'total_bronze' => 0)
nation4 = Nation.new('title' => 'Japan', 'shorthand' => 'Jpn', 'total_gold' => 0, 'total_silver' => 0, 'total_bronze' => 0)
nation5 = Nation.new('title' => 'China', 'shorthand' => 'Chn', 'total_gold' => 0, 'total_silver' => 0, 'total_bronze' => 0)
nation6 = Nation.new('title' => 'America', 'shorthand' => 'USA', 'total_gold' => 0, 'total_silver' => 0, 'total_bronze' => 0)
n1 = nation1.save()
n2 = nation2.save()
n3 = nation3.save()
n4 = nation4.save()
n5 = nation5.save()
n6 = nation6.save()

athlete1 = Athlete.new('name' => 'Seumus Blair', 'nation_id' => n1.id, 'picture' => 'images/websiteprofile.jpg')
athlete2 = Athlete.new('name' => 'Scott Blair', 'nation_id' => n1.id, 'picture' => 'images/profile.jpg')
athlete3 = Athlete.new('name' => 'Alistair', 'nation_id' => n6.id, 'picture' => 'images/profile.jpg')
athlete4 = Athlete.new('name' => 'Jean', 'nation_id' => n2.id, 'picture' => 'images/profile.jpg')
a1 = athlete1.save()
a2 = athlete2.save()
a3 = athlete3.save()
a4 = athlete4.save()

event1 = Event.new('type' => 'Gymnastics', 'gold_winner_id' => a1.id, 'silver_winner_id' => a2.id, 'bronze_winner_id' => a3.id)
event2 = Event.new('type' => 'Tennis', 'gold_winner_id' => a1.id, 'silver_winner_id' => a2.id, 'bronze_winner_id' => a3.id)
event3 = Event.new('type' => 'Wrestling', 'gold_winner_id' => a3.id, 'silver_winner_id' => a2.id, 'bronze_winner_id' => a1.id)
event4 = Event.new('type' => 'Boxing', 'gold_winner_id' => a4.id, 'silver_winner_id' => a2.id, 'bronze_winner_id' => a3.id)
e1 = event1.save()
e2 = event2.save()
e3 = event3.save()
e4 = event4.save()

athleteevent1 = AthleteEvent.new('athlete_id' => a1.id, 'event_id' => e1.id)
athleteevent2 = AthleteEvent.new('athlete_id' => a2.id, 'event_id' => e2.id)
athleteevent3 = AthleteEvent.new('athlete_id' => a1.id, 'event_id' => e2.id)
athleteevent4 = AthleteEvent.new('athlete_id' => a1.id, 'event_id' => e3.id)
athleteevent5 = AthleteEvent.new('athlete_id' => a2.id, 'event_id' => e1.id)
athleteevent6 = AthleteEvent.new('athlete_id' => a3.id, 'event_id' => e1.id)
athleteevent7 = AthleteEvent.new('athlete_id' => a3.id, 'event_id' => e2.id)
athleteevent8 = AthleteEvent.new('athlete_id' => a3.id, 'event_id' => e3.id)
athleteevent9 = AthleteEvent.new('athlete_id' => a2.id, 'event_id' => e3.id)
athleteevent10 = AthleteEvent.new('athlete_id' => a4.id, 'event_id' => e4.id)
athleteevent11 = AthleteEvent.new('athlete_id' => a2.id, 'event_id' => e4.id)
athleteevent12 = AthleteEvent.new('athlete_id' => a3.id, 'event_id' => e4.id)
ae2 = athleteevent2.save()
ae1 = athleteevent1.save()
ae3 = athleteevent3.save()
ae4 = athleteevent4.save()
ae5 = athleteevent5.save()
ae6 = athleteevent6.save()
ae7 = athleteevent7.save()
ae8 = athleteevent8.save()
ae9 = athleteevent9.save()
ae10 = athleteevent10.save()
ae11 = athleteevent11.save()
ae12 = athleteevent12.save()



flag1 = Flag.new('flag_name' => 'Scotland', 'nation_id' => n1.id, 'gif' => 'images/flags/gifs/Scotland.gif', 'still' => 'images/flags/Flag_Scotland.png')
flag2 = Flag.new('flag_name' => 'France', 'nation_id' => n2.id, 'gif' => 'images/flags/gifs/France.gif', 'still' => 'images/flags/Flag_France.png')
flag3 = Flag.new('flag_name' => 'Germany', 'nation_id' => n3.id, 'gif' => 'images/flags/gifs/Germany.gif', 'still' => 'images/flags/Flag_Germany.png')
flag4 = Flag.new('flag_name' => 'Japan', 'nation_id' => n4.id, 'gif' => 'images/flags/gifs/Japan.gif', 'still' => 'images/flags/Flag_Japan.png')
flag5 = Flag.new('flag_name' => 'China', 'nation_id' => n5.id, 'gif' => 'images/flags/gifs/China.gif', 'still' => 'images/flags/Flag_China.png')
flag6 = Flag.new('flag_name' => 'USA', 'nation_id' => n6.id, 'gif' => 'images/flags/gifs/USA.gif', 'still' => 'images/flags/Flag_USA.png')
f1 = flag1.save()
f2 = flag2.save()
f3 = flag3.save()
f4 = flag4.save()
f5 = flag5.save()
f6 = flag6.save()

Nation.update_all_gold()
Nation.update_all_silver()
Nation.update_all_bronze()
# binding.pry
# nil
