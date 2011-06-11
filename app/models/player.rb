class Player < ActiveRecord::Base
   has_many :reach_player_stats

   def self.find_by_service_tag(service_tag)
      where(:service_tag => service_tag).first
   end
end
