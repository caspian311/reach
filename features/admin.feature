Feature: Admin
   Scenario: Admin page should have the correct title
      When I go to the admin page
      Then I should see "Halo Reach: Admin"
      And I should find a button called "Update"
