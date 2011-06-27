require 'spec_helper'

describe AdminController do
   render_views

   describe "GET 'index' page" do
      it "should be successful" do
         get 'index'

         response.should be_success
       end
   end
end
