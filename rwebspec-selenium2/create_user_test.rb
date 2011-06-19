load File.dirname(__FILE__) + '/test_helper.rb'

specification "Create a new user as admin" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
  end

  after(:all) do
    logout unless debugging?
    close_browser unless debugging?
  end

  story "[482] Create new user, then login" do
    login_as("admin")
    #  click_link("Control Panel")
    click_link("control panel")
    click_link("Manage Users")
    click_link("Add new user")
    
    create_user_page = expect_page CreateUserPage
    create_user_page.enter_username("mike")
    create_user_page.enter_email("mike@gmail.com")
    create_user_page.enter_password("pass")
    create_user_page.click_create
    page_text.should contain("mike") # checkout; after create see new user
    
    logout
    login_as("mike", "pass")
#    assert_link_present_with_text("Logout") # checkpoint: login sucessuflly
    assert_link_present_with_text("logout") # checkpoint: login sucessuflly
  end

end
