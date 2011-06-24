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
            # BatchJob.new.execute
         rescue Exception => e
            mutex.synchronize do
               status = JobStatus.find_by_id(job_id)
               status.status = JobState::ERROR
               error_message = "error when calling batchjob: #{e}\n"
               e.backtrace.each do |line|
                  error_message = "#{error_message}#{line}\n"
               end
               status.content = "#{status.content}\n#{error_message}"
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
      JobStatus.where(:status => JobState::RUNNING).first
   end

   def self.clean_up
      @@threads.each do |t|
         t.join
      end
      @@threads.clear
   end
end
