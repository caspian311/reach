require 'spec_helper'

describe "Carnage Report" do
   before do
      ReachPlayerStat.delete_all
      ReachWeaponCarnageReport.delete_all
      Weapon.delete_all

      player_stat = ReachPlayerStat.new
      player_stat.save
      @player_stat_id = player_stat.id

      weapon1 = Weapon.new
      weapon1.id = 1
      weapon1.name = "Weapon 1"
      weapon1.save

      weapon2 = Weapon.new
      weapon2.id = 2
      weapon2.name = "Weapon 2"
      weapon2.save

      report1 = ReachWeaponCarnageReport.new
      report1.weapon = weapon1
      report1.kills = 12
      report1.deaths = 23

      report2 = ReachWeaponCarnageReport.new
      report2.weapon = weapon2
      report2.kills = 34
      report2.deaths = 45

      player_stat.reach_weapon_carnage_reports << report1
      player_stat.reach_weapon_carnage_reports << report2
   end

   describe "fetching carnage report for a player's game" do
      it "should return json version of report" do
         get game_report_page, :format => :json

         report = JSON.parse(response.body)
         assert_equal 2, report.size
         assert_equal "Weapon 1", report[0]["reach_weapon_carnage_report"]["weapon"]["name"]
         assert_equal 12, report[0]["reach_weapon_carnage_report"]["kills"]
         assert_equal 23, report[0]["reach_weapon_carnage_report"]["deaths"]
         assert_equal "Weapon 2", report[1]["reach_weapon_carnage_report"]["weapon"]["name"]
         assert_equal 34, report[1]["reach_weapon_carnage_report"]["kills"]
         assert_equal 45, report[1]["reach_weapon_carnage_report"]["deaths"]
      end
   end
end

def game_report_page
   "/carnage_report/#{@player_stat_id}"
end
