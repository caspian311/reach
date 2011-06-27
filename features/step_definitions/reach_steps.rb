
Given /^there are (\d+) games in the database$/ do |number_of_games|
   timestamp = Time.now

   map = ReachMap.new
   map.name = "Breakpoint"
   map.save

   number_of_games.to_i.times.each do |i|
      number = i + 1

      game = ReachGame.new
      game.name = "Capture the Flag #{number}"
      game.game_time = timestamp.advance(:days => -1)
      game.reach_map = map
      game.save
   end
end

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


