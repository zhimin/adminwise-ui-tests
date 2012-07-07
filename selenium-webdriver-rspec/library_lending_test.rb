load File.dirname(__FILE__) + '/test_helper.rb'

describe "Library: Borrowing and Lending" do
  include TestHelper

  before(:all) do
    @browser = $browser = Selenium::WebDriver.for(browser_type)
    @browser.navigate.to($BASE_URL)
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
    #@browser.find_element(:link_text, "Logout") unless debugging?
    visit("/home") unless debugging?
  end


  it "[491] Admin user can process a member borrowing a book" do
    library_page = LibraryPage.new(@browser)
    library_page.click_borrow
    library_borrow_page = LibraryBorrowPage.new(@browser)
    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    library_borrow_page.enter_resource("100001")
    library_borrow_page.click_find_resource
    library_borrow_page.click_select
    library_borrow_page = LibraryBorrowPage.new(@browser)
    library_borrow_page.click_process
    # back to empty borrow page

    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    sleep 0.5
    @browser.find_element(:link_text, "1 Rentals").click
    sleep 1
    MemberBorrowHistoryPage.new(@browser)
    #
  end

  it "[492] Admin user can process returning a book" do
    library_page = LibraryPage.new(@browser)
    library_page.click_borrow
    library_borrow_page = LibraryBorrowPage.new(@browser)
    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    library_borrow_page.enter_resource("100001")
    library_borrow_page.click_find_resource
    try_until(10) { library_borrow_page.click_select }
    library_borrow_page = LibraryBorrowPage.new(@browser)
    library_borrow_page.click_process

    #   search 100001
    #   assert status checkedout, using id
    @browser.find_element(:link_text, "Library").click
    library_page = LibraryPage.new(@browser)
    library_page.enter_query("100001")
    library_page.click_search
    sleep 1
    @browser.find_element(:link_text, "Let Me Hear Your Voice: A Family's Triumph over Autism").click
    sleep 2
    @browser.find_element(:id, "item_status_100001").text.strip.should == "Checked out"

    @browser.find_element(:link_text, "Library").click
    library_page = LibraryPage.new(@browser)
    library_page.click_return
    sleep 0.5
    library_return_page = LibraryReturnPage.new(@browser)
    library_return_page.enter_resource("100001")
    library_return_page.click_find
		
    try_until(10) { assert_link_present_with_text("Let Me Hear Your Voice: A Family's Triumph over Autism") }
    library_return_page.click_process

    @browser.find_element(:link_text, "Library").click
    library_page = LibraryPage.new(@browser)
    library_page.enter_query("100001")
    library_page.click_search
    sleep 1
    @browser.find_element(:link_text, "Let Me Hear Your Voice: A Family's Triumph over Autism").click
    @browser.find_element(:id, "item_status_100001").text.strip.should == "Available"
  end

  
end
