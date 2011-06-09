require 'spec_helper'

describe "Game Details" do
   before do
      ReachGame.delete_all

      @reach_id = "1234567890"

      game = ReachGame.new
      game.reach_id = @reach_id
      game.save

      team1 = ReachTeam.new
      team1.team_id = 1
      team1.score = 15
      game.reach_teams << team1

      team2 = ReachTeam.new
      team2.team_id = 2
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
   end

   describe "fetching details for a game" do
      it "should return json version of games" do
         get game_details_page, :format => :json

         game_details = JSON.parse(response.body)
         assert_equal 2, game_details["reach_game"]["reach_teams"].size
         assert_equal 1, game_details["reach_game"]["reach_teams"][0]["team_id"]
         assert_equal 15, game_details["reach_game"]["reach_teams"][0]["score"]
         assert_equal 2, game_details["reach_game"]["reach_teams"][0]["reach_player_stats"].size
         assert_equal "player1", game_details["reach_game"]["reach_teams"][0]["reach_player_stats"][0]["player"]["service_tag"]
         assert_equal "player3", game_details["reach_game"]["reach_teams"][0]["reach_player_stats"][1]["player"]["service_tag"]
         assert_equal 2, game_details["reach_game"]["reach_teams"][1]["team_id"]
         assert_equal 10, game_details["reach_game"]["reach_teams"][1]["score"]
         assert_equal 1, game_details["reach_game"]["reach_teams"][1]["reach_player_stats"].size
         assert_equal "player2", game_details["reach_game"]["reach_teams"][1]["reach_player_stats"][0]["player"]["service_tag"]
      end
   end
end

def game_details_page
   "/game_details/#{@reach_id}"
end
