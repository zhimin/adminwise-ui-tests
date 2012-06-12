load File.dirname(__FILE__) + '/test_helper.rb'

describe "User Management" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new(browser_type)
    failsafe{ logout }
    reset_database
  end

  after(:each) do
   failsafe{ logout  }unless debugging?
  end

  after(:all) do
    @browser.close unless debugging?
  end

  it "[480] A registered user can login" do
    login_as("bob", "test")
    logout    
  end

  it "[480] Admin user can login" do
    login_as("admin", "test")
    assert_link_present_with_text("Control Panel")
  end

  it "[480] Admin user can login - invalid password" do
    login_as("admin", "badpass")
    @browser.text.should include("Invalid password")
  end

  it "[480] Admin user can login - try go the protected url" do
    visit "/events"
    sleep 1
    @browser.text.should include("Not logged in")
  end
  
end
