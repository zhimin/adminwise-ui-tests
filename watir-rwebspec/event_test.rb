load File.dirname(__FILE__) + '/test_helper.rb'

test_suite "Events" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
    login_as("admin")
  end


  before(:each) do
    visit "/"

  end

  after(:all) do
    logout unless debugging?
  end

  # Press key Ctrl+Shift+T, then enter 123 quickly navigate you here
  story "[487] Can create a new event" do
    click_link("Events")
    event_list_page = expect_page EventListPage
    event_page = event_list_page.click_new
    event_page.enter_name("ABA Workshop")
    event_page.enter_venue("QUT")
    event_page.enter_presenters("Many")
    event_page.enter_date("10/12/2010")
    event_page.click_create
    assert_text_present("3 events")
  end
#
  test "[488] Can edit an existing event" do
    click_link("Events")
    event_list_page = expect_page EventListPage
    event_page = event_list_page.edit(0)
    event_page.enter_name("2010 Agileway Testing Conference")
    event_page.enter_date_from("2011-07-27")
    event_page.click_update
    assert_text_present("2010 Agileway Testing Conference")
    click_link("Events")
    page_text.should contain("2011-07-27")
  end


end
