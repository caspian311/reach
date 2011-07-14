class MedalsController < ActionController::Base
   def show
      player_stat_id = params[:player_stat_id]

      player_medals = ReachPlayerMedal.find_by_player_stat_id(player_stat_id)

      json = player_medals.to_json(:include => :medal)

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
