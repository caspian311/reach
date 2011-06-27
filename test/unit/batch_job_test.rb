require "test_helper"

class BatchJobTest < Test::Unit::TestCase
   def setup
      @meta_data_parser = MetaDataParser.new
      @reach_client = ReachClient.new
      @reach_json_parser = ReachJsonParser.new
      @game_filter = GameFilter.new
      @game_processor = GameProcessor.new

      @test_object = BatchJob.new(@meta_data_parser, @reach_client, @reach_json_parser, @game_filter, @game_processor)

      Weapon.delete_all
      Player.delete_all
   end

   def test_execute
      @meta_data_parser.expects(:all_weapons)
      @meta_data_parser.expects(:all_players)

      @reach_client.expects(:all_historic_games)

      game_id1 = random_string
      game_id2 = random_string

      ids = [game_id1, game_id2]

      game1 = ReachGame.new
      game2 = ReachGame.new

      games = [game1, game2]

      @game_filter.expects(:filter_game_ids).returns(ids)

      @reach_json_parser.expects(:populate_details).with(ids).returns(games)

      @game_processor.expects(:process_game).with(game1)
      @game_processor.expects(:process_game).with(game2)

      @test_object.execute
   end
end
