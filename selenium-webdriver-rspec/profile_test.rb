load File.dirname(__FILE__) + '/test_helper.rb'

describe "User Profile" do
  include TestHelper

  before(:all) do
    @browser = Selenium::WebDriver.for(browser_type)
    @browser.navigate.to($BASE_URL)
    reset_database
    fail_safe{ logout }
  end

  after(:all) do
    fail_safe { logout } unless debugging?
    @browser.quit unless debugging?
  end

  it "[481] User can change password" do
    login_as("bob", "test")
    @browser.find_element(:link_text, "profile").click # NOTES [Watir] 'Profile'
    @browser.find_element(:link_text, "Change password").click
    
    password_change_page = PasswordChangePage.new(@browser)
    password_change_page.enter_current("password")
    password_change_page.enter_new("newpass")
    password_change_page.enter_confirm("newpass2")
    password_change_page.click_change
    
    @browser.page_source.should include("Password doesn't match confirmation")
    password_change_page.enter_confirm("newpass")
    password_change_page.click_change

    logout
    login_as("bob", "newpass")
    assert_link_present_with_text("profile") # login Ok
  end

end
