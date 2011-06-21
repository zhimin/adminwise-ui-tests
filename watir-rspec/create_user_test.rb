load File.dirname(__FILE__) + '/test_helper.rb'

specification "Create a new user as admin" do
  include TestHelper

  before(:all) do
    @driver = Watir::Browser.new
    reset_database
  end

  after(:all) do
    logout unless debugging?
    @driver.close unless debugging?
  end

  story "[482] Create new user, then login" do
    login_as("admin")
    @driver.link(:text, "Control Panel").click
    @driver.link(:text, "Manage Users").click
    @driver.link(:text, "Add new user").click
    
    create_user_page = CreateUserPage.new(@driver)
    create_user_page.enter_username("mike")
    create_user_page.enter_email("mike@gmail.com")
    create_user_page.enter_password("pass")
    create_user_page.click_create
    @driver.text.should include("mike") # checkout; after create see new user
    
    logout
    login_as("mike", "pass")
    assert_link_present_with_text("Logout") # checkpoint: login sucessuflly
  end

end
