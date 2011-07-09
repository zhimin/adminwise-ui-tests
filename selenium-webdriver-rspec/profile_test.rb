load File.dirname(__FILE__) + '/test_helper.rb'

specification "User Profile" do
  include TestHelper

  before(:all) do
    @driver = Selenium::WebDriver.for(:ie) 
    @driver.navigate.to($ITEST2_PROJECT_BASE_URL || $BASE_URL)
    reset_database
    fail_safe{ logout }
  end

  after(:all) do
    fail_safe { logout } unless debugging?
    @driver.quit unless debugging?
  end

  story "[481] User can change password" do
    login_as("bob", "test")
    @driver.find_element(:link_text, "profile").click # NOTES [Watir] 'Profile'
    @driver.find_element(:link_text, "Change password").click
    
    password_change_page = PasswordChangePage.new(@driver)
    password_change_page.enter_current("password")
    password_change_page.enter_new("newpass")
    password_change_page.enter_confirm("newpass2")
    password_change_page.click_change
    
    @driver.page_source.should include("Password doesn't match confirmation")
    password_change_page.enter_confirm("newpass")
    password_change_page.click_button("Change")

    logout
    login_as("bob", "newpass")
    assert_link_present_with_text("Profile") # login Ok
  end

end
