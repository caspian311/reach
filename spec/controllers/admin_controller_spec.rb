require 'spec_helper'

describe AdminController do
   render_views

   describe "GET 'index' page" do
      it "should be successful" do
         get 'index'

         response.should be_success
       end
   end

   describe "make ajax call to do 'update'" do
      it "should be successful" do
         AdminModel.should_receive(:start_job).and_return(nil)

         get 'update', :format => :json

         response.should be_success
       end
   end

   describe "make ajax call to fetch 'results'" do
      it "should be successful" do
         get 'results', :job_id => "123", :format => :json

         response.should be_success
       end
   end
end
