load File.dirname(__FILE__) + '/test_helper.rb'

$pending_count = 1

test_suite "Event Registrations" do
  include TestHelper

  before(:all) do
    @driver = Selenium::WebDriver.for(:ie) 
    @driver.navigate.to($ITEST2_PROJECT_BASE_URL || $BASE_URL)
    reset_database
    fail_safe { logout }
    $pending_count = 1 # default
  end

  before(:each) do
  end

  after(:each) do
    fail_safe { logout } unless debugging?
  end

  after(:all) do
    @driver.quit unless debugging?
  end

  test "[485] User can sign up for events - member - populate info" do
    visit "/events/register/2"
    event_registration_page =  EventRegistrationPage.new(@driver)
    event_registration_page.select_is_member("yes")
    try { event_registration_page.enter_member_id("30002") }
    event_registration_page.enter_member_surname("Smith")
    event_registration_page.click_find
    sleep 3
    event_registration_page.click_register
    @driver.page_source.should include("Address line1 can't be blank")
    @driver.find_element(:name, "person[address_line1]").send_keys("10 Pember St")
    event_registration_page.click_register
    event_registration_confirmation_page = EventRegistrationConfirmationPage.new(@driver)
    event_registration_confirmation_page.click_confirm
    @driver.page_source.should include("Your registration for CITCON 2011 has been received")
    # use this global variable to detect this test has been run or not
    $pending_count += 1
  end

  test "[486] User can sign up for events - non member" do
    visit "/events/register/2"

    #    click_radio_option("payment_via_eft", "yes")
    event_registration_page = EventRegistrationPage.new(@driver)
    event_registration_page.select_is_member("no")
    event_registration_page.enter_person_title("Mr")
    event_registration_page.enter_first_name("Eileen")
    event_registration_page.enter_last_name("Fa")
    event_registration_page.enter_organisation("Agileway")
    event_registration_page.select_person_occupation("Occupational therapist")
    event_registration_page.enter_person_email("eileen.fa@gmail.com")
    event_registration_page.enter_person_phone("30087998")
    event_registration_page.enter_address_line1("10 Pember St")
    event_registration_page.enter_person_suburb("Brisbane")
    event_registration_page.enter_postcode("4000")
    event_registration_page.uncheck_checkbox_registration_email_notificaton
    event_registration_page.click_register
    event_registration_confirmation_page = EventRegistrationConfirmationPage.new(@driver)
    event_registration_confirmation_page.click_confirm
    @driver.page_source.should include("Your registration for CITCON 2011 has been received")

    visit "/"
    refresh
    login_as("admin")
    @driver.find_element(:link_text, "Events").click
    @driver.find_element(:link_text, "CITCON 2011").click
    @driver.find_element(:link_text, "Pending #{$pending_count}").click
    @driver.page_source.should include("Eileen Fa")
  end


end
