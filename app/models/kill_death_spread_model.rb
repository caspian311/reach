class KillDeathSpreadModel
   def self.average_stats
      sql = "  select      p.real_name as player_name, 
                           avg(kills) as killz, 
                           avg(deaths) as deathz,
                           avg(spread) as spreadz,
                           count(*) as games
               FROM        kill_death_spreads kds, players p
               WHERE       kds.player_id = p.id
               GROUP BY    p.real_name
               ORDER BY    spreadz DESC
            "

      kill_death_spread_stats = []
      KillDeathSpread.find_by_sql(sql).each do |row|
         kill_death_spread_stat = KillDeathSpreadStat.new
         kill_death_spread_stat.player_name = row.player_name
         kill_death_spread_stat.kills = row.killz
         kill_death_spread_stat.deaths = row.deathz
         kill_death_spread_stat.spread = row.spreadz
         kill_death_spread_stat.games = row.games

         kill_death_spread_stats << kill_death_spread_stat
      end

      kill_death_spread_stats
   end
end
