# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class ChangePasswordPage < RWebSpec::AbstractWebPage

  def initialize(browser)
    super(browser, "") # <= 
  end


  def enter_current_password(password="password")
    # implementions here
  end

  def enter_new(new="new")
    # implementions here
  end

  def enter_confirmation(new="new")
    # implementions here
  end

end
