# == Schema Information
# Schema version: 1
#
# Table name: reach_player_medals
#
#  id                   :integer(4)      not null, primary key
#  count                :integer(4)
#  reach_player_stat_id :integer(4)
#  medal_id             :integer(4)
#

class ReachPlayerMedal < ActiveRecord::Base
   belongs_to :reach_player_stat
   belongs_to :medal

   def self.find_by_player_stat_id(player_stat_id)
      where(:reach_player_stat_id => player_stat_id)
   end
end
