require "spec_helper"

describe AdminController do
   before do
      JobStatus.delete_all
   end

   describe "pulling up the admin page with no previously run jobs" do
      it "should show a message that says that there are no previously run jobs" do
         get "/admin"

         response.body.should contain("There are no previously run jobs.")
      end
   end

   describe "pulling up the admin page with previously run jobs" do
      it "should show the timestamps of the previous jobs in a drop down" do
         timestamp1 = Time.now.advance(:days => 1)
         timestamp2 = Time.now.advance(:days => 2)
         timestamp3 = Time.now.advance(:days => 3)

         job1 = JobStatus.new
         job1.status = "Finished"
         job1.created_at = timestamp1

         job2 = JobStatus.new
         job2.status = "Running"
         job2.created_at = timestamp2

         job3 = JobStatus.new
         job3.status = "Error"
         job3.created_at = timestamp3

         AdminModel.should_receive(:all_jobs).and_return([job1, job2, job3])

         get "/admin"

         response.body.should contain(timestamp1.getlocal.strftime("%m/%d/%Y %I:%M%p"))
         response.body.should contain(timestamp2.getlocal.strftime("%m/%d/%Y %I:%M%p"))
         response.body.should contain(timestamp3.getlocal.strftime("%m/%d/%Y %I:%M%p"))
      end
   end

   describe "pulling up the update page with a job running" do
      it "current running job should be pulled up" do
         expected_status = JobStatus.new
         expected_status.id = 123
         expected_status.created_at = Time.now
         expected_status.status = "Running"
         AdminModel.should_receive(:running_job).and_return(expected_status)

         get "/admin"

         response.body.should contain("Running")
      end
   end
end
