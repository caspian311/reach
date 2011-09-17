require "test_helper"

class MedalsControllerTest < ActionController::TestCase
   test "index page should have earned medals and the title" do
      get :index

      assigns(:title).should == "Medals"
   end

   test "show page should have earned medals, the title, selected_medal, and ranked_medals" do
      get :show, :medal_id => medals(:medal1).id

      assigns(:title).should == "Medals: Medal A"
   end
end
