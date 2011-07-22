Feature: Authentication
  As a registered user
  I want to login

  Scenario Outline: User Login
    Given I have entered username <username> on login page
    And I have entered password <password> on login page
    When I press "Log in" button
    Then the text <expected_text> should be on the screen

  Scenarios:
    | username | password | expected_text|
    | admin    | test     | Control Panel|
    | bob      | test     | Profile      |
    | bob      | badpass  | Invalid email or password.|
