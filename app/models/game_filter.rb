class GameFilter
   GAME_MIN_TIME_LIMIT = 90

   def initialize(data_directory = "reach_data")
      @data_directory = data_directory
   end

   def filter_game_ids
      filtered_game_ids = []
      Dir.glob("#{@data_directory}/*") do |file|
         file_contents = JSON.parse(File.read(file))

         reach_id = file_contents["GameDetails"]["GameId"]
         game_duration = file_contents["GameDetails"]["GameDuration"].to_i
         teams = file_contents["GameDetails"]["Teams"]

         if is_game_already_imported?(reach_id)
            if has_teams?(teams)
               if is_game_long_enough?(game_duration)
                  filtered_game_ids << reach_id
               end
            end
         end
      end

      filtered_game_ids
   end

   private
   def is_game_already_imported?(reach_id)
      ReachGame.find_by_reach_id(reach_id) == nil
   end

   def is_game_long_enough?(game_duration)
      game_duration > GAME_MIN_TIME_LIMIT
   end
   
   def has_teams?(teams)
      teams != nil
   end
end
