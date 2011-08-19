#begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end 
#require 'cucumber/formatter/unicode'

Given /^I login as "(\w+)" and on Password Change Page$/ do |username|
  begin;  logout; rescue => e; end
  @browser.navigate.to($BASE_URL)
  home_page = HomePage.new(@browser)
  home_page.enter_login(username)
  home_page.enter_password("test")
  home_page.click_login
  @browser.find_element(:link_text, "profile").click
  @browser.find_element(:link_text, "Change password").click        
  @password_change_page = PasswordChangePage.new(@browser)
  # @password_change_page = Object.const_get(page_name.gsub(" ","")).new(@browser)
end

When /^I enter current password "([^"]*)"$/ do |term|
  @password_change_page.enter_current term
end


Then /^I can relogin as "(\w+)" with new password "([^"]*)"$/ do |username, new_pass|
  logout
  home_page = HomePage.new(@browser)
  home_page.enter_login(username)
  home_page.enter_password(new_pass)
  home_page.click_login
  @browser.find_element(:link_text, "profile").click
end

Then /^I should get error "([^"]*)"$/ do |message|
  assert @browser.page_source.include?(message)
end


When /^enter new password "([^"]*)"$/ do |new_pass|
  @password_change_page.enter_new  new_pass  
end

When /^enter confirmation "([^"]*)"$/ do |confirm_password|
  @password_change_page.enter_confirm(confirm_password)
end

When /^I click change$/ do
  @password_change_page.click_change
end


def logout
  @browser.find_element(:link_text, "logout").click
end
