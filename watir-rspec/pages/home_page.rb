
class HomePage < AbstractPage

  def initialize(driver, identity_text='')
    super(driver, identity_text)
  end
  
  def enter_password(password)
    browser.text_field(:name, "password").set password
  end
  
  def click_login
    browser.button(:value, "Sign In").click
  end
  
  def enter_login(username)
    browser.text_field(:name, "username").set username
  end

end
