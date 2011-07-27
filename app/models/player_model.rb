class PlayerModel
   def self.all_kill_stats(player_id)
      ReachPlayerStat.all(
         :joins => {
            :reach_team => :reach_game
         }, 
         :conditions => {
            :reach_player_stats => {
               :player_id => player_id
            }
         },
         :order => "reach_games.game_time")
   end

   def self.all_kill_stats_for_map(player_id, map_id)
      ReachPlayerStat.all(
         :joins => {
            :reach_team => :reach_game
         }, 
         :conditions => {
            :reach_player_stats => {
               :player_id => player_id
            }, 
            :reach_games => {
                  :reach_map_id => map_id
            }
         },
         :order => "reach_games.game_time")
   end

   def self.all_medals_for_player(player_id)
      ReachPlayerMedal.all(
         :select => "medals.id, medals.name, sum(reach_player_medals.count) as count",
         :joins => [:reach_player_stat, :medal],
         :conditions => {
            :reach_player_stats => {
               :player_id => player_id
            }
         },
         :group => :medal_id,
         :order => "count desc")
   end

   def self.top_3_medals(player_id)
      all_medals = all_medals_for_player(player_id)
      [all_medals[0], all_medals[1], all_medals[2]]
   end

   def self.career_kills(player_id)
      ReachPlayerStat.all(
         :select => "sum(kills) as total_kills, sum(deaths) as total_deaths",
         :conditions => {:player_id => player_id}
         ).first
   end
end
