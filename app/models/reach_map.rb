# == Schema Information
# Schema version: 2
#
# Table name: reach_maps
#
#  id   :integer(4)      not null, primary key
#  name :string(255)
#

class ReachMap < ActiveRecord::Base
   def self.find_by_name(name)
      where(:name => name).first
   end
end
