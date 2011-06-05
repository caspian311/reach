
Given /^there are (\d+) games in the database$/ do |number_of_games|
   timestamp = Time.now

   map = ReachMap.new
   map.name = "Breakpoint"
   map.save

   number_of_games.times each do |i|
      game = ReachGame.new
      game.name = "Capture the Flag #{i}"
      game.timestamp = timestamp.advance(:days => -1)
      game.reach_map = map
      game.save
   end
end
