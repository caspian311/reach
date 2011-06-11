require 'spec_helper'

describe "Player Effectiveness Graph" do
   before do
      PlayerEffectiveness.delete_all

      @player_id = 12
      @map_id = 34

      (1..2).to_a.each do |i|
         player_effectiveness_stat = PlayerEffectiveness.new
         player_effectiveness_stat.player_id = @player_id
         player_effectiveness_stat.reach_map_id = @map_id
         player_effectiveness_stat.team_size = i
         player_effectiveness_stat.other_team_size = i
         player_effectiveness_stat.team_score = i
         player_effectiveness_stat.save
      end
   end

   describe "fetching effectivness graph data for player and map" do
      it "should return json version of games" do
         endpoint = player_effectiveness_data_endpoint(@player_id, @map_id)

         get endpoint, :format => :json

         effectiveness_data = JSON.parse(response.body)
         assert_equal 2, effectiveness_data["graph_data"].size
         assert_equal "Each game", effectiveness_data["graph_data"][0]["label"]
         assert_equal "Average", effectiveness_data["graph_data"][1]["label"]
      end
   end
end

def player_effectiveness_data_endpoint(player_id, map_id)
   "/players/#{player_id}/#{map_id}"
end
