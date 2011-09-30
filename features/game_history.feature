Feature: Game History
   Scenario: Game History page have the correct title
      When I go to the game history page
      Then I should see "Halo Reach: Game History"

   Scenario: Game History page should only show first 10 games
      When I go to the game history page
      Then I should see "Capture the Flag 1"
      And I should see "Capture the Flag 10"
      And I should not see "Capture the Flag 11"

   Scenario: Game History page link should go to the second page
      When I go to the game history page
      And I follow "2"
      Then I should be on the game history second page

   Scenario: Game History page should show only the second set of 10 games on the second page
      When I go to the game history page
      And I follow "2"
      And I should not see "Capture the Flag 10"
      And I should see "Capture the Flag 11"
      And I should see "Capture the Flag 20"

   @wip
   Scenario: Game History details are shown
      When I go to the game history page
      And I follow "1234567890"
      Then I should see the following table data:
         | player_name  | kills  | assists   | deaths | spread |
         | Player One   | 1      | 2         | 3      | 4      |
         | Player Three | 1      | 2         | 3      | 4      |
         | Player Two   | 1      | 2         | 3      | 4      |
         | Player Four  | 1      | 2         | 3      | 4      |

