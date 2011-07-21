Given /^I am on the (.+)$/ do |page_name|
  login_as("bob", "test")
  @browser.link(:text, "Profile").click
  @browser.link(:text, "Change password").click
        
  @password_change_page = Object.const_get(page_name.gsub(" ","")).new(@browser)
end

When /^I enter current password "([^"]*)"$/ do |term|
  @password_change_page.enter_current term
end

When /^enter new password "(\w+)"$/ do |new_pass|
    @password_change_page.enter_new new_pass
end

When /^enter confirmation "(\w+)"$/ do |confirm|
    @password_change_page.enter_confirm(confirm)
end

When /^I click change$/ do
    @password_change_page.click_change
end

Then /^I can relogin with new password "([^"]*)"$/ do |new_pass|
  logout
  login_as("bob", new_pass)  
  @browser.link(:text, "Profile").click
end

Then /^I should get error "([^"]*)"$/ do |message|
  raise "Expected text '#{message}' not found" unless @browser.text.include?(message)
end


def logout
  @browser.link(:text, "Logout").click;
end

def login_as(username, password = "test")
  home_page = HomePage.new(@browser)
  home_page.enter_login(username)
  home_page.enter_password(password)
  home_page.click_login
end
alias login login_as