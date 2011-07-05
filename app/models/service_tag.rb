# == Schema Information
# Schema version: 2
#
# Table name: service_tags
#
#  id        :integer(4)      not null, primary key
#  tag       :string(255)
#  player_id :integer(4)
#

class ServiceTag < ActiveRecord::Base
   belongs_to :player
end
