load File.dirname(__FILE__) + '/test_helper.rb'

describe "Correspondence" do
  include TestHelper

  before(:all) do
    @driver = Selenium::WebDriver.for(browser_type) # or :ie, :firefox, :chrome
    @driver.navigate.to($ITEST2_PROJECT_BASE_URL || $BASE_URL)
    reset_database
    failsafe{ logout }
    login_as("admin")
  end

  before(:each) do
    @driver.find_element(:link_text, "ADMINISTRATION").click
    #click_link("Administration")
    @driver.find_element(:link_text,"Correspondence").click
    @driver.find_element(:link_text,"New Correspondence").click

    new_correspondence_page = NewCorrespondencePage.new(@driver)
    new_correspondence_page.click_correspondence("Out")
    new_correspondence_page.enter_sender_receiver("Kelly Adell")
    new_correspondence_page.enter_description("Wrote a cover letter and post out the information booklet to Ashgrove State School Support Services")
    new_correspondence_page.click_add
  end

  after(:all) do
    @driver.quit unless debugging?
  end

  it "Can create a new correspondence" do
    @driver.page_source.should include("Ashgrove State School")
  end

  it "can edit existing correspondence" do
    @driver.find_element(:link_text, "Edit").click
    @driver.find_element(:name, "correspondence[description]").send_keys("Wrote a cover letter and post out the information booklet to Ashgrove West State School Support Services")
    @driver.find_element(:name, "commit").click # "Update"
    @driver.find_element(:link_text, "Edit").click
    @driver.page_source.should include("Ashgrove West State School")
  end

end
