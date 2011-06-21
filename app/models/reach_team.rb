# == Schema Information
# Schema version: 1
#
# Table name: reach_teams
#
#  id               :integer         not null, primary key
#  team_id          :integer
#  standing         :integer
#  score            :integer
#  kills            :integer
#  assists          :integer
#  betrayals        :integer
#  suicides         :integer
#  medals           :integer
#  reach_game_id    :integer
#  reach_players_id :integer
#

class ReachTeam < ActiveRecord::Base
   belongs_to :reach_game

   has_many :reach_player_stats
end
