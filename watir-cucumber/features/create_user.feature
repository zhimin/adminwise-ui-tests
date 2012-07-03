Feature: Create a new user
  As an admin
  I want to create a new user

Scenario: Admin can create a new user
  Given I login as "admin" and on manage user page
  And I click link "Add user"
  And I enter username "KDay" and email "kellyD@gmail.com" and enter password "letme" then I click "Create"
  Then I can click link "KDay" in Users
