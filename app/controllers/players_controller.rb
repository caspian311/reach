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

      all_stats = PlayerEffectivenessModel.all_stats_for_player_and_map(player_id, map_id)
      average = PlayerEffectivenessModel.average_stats_for_player_and_map(player_id, map_id)

      individual_points = ""
      average_points = ""

      all_stats.each_with_index do |stat, index|
         individual_points << "[#{index}, #{stat}]"
         average_points << "[#{index}, #{average}]"

         if index < all_stats.size - 1
            individual_points << ", "
            average_points << ", "
         end
      end

      graph_data = " [ { \"label\": \"Each game\", \"lines\": {\"show\": true}, \"points\": {\"show\": true}, \"data\": [ #{individual_points} ] }, 
                     { \"label\": \"Average\" , \"lines\": {\"show\": true}, \"points\": {\"show\": false}, \"data\": [ #{average_points} ] } ]"

      respond_to do |format|
         format.html { 
            render :json => "{\"graph_data\": #{graph_data}}"
         }
         format.json {
            render :json => "{\"graph_data\": #{graph_data}}"
         }
      end
   end
end
