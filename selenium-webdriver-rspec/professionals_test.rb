load File.dirname(__FILE__) + '/test_helper.rb'

describe "Professionals" do
  include TestHelper

  before(:all) do
    $browser = @browser = Selenium::WebDriver.for(browser_type) 
    @browser.navigate.to($BASE_URL)
    reset_database
    fail_safe{ logout }
    login_as("bob")
  end

  before(:each) do
   @browser.find_element(:link_text, "Professionals").click
  end
    
  after(:all) do
    fail_safe { logout } unless debugging?
    @browser.quit unless debugging?
  end

  it "[496] Admin User can add a professional" do
    @browser.find_element(:link_text, "New Professional").click
    new_professional_page = NewProfessionalPage.new(@browser)
    new_professional_page.select_category("Centre Based Early Intervention Programs")
    new_professional_page.enter_principal_name("Jane Steel")
    new_professional_page.enter_contact("Jenny")
    new_professional_page.enter_organisation_name("Focus Speech")
    new_professional_page.click_create
    try_until(10) { @browser.page_source.should include("Professionals List") }
    @browser.page_source.should include("Jane Steel")
  end
  
  it "[497] Admin user sort professional by category" do
    @browser.find_element(:link_text, "Category").click
    try_until(3) { @browser.find_element(:id, "category_0").text.should == "Speech Pathlogists" }
    @browser.find_element(:link_text, "Category").click  
    try_until(3) { @browser.find_element(:id, "category_0").text.should == "Auditory Integration Training" }
  end
  
end
