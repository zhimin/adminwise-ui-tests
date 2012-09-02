
Given /^I am on Home Page$/ do
  begin;
    @browser.find_element(:id, "user_nav_link").click
    sleep 0.5
    @browser.find_element(:id, "sign_out_link").click
  rescue => e; end
  @browser.navigate.to($BASE_URL)
  @home_page = HomePage.new(@browser)
end

Given /^I have entered password (\w+) on login page$/ do |password|
  @home_page.enter_password(password)
end

Given /^I have entered userame (\w+) on login page$/ do |username|
  # debug("enter user '#{username}'") # showing message in TestWise console
  @home_page.enter_login(username)
end

When /^I press '([^"]*)' button$/ do |button_name|
  if button_name == 'Sign in'
    @home_page.click_login
  end
end

Then /^the text (.*) should be on the screen$/ do |message|
  assert(@browser.page_source.include?(message))
end
