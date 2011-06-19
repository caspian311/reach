class PlayerStatsController < ActionController::Base
   def get_stats
      player_id = params[:player_id]
      map_id = params[:map_id]

      player_stats = PlayerStatsModel.get_json_stats(player_id, map_id)

      respond_to do |format|
         format.html { 
            render :json => player_stats.to_json
         }
         format.json {
            render :json => player_stats.to_json
         }
      end
   end
end
