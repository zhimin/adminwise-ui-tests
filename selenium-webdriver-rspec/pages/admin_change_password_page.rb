require File.join(File.dirname(__FILE__), "abstract_page.rb")

class AdminChangePasswordPage < AbstractPage

  def initialize(driver)
    super(driver, "Change Password for")
  end

  def enter_password(user_password)
    @browser.find_element(:name, "user[password]").send_keys(user_password)
  end

  def enter_password_confirmation(user_password_confirmation)
    # TODO: extract page shall repalce [] to _ 
    # @browser.find_element(:name, "user[password_confirmation]").send_keys(user[password_confirmation])
    @browser.find_element(:name, "user[password_confirmation]").send_keys(user_password_confirmation)
  end

  def click_change
    @browser.find_element(:name, "commit").click
  end

end
