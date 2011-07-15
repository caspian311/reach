require "test_helper"

class ReachPlayerMedalTest < Test::Unit::TestCase
   def setup
      ReachPlayerStat.delete_all
      Medal.delete_all
      ReachPlayerMedal.delete_all

      player1 = ReachPlayerStat.new
      player1.save

      @player1_id = player1.id

      player2 = ReachPlayerStat.new
      player2.save

      @player2_id = player2.id

      medal1 = Medal.new
      medal1.id = 1
      medal1.name = "Medal 1"
      medal1.save
      @medal1_id = medal1.id

      medal2 = Medal.new
      medal2.id = 2
      medal2.name = "Medal 2"
      medal2.save
      @medal2_id = medal2.id

      medal3 = Medal.new
      medal3.id = 3
      medal3.name = "Medal 3"
      medal3.save
      @medal3_id = medal3.id

      medal4 = Medal.new
      medal4.id = 4
      medal4.name = "Medal 4"
      medal4.save
      @medal4_id = medal4.id

      report1 = ReachPlayerMedal.new
      report1.medal = medal1
      report1.count = 2

      report2 = ReachPlayerMedal.new
      report2.medal = medal2
      report2.count = 5

      report3 = ReachPlayerMedal.new
      report3.medal = medal3
      report3.count = 8

      report4 = ReachPlayerMedal.new
      report4.medal = medal4
      report4.count = 11

      player1.reach_player_medals = [report1, report2]
      player2.reach_player_medals = [report3, report4]
   end
   
   def test_finding_report_by_player_stat
      reports_for_player1 = ReachPlayerMedal.find_by_player_stat_id(@player1_id)
      
      report1 = find_by_medal_id(reports_for_player1, @medal1_id)
      assert_equal "Medal 1", report1.medal.name
      assert_equal 2, report1.count

      report2 = find_by_medal_id(reports_for_player1, @medal2_id)
      assert_equal "Medal 2", report2.medal.name
      assert_equal 5, report2.count

      reports_for_player2 = ReachPlayerMedal.find_by_player_stat_id(@player2_id)

      report3 = find_by_medal_id(reports_for_player2, @medal3_id)
      assert_equal "Medal 3", report3.medal.name
      assert_equal 8, report3.count

      report4 = find_by_medal_id(reports_for_player2, @medal4_id)
      assert_equal "Medal 4", report4.medal.name
      assert_equal 11, report4.count
   end

   private
   def find_by_medal_id(reports, medal_id)
      target = nil

      reports.each do |report|
         if report.medal_id == medal_id
            target = report
            break
         end
      end

      target
   end
end


