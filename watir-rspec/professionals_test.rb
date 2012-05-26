load File.dirname(__FILE__) + '/test_helper.rb'

describe "Professionals" do
  include TestHelper

  before(:all) do
    @browser = Watir::Browser.new
    reset_database
    logout
    login_as("admin")
  end

  before(:each) do
   @browser.link(:text, "Administration").click
   @browser.link(:text, "Professionals").click
  end
    
  after(:all) do
    logout  unless debugging?
    @browser.close unless debugging?
  end

  it "[496] Admin User can add a professional" do
    @browser.link(:text, "New Professional").click
    new_professional_page = NewProfessionalPage.new(@browser)
    new_professional_page.select_category("Centre Based Early Intervention Programs")
    new_professional_page.enter_principal_name("Jane Steel")
    new_professional_page.enter_contact("Jenny")
    new_professional_page.enter_organisation_name("Focus Speech")
    new_professional_page.click_create
    try_until(10) { @browser.text.should include("Professionals List") }
    @browser.text.should include("Jane Steel")
  end
  
  it "[497] Admin user sort professional by category" do
    @browser.link(:text, "Category").click
    try_until(3) { @browser.cell(:id, "category_0").text.should == "Speech Pathlogists" }
    @browser.link(:text, "Category").click
    try_until(3) { @browser.cell(:id, "category_0").text.should == "Auditory Integration Training" }
  end
  
end
