load File.dirname(__FILE__) + '/test_helper.rb'

describe "Event Registrations as Admin" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new
    reset_database
    logout
    login_as("admin")
  end

  before(:each) do
    visit "/home"
    @browser.link(:text, "Events").click
    event_list_page = EventListPage.new(@browser)
    @browser.link(:text, "Wise Testing Conference").click
  end

  after(:each) do
    logout  unless debugging?
  end

  after(:all) do
    @browser.close unless debugging?
  end

  it "[483] Admin User can register on behalf someone" do
    @browser.link(:text, "Register on applicant's behalf").click
    event_registration_page = EventRegistrationPage.new(@browser)
    event_registration_page.select_is_member("yes")
    sleep 0.5
    event_registration_page.enter_member_id("30002")
    event_registration_page.enter_member_surname("Smith")
    event_registration_page.click_find
    sleep 1
    event_registration_page.click_register
    @browser.text.should include("Address line1 can't be blank")
    @browser.text_field(:name, "person[address_line1]").set "10 Pember St"
    event_registration_page.click_register

    @browser.button(:value, "Confirm").click
    @browser.text.should include("Your registration for Wise Testing Conference has been received")
  end

#  test "Admin user can register a staff " do
#    @browser.link(:text,"Register staff")
#  end


end
