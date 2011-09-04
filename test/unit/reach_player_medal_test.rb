require "test_helper"

class ReachPlayerMedalTest < ActiveSupport::TestCase
   test "finding_report_by_player_stat" do
      player1_id = players(:player1).id
      player2_id = players(:player2).id
      player3_id = players(:player3).id
      medal1_id = medals(:medal1).id
      medal2_id = medals(:medal2).id

      reports_for_player1 = ReachPlayerMedal.find_by_player_stat_id(player1_id)

      report1 = reports_for_player1.select { |report| report.medal_id == medal1_id }.first
      assert_equal "Medal A", report1.medal.name
      assert_equal 1, report1.count

      reports_for_player2 = ReachPlayerMedal.find_by_player_stat_id(player2_id)

      report2 = reports_for_player2.select { |report| report.medal_id == medal1_id }.first
      assert_equal "Medal A", report2.medal.name
      assert_equal 2, report2.count

      reports_for_player3 = ReachPlayerMedal.find_by_player_stat_id(player3_id)

      report3 = reports_for_player3.select { |report| report.medal_id == medal1_id }.first
      assert_equal "Medal A", report3.medal.name
      assert_equal 3, report3.count

      report4 = reports_for_player3.select { |report| report.medal_id == medal2_id }.first
      assert_equal "Medal B", report4.medal.name
      assert_equal 2, report4.count
   end

   test "earned_medals only returns medals that were earned" do
      medal1 = medals(:medal1)
      medal2 = medals(:medal2)
      medal3 = medals(:medal3)

      earned_medals = ReachPlayerMedal.earned_medals

      assert_equal 2, earned_medals.length
      assert_equal medal1.id, earned_medals[0].id
      assert_equal medal1.name, earned_medals[0].name
      assert_equal medal2.id, earned_medals[1].id
      assert_equal medal2.name, earned_medals[1].name

      earned_medal3s = earned_medals.select { |medal| medal.id == medal3.id }

      assert earned_medal3s.empty?
   end
end


