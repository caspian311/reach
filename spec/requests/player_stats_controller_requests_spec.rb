require "spec_helper"
require "./test/unit/random_string"

describe "Player Graphs" do
   fixtures :all

   before do
      @player1_id = players(:player1).id
      @player2_id = players(:player2).id
      @map_id = reach_maps(:map1).id
      @medal1_name = medals(:medal1).name
      @medal2_name = medals(:medal2).name
      @medal3_name = medals(:medal3).name
   end

   describe "fetching player kill/death stats data for player and map" do
      it "should return kill/death stats in json form" do
         get kill_death_endpoint(@player1_id, @map_id), :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 2, player_stats_data["stats"].size

         kills_data = player_stats_data["stats"][0]
         deaths_data = player_stats_data["stats"][1]

         assert_equal "Kills", kills_data["label"]
         assert_equal 1, kills_data["data"].size
         assert_equal [0, 10], kills_data["data"][0]

         assert_equal "Deaths", deaths_data["label"]
         assert_equal 1, deaths_data["data"].size
         assert_equal [0, 5], deaths_data["data"][0]
      end
   end

   describe "fetching effectiveness stats data for player and map" do
      it "should return effectiveness stats in json form" do
         get effectiveness_endpoint(@player1_id, @map_id), :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 2, player_stats_data["stats"].size

         each_game_data = player_stats_data["stats"][0]
         average_data = player_stats_data["stats"][1]

         assert_equal "Each game", each_game_data["label"]
         assert_equal 1, each_game_data["data"].size
         assert_equal [0, 1.33], each_game_data["data"][0]

         assert_equal "Average", average_data["label"]
         assert_equal 1, average_data["data"].size
         assert_equal 0, average_data["data"][0][0]
         assert_in_delta 1.33, average_data["data"][0][1], 0.01
      end
   end

   describe "fetching medal stats data for player" do
      it "should return medal stats in json form" do
         get medal_endpoint(@player1_id), :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 1, player_stats_data["stats"].size
         assert_equal 1, player_stats_data["stats"][0]["data"].size
         assert_equal [0, 1], player_stats_data["stats"][0]["data"][0]
         assert_equal 1, player_stats_data["graph_meta_data"].size
         assert_equal "1 - #{@medal1_name}", player_stats_data["graph_meta_data"][0]

         get medal_endpoint(@player2_id), :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 1, player_stats_data["stats"].size
         assert_equal 1, player_stats_data["stats"][0]["data"].size
         assert_equal [0, 2], player_stats_data["stats"][0]["data"][0]
         assert_equal 1, player_stats_data["graph_meta_data"].size
         assert_equal "2 - #{@medal1_name}", player_stats_data["graph_meta_data"][0]
      end
   end

   def kill_death_endpoint(player_id, map_id)
      "/player_stats/kill_death/#{player_id}/#{map_id}"
   end

   def effectiveness_endpoint(player_id, map_id)
      "/player_stats/effectiveness/#{player_id}/#{map_id}"
   end

   def medal_endpoint(player_id)
      "/player_stats/medals/#{player_id}"
   end
end


