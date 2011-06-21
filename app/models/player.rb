# == Schema Information
# Schema version: 1
#
# Table name: players
#
#  id                    :integer         not null, primary key
#  real_name             :string(255)
#  reach_player_stats_id :integer
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
