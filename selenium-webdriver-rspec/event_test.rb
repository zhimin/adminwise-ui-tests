load File.dirname(__FILE__) + '/test_helper.rb'

describe "Events" do
  include TestHelper

  before(:all) do
    @browser = Selenium::WebDriver.for(browser_type)
    @browser.navigate.to($BASE_URL)
    reset_database
    fail_safe{ logout }
    login_as("admin")
  end


  before(:each) do
    visit "/"
    @browser.find_element(:link_text, "EVENTS").click
  end

  after(:all) do
    logout unless debugging?
    @browser.quit unless debugging?
  end

  # Press key Ctrl+Shift+T, then enter 123 quickly navigate you here
  it "[487] Can create a new event" do
    event_list_page =  EventListPage.new(@browser)
    event_page = event_list_page.click_new
    event_page.enter_name("ABA Workshop")
    event_page.enter_venue("QUT")
    event_page.enter_presenters("Many")
    event_page.enter_date("10/12/2010")
    event_page.click_create
    @browser.page_source.should include("3 events")
  end

  it "[488] Can edit an existing event" do
    event_list_page = EventListPage.new(@browser)
    event_page = event_list_page.edit(1)
    event_page.enter_name("2010 Agileway Testing Conference")
    event_page.click_update
    @browser.page_source.should include("2010 Agileway Testing Conference")
  end


end