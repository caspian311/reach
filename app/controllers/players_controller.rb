class PlayersController < ActionController::Base
   layout "application"

   def index
      @title = "Players"

      @players = Player.find(:all, :order => :real_name)
   end

   def show
      player_id = params[:id]
      @selected_player = Player.find(player_id)
      @title = "Players"

      @maps = ReachMap.find(:all, :order => :name)

      @top_3_medals = PlayerModel.top_3_medals(player_id)
      @career_kill_deaths = PlayerModel.career_kills(player_id)
   end
end
