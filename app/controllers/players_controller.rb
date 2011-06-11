class PlayersController < ActionController::Base
   layout "application"

   def index
      @title = "Players"

      @players = Player.find(:all, :order => :real_name)
   end

   def show
      player_id = params[:id]
      player = Player.find(player_id)
      @title = "Players: #{player.real_name} (#{player.service_tag})"

      @players = Player.find(:all, :order => :real_name)
   end
end
