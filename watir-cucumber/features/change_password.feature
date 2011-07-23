Feature: User Profile
  As a registered user
  I want to update my details

  Scenario: Try to change password without valid current password
    Given I login as "bob" and on Password Change Page
    When I enter current password "badpass" # incorrect
    And enter new password "newone"
    And enter confirmation "newone"
    When I click change
    Then I should get error "Current password is invalid"

  Scenario: Change password 
    Given I login as "bob" and on Password Change Page
    When I enter current password "test"
    And enter new password "newone"
    And enter confirmation "newone"
    When I click change
    Then I can relogin as "bob" with new password "newone"
