load File.dirname(__FILE__) + '/test_helper.rb'

describe "User Profile" do
  include TestHelper

  before(:all) do
    @browser = $browser = Selenium::WebDriver.for(browser_type)
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
    @browser.find_element(:id, "user_nav_link").click 
    sleep 0.5
    @browser.find_element(:id, "profile_link").click 
    @browser.find_element(:link_text, "Change password").click
    
    password_change_page = PasswordChangePage.new(@browser)
    password_change_page.enter_current("test")
    password_change_page.enter_new("newpass")
    password_change_page.enter_confirm("newpass2")
    password_change_page.click_change
    
    @browser.page_source.should include("Password doesn't match confirmation")
    password_change_page.enter_current("test")
    password_change_page.enter_new("newpass")
    password_change_page.enter_confirm("newpass")
    password_change_page.click_change

    logout
    sleep 1
    login_as("bob", "newpass")
    @browser.page_source.should include("Sign in successfully")
  end

end
