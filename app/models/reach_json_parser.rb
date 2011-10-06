require "reach_logging"

class ReachJsonParser
   def initialize(data_directory = "reach_data")
      @data_directory = data_directory
   end

   def populate_details(game_ids)
      all_games = []

      game_ids.each_with_index do |game_id, current_game|
         LOG.info " - reading in game #{current_game} out of #{game_ids.length}"

         file_contents = JSON.parse(File.read("#{@data_directory}/#{game_id}.json"))
         game_details_json = file_contents["GameDetails"]

         if (game_details_json["Teams"] != nil)
            game = ReachGame.new
            game.reach_id = game_id
            game.name = game_details_json["GameVariantName"]
            game.duration = game_details_json["GameDuration"]
            game.game_time = parse_timestamp(game_details_json["GameTimestamp"])
            
            map_name = game_details_json["MapName"]
            map = ReachMap.find_by_name(map_name)
            if map == nil
               map = ReachMap.new
               map.name = map_name
               map.save
            end
            game.reach_map = map

            reach_teams = parse_teams(game, game_details_json["Teams"])

            parse_player_stats(reach_teams, game_details_json["Players"])

            game.save
            all_games << game
         end
      end

      all_games
   end

   private
   def parse_player_stats(reach_teams, json_players)
      json_players.each do |json_player|
         player_stat = ReachPlayerStat.new

         service_tag = json_player["PlayerDetail"]["service_tag"]
         player = Player.find_by_service_tag(service_tag)
         player_stat.player = player

         player_stat.score = json_player["Score"]
         player_stat.assists = json_player["Assists"]
         player_stat.average_death_distance = json_player["AvgDeathDistanceMeters"]
         player_stat.average_kill_distance = json_player["AvgKillDistanceMeters"]
         player_stat.betrayals = json_player["Betrayals"]
         player_stat.did_not_finish = json_player["DNF"]
         player_stat.assists = json_player["Assists"]
         player_stat.deaths = json_player["Deaths"]
         player_stat.head_shots = json_player["Headshots"]
         player_stat.overall_standing = json_player["IndividualStandingWithNoRegardForTeams"]
         player_stat.kills = json_player["Kills"]
         player_stat.total_medals = json_player["TotalMedalCount"]

         player_stat.reach_weapon_carnage_reports = parse_weapon_carnage(json_player["WeaponCarnageReport"])

         player_stat.reach_player_medals = parse_player_medals(json_player["SpecificMedalCounts"])

         reach_teams[json_player["Team"]].reach_player_stats << player_stat
      end
   end

   def parse_player_medals(player_medals_jsons)
      player_medals = []
      player_medals_jsons.each do |player_medals_json|
         player_medal = ReachPlayerMedal.new
         player_medals << player_medal

         player_medal.medal_id = player_medals_json["Key"]
         player_medal.count = player_medals_json["Value"]
      end

      player_medals
   end

   def parse_weapon_carnage(weapon_carnage_jsons)
      weapon_carnages = []
      weapon_carnage_jsons.each do |weapon_carnage_json|
         weapon_carnage = ReachWeaponCarnageReport.new
         weapon_carnages << weapon_carnage

         weapon_carnage.weapon_id = weapon_carnage_json["WeaponId"]
         weapon_carnage.deaths = weapon_carnage_json["Deaths"]
         weapon_carnage.head_shots = weapon_carnage_json["Headshots"]
         weapon_carnage.kills = weapon_carnage_json["Kills"]
         weapon_carnage.penalties = weapon_carnage_json["Penalties"]
      end

      weapon_carnages
   end

   def parse_teams(game, json_teams)
      teams = {}
      json_teams.each do |json_team|
         team = ReachTeam.new

         team_id = json_team["Index"]

         team.team_id = team_id
         team.standing = json_team["Standing"]
         team.score = json_team["Score"]
         team.kills = json_team["TeamTotalKills"]
         team.assists = json_team["TeamTotalAsssists"]
         team.betrayals = json_team["TeamTotalBetrayals"]
         team.suicides = json_team["TeamTotalSuicides"]
         team.medals = json_team["TeamTotalMedals"]

         team.reach_game_id = game.id
         game.reach_teams << team

         teams[team_id] = team
      end

      teams
   end

   def parse_timestamp(timestamp)
      if timestamp && (timestamp =~ /^\/Date\((\d+)-(\d+)\)\/$/)
         return Time.at($1.to_i / 1000).utc
      else
         raise ArgumentError.new('Invalid timestamp') 
      end
   end
end
