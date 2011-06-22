class AdminModel
   @@threads = []

   def self.current_status(id)
      JobStatus.find_by_id(id)
   end

   def self.start_job
      status = JobStatus.new
      status.status = "Running"
      status.save

      @@threads << Thread.new(status) do |status|
         status.content = ""
         status.save
         3.times do |i|
            status.content = status.content + "step #{(i + 1)}\n"
            status.save
            sleep(2)
         end
         status.status = "Finished"
         status.save
      end

      status
   end

   def self.running_job
      JobStatus.where(:status => "Running").first
   end

   def self.clean_up
      @@threads.each do |t|
         t.join
      end
      @@threads.clear
   end
end
