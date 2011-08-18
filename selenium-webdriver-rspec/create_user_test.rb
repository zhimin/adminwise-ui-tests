load File.dirname(__FILE__) + '/test_helper.rb'

describe "Create a new user as admin" do
  include TestHelper

  before(:all) do
    # by using browser_type (defined in helper), it can be choswn in TestWise
    @browser = Selenium::WebDriver.for(browser_type) # or :ie, :firefox, :chrome
    @browser.navigate.to($BASE_URL)
    reset_database
  end

  after(:all) do
    logout unless debugging?
    @browser.quit unless debugging?
  end

  it "[482] Create new user, then login" do
    login_as("admin")
    
  #   @browser.find_elements(:tag_name, "a").each do |elem|
  #      puts elem.text 
  #    end
 
    # WebDriver set the low case
    @browser.find_element(:link_text, "control panel").click # NOTES [Watir] 'Control Panel'
    @browser.find_element(:link_text, "Manage Users").click
    @browser.find_element(:link_text, "Add new user").click
    
    create_user_page = CreateUserPage.new(@browser)
    create_user_page.enter_username("mike")
    create_user_page.enter_email("mike@gmail.com")
    create_user_page.enter_password("pass")
    create_user_page.click_create
    @browser.page_source.should include("mike") # checkout; after create see new user
    
    logout
    login_as("mike", "pass")
    
    @browser.find_element(:link_text, "logout").click
    # assert_link_present_with_text("Logout") # checkpoint: login sucessuflly
  end

end
