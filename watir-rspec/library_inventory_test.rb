load File.dirname(__FILE__) + '/test_helper.rb'

describe "Library: Add resourses" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new
    reset_database
     logout 
    login_as("bob")
  end

  after(:all) do
   logout unless debugging?
    @browser.close unless debugging?
  end

  before(:each) do
    visit "/home"
    @browser.link(:text, "Library").click
  end

  after(:each) do    
    visit("/home") unless debugging?
  end

  it "[489] Admin user can add a new library resource manually" do
    library_page = LibraryPage.new(@browser)
    library_page.add_new_resources
    # library_page.add_manually
    new_resource_page = NewResourcePage.new(@browser)
    new_resource_page.enter_title("The Other Country")
    new_resource_page.enter_authors("Michael Whelan")
    new_resource_page.select_subject("Families")
    new_resource_page.click_create
    @browser.button(:value, "Save").click
    @browser.link(:text,"Library").click
    @browser.text_field(:name, "q").set "The Other Country"
    @browser.button(:value, "search").click
    try_until(10) { @browser.text.should include("matches for 'The Other Country'")}
  end

=begin
  story"[490] Admin user can add new resource via amazon"do
    library_page = expect_page LibraryPage
    library_page.add_new_resources
    if page_text.include?("OR")
      @browser.text_field(:name, "q", "Web Test Automation")
      click_button("search")
      try(10) {    link(:text => "Add", :index => 1).click }
      click_button("Create")
      click_button("Save")
      @browser.link(:text,"Library")
      @browser.text_field(:name, "q", "Unit Testing")
      click_button("search")
      try { @browser.text.should include("Pragmatic Unit Testing in Java with JUnit")}
    else
      puts "Amazon ECS is not installed or configured, amazon search test ignored"
    end
  end
=end

end
