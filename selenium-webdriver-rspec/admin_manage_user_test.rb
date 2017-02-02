load File.dirname(__FILE__) + '/test_helper.rb'

describe "Create a new user as admin" do
  include TestHelper

  before(:all) do
    # by using browser_type (defined in helper), it can be chosen in TestWise
    @browser = $browser = Selenium::WebDriver.for(browser_type) # or :ie, :firefox, :chrome
    @browser.manage().window().resize_to(browser_width, browser_height)
    @browser.navigate.to($BASE_URL)
    reset_database
    login_as("admin")
  end

  after(:all) do
    logout unless debugging?
    @browser.quit unless debugging?
  end

  it "[482] Create new user, then login" do
    @browser.find_element(:link_text, "Administration").click
    @browser.find_element(:link_text, "Manage users").click
    @browser.find_element(:link_text, "Add user").click

    create_user_page = CreateUserPage.new(@browser)
    create_user_page.enter_username("mike")
    create_user_page.enter_email("mike@gmail.com")
    create_user_page.enter_password("pass")
    create_user_page.click_create
    @browser.page_source.should include("mike") # checkout; after create see new user

    logout
    login_as("mike", "pass")

    @browser.page_source.should include("Sign in successfully")
    logout
    login_as("admin")
  end

  it "Admin can edit user email" do
    @browser.find_element(:link_text, "Manage users").click
    # with database reset, we know the no.2 is
    @browser.find_element(:id, "edit_2").click
    
    admin_edit_user_profile_page = AdminEditUserProfilePage.new(@browser)
    admin_edit_user_profile_page.enter_email("bob@thetester.com")
    admin_edit_user_profile_page.click_save
    @browser.page_source.should include("bob@thetester.com")
    logout
    login_as("bob", "test")
    @browser.page_source.should include("Sign in successfully")
    logout

    login_as("admin") 
  end


  it "Admin can change user's password'" do
    @browser.find_element(:link_text, "Manage users").click
    @browser.find_element(:link, "bob").click
    @browser.find_element(:link_text, "Change password").click

    admin_change_password_page = AdminChangePasswordPage.new(@browser)
    admin_change_password_page.enter_password("changed")
    admin_change_password_page.enter_password_confirmation("changed1")
    admin_change_password_page.click_change
    @browser.page_source.should include("Password doesn't match confirmation")

    admin_change_password_page.enter_password("changed")
    admin_change_password_page.enter_password_confirmation("changed")
    admin_change_password_page.click_change
    logout()

    login_as("bob", "changed")
    @browser.page_source.should include("Sign in successfully")
    logout

    login_as("admin")
  end

end
