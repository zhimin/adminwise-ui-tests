load File.dirname(__FILE__) + '/test_helper.rb'

describe "Memeber Login" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new
    reset_database
    logout
    login_as("bob", "test")
  end

  after(:all) do
    logout unless debugging?
    @browser.close unless debugging?
  end

  before(:each) do
    visit "/home"
  end

  it "[495] Admin can generate a login for an existing member" do
    @browser.link(:text,"Membership").click
    @browser.link(:text,"David Smith").click
    @browser.button(:value, "Generate login").click
    sleep 1
    @browser.link(:text,"dsmith").click # click new link to member login
    assert_link_present_with_text("David Smith")

    @browser.link(:text,"Member Logins").click
    @browser.text_field(:name, "search").set "dsmith"
    @browser.button(:value, "Search").click
    assert_link_present_with_text("dsmith")
  end

end






