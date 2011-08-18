load File.dirname(__FILE__) + '/test_helper.rb'

specification "User Management" do
  include TestHelper

  before(:all) do
    open_browser
    failsafe{ logout }
    reset_database
  end

  after(:each) do
    failsafe{ logout } unless debugging?
  end

  after(:all) do
    # close_browser if is_windows? and is_firefox?
  end

  story "[1] A registered user can login" do
    login_as("bob", "test")
    assert_link_present_with_text("Logout")
  end

  story "[27] Admin user can login" do
    login_as("admin", "test")
    assert_link_present_with_text("Control Panel")
  end

  story "[28] Anonymous user cannot login - invalid password" do
    login_as("admin", "badpass")
    page_text.should contain("Invalid email or password.")
  end

  story "[29] Anonymous user cannot login - try go the protected url directly" do
    visit "/events"
    #sleep 1
    page_text.should contain("You need to sign in or sign up before continuing.")
  end
  
end
