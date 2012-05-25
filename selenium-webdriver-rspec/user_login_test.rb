load File.dirname(__FILE__) + '/test_helper.rb'

describe "User Management" do
  include TestHelper

  before(:all) do
    @browser = Selenium::WebDriver.for(browser_type)
    @browser.navigate.to($BASE_URL)
    fail_safe{ logout }
    reset_database
  end

  after(:each) do
    logout
  end

  after(:all) do
    @browser.close unless debugging?
  end

  it "[480] A registered user can login" do
    login_as("bob", "test")
    assert_link_present_with_text("logout") # NOTE [Watir] link shown as Logout
  end

  it "[480] Admin user can login" do
    login_as("admin", "test")
    assert_link_present_with_text("control panel") # NOTE [Watir] link shown as Control Panel
  end

  it "[480] Admin user can login - invalid password" do
    login_as("admin", "badpass")
    @browser.page_source.should include("Invalid email or password.")
  end

  it "[480] Admin user can login - try go the protected url" do
    visit "/events"
    sleep 1
    @browser.page_source.should include("You need to sign in or sign up before continuing.")
  end
  
end
