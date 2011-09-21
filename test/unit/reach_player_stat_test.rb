require "test_helper"

class ReachPlayerStatTest < ActiveSupport::TestCase
   test "effectiveness should be calculated from the team score and the ratio of team sizes" do
      player_stat1 = reach_player_stats(:player1_game1_stat)
      player_stat2 = reach_player_stats(:player2_game1_stat)
      player_stat3 = reach_player_stats(:player3_game1_stat)
      player_stat4 = reach_player_stats(:player4_game1_stat)
      
      assert_equal 4.0, player_stat1.effectiveness
      assert_equal 3.0, player_stat2.effectiveness
      assert_equal 4.0, player_stat3.effectiveness
      assert_equal 3.0, player_stat4.effectiveness
   end
end
