require "thread"

class AdminModel
   @@threads = []

   def self.all_jobs
      JobStatus.all(:order => "created_at DESC")
   end

   def self.get_job(id)
      JobStatus.find(id)
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

         status = nil
         mutex.synchronize do
            status = JobStatus.find_by_id(job_id)
         end

         begin
            BatchJob.new.execute

            mutex.synchronize do
               status.status = JobState::FINISHED
               status.save
            end
         rescue Exception => e
            mutex.synchronize do
               status.status = JobState::ERROR
               error_message = "error when calling batchjob: #{e}\n"
               e.backtrace.each do |line|
                  error_message = "#{error_message}#{line}\n"
               end
               status.content = "#{status.content}\n#{error_message}"
               status.save
            end
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
