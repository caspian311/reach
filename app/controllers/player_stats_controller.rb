class PlayerStatsController < ActionController::Base
   def effectiveness_graph
      player_id = params[:player_id]
      map_id = params[:map_id]

      if map_id == nil
         all_stats = PlayerEffectivenessModel.all_stats_for_player(player_id)
         average = PlayerEffectivenessModel.average_stats_for_player(player_id)
      else
         all_stats = PlayerEffectivenessModel.all_stats_for_player_and_map(player_id, map_id)
         average = PlayerEffectivenessModel.average_stats_for_player_and_map(player_id, map_id)
      end

      individual_points = ""
      average_points = ""

      all_stats.each_with_index do |stat, index|
         individual_points << "[#{index}, #{stat.effectiveness_rating}]"
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
            render
         }
         format.json {
            render :json => "{\"graph_data\": #{graph_data}}"
         }
      end
   end

   def kill_death_graph
      player_id = params[:player_id]
      map_id = params[:map_id]

      if map_id == nil
         all_stats = ReachPlayerStat.all(:joins => {:reach_team => :reach_game}, 
            :conditions => {:reach_player_stats => {:player_id => player_id}},
            :order => "reach_games.timestamp")
      else
         all_stats = ReachPlayerStat.all(:joins => {:reach_team => :reach_game}, 
            :conditions => {:reach_player_stats => {:player_id => player_id}, :reach_games => {:reach_map_id => map_id}},
            :order => "reach_games.timestamp")
      end

      kill_points = ""
      death_points = ""

      graph_meta_data = []

      all_stats.each_with_index do |stat, index|
         graph_meta_data << get_game_meta_data(stat)

         kill_points << "[#{index}, #{stat.kills}]"
         death_points << "[#{index}, #{stat.deaths}]"

         if index < all_stats.size - 1
            kill_points << ", "
            death_points << ", "
         end
      end

      graph_data = " [ { \"label\": \"Kills\", \"data\": [ #{kill_points} ] }, 
                     { \"label\": \"Deaths\" , \"data\": [ #{death_points} ] } ]"

      respond_to do |format|
         format.html { 
            render
         }
         format.json {
            render :json => "{\"graph_data\": #{graph_data}, \"kill_death_graph_meta_data\": #{graph_meta_data.to_json}}"
         }
      end

   end

   private
   def get_game_meta_data(stat)
         game = stat.reach_team.reach_game

         game_name = game.name
         game_map = game.reach_map.name
         timestamp = game.timestamp.getlocal.strftime("%m/%d/%Y %I:%M%p")

         "#{timestamp}<br /> #{game_name} <br />on #{game_map}" 
   end
end
