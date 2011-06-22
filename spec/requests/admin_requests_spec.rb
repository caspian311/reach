require "spec_helper"

describe AdminController do
   describe "pulling up the update page" do
      it "current running job should be pulled up" do
         expected_status = JobStatus.new
         expected_status.id = 123
         expected_status.status = "Running"
         AdminModel.should_receive(:running_job).and_return(expected_status)

         get "/admin"

         response.body.should contain("Running")
      end
   end

   describe "pulling up the update page" do
      it "should show that nothing is running if there is no current running job" do
         AdminModel.should_receive(:running_job).and_return(nil)

         get "/admin"

         response.body.should contain("Not started")
      end
   end

   describe "updating the data" do
      it "should not really return anything but call into the model" do
         expected_status = JobStatus.new
         expected_status.id = 123
         expected_status.status = "Running"
         AdminModel.should_receive(:start_job).and_return(expected_status)

         get "/admin/update", :format => :json

         actual_status = JSON.parse(response.body)

         assert_equal 123, actual_status["job_status"]["id"]
         assert_equal "Running", actual_status["job_status"]["status"]
      end
   end

   describe "fetching results for an admin function" do
      it "should return current status" do
         expected_status = JobStatus.new
         expected_status.status = "Finished"
         AdminModel.should_receive(:current_status).with(456).and_return(expected_status)

         get "/admin/results/456", :format => :json

         actual_status = JSON.parse(response.body)

         assert_equal "Finished", actual_status["job_status"]["status"]
      end
   end
end
