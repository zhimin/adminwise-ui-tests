Feature: Create a new user
  In order to value
  As an admin
  I want to create a new user

Scenario: Admin can create a new user
  Given I login as "admin" and on Control Panel page then on manage user page
  And I click link "Add new user"
  And I enter username "KDay" and email "kellyD@gmail.com" and enter passwork "letme" then I click "Create User"
  Then I can click link "KDay" in Users
