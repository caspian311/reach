class PlayerEffectivenessController < ApplicationController
   def index
      @title = "Player Effectiveness"
      @maps = ReachMap.find(:all, :order => "name")
   end

   def show
      @maps = ReachMap.find(:all, :order => "name")
      @map_id = params[:map_id]
      selected_map = ReachMap.find_by_id(@map_id)
      @title = "Player Effectiveness: #{selected_map.name}"
      @player_stats = PlayerEffectivenessModel.stats_for_map(@map_id)
   end

   def info
      @title = "What is Player Effectiveness?"
   end
end
