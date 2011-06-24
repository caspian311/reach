require "test_helper"

class MetaDataParserTest < Test::Unit::TestCase
   def setup
      player_list_file = "test_resources/test_player_list.txt"
      meta_data_file = "test_resources/test_game_meta_data.txt"
      @test_object = MetaDataParser.new(player_list_file, meta_data_file)

      Weapon.delete_all
      Player.delete_all
      ServiceTag.delete_all
   end

   def test_all_weapons_are_pulled_from_file
      @test_object.all_weapons

      assert_equal 3, Weapon.all.size
      
      first_weapon = Weapon.all.first
      last_weapon = Weapon.all.last

      assert_equal "Weapon one", first_weapon.name
      assert_equal "This is the first weapon", first_weapon.description
      assert_equal "Weapon three", last_weapon.name
      assert_equal "This is the third weapon", last_weapon.description
   end

   def test_all_players_are_pulled_in_from_file
      @test_object.all_players

      assert_equal 3, Player.all.size

      player1 = Player.all[0]
      player2 = Player.all[1]
      player3 = Player.all[2]

      assert_equal "player 1", player1.real_name
      assert player1.uses_tag?("service tag 1")

      assert_equal "player 2", player2.real_name
      assert player2.uses_tag?("service tag 2")

      assert_equal "player 3", player3.real_name
      assert player3.uses_tag?("service tag 3a")
      assert player3.uses_tag?("service tag 3b")
   end
end
