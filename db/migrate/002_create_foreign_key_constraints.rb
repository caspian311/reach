require "active_record"

class CreateForeignKeyConstraints < ActiveRecord::Migration
   def self.up
      execute "set foreign_key_checks = 0"
      execute "alter table player_effectivenesses add constraint fk_eff_player_id foreign key (player_id) references players (id) on delete cascade"
      execute "alter table player_effectivenesses add constraint fk_eff_game_id foreign key (reach_game_id) references reach_games (id) on delete cascade"
      execute "alter table reach_games add constraint fk_games_map_id foreign key (reach_map_id) references reach_maps (id) on delete cascade"
      execute "alter table reach_player_medals add constraint fk_medals_stat_id foreign key (reach_player_stat_id) references reach_player_stats (id) on delete cascade"

      execute "alter table reach_player_medals add foreign key (medal_id) references medals (id) on delete cascade"

      execute "alter table reach_player_stats add constraint fk_stats_player_id foreign key (player_id) references players (id) on delete cascade"
      execute "alter table reach_player_stats add constraint fk_stats_team_id foreign key (reach_team_id) references reach_teams (id) on delete cascade"
      execute "alter table reach_teams add constraint fk_teams_game_id foreign key (reach_game_id) references reach_games (id) on delete cascade"
      execute "alter table reach_weapon_carnage_reports add constraint fk_report_stat_id foreign key (reach_player_stat_id) references reach_player_stats (id) on delete cascade"

      execute "alter table reach_weapon_carnage_reports add constraint fk_rep_weapon foreign key (weapon_id) references weapons (id) on delete cascade"

      execute "alter table service_tags add constraint fk_tag_player_id foreign key (player_id) references players (id) on delete cascade"
      execute "set foreign_key_checks = 1"
   end

   def self.down
      execute "set foreign_key_checks = 0"
      execute "alter table player_effectivenesses drop foreign key fk_eff_player_id"
      execute "alter table player_effectivenesses drop foreign key fk_eff_game_id"
      execute "alter table reach_games drop foreign key fk_games_map_id"
      execute "alter table reach_player_medals drop foreign key fk_medals_stat_id"
      execute "alter table reach_player_medals drop foreign key fk_pm_medal"
      execute "alter table reach_player_stats drop foreign key fk_stats_player_id"
      execute "alter table reach_player_stats drop foreign key fk_stats_team_id"
      execute "alter table reach_teams drop foreign key fk_teams_game_id"
      execute "alter table reach_weapon_carnage_reports drop foreign key fk_report_stat_id"
      execute "alter table reach_weapon_carnage_reports drop foreign key fk_rep_weapon"
      execute "alter table service_tags drop foreign key fk_tag_player_id"
      execute "set foreign_key_checks = 1"
   end
end
