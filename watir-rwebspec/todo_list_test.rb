load File.dirname(__FILE__) + '/test_helper.rb'

# Every Test Case shall be independent from each other (including use of before:each )
# Same result if runing individually or run all , in any order
# only dependable data set is database reset, if not, create from scractch
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
    enter_text("todo_list[name]", "Office work")
    click_button("Create")
  end

  after(:all) do
    close_browser unless debugging?
  end

  story "Create a new Todo list" do
    assert_link_present_with_text("Office work")
  end

  story "can edit a Todo list name" do
    click_link("Collect parcel")
    click_link("Collect parcel")
    enter_text("todo_list[name]", "Office work has to be done by Monday")
    click_button("Update")
    assert_link_present_with_text("Office work has to be done by Monday")
  end

  story "Can add a new task in existing todo list" do
    click_link("Todo lists")
    click_link("Office work has to be done by Monday")
    click_link("New task")
    enter_text("task[description]", "agenda for Tuesday meeting ")
    enter_text("task[notes]", "Write up agenda for Tuesday meeting including new business from last meeting ")
    enter_text("task[due_on]", "2011-07-19")
    click_button("Create")
  end

  # JavaScript Popup
  story "can delete Todo list" do
    # Alternative way is to use Popup Handler: http://testwisely.com/en/testwise/docs/recipes
    image(:src, /delete\.png/).click_no_wait
    browser.javascript_dialog.button('OK').click
    # TODO checkpoint
  end

end
