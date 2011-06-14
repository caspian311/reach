require 'test_helper'

class PlayerEffectivenessModelTest < Test::Unit::TestCase
   def setup
      Player.delete_all
      ReachMap.delete_all
      ReachPlayerStat.delete_all
      ReachTeam.delete_all
      ReachGame.delete_all
      PlayerEffectiveness.delete_all

      map1 = ReachMap.new
      map1.save

      @map1_id = map1.id

      map2 = ReachMap.new
      map2.save

      @map2_id = map2.id

      map3 = ReachMap.new
      map3.save

      @map3_id = map3.id

      game1 = ReachGame.new
      game1.reach_map = map1
      game1.save

      game2 = ReachGame.new
      game2.reach_map = map2
      game2.save

      game3 = ReachGame.new
      game3.reach_map = map1
      game3.save

      game4 = ReachGame.new
      game4.reach_map = map3
      game4.save

      player1 = Player.new
      player1.save

      @player1_id = player1.id

      player2 = Player.new
      player2.save

      @player2_id = player2.id

      player1a_effectiveness = PlayerEffectiveness.new
      player1a_effectiveness.reach_game = game1
      player1a_effectiveness.player = player1
      player1a_effectiveness.effectiveness_rating = 3
      player1a_effectiveness.save

      player1b_effectiveness = PlayerEffectiveness.new
      player1b_effectiveness.reach_game = game2
      player1b_effectiveness.player = player1
      player1b_effectiveness.effectiveness_rating = 1
      player1b_effectiveness.save

      player1c_effectiveness = PlayerEffectiveness.new
      player1c_effectiveness.reach_game = game3
      player1c_effectiveness.player = player1
      player1c_effectiveness.effectiveness_rating = 2
      player1c_effectiveness.save

      player2a_effectiveness = PlayerEffectiveness.new
      player2a_effectiveness.reach_game = game1
      player2a_effectiveness.player = player2
      player2a_effectiveness.effectiveness_rating = 2
      player2a_effectiveness.save

      player2b_effectiveness = PlayerEffectiveness.new
      player2b_effectiveness.reach_game = game2
      player2b_effectiveness.player = player2
      player2b_effectiveness.effectiveness_rating = 3
      player2b_effectiveness.save

      player2c_effectiveness = PlayerEffectiveness.new
      player2c_effectiveness.reach_game = game3
      player2c_effectiveness.player = player2
      player2c_effectiveness.effectiveness_rating = 2
      player2c_effectiveness.save

      player1d_effectiveness = PlayerEffectiveness.new
      player1d_effectiveness.reach_game = game4
      player1d_effectiveness.player = player1
      player1d_effectiveness.effectiveness_rating = 5
      player1d_effectiveness.save
   end

   def test_stats_from_map1
      player_effectivenesses = PlayerEffectivenessModel.stats_for_map(@map1_id)

      assert_equal 2, player_effectivenesses.size

      assert_equal (5.to_f/2), effectiveness_by_name(player_effectivenesses, @player1_id).average_rating
      assert_equal 2, effectiveness_by_name(player_effectivenesses, @player1_id).number_of_games
      assert_equal 2, effectiveness_by_name(player_effectivenesses, @player2_id).average_rating
      assert_equal 2, effectiveness_by_name(player_effectivenesses, @player2_id).number_of_games
   end

   def test_stats_from_map2
      player_effectivenesses = PlayerEffectivenessModel.stats_for_map(@map2_id)

      assert_equal 2, player_effectivenesses.size

      assert_equal 1, effectiveness_by_name(player_effectivenesses, @player1_id).average_rating
      assert_equal 1, effectiveness_by_name(player_effectivenesses, @player1_id).number_of_games
      assert_equal 3, effectiveness_by_name(player_effectivenesses, @player2_id).average_rating
      assert_equal 1, effectiveness_by_name(player_effectivenesses, @player2_id).number_of_games
   end

   def test_stats_from_map3
      player_effectivenesses = PlayerEffectivenessModel.stats_for_map(@map3_id)

      assert_equal 1, player_effectivenesses.size

      assert_equal 5, effectiveness_by_name(player_effectivenesses, @player1_id).average_rating
      assert_equal 1, effectiveness_by_name(player_effectivenesses, @player1_id).number_of_games
   end

   def test_all_stats_for_player1
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player(@player1_id)
      assert_equal 4, player_effectivenesses.size
      assert_equal 3, player_effectivenesses[0].effectiveness_rating
      assert_equal 1, player_effectivenesses[1].effectiveness_rating
      assert_equal 2, player_effectivenesses[2].effectiveness_rating
      assert_equal 5, player_effectivenesses[3].effectiveness_rating
   end

   def test_all_stats_for_player2
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player(@player2_id)
      assert_equal 3, player_effectivenesses.size
      assert_equal 2, player_effectivenesses[0].effectiveness_rating
      assert_equal 3, player_effectivenesses[1].effectiveness_rating
      assert_equal 2, player_effectivenesses[2].effectiveness_rating
   end

   def test_average_stats_for_player1
      effectiveness = PlayerEffectivenessModel.average_stats_for_player(@player1_id)
      assert_equal (11.to_f/4), effectiveness
   end

   def test_average_stats_for_player2
      effectiveness = PlayerEffectivenessModel.average_stats_for_player(@player2_id)
      assert_equal (7.to_f/3), effectiveness
   end

   def test_all_stats_for_player1_on_map1
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player1_id, @map1_id)
      assert_equal 2, player_effectivenesses.size
      assert_equal 3, player_effectivenesses[0].effectiveness_rating
      assert_equal 2, player_effectivenesses[1].effectiveness_rating
   end

   def test_all_stats_for_player2_on_map2
      player_effectivenesses = PlayerEffectivenessModel.all_stats_for_player_and_map(@player2_id, @map2_id)
      assert_equal 1, player_effectivenesses.size
      assert_equal 3, player_effectivenesses[0].effectiveness_rating
   end

   def test_average_stats_for_player1_on_map1
      effectivenesses = PlayerEffectivenessModel.average_stats_for_player_and_map(@player1_id, @map1_id)
      assert_equal (5.to_f/2), effectivenesses
   end

   def test_average_stats_for_player2_on_map2
      effectivenesses = PlayerEffectivenessModel.average_stats_for_player_and_map(@player2_id, @map1_id)
      assert_equal 2, effectivenesses
   end
   private
   def effectiveness_by_name(player_effectivenesses, player_id)
      target = nil
      player_effectivenesses.each do |player_effectiveness|
         if player_effectiveness.player_id == player_id
            target = player_effectiveness
            break
         end
      end
      target
   end
end
