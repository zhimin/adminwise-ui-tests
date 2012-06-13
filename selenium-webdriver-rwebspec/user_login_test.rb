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
    close_browser unless debugging?
  end

  story "[480] A registered user can login" do
    login_as("bob", "test")
    assert_link_present_with_text("Membership")
  end

  story "[480] Admin user can login" do
    login_as("admin", "test")
    assert_link_present_with_text("Administration")
  end

  story "[480] Admin user can login - invalid password" do
    login_as("admin", "badpass")
    page_text.should contain("Invalid password")
  end

  story "[480] Admin user can login - try go the protected url" do
    visit "/events"
    sleep 1
    page_text.should contain("Not logged in")
  end
  
end
