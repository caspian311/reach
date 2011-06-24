require "test_helper"

class ReachGameTest < Test::Unit::TestCase
   def setup
      ReachGame.delete_all
   end

   def test_retreive_by_reach_id
      reach_id = random_string
      now = Time.now

      game = ReachGame.new
      game.reach_id = reach_id
      game.game_time = now
      game.save

      actual_game = ReachGame.find_by_reach_id(reach_id)

      assert_equal now.to_i, actual_game.game_time.to_i
   end
end
