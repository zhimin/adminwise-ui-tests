load File.dirname(__FILE__) + '/test_helper.rb'

specification "Correspondence" do
  include TestHelper

  before(:all) do
      @driver = Selenium::WebDriver.for(browser_type) # or :ie, :firefox, :chrome
      @driver.navigate.to($ITEST2_PROJECT_BASE_URL || $BASE_URL)
    reset_database
    failsafe{ logout }
    login_as("admin")
  end
  
  before(:each) do
    click_link("ADMINISTRATION")
    #click_link("Administration")
    click_link("Correspondence")
    click_link("New Correspondence")
    new_correspondence_page = expect_page NewCorrespondencePage
    new_correspondence_page.click_correspondence("Out")
    new_correspondence_page.enter_sender_receiver("Kelly Adell")
    new_correspondence_page.enter_description("Wrote a cover letter and post out the information booklet to Ashgrove State School Support Services")
    new_correspondence_page.click_add
  end
  
  after(:all) do
    close_browser unless debugging?
  end

  story "Can create a new correspondence" do
    page_text.should include("Ashgrove State School")
  end
  
  story "can edit existing correspondence" do
    click_link("Edit")
    enter_text("correspondence[description]", "Wrote a cover letter and post out the information booklet to Ashgrove West State School Support Services")
    click_button("Update")
    click_link("Edit")
    page_text.should include("Ashgrove West State School")
  end

end
