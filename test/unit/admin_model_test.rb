require "test_helper"

class AdminModelTest < Test::Unit::TestCase
   def setup
      AdminModel.clean_up
      JobStatus.delete_all
   end

   def test_after_starting_the_job_the_current_stats_is_running
      BatchJob.any_instance.stubs(:execute)

      id = AdminModel.start_job.id

      assert_equal JobState::RUNNING, AdminModel.current_status(id).status
      AdminModel.clean_up
   end

   def test_if_no_job_is_running_then_running_job_returns_nil
      assert_nil AdminModel.running_job
   end

   def test_running_job_returns_the_job_that_is_currently_running
      job1 = JobStatus.new
      job1.status = JobState::FINISHED
      job1.save

      job2 = JobStatus.new
      job2.status = JobState::RUNNING
      job2.save

      running_job_id = job2.id

      job3 = JobStatus.new
      job3.status = JobState::FINISHED
      job3.save

      assert_equal running_job_id, AdminModel.running_job.id
   end
end
