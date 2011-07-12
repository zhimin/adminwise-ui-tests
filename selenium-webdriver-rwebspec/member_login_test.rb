load File.dirname(__FILE__) + '/test_helper.rb'

specification "Memeber Login" do
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

  story "[495] Admin can generate a login for an existing member" do
    click_link("Membership")
    click_link("David Smith")
    click_button("Generate login")
    sleep 1
    click_link("dsmith") # click new link to member login
    assert_link_present_with_text("David Smith")

    click_link("Member logins")
    enter_text("search", "dsmith")
    click_button("Search")
    assert_link_present_with_text("dsmith")
  end

end






