class KillDeathSpreadModel
   def self.average_stats
      ReachPlayerStat.all(:select => "reach_player_stats.*, 
            avg(reach_player_stats.kills) as average_kills, 
            avg(reach_player_stats.deaths) as average_deaths,
            (avg(reach_player_stats.kills) - avg(reach_player_stats.deaths)) as average_spread,  
            avg(reach_player_stats.assists) as average_assists,
            count(*) as number_of_games", 
         :joins => :player,
         :group => "reach_player_stats.player_id",
         :order => "average_spread desc")
   end
end
