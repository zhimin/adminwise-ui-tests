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
    close_browser unless debugging?
  end

  before(:each) do
    visit "/home"
  end

  story "Admin user can search an existing member by surname " do
    enter_text("search", "Smith")
    click_button("Search")
    page_text.should include("David Smith")
  end
  
  story "Admin user can search an existing member by membership number" do
    enter_text("search", "30002")
    click_button("Search")
    assert_link_present_with_text("David Smith")
  end
  
  story "[493] Admin user can create a new family member" do
    click_link("Membership")
    click_link("Add member")
    enter_text("member[fname]", "Cindy")
    enter_text("member[lname]", "Fu")
    enter_text("member[street_addr]", "25 John Drive")
    enter_text("member[suburb]", "Ashgrove")
    enter_text("member[state]", "QLD")
    enter_text("member[postcode]", "4051")
    enter_text("member[phone]", "33440566")
    enter_text("member[mobile]", "0411231764")
    enter_text("member[email]", "cindy@agileway.com.au")
    click_radio_option("member[member_type]", "family_1")
    click_radio_option("member[mail_out]", "true")
    click_radio_option("member[doing_aba]", "true")
    select_option("member[aware_from]", "family/ friend")
    click_button("Create Member")
    click_link("Membership")
    page_text.should include("Cindy Fu")
  end

  story "[494] Admin user can create a new organisation member" do
    click_link("Add member")
    enter_text("member[oname]", "CareLink Pty Ltd")
    enter_text("member[fname]", "Michele")
    enter_text("member[lname]", "Wind")
    enter_text("member[street_addr]", "36 Steven Road")
    enter_text("member[suburb]", "Stafford")
    enter_text("member[state]", "QLD")
    enter_text("member[postcode]", "4054")
    enter_text("member[phone]", "3972 5844")
    enter_text("member[email]", "mwind@carelink.com.au")
    click_radio_option("member[member_type]", "school")
    select_option("member[aware_from]", "conference/ workshop")
    click_button("Create Member")
    click_link("Membership")
    page_text.should include("CareLink Pty Ltd")
  end

end






