load File.dirname(__FILE__) + '/test_helper.rb'

describe "Create a new call register" do
  include TestHelper

  before(:all) do
    @browser = $browser = Selenium::WebDriver.for(browser_type) # or :ie, :firefox, :chrome
    @browser.navigate.to($TESTWISE_PROJECT_BASE_URL || $BASE_URL)
    @browser.manage().window().resize_to(browser_width, browser_height)
    reset_database
    failsafe{ logout }
    login_as("bob")
  end

  after(:all) do
    logout unless debugging?
    @browser.quit unless debugging?
  end

  before(:each) do
    sleep 1
    @browser.find_element(:link_text, "Answer Call").click
    answer_call_page = AnswerCallPage.new(@browser)
    answer_call_page.select_call_category("Resources")
    answer_call_page.enter_caller("Jesse Stewart")
    answer_call_page.enter_caller_phone("3765 4231")
    answer_call_page.click_non_member("true")
    answer_call_page.click_hang_up
  end

  it "[13] Can create a new call register" do
    @browser.page_source.should include("Jesse Stewart")
  end

  it "[14] Can edit existing call register" do
    @browser.find_element(:link_text, "Call register").click
    @browser.find_element(:link_text, "Edit").click

    edit_call_register_page = EditCallRegisterPage.new(@browser)
    edit_call_register_page.select_member_yes
    edit_call_register_page.click_update
    # now shall not be a member
    @browser.find_element(:link_text, "Edit").click

    edit_call_register_page = EditCallRegisterPage.new(@browser)
    edit_call_register_page.assert_member_yes
  end

  # end of all test cases in this file
end


