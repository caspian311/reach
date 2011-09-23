require "test_helper"

class PlayerEffectivenessModelTest < ActiveSupport::TestCase
   def setup
      @map1_id = reach_maps(:map1).id
      @map2_id = reach_maps(:map2).id
      @player1_id = players(:player1).id
      @player2_id = players(:player2).id
      @player3_id = players(:player3).id
      @player4_id = players(:player4).id
   end

   test "stats from map1" do
      results = PlayerEffectivenessModel.stats_for_map(@map1_id)

      assert_equal(4, results.size)

      assert_equal("Player One", results[0].player_name)
      assert_equal(3.0, results[0].average_rating)
      assert_equal(2, results[0].number_of_games)
      assert_equal("Player Two", results[1].player_name)
      assert_equal(3.0, results[1].average_rating)
      assert_equal(2, results[1].number_of_games)
      assert_equal("Player Three", results[2].player_name)
      assert_equal(3.0, results[2].average_rating)
      assert_equal(2, results[2].number_of_games)
      assert_equal("Player Four", results[3].player_name)
      assert_equal(3.0, results[3].average_rating)
      assert_equal(2, results[3].number_of_games)
   end

   test "stats from map2" do
      results = PlayerEffectivenessModel.stats_for_map(@map2_id)

      assert_equal 3, results.size

      assert_equal("Player One", results[0].player_name)
      assert_equal(4.0, results[0].average_rating)
      assert_equal(1, results[0].number_of_games)
      assert_equal("Player Two", results[1].player_name)
      assert_equal(4.0, results[1].average_rating)
      assert_equal(1, results[1].number_of_games)
      assert_equal("Player Three", results[2].player_name)
      assert_equal(1.0, results[2].average_rating)
      assert_equal(1, results[2].number_of_games)
   end

   test "all stats for player1" do
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player(@player1_id)
      assert_equal 3, player_effectivenesses.size
      assert_in_delta 4.0, player_effectivenesses[0].effectiveness, 0.01
      assert_in_delta 2.0, player_effectivenesses[1].effectiveness, 0.01
      assert_in_delta 4.0, player_effectivenesses[2].effectiveness, 0.01
   end

   test "all stats for player2" do 
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player(@player2_id)
      assert_equal 3, player_effectivenesses.size
      assert_in_delta 3.0, player_effectivenesses[0].effectiveness, 0.01
      assert_in_delta 3.0, player_effectivenesses[1].effectiveness, 0.01
      assert_in_delta 4.0, player_effectivenesses[2].effectiveness, 0.01
   end

   test "all stats for player3" do 
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player(@player3_id)
      assert_equal 3, player_effectivenesses.size
      assert_in_delta 4.0, player_effectivenesses[0].effectiveness, 0.01
      assert_in_delta 2.0, player_effectivenesses[1].effectiveness, 0.01
      assert_in_delta 1.0, player_effectivenesses[2].effectiveness, 0.01
   end

   test "all stats for player4" do 
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player(@player4_id)
      assert_equal 2, player_effectivenesses.size
      assert_in_delta 3.0, player_effectivenesses[0].effectiveness, 0.01
      assert_in_delta 3.0, player_effectivenesses[1].effectiveness, 0.01
   end

   test "average stats for player1" do
      effectiveness = PlayerEffectivenessModel.average_stats_for_player(@player1_id)
      assert_in_delta 3.33, effectiveness, 0.01
   end

   test "average stats for player2" do
      effectiveness = PlayerEffectivenessModel.average_stats_for_player(@player2_id)
      assert_in_delta 3.33, effectiveness, 0.01
   end

   test "average stats for player3" do
      effectiveness = PlayerEffectivenessModel.average_stats_for_player(@player3_id)
      assert_in_delta 2.33, effectiveness, 0.01
   end

   test "average stats for player4" do
      effectiveness = PlayerEffectivenessModel.average_stats_for_player(@player4_id)
      assert_in_delta 3.0, effectiveness, 0.01
   end

   test "all stats for player1 on map1" do
      effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player1_id, @map1_id)
      assert_equal 2, effectivenesses.size
      assert_equal 4.0, effectivenesses[0].effectiveness
      assert_equal 2.0, effectivenesses[1].effectiveness
   end

   test "all stats for player1 on map2" do
      effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player1_id, @map2_id)
      assert_equal 1, effectivenesses.size
      assert_equal 4.0, effectivenesses[0].effectiveness
   end

   test "all stats for player2 on map1" do
      effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player2_id, @map1_id)
      assert_equal 2, effectivenesses.size
      assert_equal 3.0, effectivenesses[0].effectiveness
      assert_equal 3.0, effectivenesses[1].effectiveness
   end

   test "all stats for player3 on map1" do
      effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player3_id, @map1_id)
      assert_equal 2, effectivenesses.size
      assert_equal 4.0, effectivenesses[0].effectiveness
      assert_equal 2.0, effectivenesses[1].effectiveness
   end

   test "all stats for player3 on map2" do
      effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player3_id, @map2_id)
      assert_equal 1, effectivenesses.size
      assert_equal 1.0, effectivenesses[0].effectiveness
   end

   test "all stats for player4 on map1" do
      effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player4_id, @map1_id)
      assert_equal 2, effectivenesses.size
      assert_equal 3.0, effectivenesses[0].effectiveness
      assert_equal 3.0, effectivenesses[1].effectiveness
   end

   test "all stats for player4 on map2" do
      effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player4_id, @map2_id)
      assert_equal 0, effectivenesses.size
   end

   test "all stats for player2 on map2" do
      effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player2_id, @map2_id)
      assert_equal 1, effectivenesses.size
      assert_equal 4.0, effectivenesses[0].effectiveness
   end

   test "average stats for player1 on map1" do
      effectiveness = PlayerEffectivenessModel.average_stats_for_player_and_map(@player1_id, @map1_id)
      assert_equal 3.0, effectiveness
   end

   test "average stats for player2 on map2" do
      effectiveness = PlayerEffectivenessModel.average_stats_for_player_and_map(@player2_id, @map1_id)
      assert_equal 3.0, effectiveness
   end
end
