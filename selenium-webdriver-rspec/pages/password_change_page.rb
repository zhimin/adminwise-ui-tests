# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class PasswordChangePage < AbstractPage

  def initialize(browser)
    super(browser, "Change Password") # <= 
  end

  def enter_current(password)
    @driver.find_element(:name, "current_password").send_keys(password)
  end

  def enter_new(new_pass)
    @driver.find_element(:name, "user[password]").send_keys(new_pass)
  end

  def enter_confirm(confirm_pass)
    @driver.find_element(:name, "user[password_confirmation]").send_keys(confirm_pass)
  end
  
  def click_change
      click_button("Change")
  end

end
