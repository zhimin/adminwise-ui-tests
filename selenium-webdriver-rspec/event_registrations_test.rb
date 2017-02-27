load File.dirname(__FILE__) + '/test_helper.rb'

$pending_count = 1

describe "Event Registrations" do
  include TestHelper

  before(:all) do
    @browser = $browser = Selenium::WebDriver.for(browser_type) 
    @browser.navigate.to($TESTWISE_PROJECT_BASE_URL || $BASE_URL)
    @browser.manage().window().resize_to(browser_width, browser_height)
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
    @browser.quit unless debugging?
  end

  it "[10] User can sign up for events - member - populate info" do
    visit "/events/register/2"
    event_registration_page =  EventRegistrationPage.new(@browser)
    event_registration_page.select_is_member("yes")
    try_until(10) { event_registration_page.enter_member_id("30002") }
    event_registration_page.enter_member_surname("Smith")
    event_registration_page.click_find
    sleep 3
    event_registration_page.click_register
    @browser.page_source.should include("Address line1 can't be blank")
    @browser.find_element(:name, "person[address_line1]").send_keys("10 Pember St")
    event_registration_page.click_register
    event_registration_confirmation_page = EventRegistrationConfirmationPage.new(@browser)
    event_registration_confirmation_page.click_confirm
    sleep 1
    @browser.page_source.should include("has been received")
    # use this global variable to detect this test has been run or not
    $pending_count += 1
  end

  it "[11] User can sign up for events - non member" do
    visit "/events/register/2"

    #    click_radio_option("payment_via_eft", "yes")
    event_registration_page = EventRegistrationPage.new(@browser)
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
    # Element is not currently interactable and may not be manipulated
    # event_registration_page.uncheck_checkbox_registration_email_notificaton
    event_registration_page.click_register
    event_registration_confirmation_page = EventRegistrationConfirmationPage.new(@browser)

    event_registration_confirmation_page.click_confirm
    sleep 1 # NOTE: sometimes selenium-wedriver too fast still get last page's source
    @browser.page_source.should include("has been received")

    visit "/"
    # refresh
    login_as("admin")
    @browser.find_element(:link_text, "Events").click
    @browser.find_element(:link_text, "CITCON 2011").click
    sleep 0.5
    @browser.find_element(:link_text, "Pending (#{$pending_count})").click
    @browser.page_source.should include("Eileen Fa")
  end


end
