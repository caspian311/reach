require "test_helper"

class GameHistoryModelTest < ActiveSupport::TestCase
   test "retreive by reach id" do
      game1 = reach_games(:game1)
      reach_id = game1.reach_id

      actual_game = GameHistoryModel.find_by_reach_id(reach_id)

      assert_equal game1, actual_game
   end

   test "retreive games for a given page" do
      game1 = reach_games(:game1)
      game2 = reach_games(:game2)
      game3 = reach_games(:game3)
      game4 = reach_games(:game4)
      game5 = reach_games(:game5)
      game6 = reach_games(:game6)
      game7 = reach_games(:game7)
      game8 = reach_games(:game8)
      game9 = reach_games(:game9)
      game10 = reach_games(:game10)
      game11 = reach_games(:game11)
      game12 = reach_games(:game12)
      game13 = reach_games(:game13)
      game14 = reach_games(:game14)
      game15 = reach_games(:game15)
      game16 = reach_games(:game16)
      game17 = reach_games(:game17)
      game18 = reach_games(:game18)
      game19 = reach_games(:game19)
      game20 = reach_games(:game20)

      game11_id = reach_games(:game11).id

      games_on_page1 = GameHistoryModel.games_for_page 0
      games_on_page2 = GameHistoryModel.games_for_page 1

      assert_equal [game1, game2, game3, game4, game5, game6, game7, game8, game9, game10], games_on_page1
      assert_equal [game11, game12, game13, game14, game15, game16, game17, game18, game19, game20], games_on_page2
   end

   test "retreive page for a given game id" do
      assert_equal 1, GameHistoryModel.page_for_game(reach_games(:game1).id)
      assert_equal 1, GameHistoryModel.page_for_game(reach_games(:game10).id)
      assert_equal 2, GameHistoryModel.page_for_game(reach_games(:game11).id)
      assert_equal 2, GameHistoryModel.page_for_game(reach_games(:game20).id)
   end
end
