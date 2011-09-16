require "spec_helper"

describe GameHistoryController do
   describe "GET show" do
      it "should be successful" do
         get "show"
         response.should be_success
       end
   end

   describe "GET show particular game" do
      it "should be successful" do
         get "show", :game => 123
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
         response.should redirect_to(:action => "show", :page => 4, :game => 1)
       end
   end

   describe "showing a particular game" do
      it "should indicate the game" do
         game_id = 123

         get "show", :game => game_id

         assigns(:show_game).should == game_id
      end
   end
end
