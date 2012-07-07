load File.dirname(__FILE__) + '/test_helper.rb'

describe "Correspondence" do
  include TestHelper

  before(:all) do
    @browser = $browser = Selenium::WebDriver.for(browser_type) # or :ie, :firefox, :chrome
    @browser.navigate.to($BASE_URL)
    reset_database
    failsafe{ logout }
    login_as("bob")
  end

  before(:each) do
    @browser.find_element(:link_text,"Correspondences").click
    @browser.find_element(:link_text,"New Correspondence").click

    new_correspondence_page = NewCorrespondencePage.new(@browser)
    new_correspondence_page.click_correspondence("Out")
    new_correspondence_page.enter_sender_receiver("Kelly Adell")
    new_correspondence_page.enter_description("Wrote a cover letter and post out the information booklet to Ashgrove State School Support Services")
    new_correspondence_page.click_add
  end

  after(:all) do
    @browser.quit unless debugging?
  end

  it "Can create a new correspondence" do
    @browser.page_source.should include("Ashgrove State School")
  end

  it "can edit existing correspondence" do
    @browser.find_element(:link_text, "Edit").click
    @browser.find_element(:name, "correspondence[description]").send_keys("Wrote a cover letter and post out the information booklet to Ashgrove West State School Support Services")
    @browser.find_element(:name, "commit").click # "Update"
    @browser.find_element(:link_text, "Edit").click
    @browser.page_source.should include("Ashgrove West State School")
  end

end
