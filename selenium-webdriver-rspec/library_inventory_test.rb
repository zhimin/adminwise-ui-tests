load File.dirname(__FILE__) + '/test_helper.rb'

describe "Library: Add resourses" do
  include TestHelper

  before(:all) do
    @browser = $browser = Selenium::WebDriver.for(browser_type)
    @browser.navigate.to($ITEST2_PROJECT_BASE_URL || $BASE_URL)
    reset_database
    fail_safe{ logout }
    login_as("bob")
  end

  after(:all) do
    fail_safe{ logout } unless debugging?
    @browser.quit unless debugging?
  end

  before(:each) do
    visit "/home"
    @browser.find_element(:link_text, "Library").click
  end

  after(:each) do    
    visit("/") unless debugging?
  end

  it "[489] Admin user can add a new library resource manually" do
    library_page = LibraryPage.new(@browser)
    library_page.add_new_resources
    #    library_page.add_manually
    new_resource_page = NewResourcePage.new(@browser)
    new_resource_page.enter_title("The Other Country")
    new_resource_page.enter_authors("Michael Whelan")
    new_resource_page.select_subject("Families")
    new_resource_page.click_create
    @browser.find_element(:name, "commit").click # click_button("Save")
    @browser.find_element(:link_text, "Library").click
    
    library_search_page = LibrarySearchPage.new(@browser)
    library_search_page.enter_query("The Other Country")
    library_search_page.click_search
    try_until(10) { @browser.page_source.should include("matches for 'The Other Country'")}
  end

=begin
  story"[490] Admin user can add new resource via amazon"do
    library_page = LibraryPage.new(@browser)
    library_page.add_new_resources
    if page_text.include?("OR")
      enter_text("q", "Web Test Automation")
      click_button("search")
      try_until(10) {    link(:text => "Add", :index => 1).click }
      click_button("Create")
      click_button("Save")
      @browser.find_element(:link_text, "Library").click
      enter_text("q", "Unit Testing")
      click_button("search")
      try { @browser.page_source.should include("Pragmatic Unit Testing in Java with JUnit")}
    else
      puts "Amazon ECS is not installed or configured, amazon search test ignored"
    end
  end
=end

end
