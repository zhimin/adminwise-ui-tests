# begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end 

Given /^I am on Home Page$/ do
  begin;  @browser.find_element(:link_text, "logout").click; rescue => e; end
  @browser.navigate.to($base_url)
  @home_page = HomePage.new(@browser)
end

Given /^I have entered password (\w+) on login page$/ do |password|
  @home_page.enter_password(password)
end

Given /^I have entered userame (\w+) on login page$/ do |username|
  @home_page.enter_login(username)
end

When /^I press '([^"]*)' button$/ do |button_name|
  if button_name == 'Log in'
    @home_page.click_login
  end 
end

Then /^the text (.*) should be on the screen$/ do |message|
  assert(@browser.page_source.include?(message))
end
