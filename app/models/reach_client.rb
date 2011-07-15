require "rubygems"
require "json"
require "halo-reach-api"

class ReachClient
   CUSTOM_GAME = 6

   def initialize(reach = Halo::Reach::API.new(ApiKeyProvider.new.api_key), throttle = 0.5, output_directory = "reach_data", accounts = ["Buckethead Died", "jaymz9mm"])
      @reach = reach
      @throttle = throttle
      @output_directory = output_directory
      @accounts = accounts
   end

   def most_recent_games
      json_games = games_on_page(0)
      ids = get_game_ids(json_games)
      retreive_game_details(ids)
   end

   def all_historic_games
      json_games = []
      (0..24).each do |page|
         json_games = json_games | games_on_page(page)
      end

      ids = get_game_ids(json_games)
      retreive_game_details(ids)
   end

   private
   def retreive_game_details(ids)
      total_games = ids.length
      current_game = 0
      ids.each do |id|
         current_game += 1

         filename = "#{@output_directory}/#{id}.json"
         if !File.exists? filename
            sleep(@throttle)
            LOG.info " - downloading: #{current_game} out of #{total_games}"

            game_details = @reach.get_game_details(id)
            game_details_json = game_details.parsed_response

            write_out_details(id, game_details_json, filename)
         end         
      end
   end

   def write_out_details(id, game_details_json, filename)
      json_text = JSON.generate(game_details_json)

      output_file = File.new(filename, "w+")
      output_file.write(json_text)
      output_file.close
   end

   def get_game_ids(json_games)
      ids = []
      json_games.each do |game_json|
         ids <<  game_json["GameId"]
      end

      ids.sort!
   end

   def games_on_page(page_number)
      games = []

      begin
         @accounts.each do |account|
            LOG.info "Getting game history page #{page_number} from Halo Reach services for #{account}..."
            game_from_account = @reach.get_game_history(account, CUSTOM_GAME, page_number)["RecentGames"]

            games = games | game_from_account
         end

         LOG.info "Game history retrieved successfully"
      rescue Exception => e
         LOG.info "Error getting data from Halo Reach services: #{e}"
         retry
      end

      games
   end
end
