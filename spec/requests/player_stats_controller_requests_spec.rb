require "spec_helper"
require "./test/unit/random_string"

describe "Player Graphs" do
   before(:all) do
      PlayerEffectiveness.delete_all
      Player.delete_all
      ReachGame.delete_all

      @map_name = random_string

      map = ReachMap.new
      map.name = @map_name
      map.save
      @map_id = map.id

      player1 = Player.new
      player1.real_name = "Player 1"
      player1.save
      @player_id = player1.id

      player2 = Player.new
      player2.real_name = "Player 2"
      player2.save

      @game_name = random_string

      game = ReachGame.new
      game.reach_map = map
      game.game_time = Time.now
      game.name = @game_name
      game.save

      team1 = ReachTeam.new
      game.reach_teams << team1

      team2 = ReachTeam.new
      game.reach_teams << team2

      player1_stat = ReachPlayerStat.new
      player1_stat.player = player1
      player1_stat.kills = 10
      player1_stat.deaths = 5
      team1.reach_player_stats << player1_stat

      player2_stat = ReachPlayerStat.new
      player2_stat.player = player2
      player2_stat.kills = 5
      player2_stat.deaths = 10
      team2.reach_player_stats << player2_stat

      (1..3).to_a.each do |i|
         player_effectiveness_stat = PlayerEffectiveness.new
         player_effectiveness_stat.player = player1
         player_effectiveness_stat.reach_game = game
         player_effectiveness_stat.effectiveness_rating = i
         player_effectiveness_stat.save
      end
   end

   describe "fetching player kill/death stats data for player and map" do
      it "should return kill/death stats in json form" do
         get kill_death_endpoint(@player_id, @map_id), :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 2, player_stats_data["stats"].size

         assert_equal "Kills", player_stats_data["stats"][0]["label"]
         assert_equal 1, player_stats_data["stats"][0]["data"].size
         assert_equal [0, 10], player_stats_data["stats"][0]["data"][0]

         assert_equal "Deaths", player_stats_data["stats"][1]["label"]
         assert_equal 1, player_stats_data["stats"][1]["data"].size
         assert_equal [0, 5], player_stats_data["stats"][1]["data"][0]
      end
   end

   describe "fetching effectiveness stats data for player and map" do
      it "should return effectiveness stats in json form" do
         get effectiveness_endpoint(@player_id, @map_id), :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 2, player_stats_data["stats"].size

         assert_equal "Each game", player_stats_data["stats"][0]["label"]
         assert_equal 3, player_stats_data["stats"][0]["data"].size
         assert_equal [0, 1], player_stats_data["stats"][0]["data"][0]
         assert_equal [1, 2],player_stats_data["stats"][0]["data"][1]
         assert_equal [2, 3],player_stats_data["stats"][0]["data"][2]

         assert_equal "Average", player_stats_data["stats"][1]["label"]
         assert_equal 3, player_stats_data["stats"][1]["data"].size
         assert_equal [0, 2], player_stats_data["stats"][1]["data"][0]
         assert_equal [1, 2], player_stats_data["stats"][1]["data"][1]
         assert_equal [2, 2], player_stats_data["stats"][1]["data"][2]
      end
   end

   def kill_death_endpoint(player_id, map_id)
      "/player_stats/kill_death/#{player_id}/#{map_id}"
   end

   def effectiveness_endpoint(player_id, map_id)
      "/player_stats/effectiveness/#{player_id}/#{map_id}"
   end
end


