require('minitest/autorun')
require_relative('../models/athlete.rb')
require_relative('../models/event.rb')
require_relative('../models/nation.rb')
require_relative('../models/athletesevents.rb')


class TestAthlete < Minitest::Test

  def setup

    Nation.delete_all()
    Event.delete_all()
    AthleteEvent.delete_all()
    Athlete.delete_all()

    nation1 = Nation.new('title' => 'England', 'shorthand' => 'Eng', 'total_gold' => 0, 'total_silver' => 0, 'total_bronze' => 0)
    @n1 = nation1.save()
    athlete1 = Athlete.new('name' => 'Scott Blair', 'nation_id' => @n1.id, 'picture' => 'images/websiteprofile.gif')
    @a1 = athlete1.save()
    event1 = Event.new('type' => 'tennis', 'gold_winner_id' => @a1.id, 'silver_winner_id' => @a1.id, 'bronze_winner_id' => @a1.id)
    @e1 = event1.save()
    athleteevent1 = AthleteEvent.new('athlete_id' => @a1.id, 'event_id' => @e1.id)
    @ae1 = athleteevent1.save()
  end

  def test_athlete_nation()
    assert_equal('England', @a1.nation)
  end




end
