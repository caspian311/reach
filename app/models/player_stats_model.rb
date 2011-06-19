class PlayerStatsModel
   def self.get_json_output_of_kill_death_stats(player_id, map_id)
      stats = get_kill_death_stats(player_id, map_id)

      graph_meta_data = []
      kill_points = []
      death_points = []

      stats.each_with_index do |stat, index|
         graph_meta_data << get_game_description(stat)
         kill_points << [index, stat.kills]
         death_points << [index, stat.deaths]
      end

      graph_data = " [ { \"label\": \"Kills\", \"data\": #{kill_points.to_json} }, 
                     { \"label\": \"Deaths\" , \"data\": #{death_points.to_json} }]"

      "{\"graph_data\": #{graph_data}, \"kill_death_graph_meta_data\": #{graph_meta_data.to_json}}"
   end

   private
   def self.get_kill_death_stats(player_id, map_id)
      if map_id == nil
         stats = ReachPlayerStat.all(:joins => {:reach_team => :reach_game}, 
            :conditions => {:reach_player_stats => {:player_id => player_id}},
            :order => "reach_games.timestamp")
      else
         stats = ReachPlayerStat.all(:joins => {:reach_team => :reach_game}, 
            :conditions => {:reach_player_stats => {:player_id => player_id}, :reach_games => {:reach_map_id => map_id}},
            :order => "reach_games.timestamp")
      end

      stats
   end

   def self.get_game_description(stat)
         game = stat.reach_team.reach_game

         formatted_timestamp = game.timestamp.getlocal.strftime("%m/%d/%Y %I:%M%p")

         "#{formatted_timestamp}<br />#{game.name} <br />#{game.reach_map.name}" 
   end
end
