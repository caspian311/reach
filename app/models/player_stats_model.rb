class PlayerStatsModel
   def self.kill_death_stats(player_id, map_id = nil)
      if map_id == nil
         kill_death_stats = ReachPlayerStat.all(:joins => {:reach_team => :reach_game}, 
            :conditions => {:reach_player_stats => {:player_id => player_id}},
            :order => "reach_games.game_time")
      else
         kill_death_stats = ReachPlayerStat.all(:joins => {:reach_team => :reach_game}, 
            :conditions => {:reach_player_stats => {:player_id => player_id}, :reach_games => {:reach_map_id => map_id}},
            :order => "reach_games.game_time")
      end

      graph_meta_data = []
      kill_points = []
      death_points = []

      kill_death_stats.each_with_index do |kill_death_stat, index|
         graph_meta_data << get_game_description(kill_death_stat)
         kill_points << [index, kill_death_stat.kills]
         death_points << [index, kill_death_stat.deaths]
      end

      kills_graph_data = GraphData.new
      kills_graph_data.label = "Kills"
      kills_graph_data.data = kill_points

      deaths_graph_data = GraphData.new
      deaths_graph_data.label = "Deaths"
      deaths_graph_data.data = death_points

      kill_death_graphs = []
      kill_death_graphs << kills_graph_data
      kill_death_graphs << deaths_graph_data

      player_stats_data = PlayerStatsData.new
      player_stats_data.stats = kill_death_graphs
      player_stats_data.graph_meta_data = graph_meta_data
      player_stats_data
   end

   def self.effectiveness_stats(player_id, map_id = nil)
      if map_id == nil
         effectiveness_stats = PlayerEffectivenessModel.all_stats_for_player(player_id)
         effectiveness_average = PlayerEffectivenessModel.average_stats_for_player(player_id)
      else
         effectiveness_stats = PlayerEffectivenessModel.all_stats_for_player_and_map(player_id, map_id)
         effectiveness_average = PlayerEffectivenessModel.average_stats_for_player_and_map(player_id, map_id)
      end

      individual_effectiveness = []
      average_effectiveness = []
      graph_meta_data = []

      effectiveness_stats.each_with_index do |effectiveness_stat, index|
         individual_effectiveness << [index, effectiveness_stat.effectiveness_rating.to_f]
         average_effectiveness << [index, effectiveness_average]
      end

      effectiveness_graph_data = GraphData.new
      effectiveness_graph_data.label = "Each game"
      effectiveness_graph_data.data = individual_effectiveness

      average_effectiveness_graph_data = GraphData.new
      average_effectiveness_graph_data.label = "Average"
      average_effectiveness_graph_data.points = PointsData.new
      average_effectiveness_graph_data.points.show = false
      average_effectiveness_graph_data.data = average_effectiveness

      effectiveness_graphs = []
      effectiveness_graphs << effectiveness_graph_data
      effectiveness_graphs << average_effectiveness_graph_data

      player_stats_data = PlayerStatsData.new
      player_stats_data.stats = effectiveness_graphs
      player_stats_data.graph_meta_data = graph_meta_data
      player_stats_data
   end

   private
   def self.get_game_description(stat)
         game = stat.reach_team.reach_game

         formatted_timestamp = game.game_time.getlocal.strftime("%m/%d/%Y %I:%M%p")

         "#{formatted_timestamp}<br />#{game.name} <br />#{game.reach_map.name}" 
   end
end
