load File.dirname(__FILE__) + '/test_helper.rb'

$pending_count = 1

test_suite "Event Registrations" do
  include TestHelper

  before(:all) do
    @driver = Watir::Browser.new
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
    # close_browser if is_windows? and is_firefox?
  end

  test "[485] User can sign up for events - member - populate info" do
    visit "/events/register/2"
    event_registration_page = expect_page EventRegistrationPage
    event_registration_page.select_is_member("yes")
    sleep 0.5
    event_registration_page.enter_member_id("30002")
    event_registration_page.enter_member_surname("Smith")
    event_registration_page.click_find
    sleep 3
    event_registration_page.click_register
    @driver.text.should contain("Address line1 can't be blank")
    enter_text("person[address_line1]", "10 Pember St")
    event_registration_page.click_register
    event_registration_confirmation_page = expect_page EventRegistrationConfirmationPage
    event_registration_confirmation_page.click_confirm
    @driver.text.should include("Your registration for CITCON 2011 has been received")
    # use this global variable to detect this test has been run or not
    $pending_count += 1
  end

  test "[486] User can sign up for events - non member" do
    visit "/events/register/2"

    #    click_radio_option("payment_via_eft", "yes")
    event_registration_page = expect_page EventRegistrationPage
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
    event_registration_confirmation_page = expect_page EventRegistrationConfirmationPage
    event_registration_confirmation_page.click_confirm
    @driver.text.should include("Your registration for CITCON 2011 has been received")

    visit "/"
    refresh
    login_as("admin")
    click_link("Events")
    click_link("CITCON 2011")
    click_link("Pending #{$pending_count}")
    @driver.text.should contain("Eileen Fa")
  end


end
