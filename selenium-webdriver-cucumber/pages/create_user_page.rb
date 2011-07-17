class CreateUserPage < AbstractPage

  def initialize(browser)
    super(browser, "Register")
  end

  def enter_username(username)
    driver.find_element(:name, "username").send_keys(username)    
  end

  def enter_email(email)
    driver.find_element(:name, "email").send_keys(email)    
  end

  def enter_password(password)
    driver.find_element(:name, "password").send_keys(password)    
  end

  def click_create
    # click_button("Create User")
    driver.find_element(:name, "password").submit()
  end
end
