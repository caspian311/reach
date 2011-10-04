namespace :reach do 
   desc "Fetch all stats from service"
   task :full => :environment do
      BatchJob.new.full
   end

   desc "Fetch only new stats from service"
   task :update => :environment do
      BatchJob.new.update
   end
end

task :reach => 'reach:full'


