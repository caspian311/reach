
Given /^no previous jobs were run$/ do
   JobStatus.delete_all
end

Then /^I should find a button called "([^"]*)"$/ do |button_name|
   find_button button_name
end

Then /^I should find a disabled button called "([^"]*)"$/ do |button_name|
   find_button(button_name)["disabled"].should == "\"disabled\""
end

Given /^a job is already running$/ do
   status = JobStatus.new
   status.status = "Running"
   status.save
end


