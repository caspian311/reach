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
      @game1_id = reach_games(:game1).id
      @game1_timestamp = reach_games(:game1).game_time.getlocal.strftime("%m/%d/%Y %I:%M%p")
      @game2_id = reach_games(:game2).id
      @game2_timestamp = reach_games(:game2).game_time.getlocal.strftime("%m/%d/%Y %I:%M%p")
   end

   describe "fetching player kill/death stats data for player and map" do
      it "should return kill/death stats in json form" do
         get "/player_stats/kill_death/#{@player1_id}/#{@map_id}", :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 2, player_stats_data["stats"].size
         assert_equal 2, player_stats_data["graph_meta_data"].size

         game1_id = player_stats_data["graph_meta_data"][1]["id"]
         game1_description = player_stats_data["graph_meta_data"][1]["description"]
         game2_id = player_stats_data["graph_meta_data"][0]["id"]
         game2_description = player_stats_data["graph_meta_data"][0]["description"]

         assert_equal @game1_id, game1_id
         assert_equal "#{@game1_timestamp}<br />Capture the Flag 1 <br />Map One", game1_description
         assert_equal @game2_id, game2_id
         assert_equal "#{@game2_timestamp}<br />Capture the Flag 2 <br />Map One", game2_description

         kills_data = player_stats_data["stats"][0]
         deaths_data = player_stats_data["stats"][1]

         assert_equal "Kills", kills_data["label"]
         assert_equal 2, kills_data["data"].size
         assert_equal [0, 7], kills_data["data"][0]
         assert_equal [1, 10], kills_data["data"][1]

         assert_equal "Deaths", deaths_data["label"]
         assert_equal 2, deaths_data["data"].size
         assert_equal [0, 6], deaths_data["data"][0]
         assert_equal [1, 5], deaths_data["data"][1]
      end
   end

   describe "fetching effectiveness stats data for player and map" do
      it "should return effectiveness stats in json form" do
         get "/player_stats/effectiveness/#{@player1_id}/#{@map_id}", :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 2, player_stats_data["stats"].size
         assert_equal 2, player_stats_data["graph_meta_data"].size

         game1_id = player_stats_data["graph_meta_data"][0]["id"]
         game1_description = player_stats_data["graph_meta_data"][0]["description"]
         game2_id = player_stats_data["graph_meta_data"][1]["id"]
         game2_description = player_stats_data["graph_meta_data"][1]["description"]

         assert_equal @game1_id, game1_id
         assert_equal "#{@game1_timestamp}<br />Capture the Flag 1 <br />Map One", game1_description
         assert_equal @game2_id, game2_id
         assert_equal "#{@game2_timestamp}<br />Capture the Flag 2 <br />Map One", game2_description

         each_game_data = player_stats_data["stats"][0]
         average_data = player_stats_data["stats"][1]

         assert_equal "Each game", each_game_data["label"]
         assert_equal 2, each_game_data["data"].size
         assert_equal [0, 4.0], each_game_data["data"][0]

         assert_equal "Average", average_data["label"]
         assert_equal 2, average_data["data"].size
         assert_equal 0, average_data["data"][0][0]
         assert_equal 3.0, average_data["data"][0][1]
      end
   end

   describe "fetching medal stats data for player" do
      it "should return medal stats in json form" do
         get "/player_stats/medals/#{@player1_id}", :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 1, player_stats_data["stats"].size
         assert_equal 1, player_stats_data["stats"][0]["data"].size
         assert_equal [0, 1], player_stats_data["stats"][0]["data"][0]
         assert_equal 1, player_stats_data["graph_meta_data"].size
         assert_equal "1 - #{@medal1_name}", player_stats_data["graph_meta_data"][0]

         get "/player_stats/medals/#{@player2_id}", :format => :json

         player_stats_data = JSON.parse(response.body)

         assert_equal 1, player_stats_data["stats"].size
         assert_equal 1, player_stats_data["stats"][0]["data"].size
         assert_equal [0, 2], player_stats_data["stats"][0]["data"][0]
         assert_equal 1, player_stats_data["graph_meta_data"].size
         assert_equal "2 - #{@medal1_name}", player_stats_data["graph_meta_data"][0]
      end
   end
end


