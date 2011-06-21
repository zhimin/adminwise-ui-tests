load File.dirname(__FILE__) + '/test_helper.rb'

specification "Library: Add resourses" do
  include TestHelper

  before(:all) do
    @driver = Watir::Browser.new
    reset_database
     logout 
    login_as("admin")
  end

  after(:all) do
   logout unless debugging?
    @driver.close unless debugging?
  end

  before(:each) do
    visit "/home"
    @driver.link(:text, "Library").click
  end

  after(:each) do    
    visit("/home") unless debugging?
  end

  story "[489] Admin user can add a new library resource manually" do
    library_page = LibraryPage.new(@driver)
    library_page.add_new_resources
    library_page.add_manually
    new_resource_page = NewResourcePage.new(@driver)
    new_resource_page.enter_title("The Other Country")
    new_resource_page.enter_authors("Michael Whelan")
    new_resource_page.select_subject("Families")
    new_resource_page.click_create
    @driver.button(:value, "Save").click
    @driver.link(:text,"Library").click
    @driver.text_field(:name, "q").set "The Other Country"
    @driver.button(:value, "search").click
    try { @driver.text.should include("matches for 'The Other Country'")}
  end

=begin
  story"[490] Admin user can add new resource via amazon"do
    library_page = expect_page LibraryPage
    library_page.add_new_resources
    if page_text.include?("OR")
      @driver.text_field(:name, "q", "Web Test Automation")
      click_button("search")
      try(10) {    link(:text => "Add", :index => 1).click }
      click_button("Create")
      click_button("Save")
      @driver.link(:text,"Library")
      @driver.text_field(:name, "q", "Unit Testing")
      click_button("search")
      try { @driver.text.should include("Pragmatic Unit Testing in Java with JUnit")}
    else
      puts "Amazon ECS is not installed or configured, amazon search test ignored"
    end
  end
=end

end
