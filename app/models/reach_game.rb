# == Schema Information
# Schema version: 2
#
# Table name: reach_games
#
#  id           :integer(4)      not null, primary key
#  reach_id     :string(255)
#  name         :string(255)
#  duration     :string(255)
#  game_time    :datetime
#  reach_map_id :integer(4)
#

class ReachGame < ActiveRecord::Base
   belongs_to :reach_map
   has_many :reach_teams

   def self.find_by_reach_id(id)
      where(:reach_id  => id).first
   end
end
