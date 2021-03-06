require "active_record"

class CreateInitialTables < ActiveRecord::Migration
   def self.up
      create_table :players do |table|
         table.column :real_name, :string
      end

      create_table :service_tags do |table|
         table.column :tag, :string

         table.references :player
      end

      create_table :player_effectivenesses do |table|
         table.column :effectiveness_rating, :float

         table.references :player         
         table.references :reach_game
      end

      create_table :reach_maps do |table|
         table.column :name, :string
      end

      create_table :reach_player_stats do |table|
         table.column :score, :integer
         table.column :assists, :integer
         table.column :average_death_distance, :decimal
         table.column :average_kill_distance, :decimal
         table.column :betrayals, :integer
         table.column :did_not_finish, :boolean
         table.column :deaths, :integer
         table.column :head_shots, :integer
         table.column :overall_standing, :integer
         table.column :kills, :integer
         table.column :total_medals, :integer

         table.references :player
         table.references :reach_team
      end

      create_table :reach_teams do |table|
         table.column :team_id, :integer
         table.column :standing, :integer
         table.column :score, :integer
         table.column :kills, :integer
         table.column :assists, :integer
         table.column :betrayals, :integer
         table.column :suicides, :integer
         table.column :medals, :integer

         table.references :reach_game
      end

      create_table :reach_games do |table|
         table.column :reach_id, :string
         table.column :name, :string
         table.column :duration, :string
         table.column :game_time, :datetime

         table.references :reach_map
      end

      create_table :reach_weapon_carnage_reports do |table|
         table.column :weapon_id, :integer
         table.column :deaths, :integer
         table.column :head_shots, :integer
         table.column :kills, :integer
         table.column :penalties, :integer

         table.references :reach_player_stat
         table.references :weapon
      end

      create_table :reach_player_medals do |table|
         table.column :count, :integer

         table.references :reach_player_stat
         table.references :medal
      end

      create_table :job_statuses do |table|
         table.column :status, :string
         table.column :content, :text
         table.column :created_at, :datetime
      end

      create_table :weapons, :id => false do |table|
         table.column :id, :integer, :null => false, :unique => true
         table.column :name, :string
         table.column :description, :string
         table.column :image, :string
      end

      create_table :medals, :id => false do |table|
         table.column :id, :integer, :null => false, :unique => true
         table.column :name, :string
         table.column :description, :string
         table.column :image, :string
      end
   end

   def self.down
      drop_table :players
      drop_table :reach_maps
      drop_table :service_tags
      drop_table :reach_games
      drop_table :reach_teams
      drop_table :reach_player_stats
      drop_table :reach_weapon_carnage_reports
      drop_table :reach_player_medals
      drop_table :player_effectivenesses
      drop_table :job_statuses
      drop_table :weapons
      drop_table :medals
   end
end
