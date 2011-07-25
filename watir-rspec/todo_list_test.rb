load File.dirname(__FILE__) + '/test_helper.rb'

describe "To Do List" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new
    begin; logout;  rescue; end
  end

  before(:each) do
    reset_database
    login_as("bob")
    @browser.link(:text, "Todo lists").click
    @browser.link(:text, "New Todo list").click
    @browser.text_field(:name, "todo_list[name]").set("Collect parcel")
    @browser.button(:value, "Create").click
  end

  after(:all) do
    @browser.close unless debugging?
  end

  it "Create a new Todo list" do
    assert_link_present_with_text("Collect parcel")
  end

  it "can edit a Todo list name" do
    @browser.link(:text, "Collect parcel").click
    @browser.link(:text, "Collect parcel").click
    @browser.text_field(:name, "todo_list[name]").set("Collect returned resources")
    @browser.button(:value, "Update").click
    assert_link_present_with_text("Collect returned resources")
  end

  # JavaScript Popup
  it "can delete Todo list" do
    # Alternative way is use Popup Handler: http://testwisely.com/en/testwise/docs/recipes
    @browser.image(:src, /delete\.png/).click_no_wait
    @browser.javascript_dialog.button('OK').click
    # TODO checkpoint    
  end

end
