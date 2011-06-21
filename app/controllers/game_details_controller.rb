class GameDetailsController < ActionController::Base
   def show
      reach_id = params[:reach_id]

      game = ReachGame.find_by_reach_id(reach_id)

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
