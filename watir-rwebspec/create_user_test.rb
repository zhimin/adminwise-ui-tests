load File.dirname(__FILE__) + '/test_helper.rb'

specification "Create a new user as admin" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
  end

  after(:all) do
    logout unless debugging?
  end

  story "[19] Create new user, then login" do
    login_as("admin")
    click_link("Administration")
    click_link("Manage users")
    click_link("Add user")
    
    create_user_page = expect_page CreateUserPage
    create_user_page.enter_username("mike")
    create_user_page.enter_email("mike@gmail.com")
    create_user_page.enter_password("pass")
    create_user_page.click_create
    page_text.should contain("mike") # checkout; after create see new user
    
    logout
    login_as("mike", "pass")
    page_text.should contain("Sign in successfully")
  end

end
