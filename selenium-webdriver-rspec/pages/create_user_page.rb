class CreateUserPage < AbstractPage

  def initialize(driver)
    super(driver, "Register User")
  end

  def enter_username(username)
    browser.find_element(:name, "user[username]").send_keys(username)
  end

  def enter_email(email)
    browser.find_element(:name, "user[email]").send_keys(email)
  end

  def enter_password(password)
    browser.find_element(:name, "user[password]").send_keys(password)
  end

  def click_create
    # click_button("Create User")
    # the below seems more reliable for all browsers 
    browser.find_element(:name, "user[password]").submit()
  end
end
