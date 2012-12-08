load File.dirname(__FILE__) + '/test_helper.rb'

test_suite "Events" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
    login_as("bob")
  end


  before(:each) do
    visit "/"
    click_link("Events")
  end

  after(:all) do
    logout unless debugging?
    close_browser unless debugging?
  end

  # Press key Ctrl+Shift+T, then enter 123 quickly navigate you here
  story "[123] Can create a new event" do
    event_list_page = expect_page EventListPage
    event_page = event_list_page.click_new
    event_page.enter_name("ABA Workshop")
    event_page.enter_venue("QUT")
    event_page.enter_presenters("Many")
    event_page.enter_date("10/12/2010")
    event_page.click_create
    assert_text_present("Event was successfully created.")
  end

  test "[488] Can edit an existing event" do
    event_list_page = expect_page EventListPage
    event_page = event_list_page.edit(1)
    event_page.enter_name("2010 Agileway Testing Conference")
    event_page.click_update
    assert_text_present("2010 Agileway Testing Conference")
  end


end