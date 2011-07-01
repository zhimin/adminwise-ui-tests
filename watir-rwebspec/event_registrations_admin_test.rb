load File.dirname(__FILE__) + '/test_helper.rb'

test_suite "Event Registrations as Admin" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
    login_as("admin")
  end

  before(:each) do
    visit "/home"
    click_link("Events")
    event_list_page = expect_page EventListPage
    click_link("ABIQ 2011 Autism Conference")
  end

  after(:each) do
    #fail_safe { logout } unless debugging?

  end

  after(:all) do
    # close_browser if is_windows? and is_firefox?
  end

  test "[483] Admin User can register on behalf someone" do
    click_link("Register on applicant's behalf")
    event_registration_page = expect_page EventRegistrationPage
    event_registration_page.select_is_member("yes")
    sleep 0.5
    event_registration_page.enter_member_id("30002")
    event_registration_page.enter_member_surname("Smith")
    event_registration_page.click_find
    sleep 1
    event_registration_page.click_register
    page_text.should contain("Address line1 can't be blank")
    event_registration_page.enter_address_line1("10 Pember St")
    event_registration_page.click_register
    page_text.should include("Confirm your registration details")
    click_button("Confirm")
    page_text.should include("Your registration for ABIQ 2011 Autism Conference has been received")
  end

  test "[498]Admin user can register a staff " do
    click_link("Register staff")
    register_speakers_page = expect_page RegisterSpeakersPage
    register_speakers_page.enter_title("Mrs")
    register_speakers_page.enter_first_name("Lianne")
    register_speakers_page.enter_last_name("Kerr")
    register_speakers_page.enter_organisation("ABIQ")
    register_speakers_page.select_occupation("Parent of ASD child")
    register_speakers_page.enter_email("lkerr2@eq.edu.au")
    register_speakers_page.enter_phone("0414 756 436")
    register_speakers_page.enter_address_line1("8/34 Down Road")
    register_speakers_page.enter_suburb("Kuraby")
    register_speakers_page.enter_state("QLD")
    register_speakers_page.enter_postcode("4013")
    register_speakers_page.enter_country("Australia")
    register_speakers_page.check_day_1
    register_speakers_page.select_level("Volunteer")
    register_speakers_page.click_register
    page_text.should include("Staff registration details confirmation")
  end

end
