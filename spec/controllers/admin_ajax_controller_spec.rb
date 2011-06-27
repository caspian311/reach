require 'spec_helper'

describe AdminAjaxController do
   describe "make ajax call to do 'update'" do
      it "should be successful" do
         AdminModel.should_receive(:start_job).and_return(nil)

         get 'update', :format => :json

         response.should be_success
       end
   end

   describe "make ajax call to fetch 'results'" do
      it "should be successful" do
         status = JobStatus.new
         status.created_at = Time.now
         status.status = "Finished"
         AdminModel.should_receive(:get_job).with(789).and_return(status)

         get 'results', :job_id => "789", :format => :json

         response.should be_success
       end
   end
end
