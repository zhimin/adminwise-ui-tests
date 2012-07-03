load File.dirname(__FILE__) + '/test_helper.rb'

describe "User Profile" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new
    reset_database
    begin; logout;  rescue => e; end
  end

  after(:all) do
    logout  unless debugging?
    @browser.close unless debugging?
  end

  it "[481] User can change password", :tag => "must" do
    login_as("bob", "test")
    @browser.link(:id, "user_nav_link").click;
    sleep 0.5
    @browser.link(:id, "profile_link").click;

    @browser.link(:text, "Change password").click    
    
    password_change_page = PasswordChangePage.new(@browser)
    password_change_page.enter_current("test")
    password_change_page.enter_new("newpass")
    password_change_page.enter_confirm("newpass2")
    password_change_page.click_change
    
    @browser.text.should include("Password doesn't match confirmation")
    password_change_page.enter_current("test")
    password_change_page.enter_new("newpass")
    password_change_page.enter_confirm("newpass")
    password_change_page.click_change

    logout
    login_as("bob", "newpass")
    @browser.text.should include("Sign in successfully")
  end

end
