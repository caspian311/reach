class HomeModel
   def self.todays_stats
      stats = []
      all_games_on_last_day.each do |game|
         game.reach_teams.each do |team|
            team.reach_player_stats.each do |player_stat|
               stat = SummaryStat.new
               stat.name = player_stat.player == nil ? "Unknown" : player_stat.player.real_name
               stat.kd_spread = player_stat.kills - player_stat.deaths
               stat.number_of_games = 1
               stat.effectiveness = player_stat.effectiveness
               stat.number_of_medals = total_medal_count(player_stat)
               stats << stat
            end
         end
      end

      stats = aggregate(stats)

      stats.sort do |stat1, stat2|
         stat1.name.downcase <=> stat2.name.downcase
      end
   end

   def self.last_day_of_stats
      ReachGame.all(:order => "game_time").last.game_time.to_date
   end

   private
   def self.aggregate(stats)
      all_stats = {}
      stats.each do |stat|
         aggregated_stat = all_stats[stat.name]
         if aggregated_stat == nil
            aggregated_stat = SummaryStat.new
            aggregated_stat.name = stat.name
            all_stats[aggregated_stat.name] = aggregated_stat
            all_stats[aggregated_stat.name].kd_spread = []
            all_stats[aggregated_stat.name].effectiveness = []
            all_stats[aggregated_stat.name].number_of_medals = []
         end

         all_stats[aggregated_stat.name].kd_spread << stat.kd_spread
         all_stats[aggregated_stat.name].effectiveness << stat.effectiveness
         all_stats[aggregated_stat.name].number_of_medals << stat.number_of_medals
      end

      aggregated_stats = []
      all_stats.values.each do |stat|
         aggregated_stat = SummaryStat.new
         aggregated_stat.name = stat.name

         aggregated_stat.kd_spread = stat.kd_spread.sum / stat.kd_spread.size.to_f
         aggregated_stat.effectiveness = stat.effectiveness.sum / stat.effectiveness.size.to_f
         aggregated_stat.number_of_medals = stat.number_of_medals.sum / stat.number_of_medals.size.to_f
         aggregated_stat.number_of_games = stat.kd_spread.size

         aggregated_stats << aggregated_stat
      end

      aggregated_stats
   end

   def self.total_medal_count(player_stat)
      medal_count = 0
      player_stat.reach_player_medals.each do |medal_stat|
         medal_count += medal_stat.count
      end
      medal_count
   end

   def self.all_games_on_last_day
      ReachGame.all(
            :conditions => ["date(game_time) = ?", last_day_of_stats]
         )
   end

   class SummaryStat
      attr_accessor :name
      attr_accessor :number_of_games
      attr_accessor :kd_spread
      attr_accessor :effectiveness
      attr_accessor :number_of_medals

      def initialize
         @kd_spread = 0
         @effectiveness = 0
         @number_of_games = 0
         @number_of_medals = 0
      end
   end
end
