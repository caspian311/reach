require "active_record"

class CreateCarnageReports < ActiveRecord::Migration
   def self.up
      create_table :medals do |table|
         table.column :name, :string
         table.column :description, :string
         table.column :image, :string
      end
   end

   def self.down
      drop_table :medals
   end
end
