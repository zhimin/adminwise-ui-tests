load File.dirname(__FILE__) + '/test_helper.rb'

describe "To Do List" do
  include TestHelper

  before(:all) do
    @driver = Watir::Browser.new
    begin; logout;  rescue; end
  end

  before(:each) do
    reset_database
    login_as("bob")
    @driver.link(:text, "Todo lists").click
    @driver.link(:text, "New Todo list").click
    @driver.text_field(:name, "todo_list[name]").set("Collect parcel")
    @driver.button(:value, "Create").click
  end

  after(:all) do
    @driver.close unless debugging?
  end

  it "Create a new Todo list" do
    assert_link_present_with_text("Collect parcel")
  end

  it "can edit a Todo list name" do
    @driver.link(:text, "Collect parcel").click
    @driver.link(:text, "Collect parcel").click
    @driver.text_field(:name, "todo_list[name]").set("Collect returned resources")
    @driver.button(:value, "Update").click
    assert_link_present_with_text("Collect returned resources")
  end

  # JavaScript Popup
  it "can delete Todo list" do
    # Alternative way is use Popup Handler: http://testwisely.com/en/testwise/docs/recipes
    @driver.image(:src, /delete\.png/).click_no_wait
    @driver.javascript_dialog.button('OK').click
    # TODO checkpoint    
  end

end
