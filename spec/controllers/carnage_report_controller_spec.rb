require 'spec_helper'

describe CarnageReportController do
   render_views

   describe "GET 'show'" do
      it "should be successful" do
         get 'show', :player_stat_id => '1'
         response.should be_success
       end
   end
end
