# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class PasswordChangePage < AbstractPage

  def initialize(browser)
    super(browser, "Change Password") # <= 
  end


  def enter_current(password)
    @driver.text_field(:name, "current_password").set password
  end

  def enter_new(new_pass)
    @driver.text_field(:name, "user[password]").set new_pass
  end

  def enter_confirm(confirm_pass)
    @driver.text_field(:name, "user[password_confirmation]").set confirm_pass
  end

end
