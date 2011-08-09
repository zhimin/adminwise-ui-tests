load File.dirname(__FILE__) + '/test_helper.rb'

describe "Memeber Login" do
  include TestHelper

  before(:all) do
    @driver = Selenium::WebDriver.for(browser_type) 
    @driver.navigate.to($ITEST2_PROJECT_BASE_URL || $BASE_URL)
    reset_database
    fail_safe{ logout }
    login_as("admin", "test")
  end

  after(:all) do
    logout unless debugging?
    @driver.quit unless debugging?
  end

  before(:each) do
    visit "/home"
  end

  it "[495] Admin can generate a login for an existing member" do
    @driver.find_element(:link_text, "MEMBERSHIP").click # NOTES [Watir] 'Membership'
    @driver.find_element(:link_text, "David Smith").click
    @driver.find_element(:id, "generate_login").click
    sleep 1
    @driver.find_element(:link_text, "dsmith").click # click new link to member login
    assert_link_present_with_text("David Smith")

    @driver.find_element(:link_text, "Member logins").click
    member_logins_page = MemberLoginsPage.new(@driver)
    member_logins_page.enter_query("dsmith")    
    member_logins_page.click_search
    assert_link_present_with_text("dsmith")
  end

end






