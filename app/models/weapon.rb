# == Schema Information
# Schema version: 1
#
# Table name: weapons
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#

require 'active_record'

class Weapon < ActiveRecord::Base

end
