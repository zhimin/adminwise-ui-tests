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
    login_as("bob")
  end

  before(:each) do
    goto_page("/")
    refresh
    click_link("TODO Lists")
    click_link("New TODO list")
  end
  
  after(:all) do
    fail_safe{ logout } unless debugging?
  end

  story "[37] Create a new Todo list" do
    enter_text("todo_list[name]", "Office work")
    click_button("Create")
    assert_link_present_with_text("Office work")
  end

  story "[38] Can edit a Todo list name" do
    enter_text("todo_list[name]", "Collect parcel")
    click_button("Create")    
    click_link("Collect parcel") # second link for is for editing
    enter_text("todo_list[name]", "Office work has to be done by Monday")
    click_button("Save")
    refresh # IE not refresh
    assert_link_present_with_text("Office work has to be done by Monday")
  end

  story "[39] Can add a new task in existing todo list" do
    enter_text("todo_list[name]", "Office work has to be done by Monday")    
    click_button("Create")        

    click_link("New task")
    enter_text("task[description]", "agenda for Tuesday meeting ")
    enter_text("task[notes]", "Write up agenda for Tuesday meeting including new business from last meeting ")
    enter_text("task[due_on]", "2011-07-19")
    click_button("Create")
  end

  # JavaScript Popup
  #
  # Also smart to calculate last entry
  story "[40] Can delete Todo list" do
    enter_text("todo_list[name]", "Not important")    
    click_button("Create")    
    assert_link_present_with_text("Not important")
    click_link("TODO Lists")
    # Alternative way is to use Popup Handler: http://testwisely.com/en/testwise/docs/recipes
    del_link_ids = []
    browser.links.each_with_index do |x, xid|
      del_link_ids << x.id if x.id && x.id =~ /del_todo_\d+/
    end
    link(:id, del_link_ids.last).click_no_wait
    browser.javascript_dialog.button('OK').click
    sleep 2
    refresh
    assert_link_not_present_with_text("Not important")
  end

end