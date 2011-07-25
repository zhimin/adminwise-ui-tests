load File.dirname(__FILE__) + '/test_helper.rb'

describe "Library: Borrowing and Lending" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new
    reset_database
    logout
    login_as("admin")
  end

  after(:all) do
    logout  unless debugging?
    @browser.close unless debugging?
  end

  before(:each) do
    visit "/home"
    @browser.link(:text,"Library").click
  end

  after(:each) do
    #@browser.link(:text,"Logout") unless debugging?
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
    library_borrow_page =  LibraryBorrowPage.new(@browser)
    library_borrow_page.click_process
    # back to empty borrow page

    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    sleep 0.5
    @browser.link(:text,"1 Rentals")
    MemberBorrowHistoryPage.new(@browser)
    #
  end

  it "[492] Admin user can process returning a book" do
    library_page =  LibraryPage.new(@browser)
    library_page.click_borrow
    library_borrow_page = LibraryBorrowPage.new(@browser)
    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    library_borrow_page.enter_resource("100001")
    library_borrow_page.click_find_resource
    try { library_borrow_page.click_select }
    library_borrow_page = LibraryBorrowPage.new(@browser)
    library_borrow_page.click_process

    #   search 100001
    #   assert status checkedout, using id
    @browser.link(:text,"Library").click
    library_page = LibraryPage.new(@browser)
    library_page.enter_query("100001")
    library_page.click_search
    sleep 0.5
    @browser.link(:text,"Let Me Hear Your Voice: A Family's Triumph over Autism").click
    @browser.cell(:id, "item_status_100001").text.strip.should == "Checked out"

    @browser.link(:text,"Library").click
    library_page = LibraryPage.new(@browser)
    library_page.click_return
    sleep 0.5
    library_return_page =  LibraryReturnPage.new(@browser)
    library_return_page.enter_resource("100001")
    library_return_page.click_find
		
    try { assert_link_present_with_text("Let Me Hear Your Voice: A Family's Triumph over Autism") }
    library_return_page.click_process

    @browser.link(:text,"Library").click
    library_page = LibraryPage.new(@browser)
    library_page.enter_query("100001")
    library_page.click_search
    sleep 1
    @browser.link(:text,"Let Me Hear Your Voice: A Family's Triumph over Autism").click
    @browser.cell(:id, "item_status_100001").text.strip.should == "Available"
  end

  
end
