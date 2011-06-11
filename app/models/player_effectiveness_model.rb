class PlayerEffectivenessModel
   def self.stats_for_map(map_name)
      sql = "  SELECT         p.real_name as player_name,
                              m.name as map,
                              (avg((1.0 * team_score) + 1) / ((1.0 * team_size) / (1.0 * other_team_size))) as effectiveness,
                              count(*) as number_of_games
               FROM           player_effectivenesses pe, players p, reach_maps m
               WHERE          m.name = '#{map_name}'
               AND            m.id = pe.reach_map_id
               AND            pe.player_id = p.id
               GROUP BY       service_tag
               ORDER By       effectiveness DESC
            "

      player_effectiveness_stats = []
      PlayerEffectiveness.find_by_sql(sql).each do |row|
         player_effectiveness_stat = PlayerEffectivenessStat.new
         player_effectiveness_stat.player_name = row.player_name
         player_effectiveness_stat.map = row.map
         player_effectiveness_stat.effectiveness = row.effectiveness
         player_effectiveness_stat.number_of_games = row.number_of_games

         player_effectiveness_stats << player_effectiveness_stat
      end
      player_effectiveness_stats
   end

   def self.all_stats_for_player_and_map(player_id, map_id)
      sql = "  SELECT         ( (1.0 * pe.team_score + 1)  ) / ( (1.0 * pe.other_team_size) / (1.0 * pe.team_size) ) as effectiveness
               FROM           player_effectivenesses pe
               WHERE          pe.player_id = #{player_id}
               AND            pe.reach_map_id = #{map_id}
            "

      effectivenesses = []
      PlayerEffectiveness.find_by_sql(sql).each do |row|
         player_effectiveness_stat = PlayerEffectivenessStat.new
         effectivenesses << row.effectiveness
      end
      effectivenesses
   end

   def self.average_stats_for_player_and_map(player_id, map_id)
      sql = "  SELECT         avg( (1.0 * pe.team_score + 1)  ) / ( (1.0 * pe.other_team_size) / (1.0 * pe.team_size) ) as effectiveness
               FROM           player_effectivenesses pe
               WHERE          pe.player_id = #{player_id}
               AND            pe.reach_map_id = #{map_id}
            "

      PlayerEffectiveness.find_by_sql(sql).first.effectiveness
   end

   def self.all_stats_for_player(player_id)
      sql = "  SELECT         ( (1.0 * pe.team_score + 1)  ) / ( (1.0 * pe.other_team_size) / (1.0 * pe.team_size) ) as effectiveness
               FROM           player_effectivenesses pe
               WHERE          pe.player_id = #{player_id}
            "

      effectivenesses = []
      PlayerEffectiveness.find_by_sql(sql).each do |row|
         player_effectiveness_stat = PlayerEffectivenessStat.new
         effectivenesses << row.effectiveness
      end
      effectivenesses
   end

   def self.average_stats_for_player(player_id)
      sql = "  SELECT         avg( (1.0 * pe.team_score + 1)  ) / ( (1.0 * pe.other_team_size) / (1.0 * pe.team_size) ) as effectiveness
               FROM           player_effectivenesses pe
               WHERE          pe.player_id = #{player_id}
            "

      PlayerEffectiveness.find_by_sql(sql).first.effectiveness
   end

end
