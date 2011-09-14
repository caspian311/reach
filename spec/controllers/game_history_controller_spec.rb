require "spec_helper"

describe GameHistoryController do
   describe "GET show" do
      it "should be successful" do
         get "show"
         response.should be_success
       end
   end

   describe "GET info" do
      it "should be successful" do
         get "info"
         response.should be_success
       end
   end

   describe "GET search" do
      it "should be successful" do
         GameHistoryModel.should_receive(:page_for_game).with(1).and_return(4)

         get "search", :game_id => 1
         response.should redirect_to(:action => "show", :page => 4)
       end
   end
end
