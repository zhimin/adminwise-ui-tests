load File.dirname(__FILE__) + '/test_helper.rb'

describe "Memeber Login" do
  include TestHelper

  before(:all) do
    @browser = $browser = Selenium::WebDriver.for(browser_type)
    @browser.navigate.to($TESTWISE_PROJECT_BASE_URL || $BASE_URL)
    reset_database
    fail_safe{ logout }
    login_as("bob", "test")
  end

  after(:all) do
    logout unless debugging?
    @browser.quit unless debugging?
  end

  before(:each) do
    visit "/home"
  end

  it "[495] Admin can generate a login for an existing member" do
    @browser.find_element(:link_text, "Membership").click
    @browser.find_element(:link_text, "David Smith").click
    @browser.find_element(:id, "generate_login").click
    sleep 1
    @browser.find_element(:link_text, "dsmith").click # click new link to member login
    assert_link_present_with_text("David Smith")

    @browser.find_element(:link_text, "Member Logins").click
    member_logins_page = MemberLoginsPage.new(@browser)
    member_logins_page.enter_query("dsmith")    
    member_logins_page.click_search
    assert_link_present_with_text("dsmith")
  end

end






