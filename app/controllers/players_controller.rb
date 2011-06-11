class PlayersController < ActionController::Base
   layout "application"

   def index
      @title = "Players"

      @players = Player.find(:all, :order => :real_name)
   end

   def show
      @selected_player = Player.find(params[:id])
      @title = "Players"

      @players = Player.find(:all, :order => :real_name)
      @maps = ReachMap.find(:all, :order => :name)
   end

   def effectiveness_graph
      player_id = params[:player_id]
      map_id = params[:map_id]

      d2 = "[[0, 3], [4, 8], [8, 5], [9, 13]]"
      d3 = "[[0, 12], [7, 12], null, [7, 2.5], [12, 2.5]]"

      data = "[#{d2}, #{d3}]"


      respond_to do |format|
         format.html { 
            render :json => data
         }
         format.json {
            render :json => data
         }
      end
   end
end
