require "reach_logging"

class MetaDataParser
   def initialize(player_file_location = "resources/players.txt", meta_data_file_location = "resources/game_meta_data.txt")
      @player_file_location = player_file_location
      meta_data_file = File.new(meta_data_file_location)
      @meta_data = JSON.parse(meta_data_file.read)
      @weapons_with_images = YAML.load_file("resources/weapon_mapping.yml")
   end

   def all_players
      LOG.info "removing all players"
      Player.delete_all
      ServiceTag.delete_all

      LOG.info "loading all players"
      players = YAML.load_file(@player_file_location)

      LOG.info "number of players: #{players.length}"
      players.keys.each do |real_name|
         player = Player.new
         player.real_name = real_name
         player.save

         service_tag_name = players[real_name]

         if service_tag_name.kind_of?(Array)
            service_tag_name.each do |tag|
               service_tag = ServiceTag.new
               service_tag.tag = tag

               player.service_tags << service_tag
            end
         else
            service_tag = ServiceTag.new
            service_tag.tag = service_tag_name

            player.service_tags << service_tag
         end
      end
   end

   def all_weapons
      LOG.info "removing all weapons"
      Weapon.delete_all

      LOG.info "loading all weapons"
      @meta_data["Data"]["AllWeaponsById"].each do |json_weapon|
         weapon = Weapon.new

         weapon.id = json_weapon["Value"]["Id"]
         weapon.name = json_weapon["Value"]["Name"]
         weapon.description = json_weapon["Value"]["Description"]
         image = @weapons_with_images[json_weapon["Value"]["Id"]]
         if image == nil
            image = "unknown"
         end
         weapon.image = image

         weapon.save
      end
   end

   def all_medals
      LOG.info "removing all medals"
      Medal.delete_all

      LOG.info "loading all medals"
      @meta_data["Data"]["AllMedalsById"].each do |json_medal|
         medal = Medal.new

         medal.id = json_medal["Value"]["Id"]
         medal.name = json_medal["Value"]["Name"]
         medal.description = json_medal["Value"]["Description"]
         medal.image = json_medal["Value"]["ImageName"]

         medal.save
      end
   end
end
