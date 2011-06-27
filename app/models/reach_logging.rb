require "thread"
require "active_record"

require "./app/models/admin_model"
require "./app/models/job_status"
require "./app/models/job_state"

class ReachLogging
   def initialize
      @mutex = Mutex.new
   end

   def info(message)
      @mutex.synchronize do
         status = AdminModel.running_job
         if status == nil
            puts message
         else
            status.content = "#{status.content}#{message}<br />"
            status.save
         end
      end
   end
end

LOG = ReachLogging.new


