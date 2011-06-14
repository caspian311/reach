class PlayerEffectivenessController < ActionController::Base
   layout "application"

   def index
      setup_page
   end

   def show
      setup_page

      @map_id = params[:map_id]
      @player_stats = PlayerEffectivenessModel.stats_for_map(@map_id)
   end

   private
   def setup_page
      @title = "Player Effectiveness"
      @maps = ReachMap.find(:all, :order => "name")
   end
end
