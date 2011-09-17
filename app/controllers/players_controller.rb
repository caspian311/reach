class PlayersController < ApplicationController
   def index
      @title = "Players"

      @players = Player.find(:all, :order => :real_name)
   end

   def show
      player_id = params[:id]
      @selected_player = Player.find(player_id)
      @title = "Players: #{@selected_player.real_name} ("
      @selected_player.service_tags.each do |service_tag|
         @title += service_tag.tag
      end
      @title += ")"

      @maps = ReachMap.find(:all, :order => :name)

      @top_3_medals = PlayerModel.top_3_medals(player_id)
      @career_kill_deaths = PlayerModel.career_kills(player_id)
   end
end
