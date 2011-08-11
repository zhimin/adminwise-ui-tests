# Enter your step denfitions below

# Once you created the step skeleton (right mouse click from feature file),
# add test steps like below:
#  @browser.link(:text, "Start here").click
# Then perform refactorings to extract the steps into Page Objects.

Given /^I login as "(.*)" and on membership page and on add member page$/ do |username|
  begin;  logout; rescue => e; end
  @browser.goto($base_url)
  home_page = HomePage.new(@browser)
  home_page.enter_login(username)
  home_page.enter_password("test")
  home_page.click_login
  sleep 2
  @browser.link(:text, "Membership").click
  @browser.link(:text, "Add member").click
end


When /^I enter firstname "(.*)" and lastname "(.*)" and street address "(.*)"and suburb "(.*)"and state "(.*))"and postcode "(.*)"$/ do |fname,lname,member_street_addr,member_state,member_postcode|
  @browser.text_field(:id, "member_fname").set member_fname
  @browser.text_field(:id, "member_lname").set member_lname)
  @browser.text_field(:id, "member_street_addr").set member_street_addr
  @browser.text_field(:id, "member_suburb").set member_suburb
  @browser.text_field(:id, "member_state").set member_state
  @browser.text_field(:id, "member_postcode").set member_postcode

end
#When /^I enter firstname "(.*)"and lastname "(.*)" and street address "(.*)"and suburb "(.*)"and state "(.*))"and postcode "(.*)"$/ do |fname,lname,member_street_addr,member_state,member_postcode|
#  @browser.text_field(:id, "member_fname").set member_fname
#  @browser.text_field(:id, "member_lname").set member_lname)
#  @browser.text_field(:id, "member_street_addr").set member_street_addr
#  @browser.text_field(:id, "member_suburb").set member_suburb
#  @browser.text_field(:id, "member_state").set member_state
#  @browser.text_field(:id, "member_postcode").set member_postcode
#
#end




# I want enter some text in phone number field
# There are many text boxes on the page???
# I want identify the which text box
# I know text box can be identified about name or id
# in this exmale, from recorder, it use text_field(:id, "member_phone")
# Now I get hold of the element
# I set text in the element .set("xxxx")
# use what use entered in feature file .. I enter phone "1234"
# element .set(member_phone) # member_phone is arguments, in this case is 1234
#When /^I enter phone "(.*)"$/ do |member_phone|
#  @browser.text_field(:id, "member_phone").set member_phone
#end
#
#
#
#When /^I choose member type as "(.*)" and "(.*)" to mail out and aware of from "(.*)"$/ do |member_type, mail_out, heard_from|
#  @browser.radio(:id, "member_member_type_#{member_type}").set
#  @browser.radio(:id, "member_mail_out_true").set if mail_out == "yes"
#  @browser.select_list(:id, "member_aware_from").set(heard_from)
#end


#When /^I click button "(.*)"$/ do |button_text|
#  @browser.button(:value, button_text).click
#end


#Then /^I can click link "(.*)" in Membership list$/ do |link|
#   @browser.link(:text, "Joy Lin").click
#end




#end


