Feature: Admin
   Scenario: Admin page should have the correct title
      When I go to the admin page
      Then I should see "Halo Reach: Admin"

   Scenario: Update button is disabled when a job is already running
      When I go to the admin page
      Then I should see "Not started"
      And I should find a button called "Update"

   Scenario: Status indicates that job is already running when a job is already running
      Given a job is already running
      When I go to the admin page
      Then I should see "Running"

   Scenario: Update button is disabled when a job is already running
      Given a job is already running
      When I go to the admin page
      Then I should find a disabled button called "Update"
