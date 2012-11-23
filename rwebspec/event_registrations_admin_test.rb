load File.dirname(__FILE__) + '/test_helper.rb'

test_suite "Event Registrations as Admin" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
    login_as("bob")
  end

  before(:each) do
    visit "/"
    click_link("Events")
  end

  after(:each) do
  end

  after(:all) do
    close_browser unless debugging?
  end

  test "[483] Admin User can register on behalf someone, then process with payment" do
        event_list_page = expect_page EventListPage
    click_link("Wise Testing Conference")
    click_link("Register on applicant's behalf")
    event_registration_page = expect_page EventRegistrationPage
    event_registration_page.select_is_member("yes")
    try(3) { event_registration_page.enter_member_id("30002") }
    event_registration_page.enter_member_surname("Smith")
    event_registration_page.click_find
    sleep 1
    event_registration_page.click_register
    page_text.should contain("Address line1 can't be blank")
    enter_text("person[address_line1]", "10 Pember St")
    event_registration_page.click_register

    click_button("Confirm")
    page_text.should include("Your registration for Wise Testing Conference has been received")
    
    goto_page("/events/1")
    event_page = expect_page EventPage
    click_link("DS0001")
    process_registration_page = expect_page ProcessRegistrationPage
    process_registration_page.enter_amount("200")
    process_registration_page.select_payment_method("Cash")
    process_registration_page.enter_invoice("123")
    process_registration_page.enter_receipt("DS9999")
    process_registration_page.enter_comments("Yes")
    process_registration_page.click_accept_payment
    event_page = expect_page EventPage
    click_link("Processed (1)")
    click_link("DS0001")
    page_text.should contain("Payments received")
  end

  test "[483] Admin user process registration for free events" do
    event_list_page = expect_page EventListPage
    click_link("CITCON 2011")
    click_link("Register on applicant's behalf")
    event_registration_page = expect_page EventRegistrationPage
    page_text.should contain("Free")
    event_registration_page.select_is_member("yes")
    try(3) { event_registration_page.enter_member_id("30002") }
    event_registration_page.enter_member_surname("Smith")
    event_registration_page.click_find
    sleep 1
    enter_text("person[address_line1]", "10 Pember St")
    event_registration_page.click_register

    click_button("Confirm")
    page_text.should include("Your registration for")
    
    goto_page("/events/2")
    event_page = expect_page EventPage
    begin
      click_link("DS0001") # when run individually
    rescue 
      click_link("DS0002") # if running test file
    end
    process_registration_page = expect_page ProcessRegistrationPage
    process_registration_page.click_activate
 
    event_page = expect_page EventPage
    click_link("Processed (1)")
    begin
      click_link("DS0001") # when run individually
    rescue 
      click_link("DS0002") # if running test file
    end
    
    shall_not_allow { click_button("Activate") }
  end

  test "Admin user can register a staff (and process) " do
    event_list_page = expect_page EventListPage
    click_link("Wise Testing Conference")
    click_link("Register staff")
    register_staff_page = expect_page RegisterStaffPage
    register_staff_page.enter_title("Mr")
    register_staff_page.enter_first_name("James")
    register_staff_page.enter_last_name("Bond")
    register_staff_page.select_occupation("Psychologist")
    register_staff_page.enter_email("james@008.com")
    register_staff_page.enter_phone("3333444")
    register_staff_page.enter_address_line1("8 Lucky Street")
    register_staff_page.enter_suburb("London")
    register_staff_page.enter_state("QLD")
    register_staff_page.enter_postcode("4000")
    register_staff_page.enter_country("Australia")
    register_staff_page.check_dieatry_gluten_free
    register_staff_page.select_level("Speaker")
    register_staff_page.click_register
    click_link("Manage registrations")
    event_page = expect_page EventPage
    click_link("Staff (1)")
    page_text.should contain("James Bond")
  end

end
