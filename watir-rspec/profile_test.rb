load File.dirname(__FILE__) + '/test_helper.rb'

specification "User Profile" do
  include TestHelper

  before(:all) do
    @driver = Watir::Browser.new
    reset_database
    begin; logout;  rescue => e; end
  end

  after(:all) do
    begin; logout;  rescue => e; end  unless debugging?
    close_browser unless debugging?
  end

  story "[481] User can change password" do
    login_as("bob", "test")
    @driver.link(:text, "Profile").click    
    @driver.link(:text, "Change password").click    
    
    password_change_page =  PasswordChangePage.new(@driver)
    password_change_page.enter_current("password")
    password_change_page.enter_new("newpass")
    password_change_page.enter_confirm("newpass2")
    password_change_page.click_change
    
    @driver.text.should include("Password doesn't match confirmation")
    password_change_page.enter_confirm("newpass")
    password_change_page.click_change

    logout
    login_as("bob", "newpass")
    assert_link_present_with_text("Profile") # login Ok
  end

end
