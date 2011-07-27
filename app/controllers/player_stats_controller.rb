class PlayerStatsController < ActionController::Base
   def kill_death_stats
      player_id = params[:player_id]

      stats = PlayerStatsModel.kill_death_stats(player_id)
      render_stats(stats)
   end

   def kill_death_stats_for_map
      player_id = params[:player_id]
      map_id = params[:map_id]

      stats = PlayerStatsModel.kill_death_stats(player_id, map_id)
      render_stats(stats)
   end

   def effectiveness_stats
      player_id = params[:player_id]

      stats = PlayerStatsModel.effectiveness_stats(player_id)
      render_stats(stats)
   end

   def effectiveness_stats_for_map
      player_id = params[:player_id]
      map_id = params[:map_id]

      stats = PlayerStatsModel.effectiveness_stats(player_id, map_id)
      render_stats(stats)
   end

   def medal_stats
      player_id = params[:player_id]

      stats = PlayerStatsModel.medal_stats(player_id)
      render_stats(stats)
   end

   def render_stats(stats)
      respond_to do |format|
         format.html { 
            render :json => stats.to_json
         }
         format.json {
            render :json => stats.to_json
         }
      end
   end
end
