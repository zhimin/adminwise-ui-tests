Feature: Event
  As a role
  I want to create or manage events

  Scenario: I can create a new event
    Given I logged in
    When click link "New Event"
    And enter event name and details
    When I click "Create"
    Then I shall see the new event shown in the list
  
  
