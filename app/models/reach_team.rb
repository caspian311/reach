# == Schema Information
# Schema version: 2
#
# Table name: reach_teams
#
#  id            :integer(4)      not null, primary key
#  team_id       :integer(4)
#  standing      :integer(4)
#  score         :integer(4)
#  kills         :integer(4)
#  assists       :integer(4)
#  betrayals     :integer(4)
#  suicides      :integer(4)
#  medals        :integer(4)
#  reach_game_id :integer(4)
#

class ReachTeam < ActiveRecord::Base
   belongs_to :reach_game

   has_many :reach_player_stats
end
