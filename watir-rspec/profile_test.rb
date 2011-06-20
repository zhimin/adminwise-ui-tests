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
    # close_browser if is_windows? and is_firefox?
  end

  story "[481] User can change password" do
    login_as("bob", "test")
    link(:text, "Profile").click    
    link(:text, "Change password").click    
    
    password_change_page =  PasswordChangePage.new(@driver)
    password_change_page.enter_current("password")
    password_change_page.enter_new("newpass")
    password_change_page.enter_confirm("newpass2")
    password_change_page.click_button("Change")
    
    @driver.text.should contain("Password doesn't match confirmation")
    password_change_page.enter_confirm("newpass")
    password_change_page.click_button("Change")

    logout
    login_as("bob", "newpass")
    assert_link_present_with_text("Profile") # login Ok
  end

end
