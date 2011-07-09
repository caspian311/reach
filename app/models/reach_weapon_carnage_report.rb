# == Schema Information
# Schema version: 1
#
# Table name: reach_weapon_carnage_reports
#
#  id                   :integer(4)      not null, primary key
#  weapon_id            :integer(4)
#  deaths               :integer(4)
#  head_shots           :integer(4)
#  kills                :integer(4)
#  penalties            :integer(4)
#  reach_player_stat_id :integer(4)
#

class ReachWeaponCarnageReport < ActiveRecord::Base
   belongs_to :reach_player_stat
end
