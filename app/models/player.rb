# == Schema Information
# Schema version: 2
#
# Table name: players
#
#  id        :integer(4)      not null, primary key
#  real_name :string(255)
#

class Player < ActiveRecord::Base
   has_many :reach_player_stats
   has_many :service_tags

   def self.find_by_service_tag(service_tag)
      joins(:service_tags).where(:service_tags => {:tag => service_tag}).first
   end

   def uses_tag?(service_tag)
      uses_tag = false
      service_tags.each do |tag|
         if tag.tag == service_tag
            uses_tag = true
            break
         end
      end
      uses_tag
   end
end
