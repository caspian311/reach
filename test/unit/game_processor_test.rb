require "test_helper"

class GameProcessorTest < Test::Unit::TestCase
   def setup
      @processor1 = StubProcessor.new
      @processor2 = StubProcessor.new

      @test_object = GameProcessor.new([@processor1, @processor2])

      ReachGame.delete_all
   end

   def test_each_processor_is_called_with_the_given_game
      game = ReachGame.new
      game.save

      @test_object.process_game(game)

      assert_equal game.id, @processor1.given_game.id
      assert_equal game.id, @processor2.given_game.id
   end
end

class StubProcessor
   attr_accessor :given_game

   def process_game(game)
      @given_game = game
   end
end
