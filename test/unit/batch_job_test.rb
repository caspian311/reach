require "test_helper"

class BatchJobTest < Test::Unit::TestCase
   def setup
      @meta_data_parser = MetaDataParser.new
      @reach_client = ReachClient.new
      @reach_json_parser = ReachJsonParser.new
      @game_filter = GameFilter.new
      @game_processor = GameProcessor.new

      @test_object = BatchJob.new(@meta_data_parser, @reach_client, @reach_json_parser, @game_filter, @game_processor)

      @reach_client.stubs(:all_historic_games)

      game_id1 = random_string
      game_id2 = random_string

      @game_ids = [game_id1, game_id2]
      @game_filter.stubs(:filter_game_ids).returns(@game_ids)

      Weapon.delete_all
      Medal.delete_all
      Player.delete_all
   end

   def test_execute_calls_all_historic_games
      @reach_client.expects(:all_historic_games)

      @test_object.execute
   end


   def test_execute_calls_all_historic_games
      game1 = ReachGame.new
      game2 = ReachGame.new

      games = [game1, game2]

      @reach_json_parser.expects(:populate_details).with(@game_ids).returns(games)

      @game_processor.expects(:process_game).with(game1)
      @game_processor.expects(:process_game).with(game2)

      @test_object.execute
   end

   def test_execute_populates_all_weapons
      @meta_data_parser.expects(:all_weapons)

      @test_object.execute
   end

   def test_execute_does_not_populate_all_weapons_if_any_weapons_already_exist
      weapon = Weapon.new
      weapon.id = 33
      weapon.name = "woot"
      weapon.save

      @meta_data_parser.expects(:all_weapons).never

      @test_object.execute
   end

   def test_execute_populates_all_players
      @meta_data_parser.expects(:all_players)

      @test_object.execute
   end

   def test_execute_does_not_populate_all_players_if_any_players_already_exist
      player = Player.new
      player.save

      @meta_data_parser.expects(:all_players).never

      @test_object.execute
   end

   def test_execute_populates_all_medals
      @meta_data_parser.expects(:all_medals)

      @test_object.execute
   end

   def test_execute_does_not_populate_all_medals_if_any_medals_already_exist
      medal = Medal.new
      medal.id = 1
      medal.save

      @meta_data_parser.expects(:all_medals).never

      @test_object.execute
   end
end
