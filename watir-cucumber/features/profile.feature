Feature: User Profile
  As a registered user
  I want to update my details

  Scenario: Change password
    Given I am on the Password Change Page
    When I enter current password "test"
    And enter new password "newone"
    And enter confirmation "newone"
    When I click change
    Then I can relogin with new password "newone"
