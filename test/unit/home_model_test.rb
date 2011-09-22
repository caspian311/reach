require "test_helper"

class HomeModelTest < ActiveSupport::TestCase
   test "todays_stats only pulls stats from the last day of games" do
      stats = HomeModel.todays_stats

      assert_equal 4, stats.count

      assert_equal "Player Four", stats[0].name      
      assert_equal 1, stats[0].number_of_games
      assert_equal 4, stats[0].kd_spread
      assert_equal 3.0, stats[0].effectiveness
      assert_equal 2, stats[0].number_of_medals

      assert_equal "Player One", stats[1].name      
      assert_equal 1, stats[1].number_of_games
      assert_equal 5, stats[1].kd_spread
      assert_equal 4.0, stats[1].effectiveness
      assert_equal 1, stats[1].number_of_medals

      assert_equal "Player Three", stats[2].name      
      assert_equal 1, stats[2].number_of_games
      assert_equal -3, stats[2].kd_spread
      assert_equal 4.0, stats[2].effectiveness
      assert_equal 5, stats[2].number_of_medals

      assert_equal "Player Two", stats[3].name      
      assert_equal 1, stats[3].number_of_games
      assert_equal 2, stats[3].kd_spread
      assert_equal 3.0, stats[3].effectiveness
      assert_equal 2, stats[3].number_of_medals
   end

   test "last day of stats is last day that has data recorded" do
      assert_equal Time.now.to_date, HomeModel.last_day_of_stats
   end
end
