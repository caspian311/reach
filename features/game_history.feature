Feature: Game History
   Scenario: Game History page have the correct title
      When I go to the game history page
      Then I should see "Halo Reach: Game History"

   Scenario: Game History page should only show first 10 games
      Given there are 11 games in the database
      When I go to the game history page
      Then I should see "Capture the Flag 1"
      And I should see "Capture the Flag 10"
      And I should not see "Capture the Flag 11"

   Scenario: Game History page link should go to the second page
      Given there are 20 games in the database
      When I go to the game history page
      And I follow "2"
      Then I should be on the game history second page

   Scenario: Game History page should show only the second set of 10 games on the second page
      Given there are 20 games in the database
      When I go to the game history page
      And I follow "2"
      And I should not see "Capture the Flag 10"
      And I should see "Capture the Flag 11"
      And I should see "Capture the Flag 20"
