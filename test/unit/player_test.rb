require "test_helper"

class PlayerTest < Test::Unit::TestCase
   def setup
      Player.delete_all
      ServiceTag.delete_all

      @player1_real_name = random_string
      @player1_service_tag1 = random_string
      @player1_service_tag2 = random_string

      @player2_real_name = random_string
      @player2_service_tag1 = random_string
      @player2_service_tag2 = random_string

      player1 = Player.new
      player1.real_name = @player1_real_name
      player1.save

      @player1_id = player1.id

      service_tag1 = ServiceTag.new
      service_tag1.tag = @player1_service_tag1

      service_tag2 = ServiceTag.new
      service_tag2.tag = @player1_service_tag2

      player1.service_tags << service_tag1
      player1.service_tags << service_tag2

      player2 = Player.new
      player2.real_name = @player2_real_name
      player2.save

      @player2_id = player2.id

      service_tag3 = ServiceTag.new
      service_tag3.tag = @player2_service_tag1

      service_tag4 = ServiceTag.new
      service_tag4.tag = @player2_service_tag2

      player2.service_tags << service_tag3
      player2.service_tags << service_tag4
   end

   def test_finding_players_by_service_tag
      assert_equal @player1_real_name, Player.find_by_service_tag(@player1_service_tag1).real_name
      assert_equal @player1_real_name, Player.find_by_service_tag(@player1_service_tag2).real_name
      assert_equal @player2_real_name, Player.find_by_service_tag(@player2_service_tag1).real_name
      assert_equal @player2_real_name, Player.find_by_service_tag(@player2_service_tag2).real_name
   end

   def test_uses_tag
      assert Player.find_by_id(@player1_id).uses_tag?(@player1_service_tag1)
      assert Player.find_by_id(@player1_id).uses_tag?(@player1_service_tag2)
      assert Player.find_by_id(@player2_id).uses_tag?(@player2_service_tag1)
      assert Player.find_by_id(@player2_id).uses_tag?(@player2_service_tag2)
   end

   def test_last_game
      player = Player.new
      player.save
      player_id = player.id

      game1_stats = ReachPlayerStat.new
      game1_stats.player = player 

      game1 = ReachGame.new
      game1.game_time = Time.now.advance(:days => -5)
      game1.save

      team1 = ReachTeam.new
      game1.reach_teams << team1

      team1.reach_player_stats << game1_stats

      game2_stats = ReachPlayerStat.new
      game2_stats.player = player 

      game2 = ReachGame.new
      game2.game_time = Time.now.advance(:days => -1)
      game2.save

      team2 = ReachTeam.new
      game2.reach_teams << team2

      team2.reach_player_stats << game2_stats

      game3_stats = ReachPlayerStat.new
      game3_stats.player = player 

      game3 = ReachGame.new
      game3.game_time = Time.now.advance(:days => -3)
      game3.save

      team3 = ReachTeam.new
      game3.reach_teams << team3

      team3.reach_player_stats << game3_stats

      player_from_db = Player.find(player_id)
      last_game = player_from_db.last_game

      assert_equal game2.id, last_game.id
   end
end
