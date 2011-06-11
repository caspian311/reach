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
end
