require "test_helper"

class MedalTest < ActiveSupport::TestCase
   test "this" do
      medal1 = medals(:medal1)
      medal2 = medals(:medal2)
      medal3 = medals(:medal3)

      assert_equal [medal1, medal2], Medal.earned_medals
   end
end
