# encoding: utf-8
load File.dirname(__FILE__) + '/test_helper.rb'

describe "Notices" do
  include TestHelper

  before(:all) do
    @browser = $browser = Selenium::WebDriver.for(browser_type)
    @browser.navigate.to($TESTWISE_PROJECT_BASE_URL || $BASE_URL)
    @browser.manage().window().resize_to(browser_width, browser_height)
    reset_database
    fail_safe{ logout }
  end

  after(:all) do
    fail_safe{ logout } unless debugging?
    @browser.quit unless debugging?
  end

  after(:each) do
    failsafe{ logout } unless debugging?
  end

  it "[22] Admin can create a new active notice and display" do
    login_as("admin")
    @browser.find_element(:link_text, "Administration").click
    @browser.find_element(:link_text, "Notices").click
    notice_list_page = NoticeListPage.new(@browser)
    notice_list_page.click_new_notice
    new_notice_page = NewNoticePage.new(@browser)
    new_notice_page.enter_header("Fire Drill")
    new_notice_page.enter_body("Evacuate in 10 minutes")
    new_notice_page.select_severity("High")
    new_notice_page.check_active
    new_notice_page.click_create

    logout
    visit("/")
    @browser.page_source.should include("Evacuate in 10 minutes")

    login_as("admin")
    @browser.find_element(:link_text, "Notices").click
    notice_list_page = NoticeListPage.new(@browser)
    @browser.find_element(:link, "Fire Drill").click
    notice_page = NoticePage.new(@browser)
    notice_page.click_edit

    edit_notice_page = EditNoticePage.new(@browser)
    edit_notice_page.uncheck_active
    edit_notice_page.click_save

    logout
    visit("/")
    @browser.page_source.should_not include("Evacuate in 10 minutes")
  end

  it "[22] Admin can create one future notice then change to now" do
    visit "/"
    login_as("admin")
    @browser.find_element(:link_text, "Notices").click
    notice_list_page = NoticeListPage.new(@browser)
    notice_list_page.click_new_notice
    new_notice_page =  NewNoticePage.new(@browser)
    new_notice_page.enter_header("Fire Drill")
    new_notice_page.enter_body("Evacuate in 20 minutes")
    new_notice_page.select_severity("Normal")
    new_notice_page.select_start_year(2014)
    new_notice_page.select_end_year(2014)
    new_notice_page.check_active
    new_notice_page.click_create

    logout
    visit("/")
    @browser.page_source.should_not include("Evacuate in 20 minutes")

    login_as("admin")
    @browser.find_element(:link_text, "Notices").click
    notice_list_page = NoticeListPage.new(@browser)
    @browser.find_element(:link, "Fire Drill").click
    notice_page = NoticePage.new(@browser)
    notice_page.click_edit

    edit_notice_page = EditNoticePage.new(@browser)
    edit_notice_page.select_start_year(2013)
    edit_notice_page.select_end_year(2013)
    edit_notice_page.click_save

    logout
    visit("/")
    @browser.page_source.should include("Evacuate in 20 minutes")
  end

  it "[23] Only Admin User can publish notices" do
    login_as("bob")
    visit("/notices")
    @browser.page_source.should include("Only admin user can preform")
    visit("/")
  end

end
