require File.join(File.dirname(__FILE__), "abstract_page.rb")

class AdminEditUserProfilePage < AbstractPage

  def initialize(driver)
    super(driver, "Edit User")
  end

  def enter_email(user_email)
    @browser.find_element(:name, "user[email]").clear
    @browser.find_element(:name, "user[email]").send_keys(user_email)
  end
  
  def click_save
    @browser.find_element(:id, "update_user_btn").click
  end

end
