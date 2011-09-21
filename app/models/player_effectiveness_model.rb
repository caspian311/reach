class PlayerEffectivenessModel
   def self.stats_for_map(map_id)
      ReachPlayerStat.all(
         :select => "reach_player_stats.*, count(*) as number_of_games",
         :joins => [:player, {:reach_team => :reach_game}], 
         :conditions => {:reach_games => {:reach_map_id => map_id} }, 
         :group => "players.id")
   end

   def self.all_stats_for_player(player_id)
     ReachPlayerStat.all(:conditions => {:player_id => player_id},
         :joins => {:reach_team => :reach_game},
         :order => {:reach_game => :game_time})
   end

   def self.average_stats_for_player(player_id)
      stats_for_player = ReachPlayerStat.find_all_by_player_id(player_id)
      stats_for_player.inject(0.0) {|sum, stat| sum + stat.effectiveness } / stats_for_player.size
   end

   def self.all_stats_for_player_and_map(player_id, map_id)
      ReachPlayerStat.all(
         :joins => {:reach_team => :reach_game},
         :conditions => {:player_id => player_id, :reach_games => {:reach_map_id => map_id}},
         :order => {:reach_game => :game_time})
   end

   def self.average_stats_for_player_and_map(player_id, map_id)
      stats_for_player = ReachPlayerStat.all(
         :joins => {:reach_team => :reach_game},
         :conditions => {:player_id => player_id, :reach_games => {:reach_map_id => map_id}},
         :order => {:reach_game => :game_time})
      stats_for_player.inject(0.0){ |sum, stat| sum + stat.effectiveness }.to_f / stats_for_player.size
   end
end
