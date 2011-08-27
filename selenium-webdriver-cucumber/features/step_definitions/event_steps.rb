# steps for event steps   
Given /^I logged in$/ do
  begin;  logout; rescue => e; end
  @browser.navigate.to($BASE_URL)
  home_page = HomePage.new(@browser)
  home_page.enter_login("bob")
  home_page.enter_password("test")
  home_page.click_login
end

When /^click link "([^"]*)"$/ do |arg1|
  @browser.find_element(:link_text, "EVENTS").click
  event_list_page =  EventListPage.new(@browser)
  @event_page = event_list_page.click_new
end

When /^enter event name and details$/ do
  @event_page.enter_name("ABA Workshop")
  @event_page.enter_venue("QUT")
  @event_page.enter_presenters("Many")
  @event_page.enter_date("10/12/2010")
end

When /^I click "([^"]*)"$/ do |arg1|
  @event_page.click_create
end

Then /^I shall see the new event shown in the list$/ do
  assert @browser.page_source.include?("3 events")
end
