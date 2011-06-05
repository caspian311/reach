Feature: Game History
   Scenario: Game History page have the correct title
      When I go to the game history page
      Then I should see "Halo Reach: Game History"

   @wip
   Scenario: Game History page should show first 10 games
#      Given there are 200 games in the database
      When I go to the game history page
      Then I should see "Capture the Flag 1"
      And I should see "Capture the Flag 10"
