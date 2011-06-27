# == Schema Information
# Schema version: 1
#
# Table name: reach_player_stats
#
#  id                     :integer         not null, primary key
#  score                  :integer
#  assists                :integer
#  average_death_distance :decimal(, )
#  average_kill_distance  :decimal(, )
#  betrayals              :integer
#  did_not_finish         :boolean
#  deaths                 :integer
#  head_shots             :integer
#  overall_standing       :integer
#  kills                  :integer
#  total_medals           :integer
#  player_id              :integer
#  reach_team_id          :integer
#

class ReachPlayerStat < ActiveRecord::Base
   belongs_to :reach_team
   belongs_to :player
end
