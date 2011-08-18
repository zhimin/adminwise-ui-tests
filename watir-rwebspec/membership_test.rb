load File.dirname(__FILE__) + '/test_helper.rb'

specification "Memebership" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
    login_as("admin", "test")
  end

  after(:all) do
    logout unless debugging?
  end

  before(:each) do
    visit "/home"
  end

  story "[17] Admin user can search an existing member by surname " do
    enter_text("search", "Smith")
    click_button("Search")
    page_text.should include("David Smith")
  end

  story "[18] Admin user can search an existing member by membership number" do
    enter_text("search", "30002")
    click_button("Search")
    assert_link_present_with_text("David Smith")
  end

  story "[10] Admin user can create a new family member" do
    click_link("Membership")
    membership_page = expect_page MembershipPage
    membership_page.add_member
    membership_page.enter_first_name("Cindy")
    membership_page.enter_last_name("Fu")
    membership_page.enter_street_address("25 John Drive")
    membership_page.enter_suburb("Ashgrove")
    membership_page.enter_state("QLD")
    membership_page.enter_postcode("4051")
    membership_page.enter_phone("33440566")
    membership_page.enter_mobile("0411231764")
    membership_page.enter_email("cindy@agileway.com.au")
    membership_page.click_member_type("family_1")
    membership_page.click_mail_out("true")
    membership_page.click_doing_aba("true")
    membership_page.select_aware_from("family/ friend")
    membership_page.click_create_member
    membership_page.click_membership
    page_text.should include("Cindy Fu")
  end

  story "[11] Admin user can create a new organisation member" do
    membership_page = expect_page MembershipPage
    membership_page.click_add_member
    membership_page.enter_organisation_name("CareLink Pty Ltd")
    membership_page.enter_first_name("Michele")
    membership_page.enter_last_name("Wind")
    membership_page.enter_street_address("36 Steven Road")
    membership_page.enter_suburb("Stafford")
    membership_page.enter_state("QLD")
    membership_page.enter_postcode("4054")
    membership_page.enter_phone("3972 5844")
    membership_page.enter_email("mwind@carelink.com.au")
    membership_page.click_member_type("school")
    membership_page.select_aware_from("conference/ workshop")
    membership_page.click_create_member
    membership_page.click_membership
    page_text.should include("CareLink Pty Ltd")
  end

  story "[15] Admin user can update an existing member details" do
    membership_page = expect_page MembershipPage
    membership_page.click_name("David Smith")
    membership_page.enter_member_end_date("2012-08-20")
    membership_page.enter_suburb("Norman Park")
    membership_page.click_update_member
    page_text.should include("20/08/2012")
    page_text.should contain("Norman Park")
  end

  story "[16] Can browse past member" do
    click_link("Bob Builder")
    enter_text("member[end_date]", "2010-08-20")
    click_button("Update Member")
    click_link("Browse current members")
    assert_link_not_present_with_text("Bob Builder")
    click_link("Browse members (including past)")
    assert_link_present_with_text("Bob Builder")
  end

end