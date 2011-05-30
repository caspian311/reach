require "test_helper"

require "player_effectiveness_processor"

class PlayerEffectivenessProcessorTest < Test::Unit::TestCase
   def setup
      @test_object = PlayerEffectivenessProcessor.new
      
      Player.delete_all
      ReachPlayerStat.delete_all
      ReachTeam.delete_all
      ReachGame.delete_all
      PlayerEffectiveness.delete_all
   end

   def test_player_effectiveness_is_stored_in_db
      map_name = random_string

      map = Map.new
      map.name = map_name
      map.save

      game = ReachGame.new
      game.map = map
      game.save

      team1 = ReachTeam.new
      team1.score = 15
      game.reach_teams << team1

      team2 = ReachTeam.new
      team2.score = 10
      game.reach_teams << team2

      player1 = Player.new
      player1.service_tag = "player1"
      player1.save

      player2 = Player.new
      player2.service_tag = "player2"
      player2.save

      player3 = Player.new
      player3.service_tag = "player3"
      player3.save

      player_stat1 = ReachPlayerStat.new
      player_stat1.player = player1
      team1.reach_player_stats << player_stat1

      player_stat2 = ReachPlayerStat.new
      player_stat2.player = player2
      team2.reach_player_stats << player_stat2

      player_stat3 = ReachPlayerStat.new
      player_stat3.player = player3
      team1.reach_player_stats << player_stat3

      @test_object.process_game(game)

      assert_equal 3, PlayerEffectiveness.all.count

      player1_effectiveness = PlayerEffectiveness.find_by_service_tag("player1").first
      assert_not_nil player1_effectiveness
      assert_equal map_name, player1_effectiveness.map.name
      assert_equal 15, player1_effectiveness.team_score
      assert_equal 2, player1_effectiveness.team_size
      assert_equal 10, player1_effectiveness.other_team_score
      assert_equal 1, player1_effectiveness.other_team_size

      player2_effectiveness = PlayerEffectiveness.find_by_service_tag("player2").first
      assert_equal map_name, player2_effectiveness.map.name
      assert_equal 10, player2_effectiveness.team_score
      assert_equal 1, player2_effectiveness.team_size
      assert_equal 15, player2_effectiveness.other_team_score
      assert_equal 2, player2_effectiveness.other_team_size

      player3_effectiveness = PlayerEffectiveness.find_by_service_tag("player3").first
      assert_equal map_name, player3_effectiveness.map.name
      assert_equal 15, player3_effectiveness.team_score
      assert_equal 2, player3_effectiveness.team_size
      assert_equal 10, player3_effectiveness.other_team_score
      assert_equal 1, player3_effectiveness.other_team_size
   end
end