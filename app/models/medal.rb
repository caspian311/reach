# == Schema Information
# Schema version: 1
#
# Table name: medals
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#  image       :string(255)
#

class Medal < ActiveRecord::Base
   def self.earned_medals
      all(:order => :name)
   end
end
