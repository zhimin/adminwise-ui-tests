load File.dirname(__FILE__) + '/test_helper.rb'

describe "Create a new user as admin" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new
    reset_database
  end

  after(:all) do
    logout unless debugging?
    @browser.close unless debugging?
  end

  it "[482] Create new user, then login" do
    login_as("admin")
    @browser.link(:text, "Administration").click
    @browser.link(:text, "Add user").click
    
    create_user_page = CreateUserPage.new(@browser)
    create_user_page.enter_username("mike")
    create_user_page.enter_email("mike@gmail.com")
    create_user_page.enter_password("pass")
    create_user_page.click_create
    @browser.text.should include("mike") # checkout; after create see new user
    
    logout
    login_as("mike", "pass")
    @browser.text.should include("Sign in successfully")
  end

end
