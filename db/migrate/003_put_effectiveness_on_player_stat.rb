require "active_record"

class PutEffectivenessOnPlayerStat < ActiveRecord::Migration
   def self.up
      drop_table :player_effectivenesses
   end
   
   def self.down
      create_table :player_effectivenesses do |table|
         table.column :effectiveness_rating, :float

         table.references :player         
         table.references :reach_game
      end

      processor = PlayerEffectivenessProcessor.new
      ReachGame.all().each do |game|
         processor.process_game(game)
      end
   end
end
