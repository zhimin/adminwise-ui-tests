begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end 

Given /I have entered username (\w+) on login page/ do |username|
  @browser.text_field(:name, "user[username]").set username
end

Given /I have entered password (\w+) on login page/ do |password|
  @browser.text_field(:name, "user[password]").set password
end

When /^I press "([^"]*)" button$/ do |button_name|
  if button_name == "Log in"
    @browser.button(:value, "Log in").click
  end 
end

Then /^the text (.*) should be on the screen$/ do |message|
  @browser.text.include?(message).should be_true
end
