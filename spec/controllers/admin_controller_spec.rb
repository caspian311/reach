require 'spec_helper'

describe AdminController do
   render_views

   describe "GET 'index' page" do
      it "should be successful" do
         get 'index'

         response.should be_success
       end
   end

   describe "make ajax call to 'update' page" do
      it "should be successful" do
         get 'update', :format => :json

         response.should be_success
       end
   end
end
