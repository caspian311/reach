require 'spec_helper'

describe MedalsController do
   render_views

   describe "GET 'index'" do
      it "should be successful" do
         get 'index'
         response.should be_success
       end
   end

   describe "GET 'show'" do
      it "should be successful" do
         get 'index'
         response.should be_success
       end
   end
end
