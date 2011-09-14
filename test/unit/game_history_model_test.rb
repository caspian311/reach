require "test_helper"

class GameHistoryModelTest < ActiveSupport::TestCase
   def test_retreive_by_reach_id
      game1 = reach_games(:game1)
      reach_id = game1.reach_id

      actual_game = GameHistoryModel.find_by_reach_id(reach_id)

      assert_equal game1, actual_game
   end
end
