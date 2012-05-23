# Enter your step denfitions below

# Once you created the step skeleton (right mouse click from feature file),
# add test steps like below:
#  @browser.link(:text, "Start here").click
# Then perform refactorings to extract the steps into Page Objects.

Given /^I login as "(.*)" and on Control Panel page then on manage user page$/ do |username|
  begin;  logout; rescue => e; end
  @browser.goto($BASE_URL)
  home_page = HomePage.new(@browser)
  home_page.enter_login(username)
  home_page.enter_password("test")
  home_page.click_login
  sleep 2
  @browser.link(:text, "Control Panel").click
  @browser.link(:text, "Manage Users").click        
  
end

When /^I click link "(.*)"$/ do |link|
  @browser.link(:text, link).click
end


Then /^I can click link "(.*)" in Users$/ do |link|
   @browser.link(:text, link).click
end

Given /^I enter username "(.*?)" and email "(.*?)" and enter password "(.*?)" then I click "(.*?)"$/ do |username, email, password, create_button_text|
  debug("Enter user '#{username}'")
  @browser.text_field(:id, "username").set(username)
  @browser.text_field(:id, "email").set(email)
  @browser.text_field(:id, "password").set(password)
  @browser.button(:value, create_button_text).click 
end