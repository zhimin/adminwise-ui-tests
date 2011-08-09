load File.dirname(__FILE__) + '/test_helper.rb'

describe "Event Registrations as Admin" do
  include TestHelper

  before(:all) do
    @driver = Selenium::WebDriver.for(browser_type) 
    @driver.navigate.to($ITEST2_PROJECT_BASE_URL || $BASE_URL)
    reset_database
    fail_safe{ logout }
    login_as("admin")
  end

  before(:each) do
    visit "/home"
    @driver.find_element(:link_text, "EVENTS").click
    event_list_page = EventListPage.new(@driver)
    @driver.find_element(:link_text, "ABIQ 2011 Autism Conference").click
  end

  after(:each) do
    fail_safe { logout } unless debugging?
  end

  after(:all) do
    @driver.quit unless debugging?
  end

  it "[483] Admin User can register on behalf someone" do
    @driver.find_element(:link_text, "Register on applicant's behalf").click
    event_registration_page = EventRegistrationPage.new(@driver)
    event_registration_page.select_is_member("yes")
    sleep 0.5
    event_registration_page.enter_member_id("30002")
    event_registration_page.enter_member_surname("Smith")
    event_registration_page.click_find
    sleep 1
    event_registration_page.click_register
    try(3) {@driver.page_source.should include("Address line1 can't be blank")}
    @driver.find_element(:name, "person[address_line1]").send_keys("10 Pember St")
    event_registration_page.click_register

    @driver.find_element(:id, "confirmBtn").click
    @driver.page_source.should include("has been received.")
    # TODO: using text version is better here
    # @driver.page_source.should include("Your registration for ABIQ 2011 Autism Conference has been received")
  end

#  it "Admin user can register a staff " do
#    @driver.find_element(:link_text, "Register staff")
#  end


end
