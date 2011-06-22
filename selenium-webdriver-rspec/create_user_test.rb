load File.dirname(__FILE__) + '/test_helper.rb'

specification "Create a new user as admin" do
  include TestHelper

  before(:all) do
    @driver = Selenium::WebDriver.for(:ie) 
    @driver.navigate.to($ITEST2_PROJECT_BASE_URL || $BASE_URL)
    reset_database
  end

  after(:all) do
    logout unless debugging?
    @driver.quit unless debugging?
  end

  story "[482] Create new user, then login" do
    login_as("admin")
    
  #   @driver.find_elements(:tag_name, "a").each do |elem| 
  #      puts elem.text 
  #    end
 
    # WebDriver set the low case
    @driver.find_element(:link_text, "control panel").click # NOTES [Watir] 'Control Panel'
    @driver.find_element(:link_text, "Manage Users").click
    @driver.find_element(:link_text, "Add new user").click
    
    create_user_page = CreateUserPage.new(@driver)
    create_user_page.enter_username("mike")
    create_user_page.enter_email("mike@gmail.com")
    create_user_page.enter_password("pass")
    create_user_page.click_create
    @driver.page_source.should include("mike") # checkout; after create see new user
    
    logout
    login_as("mike", "pass")
    
    @driver.find_element(:link_text, "logout")
    # assert_link_present_with_text("Logout") # checkpoint: login sucessuflly
  end

end
