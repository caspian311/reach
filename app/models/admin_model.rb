require "thread"

class AdminModel
   @@threads = []

   def self.current_status(id)
      JobStatus.find_by_id(id)
   end

   def self.start_job
      status = nil

      Mutex.new.synchronize do
         status = JobStatus.new
         status.status = JobState::RUNNING
         status.save
      end

      Thread.abort_on_exception = true

      @@threads << Thread.new(status.id) do |job_id|
         mutex = Mutex.new

         begin
            3.times do |i|
               mutex.synchronize do
                  status = JobStatus.find_by_id(job_id)
                  status.content = "#{status.content}step #{(i + 1)}\n"
                  status.save
                  sleep(2)
               end
            end
         rescue Exception => e
            mutex.synchronize do
               status = JobStatus.find_by_id(job_id)
               status.status = JobState::ERROR
               status.content = "error when calling batchjob: #{e}"
               status.save
            end
         end

         mutex.synchronize do
            status = JobStatus.find_by_id(job_id)
            status.status = JobState::FINISHED
            status.save
         end
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
