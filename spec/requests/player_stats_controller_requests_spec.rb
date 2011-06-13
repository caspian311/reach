require 'spec_helper'

describe "Player Graphs" do
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
      it "should return effectiveness stats in json form" do
         endpoint = effectiveness_data_endpoint(@player_id, @map_id)

         get endpoint, :format => :json

         effectiveness_data = JSON.parse(response.body)
         assert_equal 2, effectiveness_data["graph_data"].size
         assert_equal "Each game", effectiveness_data["graph_data"][0]["label"]
         assert_equal "Average", effectiveness_data["graph_data"][1]["label"]
      end
   end

   describe "fetching kill/death graph data for player and map" do
      it "should return kill/death statis in json form" do
         endpoint = kill_death_data_endpoint(@player_id, @map_id)

         get endpoint, :format => :json

         kill_death_data = JSON.parse(response.body)
         assert_equal 2, kill_death_data["graph_data"].size
         assert_equal "Kills", kill_death_data["graph_data"][0]["label"]
         assert_equal "Deaths", kill_death_data["graph_data"][1]["label"]
      end
   end
end

def effectiveness_data_endpoint(player_id, map_id)
   "/player_stats/effectiveness/#{player_id}/#{map_id}"
end

def kill_death_data_endpoint(player_id, map_id)
   "/player_stats/kill_deaths/#{player_id}/#{map_id}"
end
