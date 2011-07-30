require 'spec_helper'

describe "MedalsHistory" do
   before do
      ReachPlayerStat.delete_all
      ReachPlayerMedal.delete_all
      Medal.delete_all

      player_stat = ReachPlayerStat.new
      player_stat.save
      @player_stat_id = player_stat.id

      medal1 = Medal.new
      medal1.id = 1
      medal1.name = "Medal 1"
      medal1.save

      medal2 = Medal.new
      medal2.id = 2
      medal2.name = "Medal 2"
      medal2.save

      report1 = ReachPlayerMedal.new
      report1.medal = medal1
      report1.count = 5

      report2 = ReachPlayerMedal.new
      report2.medal = medal2
      report2.count = 3

      player_stat.reach_player_medals << report1
      player_stat.reach_player_medals << report2
   end

   describe "fetching medals for a player's game" do
      it "should return json version of report" do
         get game_report_page, :format => :json

         report = JSON.parse(response.body)
         assert_equal 2, report.size
         assert_equal "Medal 1", report[0]["reach_player_medal"]["medal"]["name"]
         assert_equal 5, report[0]["reach_player_medal"]["count"]
         assert_equal "Medal 2", report[1]["reach_player_medal"]["medal"]["name"]
         assert_equal 3, report[1]["reach_player_medal"]["count"]
      end
   end
   
   def game_report_page
      "/medals_history/#{@player_stat_id}"
   end
end


