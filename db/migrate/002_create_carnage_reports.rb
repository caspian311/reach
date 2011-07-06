require "active_record"

class CreateCarnageReports < ActiveRecord::Migration
   def self.up
      create_table :medals, :id => false do |table|
         table.column :id, :integer, :null => false         
         table.column :name, :string
         table.column :description, :string
         table.column :image, :string
      end
   end

   def self.down
      drop_table :medals
   end
end
