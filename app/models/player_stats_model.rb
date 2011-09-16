class PlayerStatsModel
   def self.kill_death_stats(player_id, map_id = nil)
      if map_id == nil
         kill_death_stats = PlayerModel.all_kill_stats(player_id)
      else
         kill_death_stats = PlayerModel.all_kill_stats_for_map(player_id, map_id)
      end

      graph_meta_data = []
      kill_points = []
      death_points = []

      kill_death_stats.each_with_index do |kill_death_stat, index|
         graph_meta_data << meta_data(kill_death_stat.reach_team.reach_game)
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
         graph_meta_data << meta_data(effectiveness_stat.reach_game)
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

   def self.medal_stats(player_id)
      medal_stats = PlayerModel.all_medals_for_player(player_id)

      data = []
      graph_meta_data = []
      medal_stats.each_with_index do |medal_stat, index|
         data << [index, medal_stat.count]
         graph_meta_data << "#{medal_stat.count} - #{medal_stat.name}"
      end


      medal_graph_data = GraphData.new
      medal_graph_data.data = data

      player_stats_data = PlayerStatsData.new
      player_stats_data.stats = [ medal_graph_data ]
      player_stats_data.graph_meta_data = graph_meta_data
      player_stats_data
   end

   private
   def self.meta_data(game)
         meta_data = {}
         meta_data["id"] = game.id
         meta_data["description"] = game_description(game)
         meta_data
   end

   private
   def self.game_description(game)
         formatted_timestamp = game.game_time.getlocal.strftime("%m/%d/%Y %I:%M%p")

         "#{formatted_timestamp}<br />#{game.name} <br />#{game.reach_map.name}" 
   end
end
