class PlayerEffectivenessProcessor
   def process_game(game)
      LOG.info "Calculating effectiveness for game: #{game.reach_id}"

      if highest_score(game) <= 5
         game.reach_teams.each do |team|
            team.reach_player_stats.each do |player_stat|
               player_effectiveness = PlayerEffectiveness.new
               player_effectiveness.player = player_stat.player
               player_effectiveness.reach_game = game

               team_score = team_score(game, team.team_id)
               team_size = team_size(game, team.team_id)
               other_team_size = other_team_size(game, team.team_id)

               team_ratio = team_size.to_f / other_team_size.to_f
               effectiveness_rating = (team_score + 1) / ( team_ratio )

               player_effectiveness.effectiveness_rating = effectiveness_rating
               player_effectiveness.save
            end
         end
      else
         LOG.info "disregarded because the score was too high... probably a team slayer game"
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