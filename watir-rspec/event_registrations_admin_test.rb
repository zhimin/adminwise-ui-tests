load File.dirname(__FILE__) + '/test_helper.rb'

test_suite "Event Registrations as Admin" do
  include TestHelper

  before(:all) do
    @driver = Watir::Browser.new
    reset_database
    logout
    login_as("admin")
  end

  before(:each) do
    visit "/home"
    @driver.link(:text, "Events").click
    event_list_page = EventListPage.new(@driver)
    @driver.link(:text, "ABIQ 2011 Autism Conference").click
  end

  after(:each) do
    logout  unless debugging?
  end

  after(:all) do
    # close_browser if is_windows? and is_firefox?
  end

  test "[483] Admin User can register on behalf someone" do
    @driver.link(:text, "Register on applicant's behalf").click
    event_registration_page = EventRegistrationPage.new(@driver)
    event_registration_page.select_is_member("yes")
    sleep 0.5
    event_registration_page.enter_member_id("30002")
    event_registration_page.enter_member_surname("Smith")
    event_registration_page.click_find
    sleep 1
    event_registration_page.click_register
    @driver.text.should contain("Address line1 can't be blank")
    @driver.text_field(:name, "person[address_line1]").set "10 Pember St"
    event_registration_page.click_register

    @driver.button(:value, "Confirm").click
    @driver.text.should include("Your registration for ABIQ 2011 Autism Conference has been received")
  end

#  test "Admin user can register a staff " do
#    @driver.link(:text,"Register staff")
#  end


end
