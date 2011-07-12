load File.dirname(__FILE__) + '/test_helper.rb'

specification "User Profile" do
  include TestHelper

  before(:all) do
    open_browser
    reset_database
    failsafe{ logout }
  end

  after(:all) do
    fail_safe { logout } unless debugging?
    close_browser unless debugging?
  end

  story "[481] User can change password" do
    login_as("bob", "test")
    click_link("Profile")
    click_link("Change password")
    
    password_change_page = expect_page PasswordChangePage
    password_change_page.enter_current("password")
    password_change_page.enter_new("newpass")
    password_change_page.enter_confirm("newpass2")
    password_change_page.click_button("Change")
    
    page_text.should contain("Password doesn't match confirmation")
    password_change_page.enter_confirm("newpass")
    password_change_page.click_button("Change")

    logout
    login_as("bob", "newpass")
    assert_link_present_with_text("Profile") # login Ok
  end

end
