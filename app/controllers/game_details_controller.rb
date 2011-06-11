class GameDetailsController < ActionController::Base
   def show
      reach_id = params[:reach_id]

      game = ReachGame.find_by_reach_id(reach_id)

      respond_to do |format|
         format.html { 
            render :json => game.to_json(:include => { :reach_teams => { :include => { :reach_player_stats => { :include => :player } } } }) 
         }
         format.json {
            render :json => game.to_json(:include => { :reach_teams => { :include => { :reach_player_stats => { :include => :player } } } }) 
         }
      end
   end
end
