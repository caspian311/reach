class PlayerStatsController < ActionController::Base
   def effectiveness_graph
      player_id = params[:player_id]
      map_id = params[:map_id]

      if map_id == nil
         all_stats = PlayerEffectivenessModel.all_stats_for_player(player_id)
         average = PlayerEffectivenessModel.average_stats_for_player(player_id)
      else
         all_stats = PlayerEffectivenessModel.all_stats_for_player_and_map(player_id, map_id)
         average = PlayerEffectivenessModel.average_stats_for_player_and_map(player_id, map_id)
      end

      individual_points = ""
      average_points = ""

      all_stats.each_with_index do |stat, index|
         individual_points << "[#{index}, #{stat}]"
         average_points << "[#{index}, #{average}]"

         if index < all_stats.size - 1
            individual_points << ", "
            average_points << ", "
         end
      end

      graph_data = " [ { \"label\": \"Each game\", \"lines\": {\"show\": true}, \"points\": {\"show\": true}, \"data\": [ #{individual_points} ] }, 
                     { \"label\": \"Average\" , \"lines\": {\"show\": true}, \"points\": {\"show\": false}, \"data\": [ #{average_points} ] } ]"

      respond_to do |format|
         format.html { 
            render :json => "{\"graph_data\": #{graph_data}}"
         }
         format.json {
            render :json => "{\"graph_data\": #{graph_data}}"
         }
      end
   end

   def kill_death_graph
      player_id = params[:player_id]
      map_id = params[:map_id]

      if map_id == nil
         all_stats = Player.find_by_id(player_id).reach_player_stats
      else
         all_stats = ReachPlayerStat.all(:joins => {:reach_team => :reach_game}, :conditions => {:reach_player_stats => {:player_id => player_id}, :reach_games => {:reach_map_id => map_id}})
      end

      kill_points = ""
      death_points = ""

      all_stats.each_with_index do |stat, index|
         kill_points << "[#{index}, #{stat.kills}]"
         death_points << "[#{index}, #{stat.deaths}]"

         if index < all_stats.size - 1
            kill_points << ", "
            death_points << ", "
         end
      end

      graph_data = " [ { \"label\": \"Kills\", \"lines\": {\"show\": true}, \"points\": {\"show\": false}, \"data\": [ #{kill_points} ] }, 
                     { \"label\": \"Deaths\" , \"lines\": {\"show\": true}, \"points\": {\"show\": false}, \"data\": [ #{death_points} ] } ]"

      respond_to do |format|
         format.html { 
            render :json => "{\"graph_data\": #{graph_data}}"
         }
         format.json {
            render :json => "{\"graph_data\": #{graph_data}}"
         }
      end
   end
end
