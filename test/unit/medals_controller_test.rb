require "test_helper"

class MedalsControllerTest < ActionController::TestCase
   test "index page should have earned medals and the title" do
      get :index

      actual_title = assigns :title

      assert_equal "Medals", actual_title
   end

   test "show page should have earned medals, the title, selected_medal, and ranked_medals" do
      get :show, :medal_id => medals(:medal1).id

      actual_title = assigns :title

      assert_equal "Medals", actual_title
   end
end
