load File.dirname(__FILE__) + '/test_helper.rb'

specification "Library: Borrowing and Lending" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
    login_as("bob")
  end

  after(:all) do
    failsafe{ logout } unless debugging?
    #close_browser unless debugging?
  end

  before(:each) do
    visit "/home"
    click_link("Library")
  end

  after(:each) do
    #click_link("Logout") unless debugging?
    goto_page("/home") unless debugging?
  end


  story "[21] Admin user can process a member borrowing a book" do
    library_page = expect_page LibraryPage
    library_page.click_borrow
    library_borrow_page = expect_page LibraryBorrowPage
    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    library_borrow_page.enter_resource("100001")
    library_borrow_page.click_find_resource
    library_borrow_page.click_select
    library_borrow_page = expect_page LibraryBorrowPage
    library_borrow_page.click_process
    # back to empty borrow page

    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    sleep 0.5
    click_link("1 Rentals")
    expect_page MemberBorrowHistoryPage
    #
  end

  story "[22] Admin user can process returning a book" do
    library_page = expect_page LibraryPage
    library_page.click_borrow
    library_borrow_page = expect_page LibraryBorrowPage
    library_borrow_page.enter_member_name("30008")
    library_borrow_page.click_find_member
    library_borrow_page.enter_resource("100001")
    library_borrow_page.click_find_resource
    try { library_borrow_page.click_select }
    library_borrow_page = expect_page LibraryBorrowPage
    library_borrow_page.click_process

    #   search 100001
    #   assert status checkedout, using id
    click_link("Library")
    library_page = expect_page LibraryPage
    library_page = expect_page LibraryPage
    library_page.enter_query("100001")
    library_page.click_search
    sleep 0.5
    click_link("Let Me Hear Your Voice: A Family's Triumph over Autism")
    cell(:id, "item_status_100001").text.strip.should == "Checked out"

    click_link("Library")
    library_page = expect_page LibraryPage
    library_page.click_return
    sleep 0.5
    library_return_page = expect_page LibraryReturnPage
    library_return_page.enter_resource("100001")
    library_return_page.click_find
		
    try { assert_link_present_with_text("Let Me Hear Your Voice: A Family's Triumph over Autism") }
    library_return_page.click_process

    click_link("Library")
    library_page = expect_page LibraryPage
    library_page.enter_query("100001")
    library_page.click_search
    sleep 1
    click_link("Let Me Hear Your Voice: A Family's Triumph over Autism")
    cell(:id, "item_status_100001").text.strip.should == "Available"
  end

  
end
