# == Schema Information
# Schema version: 2
#
# Table name: weapons
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :string(255)
#

require 'active_record'

class Weapon < ActiveRecord::Base

end
