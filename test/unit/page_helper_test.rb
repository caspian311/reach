require "test_helper"

class PageHelperTest < Test::Unit::TestCase
   def ignore_test_seconds_to_minutes
      assert_equal "2:00", seconds_to_minutes(120)
      assert_equal "10:00", seconds_to_minutes(600)
      assert_equal "10:10", seconds_to_minutes(610)
      assert_equal "12:10", seconds_to_minutes(730)
   end
end
