load File.dirname(__FILE__) + '/test_helper.rb'

describe "User Management" do
  include TestHelper

  before(:all) do
    @browser = Selenium::WebDriver.for(browser_type)
    @browser.navigate.to($TESTWISE_PROJECT_BASE_URL || $BASE_URL)
    @browser.manage().window().resize_to(browser_width, browser_height)
    fail_safe{ logout }
    reset_database
  end

  after(:each) do
    logout
  end

  after(:all) do
    @browser.close unless debugging?
  end

  it "[1] A registered user can login" do
    login_as("bob", "test")
    @browser.page_source.should include("Sign in successfully")
  end

  it "[2] Admin user can login" do
    login_as("admin", "test")
    assert_link_present_with_text("Administration") 
  end

  it "[2] Admin user can login - invalid password" do
    login_as("admin", "badpass")
    @browser.page_source.should include("Invalid password")
  end

  it "[2] Admin user can login - try go the protected url" do
    visit "/events"
    sleep 1
    @browser.page_source.should include("Not logged in")
  end
  
end
