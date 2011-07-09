load File.dirname(__FILE__) + '/test_helper.rb'

specification "Library: Borrowing and Lending" do
  include TestHelper

  before(:all) do
    @driver = Selenium::WebDriver.for(:ie) 
    @driver.navigate.to($ITEST2_PROJECT_BASE_URL || $BASE_URL)
    reset_database
    fail_safe{ logout }
    login_as("admin")
  end

  after(:all) do
    fail_safe{ logout } unless debugging?
    @driver.quit unless debugging?
  end

  before(:each) do
    visit "/home"
    @driver.find_element(:link_text, "LIBRARY").click
  end

  after(:each) do
    #@driver.find_element(:link_text, "Logout") unless debugging?
    goto_page("/home") unless debugging?
  end


  story "[491] Admin user can process a member borrowing a book" do
    library_page = LibraryPage.new(@driver)
    library_page.click_borrow
    library_borrow_page = LibraryBorrowPage.new(@driver)
    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    library_borrow_page.enter_resource("100001")
    library_borrow_page.click_find_resource
    library_borrow_page.click_select
    library_borrow_page = LibraryBorrowPage.new(@driver)
    library_borrow_page.click_process
    # back to empty borrow page

    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    sleep 0.5
    @driver.find_element(:link_text, "1 Rentals")
    MemberBorrowHistoryPage.new(@driver)
    #
  end

  story "[492] Admin user can process returning a book" do
    library_page = LibraryPage.new(@driver)
    library_page.click_borrow
    library_borrow_page = LibraryBorrowPage.new(@driver)
    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    library_borrow_page.enter_resource("100001")
    library_borrow_page.click_find_resource
    try { library_borrow_page.click_select }
    library_borrow_page = LibraryBorrowPage.new(@driver)
    library_borrow_page.click_process

    #   search 100001
    #   assert status checkedout, using id
    @driver.find_element(:link_text, "LIBRARY").click
    library_page = LibraryPage.new(@driver)
    library_page.enter_query("100001")
    library_page.click_search
    sleep 0.5
    @driver.find_element(:link_text, "Let Me Hear Your Voice: A Family's Triumph over Autism").click
    sleep 1
    @driver.find_element(:id, "item_status_100001").text.strip.should == "Checked out"

    @driver.find_element(:link_text, "LIBRARY").click
    library_page = LibraryPage.new(@driver)
    library_page.click_return
    sleep 0.5
    library_return_page = LibraryReturnPage.new(@driver)
    library_return_page.enter_resource("100001")
    library_return_page.click_find
		
    try { assert_link_present_with_text("Let Me Hear Your Voice: A Family's Triumph over Autism") }
    library_return_page.click_process

    @driver.find_element(:link_text, "LIBRARY").click
    library_page = LibraryPage.new(@driver)
    library_page.enter_query("100001")
    library_page.click_search
    sleep 1
    @driver.find_element(:link_text, "Let Me Hear Your Voice: A Family's Triumph over Autism").click
    cell(:id, "item_status_100001").text.strip.should == "Available"
  end

  
end
