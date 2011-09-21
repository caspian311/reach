class BatchJob
   def initialize(meta_data_parser = MetaDataParser.new, reach_client = ReachClient.new, reach_json_parser = ReachJsonParser.new, game_filter = GameFilter.new)
      @meta_data_parser = meta_data_parser
      @reach_client = reach_client
      @reach_json_parser = reach_json_parser
      @game_filter = game_filter
   end

   def execute
      populate_meta_data
      fetch_game_data

      LOG.info "Running batch job: complete."
   end

   private
   def populate_meta_data
      LOG.info "Populating meta-data..."
      if Weapon.all.empty?
         @meta_data_parser.all_weapons
      end

      if Player.all.empty?
         @meta_data_parser.all_players
      end

      if Medal.all.empty?
         @meta_data_parser.all_medals
      end
      LOG.info "Populating meta-data: complete."
   end

   def fetch_game_data
      @reach_client.all_historic_games

      filtered_game_ids = @game_filter.filter_game_ids
      LOG.info " - #{filtered_game_ids.length} game(s) to be imported into the database"

      @reach_json_parser.populate_details(filtered_game_ids)
   end
end
