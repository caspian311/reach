class PlayerEffectivenessProcessor
   def effectiveness_for_player(player_stat)
      team_score = player_stat.reach_team.score
      team_size = player_stat.reach_team.reach_player_stats.count

      other_team_size = other_team(player_stat).reach_player_stats.count

      team_ratio = team_size.to_f / other_team_size.to_f
      effectiveness_rating = (team_score + 1) / ( team_ratio )

      player_stat.effectiveness_rating = effectiveness_rating
   end

   private 
   def other_team(player_stat)
      all_teams = player_stat.reach_team.reach_game.reach_teams
      other_team = all_teams[0].id == player_stat.reach_team.id ? all_teams[0] : all_teams[1]
   end
end
