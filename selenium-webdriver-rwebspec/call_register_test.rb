load File.dirname(__FILE__) + '/test_helper.rb'

specification "Create a new call register" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
    login_as("bob")
  end

  after(:all) do
    logout unless debugging?
    close_browser unless debugging?
  end

  before(:each) do
    click_link("Answer Call")
    answer_call_page = expect_page AnswerCallPage
    answer_call_page.select_call_category("Resources")
    answer_call_page.enter_caller("Jesse Stewart")
    answer_call_page.enter_caller_phone("3765 4231")
    answer_call_page.click_non_member("true")
    answer_call_page.click_hang_up
  end

  story "Can create a new call register" do
    page_text.should include("Jesse Stewart")
  end

  story "Can edit existing call register" do
    click_link("Call register")
    click_link("Edit")
    # link(:text => "Edit", :index => 5).click
    click_radio_option("call[non_member]", "false")

    click_button("Save")
    # now shall not be a member
    click_link("Edit")
    assert_radio_option_checked("call[non_member]", "false")
  end

  # end of all test cases in this file
end


