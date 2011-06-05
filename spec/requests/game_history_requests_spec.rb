require "spec_helper"

describe "Game History" do
   describe "listing" do
      it "should show some games" do
         visit game_history_page

         response.should render_template("game_history/show")
      end
   end
end

def game_history_page
   "/game_history"
end
