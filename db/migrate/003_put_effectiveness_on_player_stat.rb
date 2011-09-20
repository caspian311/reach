require "active_record"

class PutEffectivenessOnPlayerStat < ActiveRecord::Migration
   def self.up
      drop_table :player_effectivenesses

      alter_table :reach_player_stats do |table|
         table.column :effectiveness_rating, :float
      end

      # populate_player_effectiveness
   end
   
   def self.down
      create_table :player_effectivenesses do |table|
         table.column :effectiveness_rating, :float

         table.references :player         
         table.references :reach_game
      end

      populate_player_effectiveness
   end

   private
   def populate_player_effectiveness
      processor = PlayerEffectivenessProcessor.new
      ReachGame.all().each do |game|
         processor.process_game(game)
      end
   end
end
