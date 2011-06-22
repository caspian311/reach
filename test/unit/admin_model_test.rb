require "test_helper"

class AdminModelTest < Test::Unit::TestCase
   def setup
      JobStatus.delete_all
   end

   def test_after_starting_the_job_the_current_stats_is_running
      id = AdminModel.start_job.id

      assert_equal "Running", AdminModel.current_status(id).status
   end
end
