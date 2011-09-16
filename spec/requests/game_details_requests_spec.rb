require 'spec_helper'

describe "Game Details" do
   fixtures :all

   describe "fetching details for a game" do
      it "should return json version of games" do
         game_id = reach_games(:game1).id

         get "/game_details/#{game_id}", :format => :json

         game_details = JSON.parse(response.body)
         assert_equal 2, game_details["reach_game"]["reach_teams"].size

         assert_equal 0, game_details["reach_game"]["reach_teams"][0]["team_id"]
         assert_equal 3, game_details["reach_game"]["reach_teams"][0]["score"]
         assert_equal 2, game_details["reach_game"]["reach_teams"][0]["reach_player_stats"].size
         assert_equal "PLYR1", game_details["reach_game"]["reach_teams"][0]["reach_player_stats"][0]["player"]["service_tags"][0]["tag"]
         assert_equal "PLYR3", game_details["reach_game"]["reach_teams"][0]["reach_player_stats"][1]["player"]["service_tags"][0]["tag"]
         assert_equal 1, game_details["reach_game"]["reach_teams"][1]["team_id"]
         assert_equal 2, game_details["reach_game"]["reach_teams"][1]["score"]
         assert_equal 2, game_details["reach_game"]["reach_teams"][1]["reach_player_stats"].size
         assert_equal "PLYR2", game_details["reach_game"]["reach_teams"][1]["reach_player_stats"][0]["player"]["service_tags"][0]["tag"]
         assert_equal "PLYR4", game_details["reach_game"]["reach_teams"][1]["reach_player_stats"][1]["player"]["service_tags"][0]["tag"]
      end
   end
end


