require "spec_helper"

describe "Game History" do
   before(:all) do
      ReachGame.delete_all
      ReachTeam.delete_all
      ReachPlayerStat.delete_all
      Player.delete_all
   end

   describe "listing" do
      it "should show some games" do
         get game_history_page

         response.should render_template("game_history/show")
      end
   end

   def game_history_page
      "/game_history"
   end
end


