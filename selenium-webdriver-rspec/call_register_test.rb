load File.dirname(__FILE__) + '/test_helper.rb'

describe "Create a new call register" do
  include TestHelper

  before(:all) do
    @driver = Selenium::WebDriver.for(browser_type) # or :ie, :firefox, :chrome
    @driver.navigate.to($ITEST2_PROJECT_BASE_URL || $BASE_URL)
    reset_database
    failsafe{ logout }
    login_as("admin")
  end

  after(:all) do
    logout unless debugging?
    @driver.quit unless debugging?
  end

  before(:each) do
    @driver.find_element(:link_text, "Answer call").click
    answer_call_page = AnswerCallPage.new(@driver)
    answer_call_page.select_call_category("Resources")
    answer_call_page.enter_caller("Jesse Stewart")
    answer_call_page.enter_caller_phone("3765 4231")
    answer_call_page.click_non_member("true")
    answer_call_page.click_hang_up
  end

  it "Can create a new call register" do
    @driver.page_source.should include("Jesse Stewart")
  end

  it "Can edit existing call register" do
    @driver.find_element(:link_text, "Call register list").click
    @driver.find_element(:link_text, "Edit").click

    edit_call_register_page = EditCallRegisterPage.new(@driver)
    edit_call_register_page.select_member_yes
    edit_call_register_page.click_update
    # now shall not be a member
    @driver.find_element(:link_text, "Edit").click

    edit_call_register_page = EditCallRegisterPage.new(@driver)
    edit_call_register_page.assert_member_yes
  end

  # end of all test cases in this file
end


