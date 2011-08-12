load File.dirname(__FILE__) + '/test_helper.rb'

specification "Library: Add resourses" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
    login_as("admin")
  end

  after(:all) do
    failsafe{ logout }
    #close_browser unless debugging?
  end

  before(:each) do
    visit "/home"
    click_link("Library")
  end

  after(:each) do    
    goto_page("/home") unless debugging?
  end

  story "[20] Admin user can add a new library resource manually" do
    library_page = expect_page LibraryPage
    library_page.add_new_resources
    library_page.add_manually
    new_resource_page = expect_page NewResourcePage
    new_resource_page.enter_title("The Other Country")
    new_resource_page.enter_authors("Michael Whelan")
    new_resource_page.select_subject("Families")
    new_resource_page.click_create
    click_button("Save")
    click_link("Library")
    enter_text("q", "The Other Country")
    click_button("search")
    try { page_text.should include("matches for 'The Other Country'")}
  end

=begin
  story"[490] Admin user can add new resource via amazon"do
    library_page = expect_page LibraryPage
    library_page.add_new_resources
    if page_text.include?("OR")
      enter_text("q", "Web Test Automation")
      click_button("search")
      try(10) {    link(:text => "Add", :index => 1).click }
      click_button("Create")
      click_button("Save")
      click_link("Library")
      enter_text("q", "Unit Testing")
      click_button("search")
      try { page_text.should include("Pragmatic Unit Testing in Java with JUnit")}
    else
      puts "Amazon ECS is not installed or configured, amazon search test ignored"
    end
  end
=end

end
