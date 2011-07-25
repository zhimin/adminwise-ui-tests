class CreateUserPage < AbstractPage

  def initialize(browser)
    super(browser, "Register")
  end

  def enter_username(username)
    browser.text_field(:name, "username").set username
  end

  def enter_email(email)
    browser.text_field(:name, "email").set email
  end

  def enter_password(password)
    browser.text_field(:name, "password").set password
  end

  def click_create
    browser.button(:value, "Create User").click
  end
end
