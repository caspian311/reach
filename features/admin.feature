@ignore
Feature: Admin
   Scenario: Admin page should have the correct title
      When I go to the admin page
      Then I should see "Halo Reach: Admin"

   Scenario: Update button is disabled when a job is already running
      When I go to the admin page
      Then I should find a button called "Run update"

   Scenario: Status indicates that job is already running when a job is already running
      Given a job is already running
      When I go to the admin page
      Then I should see "Running"

   Scenario: Status indicates that job is already running when a job is already running
      Given no previous jobs were run
      When I go to the admin page
      Then I should see "There are no previously run jobs."

   Scenario: Update button is disabled when a job is already running
      Given a job is already running
      When I go to the admin page
      Then I should find a disabled button called "Run update"
