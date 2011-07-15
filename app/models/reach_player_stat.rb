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
end
