require 'spec_helper'

describe "Player Graphs" do
   before(:all) do
      PlayerEffectiveness.delete_all
      Player.delete_all
      ReachGame.delete_all

      map = ReachMap.new
      map.save

      game = ReachGame.new
      game.reach_map = map
      game.save

      player = Player.new
      player.real_name = "Player 1"
      player.save

      @player_id = player.id
      @map_id = map.id

      (1..3).to_a.each do |i|
         player_effectiveness_stat = PlayerEffectiveness.new
         player_effectiveness_stat.player = player
         player_effectiveness_stat.reach_game = game
         player_effectiveness_stat.effectiveness_rating = i
         player_effectiveness_stat.save
      end
   end

   describe "fetching player stats data for player and map" do
      it "should return stats in json form" do
         get endpoint(@player_id, @map_id), :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 2, player_stats_data["effectiveness"].size
         assert_equal "Each game", player_stats_data["effectiveness"][0]["label"]
         assert_equal 0, player_stats_data["effectiveness"][0]["data"][0][0]
         assert_equal 1,player_stats_data["effectiveness"][0]["data"][1][0]
         assert_equal 2,player_stats_data["effectiveness"][0]["data"][2][0]
         assert_equal 1, player_stats_data["effectiveness"][0]["data"][0][1]
         assert_equal 2, player_stats_data["effectiveness"][0]["data"][1][1]
         assert_equal 3, player_stats_data["effectiveness"][0]["data"][2][1]

         assert_equal "Average", player_stats_data["effectiveness"][1]["label"]
         assert_equal 0, player_stats_data["effectiveness"][1]["data"][0][0]
         assert_equal 1, player_stats_data["effectiveness"][1]["data"][1][0]
         assert_equal 2, player_stats_data["effectiveness"][1]["data"][2][0]
         assert_equal 2, player_stats_data["effectiveness"][1]["data"][0][1]
         assert_equal 2, player_stats_data["effectiveness"][1]["data"][1][1]
         assert_equal 2, player_stats_data["effectiveness"][1]["data"][2][1]

         assert_equal 2, player_stats_data["kill_death"].size
         assert_equal "Kills", player_stats_data["kill_death"][0]["label"]
         assert_equal "Deaths", player_stats_data["kill_death"][1]["label"]
      end
   end
end

def endpoint(player_id, map_id)
   "/player_stats/#{player_id}/#{map_id}"
end
