require 'spec_helper'

describe "Player Graphs" do
   before(:all) do
      PlayerEffectiveness.delete_all
      Player.delete_all
      ReachGame.delete_all

      map = ReachMap.new
      map.save

      game = ReachGame.new
      game.reach_map = map
      game.save

      player = Player.new
      player.real_name = "Player 1"
      player.save

      @player_id = player.id
      @map_id = map.id

      (1..3).to_a.each do |i|
         player_effectiveness_stat = PlayerEffectiveness.new
         player_effectiveness_stat.player = player
         player_effectiveness_stat.reach_game = game
         player_effectiveness_stat.effectiveness_rating = i
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
         assert_equal 0, effectiveness_data["graph_data"][0]["data"][0][0]
         assert_equal 1, effectiveness_data["graph_data"][0]["data"][1][0]
         assert_equal 2, effectiveness_data["graph_data"][0]["data"][2][0]
         assert_equal 1, effectiveness_data["graph_data"][0]["data"][0][1]
         assert_equal 2, effectiveness_data["graph_data"][0]["data"][1][1]
         assert_equal 3, effectiveness_data["graph_data"][0]["data"][2][1]
         assert_equal "Average", effectiveness_data["graph_data"][1]["label"]
         assert_equal 0, effectiveness_data["graph_data"][1]["data"][0][0]
         assert_equal 1, effectiveness_data["graph_data"][1]["data"][1][0]
         assert_equal 2, effectiveness_data["graph_data"][1]["data"][2][0]
         assert_equal 2, effectiveness_data["graph_data"][1]["data"][0][1]
         assert_equal 2, effectiveness_data["graph_data"][1]["data"][1][1]
         assert_equal 2, effectiveness_data["graph_data"][1]["data"][2][1]
      end
   end

   describe "fetching kill/death graph data for player and map" do
      it "should return kill/death stats in json form" do
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
