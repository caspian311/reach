require "test_helper"

class GameFilterTest < ActiveSupport::TestCase
   def setup
      @test_object = GameFilter.new("test_resources/game_filter_data")
   end

   test "games in db are filtered out" do
      filtered_game_ids = @test_object.filter_game_ids
      
      assert_equal [817705747], filtered_game_ids
   end
end
