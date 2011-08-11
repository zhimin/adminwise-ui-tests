Feature: Add a new member
  In order to value
  As an admin
  I want to add a new member

Scenario: Admin can add a new member
  Given I login as "admin" and on membership page and on add member page
  And I enter firstname "Joy" and last name"Lin" and enter address as "4 Samual Street", suburb "Toombul", state as "QLD" and postcode as "4011"
#  And I enter phone "3765 4321"
#  And I choose member type as "student" and "yes" to mail out and aware of from "conference/workshop"
#  And I click button "Create Member"

#  Then I can click link "Joy Lin" in Membership list

