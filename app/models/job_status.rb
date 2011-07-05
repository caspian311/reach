# == Schema Information
# Schema version: 2
#
# Table name: job_statuses
#
#  id         :integer(4)      not null, primary key
#  status     :string(255)
#  content    :text
#  created_at :datetime
#

class JobStatus < ActiveRecord::Base
end
