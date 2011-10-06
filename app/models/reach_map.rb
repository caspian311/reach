# == Schema Information
# Schema version: 2
#
# Table name: reach_maps
#
#  id   :integer(4)      not null, primary key
#  name :string(255)
#

class ReachMap < ActiveRecord::Base
   def self.get_or_create_by_name(map_name)
      map = find_by_name map_name
      if map == nil
         map = ReachMap.new
         map.name = map_name
         map.save
      end
      map
   end
end
