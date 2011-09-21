require "test_helper"

class PlayerEffectivenessModelTest < ActiveSupport::TestCase
   def setup
      @map1_id = reach_maps(:map1).id
      @player1_id = players(:player1).id
      @player2_id = players(:player2).id
      @player3_id = players(:player3).id
      @player4_id = players(:player4).id
   end

   test "stats from map1" do
      results = PlayerEffectivenessModel.stats_for_map(@map1_id)

      assert_equal(4, results.size)

      assert_equal("Player One", results[0].player_name)
      assert_equal(4.0, results[0].average_rating)
      assert_equal(1, results[0].number_of_games)
      assert_equal("Player Three", results[1].player_name)
      assert_equal(4.0, results[1].average_rating)
      assert_equal(1, results[1].number_of_games)
      assert_equal("Player Two", results[2].player_name)
      assert_equal(3.0, results[2].average_rating)
      assert_equal(1, results[2].number_of_games)
      assert_equal("Player Four", results[3].player_name)
      assert_equal(3.0, results[3].average_rating)
      assert_equal(1, results[3].number_of_games)
   end

   test "all stats for player1" do
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player(@player1_id)
      assert_equal 1, player_effectivenesses.size
      assert_equal 4.0, player_effectivenesses[0].effectiveness
   end

   test "all stats for player2" do 
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player(@player2_id)
      assert_equal 1, player_effectivenesses.size
      assert_equal 3.0, player_effectivenesses[0].effectiveness
   end

   test "average stats for player1" do
      effectiveness = PlayerEffectivenessModel.average_stats_for_player(@player1_id)
      assert_equal 4.0, effectiveness
   end

   test "average stats for player2" do
      effectiveness = PlayerEffectivenessModel.average_stats_for_player(@player2_id)
      assert_equal 3.0, effectiveness
   end

   test "all stats for player1 on map1" do
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player1_id, @map1_id)
      assert_equal 1, player_effectivenesses.size
      assert_equal 4.0, player_effectivenesses[0].effectiveness
   end

   test "all stats for player2 on map1" do
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player2_id, @map1_id)
      assert_equal 1, player_effectivenesses.size
      assert_equal 3.0, player_effectivenesses[0].effectiveness
   end

   test "average stats for player1 on map1" do
      effectiveness = PlayerEffectivenessModel.average_stats_for_player_and_map(@player1_id, @map1_id)
      assert_equal 4.0, effectiveness
   end

   test "average stats for player2 on map2" do
      effectiveness = PlayerEffectivenessModel.average_stats_for_player_and_map(@player2_id, @map1_id)
      assert_equal 3.0, effectiveness
   end
end
