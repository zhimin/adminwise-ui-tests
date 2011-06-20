load File.dirname(__FILE__) + '/test_helper.rb'

specification "Professionals" do
  include TestHelper

  before(:all) do
    @driver = Watir::Browser.new
    reset_database
    failsafe{ logout }
    login_as("admin")
  end

  before(:each) do
   link(:text, "Administration").click
   link(:text, "Professionals").click
  end
    
  after(:all) do
    fail_safe { logout } unless debugging?
    # close_browser if is_windows? and is_firefox?
  end

  story "[496] Admin User can add a professional" do
    link(:text, "New Professional").click
    new_professional_page = NewProfessionalPage.new(driver)
    new_professional_page.select_category("Centre Based Early Intervention Programs")
    new_professional_page.enter_principal_name("Jane Steel")
    new_professional_page.enter_contact("Jenny")
    new_professional_page.enter_organisation_name("Focus Speech")
    new_professional_page.click_create
    try(10) { @driver.text.should contain("Professionals List") }
    @driver.text.should contain("Jane Steel")
  end
  
  story "[497] Admin user sort professional by category" do
    link(:text, "Category").click
    try(3) { cell(:id, "category_0").text.should == "Speech Pathlogists" }
    link(:text, "Category").click
    try(3) { cell(:id, "category_0").text.should == "Auditory Integration Training" }
  end
  
end
