require 'spec_helper'

describe GameHistoryController do
   before(:all) do
      ReachGame.delete_all
      ReachTeam.delete_all
      ReachPlayerStat.delete_all
      Player.delete_all
   end

   render_views

   describe "GET 'show'" do
      it "should be successful" do
         get 'show'
         response.should be_success
       end
   end
end
