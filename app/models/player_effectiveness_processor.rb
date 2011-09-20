class PlayerEffectivenessProcessor
   def process_game(game)
      if highest_score(game) <= 5
         game.reach_teams.each do |team|
            team.reach_player_stats.each do |player_stat|
               team_score = team_score(game, team.team_id)
               team_size = team_size(game, team.team_id)
               other_team_size = other_team_size(game, team.team_id)

               team_ratio = team_size.to_f / other_team_size.to_f
               effectiveness_rating = (team_score + 1) / ( team_ratio )

               player_stat.effectiveness_rating = effectiveness_rating
            end
         end
      end
   end

   private 
   def highest_score(game)
      score = 0

      game.reach_teams.each do |team|
         score = [score, team.score].max
      end

      score
   end

   def team_score(game, team_id)
      score = 0

      game.reach_teams.each do |team|
         if team.team_id == team_id
            score = team.score
            break
         end
      end

      score
   end

   def team_size(game, team_id)
      team_size = 0

      game.reach_teams.each do |team|
         if team.team_id == team_id
            team_size = team.reach_player_stats.count
            break
         end
      end

      team_size
   end

   def other_team_size(game, team_id)
      team_size = 0

      game.reach_teams.each do |team|
         if team.team_id != team_id
            team_size += team.reach_player_stats.count
            break
         end
      end

      team_size
   end
end
