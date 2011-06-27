# == Schema Information
# Schema version: 1
#
# Table name: service_tags
#
#  id        :integer         not null, primary key
#  tag       :string(255)
#  player_id :integer
#

class ServiceTag < ActiveRecord::Base
   belongs_to :player
end
