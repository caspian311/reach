# == Schema Information
# Schema version: 2
#
# Table name: medals
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#

class Medal < ActiveRecord::Base
end
