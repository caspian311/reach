require "test_helper"

class ReachWeaponCarnageReportTest < Test::Unit::TestCase
   def setup
      ReachPlayerStat.delete_all
      Weapon.delete_all

      player1 = ReachPlayerStat.new
      player1.save

      @player1_id = player1.id

      player2 = ReachPlayerStat.new
      player2.save

      @player2_id = player2.id

      weapon1 = Weapon.new
      weapon1.id = 1
      weapon1.name = "Weapon 1"
      weapon1.save
      @weapon1_id = weapon1.id

      weapon2 = Weapon.new
      weapon2.id = 2
      weapon2.name = "Weapon 2"
      weapon2.save
      @weapon2_id = weapon2.id

      weapon3 = Weapon.new
      weapon3.id = 3
      weapon3.name = "Weapon 3"
      weapon3.save
      @weapon3_id = weapon3.id

      weapon4 = Weapon.new
      weapon4.id = 4
      weapon4.name = "Weapon 4"
      weapon4.save
      @weapon4_id = weapon4.id

      report1 = ReachWeaponCarnageReport.new
      report1.weapon = weapon1
      report1.kills = 2
      report1.deaths = 3

      report2 = ReachWeaponCarnageReport.new
      report2.weapon = weapon2
      report2.kills = 5
      report2.deaths = 6

      report3 = ReachWeaponCarnageReport.new
      report3.weapon = weapon3
      report3.kills = 8
      report3.deaths = 9

      report4 = ReachWeaponCarnageReport.new
      report4.weapon = weapon4
      report4.kills = 11
      report4.deaths = 12

      player1.reach_weapon_carnage_reports = [report1, report2]
      player2.reach_weapon_carnage_reports = [report3, report4]
   end
   
   def test_finding_report_by_player_stat
      reports_for_player1 = ReachWeaponCarnageReport.find_by_player_stat_id(@player1_id)
      
      report1 = find_by_weapon_id(reports_for_player1, @weapon1_id)
      assert_equal "Weapon 1", report1.weapon.name
      assert_equal 2, report1.kills
      assert_equal 3, report1.deaths

      report2 = find_by_weapon_id(reports_for_player1, @weapon2_id)
      assert_equal "Weapon 2", report2.weapon.name
      assert_equal 5, report2.kills
      assert_equal 6, report2.deaths

      reports_for_player2 = ReachWeaponCarnageReport.find_by_player_stat_id(@player2_id)

      report3 = find_by_weapon_id(reports_for_player2, @weapon3_id)
      assert_equal "Weapon 3", report3.weapon.name
      assert_equal 8, report3.kills
      assert_equal 9, report3.deaths

      report4 = find_by_weapon_id(reports_for_player2, @weapon4_id)
      assert_equal "Weapon 4", report4.weapon.name
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


