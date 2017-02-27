load File.dirname(__FILE__) + '/test_helper.rb'

describe "Event Registrations as Admin" do
  include TestHelper

  before(:all) do
    @browser = $browser =  Selenium::WebDriver.for(browser_type)
    @browser.navigate.to($TESTWISE_PROJECT_BASE_URL || $BASE_URL)
    @browser.manage().window().resize_to(browser_width, browser_height)
    reset_database
    fail_safe{ logout }
    login_as("bob")
  end

  before(:each) do
    visit "/"
    @browser.find_element(:link_text, "Events").click
    event_list_page = EventListPage.new(@browser)
    @browser.find_element(:link_text, "Wise Testing Conference").click
  end

  after(:each) do
    fail_safe { logout } unless debugging?
  end

  after(:all) do
    @browser.quit unless debugging?
  end

  it "[12] Admin User can register on behalf someone" do
    @browser.find_element(:link_text, "Register on applicant's behalf").click
    event_registration_page = EventRegistrationPage.new(@browser)
    event_registration_page.select_is_member("yes")
    sleep 0.5
    event_registration_page.enter_member_id("30002")
    event_registration_page.enter_member_surname("Smith")
    event_registration_page.click_find
    sleep 1
    event_registration_page.click_register
    try_until(3) {@browser.page_source.should include("Address line1 can't be blank")}
    @browser.find_element(:name, "person[address_line1]").send_keys("10 Pember St")
    event_registration_page.click_register

    @browser.find_element(:id, "confirmBtn").click
    @browser.page_source.should include("has been received.")
    # TODO: using text version is better here
    # @browser.page_source.should include("Your registration for ABIQ 2011 Autism Conference has been received")
  end

#  it "Admin user can register a staff " do
#    @browser.find_element(:link_text, "Register staff")
#  end


end
