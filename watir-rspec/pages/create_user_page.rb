class CreateUserPage < AbstractPage

  def initialize(browser)
    super(browser, "Register")
  end

  def enter_username(username)
    @driver.text_field(:name, "username").set username
  end

  def enter_email(email)
    @driver.text_field(:name, "email").set email
  end

  def enter_password(password)
    @driver.text_field(:name, "password").set password
  end

  def click_create
    click_button("Create User")
  end
end
