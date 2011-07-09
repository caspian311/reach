require "test_helper"

class ReachWeaponCarnageReportTest < Test::Unit::TestCase
   def setup
      player1 = ReachPlayerStat.new
      player1.save

      @player1_id = player1.id

      player2 = ReachPlayerStat.new
      player2.save

      @player2_id = player2.id

      report1 = ReachWeaponCarnageReport.new
      report1.weapon_id = 1
      report1.kills = 2
      report1.deaths = 3

      report2 = ReachWeaponCarnageReport.new
      report2.weapon_id = 4
      report2.kills = 5
      report2.deaths = 6

      report3 = ReachWeaponCarnageReport.new
      report3.weapon_id = 7
      report3.kills = 8
      report3.deaths = 9

      report4 = ReachWeaponCarnageReport.new
      report4.weapon_id = 10
      report4.kills = 11
      report4.deaths = 12

      player1.reach_weapon_carnage_reports = [report1, report2]
      player2.reach_weapon_carnage_reports = [report3, report4]
   end
   
   def test_finding_report_by_player_stat
      reports_for_player1 = ReachWeaponCarnageReport.find_by_player_stat_id(@player1_id)
      
      report1 = find_by_weapon_id(reports_for_player1, 1)
      assert_equal 1, report1.weapon_id
      assert_equal 2, report1.kills
      assert_equal 3, report1.deaths

      report2 = find_by_weapon_id(reports_for_player1, 4)
      assert_equal 4, report2.weapon_id
      assert_equal 5, report2.kills
      assert_equal 6, report2.deaths

      reports_for_player2 = ReachWeaponCarnageReport.find_by_player_stat_id(@player2_id)

      report3 = find_by_weapon_id(reports_for_player2, 7)
      assert_equal 7, report3.weapon_id
      assert_equal 8, report3.kills
      assert_equal 9, report3.deaths

      report4 = find_by_weapon_id(reports_for_player2, 10)
      assert_equal 10, report4.weapon_id
      assert_equal 11, report4.kills
      assert_equal 12, report4.deaths
   end

   private
   def find_by_weapon_id(reports, weapon_id)
      target = nil

      reports.each do |report|
         if report.weapon_id == weapon_id
            target = report
            break
         end
      end

      target
   end
end


