require "test_helper"

class AdminModelTest < Test::Unit::TestCase
   def setup
      AdminModel.clean_up
      JobStatus.delete_all
   end

   def test_all_jobs_returns_all_the_jobs_sorted_by_date
      job1 = JobStatus.new
      job1.created_at = Time.now.advance(:days => -2)
      job1.save
      job1_id = job1.id

      job2 = JobStatus.new
      job2.created_at = Time.now.advance(:days => -1)
      job2.save
      job2_id = job2.id

      job3 = JobStatus.new
      job3.created_at = Time.now.advance(:days => -3)
      job3.save
      job3_id = job3.id

      assert_equal job2_id, AdminModel.all_jobs[0].id
      assert_equal job1_id, AdminModel.all_jobs[1].id
      assert_equal job3_id, AdminModel.all_jobs[2].id
   end

   def test_after_starting_the_job_the_current_stats_is_running
      BatchJob.any_instance.stubs(:execute)

      id = AdminModel.start_job.id

      assert_equal JobState::RUNNING, AdminModel.get_job(id).status
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
