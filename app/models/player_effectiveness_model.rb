class PlayerEffectivenessModel
   def self.stats_for_map(map_id)
      PlayerEffectiveness.all(:select => "player_effectivenesses.*, avg(player_effectivenesses.effectiveness_rating) as average_rating, count(*) as number_of_games", 
         :joins => [:player, :reach_game], 
         :conditions => {:reach_games => {:reach_map_id => map_id} }, 
         :group => "players.id",
         :order => "average_rating desc")
   end

   def self.all_stats_for_player(player_id)
      PlayerEffectiveness.all(:conditions => {:player_id => player_id},
         :joins => :reach_game,
         :order => {:reach_game => :game_time})
   end

   def self.average_stats_for_player(player_id)
      PlayerEffectiveness.average(:effectiveness_rating, :conditions => {:player_id => player_id})
   end

   def self.all_stats_for_player_and_map(player_id, map_id)
      PlayerEffectiveness.all(:joins => :reach_game,
         :conditions => {:player_id => player_id, :reach_games => {:reach_map_id => map_id}},
         :order => {:reach_game => :game_time})
   end

   def self.average_stats_for_player_and_map(player_id, map_id)
      PlayerEffectiveness.average(:effectiveness_rating, 
         :joins => :reach_game,
         :conditions => {:player_id => player_id, :reach_games => {:reach_map_id => map_id}}).to_f
   end
end
