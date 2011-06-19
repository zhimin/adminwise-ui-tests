# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class PasswordChangePage < RWebSpec::AbstractWebPage

  def initialize(browser)
    super(browser, "Change Password") # <= 
  end


  def enter_current(password)
    enter_text("current_password", password)
  end

  def enter_new(new_pass)
    enter_text("user[password]", new_pass)
  end

  def enter_confirm(confirm_pass)
    enter_text("user[password_confirmation]", confirm_pass)
  end

end
