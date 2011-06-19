load File.dirname(__FILE__) + '/test_helper.rb'

specification "Professionals" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
    login_as("admin")
  end

  before(:each) do
   click_link("Administration")
   click_link("Professionals")
  end
    
  after(:all) do
    fail_safe { logout } unless debugging?
    # close_browser if is_windows? and is_firefox?
  end

  story "[496] Admin User can add a professional" do
    click_link("New Professional")
    new_professional_page = expect_page NewProfessionalPage
    new_professional_page.select_category("Centre Based Early Intervention Programs")
    new_professional_page.enter_principal_name("Jane Steel")
    new_professional_page.enter_contact("Jenny")
    new_professional_page.enter_organisation_name("Focus Speech")
    new_professional_page.click_create
    try(10) { page_text.should contain("Professionals List") }
    page_text.should contain("Jane Steel")
  end
  
  story "[497] Admin user sort professional by category" do
    click_link("Category")  
    try(3) { cell(:id, "category_0").text.should == "Speech Pathlogists" }
    click_link("Category")  
    try(3) { cell(:id, "category_0").text.should == "Auditory Integration Training" }
  end
  
end
