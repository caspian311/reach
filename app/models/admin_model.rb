class AdminModel
   def self.current_status(id)
      JobStatus.find_by_id(id)
   end

   def self.start_job
      status = JobStatus.new
      status.status = "Running"
      status.save

      status
   end
end
