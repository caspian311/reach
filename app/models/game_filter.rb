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

         if is_game_unique?(reach_id)
            if game_duration > GAME_MIN_TIME_LIMIT
               filtered_game_ids << reach_id
            end
         end
      end

      filtered_game_ids
   end

   private
   def is_game_unique?(reach_id)
      ReachGame.find_by_reach_id(reach_id) == nil
   end
end
