require "test_helper"

class KillDeathSpreadModelTest < Test::Unit::TestCase
   def setup
      ReachPlayerStat.delete_all
      ReachTeam.delete_all      
      ReachGame.delete_all
   end

   def test_kill_death_spread
      reach_id = random_string

      player1_service_tag = ServiceTag.new
      player1_service_tag.tag = "player1"

      player1 = Player.new
      player1.service_tags <<  player1_service_tag
      player1.save

      player2_service_tag = ServiceTag.new
      player2_service_tag.tag = "player2"

      player2 = Player.new
      player2.service_tags << player2_service_tag
      player2.save

      game = ReachGame.new
      game.reach_id = reach_id
      game.save

      team1 = ReachTeam.new
      game.reach_teams << team1

      team2 = ReachTeam.new
      game.reach_teams << team2

      player1_stat = ReachPlayerStat.new
      player1_stat.player = player1
      player1_stat.kills = 6
      player1_stat.deaths = 8
      team1.reach_player_stats << player1_stat

      player2_stat = ReachPlayerStat.new
      player2_stat.player = player2
      player2_stat.kills = 10
      player2_stat.deaths = 4
      team2.reach_player_stats << player2_stat

      stats = KillDeathSpreadModel.average_stats

      assert_equal 2, stats.size

      player1_spread = find_stat_by_service_tag(stats, "player1")
      assert_equal 6, player1_spread.average_kills
      assert_equal 8, player1_spread.average_deaths
      assert_equal -2, player1_spread.average_spread
      assert_equal 1, player1_spread.number_of_games

      player2_spread = find_stat_by_service_tag(stats, "player2")
      assert_equal 10, player2_spread.average_kills
      assert_equal 4, player2_spread.average_deaths
      assert_equal 6, player2_spread.average_spread
      assert_equal 1, player2_spread.number_of_games
   end

   private
   def find_stat_by_service_tag(stats, service_tag)
      target = nil
      stats.each do |stat|
         if stat.player.uses_tag?(service_tag)
            target = stat
            break
         end
      end
      target
   end
end
