require "spec_helper"

describe "Game History" do
   describe "listing" do
      it "should show some games" do
         get "/game_history"

         response.should render_template("game_history/show")
      end
   end
end


