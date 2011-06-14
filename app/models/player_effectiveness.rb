class PlayerEffectiveness < ActiveRecord::Base
   belongs_to :player
   belongs_to :reach_game

   def self.find_by_service_tag(service_tag)
      joins(:player, :reach_game).where(:players => {:service_tag => service_tag})
   end
end
