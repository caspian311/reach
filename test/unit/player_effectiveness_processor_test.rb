require "test_helper"

require "player_effectiveness_processor"

class PlayerEffectivenessProcessorTest < Test::Unit::TestCase
   def setup
      @test_object = PlayerEffectivenessProcessor.new
      
      Player.delete_all
      ReachMap.delete_all
      ReachPlayerStat.delete_all
      ReachTeam.delete_all
      ReachGame.delete_all
      PlayerEffectiveness.delete_all
   end

   def test_player_effectiveness_is_stored_in_db
      map_name = random_string

      map = ReachMap.new
      map.name = map_name
      map.save

      game = ReachGame.new
      game.reach_map = map
      game.reach_id = "123456789"
      game.save

      team1 = ReachTeam.new
      team1.team_id = 1
      team1.score = 3
      game.reach_teams << team1

      team2 = ReachTeam.new
      team2.team_id = 2
      team2.score = 2
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
      assert_equal map_name, player1_effectiveness.reach_game.reach_map.name
      assert_equal 2, player1_effectiveness.effectiveness_rating

      player2_effectiveness = PlayerEffectiveness.find_by_service_tag("player2").first
      assert_equal map_name, player2_effectiveness.reach_game.reach_map.name
      assert_equal 6, player2_effectiveness.effectiveness_rating

      player3_effectiveness = PlayerEffectiveness.find_by_service_tag("player3").first
      assert_equal map_name, player3_effectiveness.reach_game.reach_map.name
      assert_equal 2, player3_effectiveness.effectiveness_rating
   end

   def test_player_effectiveness_for_0_to_0_game_with_uneven_numbers
      map_name = random_string

      map = ReachMap.new
      map.name = map_name
      map.save

      game = ReachGame.new
      game.reach_map = map
      game.reach_id = "123456789"
      game.save

      team1 = ReachTeam.new
      team1.team_id = 1
      team1.score = 0
      game.reach_teams << team1

      team2 = ReachTeam.new
      team2.team_id = 2
      team2.score = 0
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

      player4 = Player.new
      player4.service_tag = "player4"
      player4.save

      player5 = Player.new
      player5.service_tag = "player5"
      player5.save

      player_stat1 = ReachPlayerStat.new
      player_stat1.player = player1
      team1.reach_player_stats << player_stat1

      player_stat2 = ReachPlayerStat.new
      player_stat2.player = player2
      team1.reach_player_stats << player_stat2

      player_stat3 = ReachPlayerStat.new
      player_stat3.player = player3
      team2.reach_player_stats << player_stat3

      player_stat4 = ReachPlayerStat.new
      player_stat4.player = player4
      team2.reach_player_stats << player_stat4

      player_stat5 = ReachPlayerStat.new
      player_stat5.player = player5
      team2.reach_player_stats << player_stat5

      @test_object.process_game(game)

      assert_equal 5, PlayerEffectiveness.all.count

      player1_effectiveness = PlayerEffectiveness.find_by_service_tag("player1").first
      assert_equal map_name, player1_effectiveness.reach_game.reach_map.name
      assert_equal 1.5, player1_effectiveness.effectiveness_rating

      player2_effectiveness = PlayerEffectiveness.find_by_service_tag("player2").first
      assert_equal map_name, player2_effectiveness.reach_game.reach_map.name
      assert_equal 1.5, player2_effectiveness.effectiveness_rating

      player3_effectiveness = PlayerEffectiveness.find_by_service_tag("player3").first
      assert_equal map_name, player3_effectiveness.reach_game.reach_map.name
      assert_equal (2.to_f/3), player3_effectiveness.effectiveness_rating

      player4_effectiveness = PlayerEffectiveness.find_by_service_tag("player4").first
      assert_equal map_name, player4_effectiveness.reach_game.reach_map.name
      assert_equal (2.to_f/3), player4_effectiveness.effectiveness_rating

      player5_effectiveness = PlayerEffectiveness.find_by_service_tag("player5").first
      assert_equal map_name, player5_effectiveness.reach_game.reach_map.name
      assert_equal (2.to_f/3), player5_effectiveness.effectiveness_rating
   end

   def test_player_effectiveness_is_same_as_score_if_teams_are_event
      map_name = random_string

      map = ReachMap.new
      map.name = map_name
      map.save

      game = ReachGame.new
      game.reach_map = map
      game.reach_id = "123456789"
      game.save

      team1 = ReachTeam.new
      team1.team_id = 1
      team1.score = 1
      game.reach_teams << team1

      team2 = ReachTeam.new
      team2.team_id = 2
      team2.score = 2
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

      player4 = Player.new
      player4.service_tag = "player4"
      player4.save

      player_stat1 = ReachPlayerStat.new
      player_stat1.player = player1
      team1.reach_player_stats << player_stat1

      player_stat2 = ReachPlayerStat.new
      player_stat2.player = player2
      team1.reach_player_stats << player_stat2

      player_stat3 = ReachPlayerStat.new
      player_stat3.player = player3
      team2.reach_player_stats << player_stat3

      player_stat4 = ReachPlayerStat.new
      player_stat4.player = player4
      team2.reach_player_stats << player_stat4

      @test_object.process_game(game)

      assert_equal 4, PlayerEffectiveness.all.count

      player1_effectiveness = PlayerEffectiveness.find_by_service_tag("player1").first
      assert_equal map_name, player1_effectiveness.reach_game.reach_map.name
      assert_equal 2, player1_effectiveness.effectiveness_rating

      player2_effectiveness = PlayerEffectiveness.find_by_service_tag("player2").first
      assert_equal map_name, player2_effectiveness.reach_game.reach_map.name
      assert_equal 2, player2_effectiveness.effectiveness_rating

      player3_effectiveness = PlayerEffectiveness.find_by_service_tag("player3").first
      assert_equal map_name, player3_effectiveness.reach_game.reach_map.name
      assert_equal 3, player3_effectiveness.effectiveness_rating

      player4_effectiveness = PlayerEffectiveness.find_by_service_tag("player4").first
      assert_equal map_name, player4_effectiveness.reach_game.reach_map.name
      assert_equal 3, player4_effectiveness.effectiveness_rating
   end

   def test_dont_record_games_with_really_high_scores
      game = ReachGame.new
      game.save

      team1 = ReachTeam.new
      team1.team_id = 1
      team1.score = 15
      game.reach_teams << team1

      team2 = ReachTeam.new
      team2.team_id = 2
      team2.score = 10
      game.reach_teams << team2

      @test_object.process_game(game)

      assert PlayerEffectiveness.all.empty?
   end
end
