class PlayerEffectivenessModel
   def self.stats_for_map(map_id)
      stats = ReachPlayerStat.all(
         :joins => [:player, {:reach_team => :reach_game}], 
         :conditions => {:reach_games => {:reach_map_id => map_id} }) 
      effectiveness_by_player = {}
      stats.each do |stat|
         if effectiveness_by_player[stat.player.real_name] == nil
            effectiveness_by_player[stat.player.real_name] = []
         end
         effectiveness_by_player[stat.player.real_name] << stat.effectiveness
      end

      average_stats = []
      effectiveness_by_player.keys.each do |player_name|
         effectivenesses = effectiveness_by_player[player_name] 
         number_of_games = effectivenesses.size
         average_rating = effectivenesses.inject(0.0){ |sum, effectiveness| sum + effectiveness } / number_of_games
         average_stats << StatsForMap.new(player_name, average_rating, number_of_games)
      end
      average_stats.sort do |stat1, stat2|
         stat2.average_rating <=> stat1.average_rating
      end
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

   class StatsForMap
      attr_reader :player_name
      attr_reader :average_rating
      attr_reader :number_of_games

      def initialize(player_name, average_rating, number_of_games)
         @player_name = player_name
         @average_rating = average_rating
         @number_of_games = number_of_games
      end
   end
end
