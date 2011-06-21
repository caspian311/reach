require 'spec_helper'

describe "Admin Functionality" do
   describe "updating the data" do
      it "should not really return anything but call into the model" do
         expected_status = ResultsStatus.new
         expected_status.status = "finished"

         AdminModel.should_receive(:start_job)

         get "/admin/update", :format => :json

         response.should be_successful
      end
   end

   describe "fetching results for an admin function" do
      it "should return current status" do
         expected_status = ResultsStatus.new
         expected_status.status = "finished"

         AdminModel.should_receive(:current_status).and_return(expected_status)

         get "/admin/results", :format => :json

         actual_status = JSON.parse(response.body)

         assert_equal "finished", actual_status["status"]
      end
   end
end
