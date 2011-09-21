# == Schema Information
# Schema version: 2
#
# Table name: reach_player_stats
#
#  id                     :integer(4)      not null, primary key
#  score                  :integer(4)
#  assists                :integer(4)
#  average_death_distance :integer(10)
#  average_kill_distance  :integer(10)
#  betrayals              :integer(4)
#  did_not_finish         :boolean(1)
#  deaths                 :integer(4)
#  head_shots             :integer(4)
#  overall_standing       :integer(4)
#  kills                  :integer(4)
#  total_medals           :integer(4)
#  player_id              :integer(4)
#  reach_team_id          :integer(4)
#

class ReachPlayerStat < ActiveRecord::Base
   belongs_to :reach_team
   belongs_to :player
   has_many :reach_weapon_carnage_reports
   has_many :reach_player_medals

   def effectiveness
      team_score = self.reach_team.score
      team_size = self.reach_team.reach_player_stats.count

      other_team_size = other_team.reach_player_stats.count

      team_ratio = team_size.to_f / other_team_size.to_f
      (team_score + 1) / ( team_ratio )
   end

   private 
   def other_team
      all_teams = self.reach_team.reach_game.reach_teams
      other_team = all_teams[0].id == self.reach_team.id ? all_teams[0] : all_teams[1]
   end
end
