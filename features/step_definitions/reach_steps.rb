
Given /^there are (\d+) games in the database$/ do |number_of_games|
   timestamp = Time.now

   map = ReachMap.new
   map.name = "Breakpoint"
   map.save

   number_of_games.to_i.times.each do |i|
      number = i + 1

      game = ReachGame.new
      game.name = "Capture the Flag #{number}"
      game.timestamp = timestamp.advance(:days => -1)
      game.reach_map = map
      game.save
   end
end

Then /^I should find a button called "([^"]*)"$/ do |button_name|
   find_button button_name
end
