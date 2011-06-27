# == Schema Information
# Schema version: 1
#
# Table name: player_effectivenesses
#
#  id                   :integer         not null, primary key
#  effectiveness_rating :decimal(, )
#  player_id            :integer
#  reach_game_id        :integer
#

class PlayerEffectiveness < ActiveRecord::Base
   belongs_to :player
   belongs_to :reach_game

   def self.find_by_service_tag(service_tag)
      joins(:player, {:player => :service_tags}, :reach_game).where(:players => {:service_tags => {:tag => service_tag}})
   end
end
