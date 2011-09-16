class GameDetailsController < ActionController::Base
   def show
      game_id = params[:reach_id]

      game = ReachGame.find_by_id(game_id)

      json = game.to_json(:include => { :reach_teams => { :include => { :reach_player_stats => { :include => {:player => {:include => :service_tags} } } } } }) 

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
