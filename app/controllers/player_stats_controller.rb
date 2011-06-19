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
         individual_points << "[#{index}, #{stat.effectiveness_rating}]"
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
            render
         }
         format.json {
            render :json => "{\"graph_data\": #{graph_data}}"
         }
      end
   end

   def kill_death_graph
      player_id = params[:player_id]
      map_id = params[:map_id]

      json = PlayerStatsModel.get_json_output_of_kill_death_stats(player_id, map_id)

      respond_to do |format|
         format.html { 
            render :json => json
         }
         format.json {
            render :json => json
         }
      end

   end
end
