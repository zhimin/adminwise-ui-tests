# Enter your step denfitions below

# Once you created the step skeleton (right mouse click from feature file),
# add test steps like below:
#  @browser.link(:text, "Start here").click
# Then perform refactorings to extract the steps into Page Objects.

Given /^I login as "(.*)" and on Control Panel page then on manage user page$/ do |username|
  begin;  logout; rescue => e; end
  @browser.goto($base_url)
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

When /^I enter username "(.*)"$/ do |username|
  @browser.text_field(:id, "username").set("KDay")
  @browser.text_field(:id, "email").set("kellyD@gmail.com")
  @browser.text_field(:id, "password").set("letme")
  @browser.button(:value,"Create User").click
 
end



Then /^I can click link "(.*)" in Users$/ do |link|
   @browser.link(:text, "KDay").click

end