load File.dirname(__FILE__) + '/test_helper.rb'

specification "To Do List" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
    login_as("admin")
  end

  before(:each) do
    click_link("Todo lists")
    click_link("New Todo list")
    enter_text("todo_list[name]", "Collect parcel")
    click_button("Create")
  end


  after(:all) do
    close_browser unless debugging?
  end

  story "Create a new Todo list" do
    assert_link_present_with_text("Collect parcel")
  end

  story "can edit a Todo list name" do
    click_link("Collect parcel")
    click_link("Collect parcel")
    enter_text("todo_list[name]", "Collect returned resources")
    click_button("Update")
    assert_link_present_with_text("Collect returned resources")
  end

  # JavaScript Popup
  story "can delete Todo list" do
    image(:src, /delete\.png/).click_no_wait
    browser.ie.javascript_dialog.button('OK').click
    # TODO checkpoint
  end

end
