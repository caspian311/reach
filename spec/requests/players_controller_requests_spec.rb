require 'spec_helper'

describe "Player Effectiveness Graph" do
   describe "fetching effectivness graph data for player and map" do
      it "should return json version of games" do
         endpoint = player_effectiveness_data_endpoint(1, 2)

         get endpoint, :format => :json

         effectiveness_data = response.body
         assert !effectiveness_data.empty?
      end
   end
end

def player_effectiveness_data_endpoint(player_id, map_id)
   "/players/#{player_id}/#{map_id}"
end
