# == Schema Information
# Schema version: 1
#
# Table name: job_statuses
#
#  id      :integer         not null, primary key
#  status  :string(255)
#  content :text
#

class JobStatus < ActiveRecord::Base
end
