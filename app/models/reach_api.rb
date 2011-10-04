require 'httparty'
require 'json'

class ReachApi
   include HTTParty

   def initialize(api_key = ApiKeyProvider.new.api_key)
      @api_key = api_key
   end

   VARIANT = 6
   API_URL = 'http://www.bungie.net/api/reach/reachapijson.svc/'
      
   DEFAULT_HEADERS = {
      'User-Agent' => "Halo Reach API"
   }

   headers(DEFAULT_HEADERS)

   format(:json)

   def get_game_details(reach_id)
      get_game_details_uri = "game/details/#{@api_key}/#{reach_id}"
      self.class.get(API_URL + get_game_details_uri)
   end

   def get_game_history(account_name, page)
      get_game_history_uri = "player/gamehistory/#{@api_key}/#{account_name}/#{VARIANT}/#{page}"
      self.class.get(API_URL + get_game_history_uri)
   end
end
