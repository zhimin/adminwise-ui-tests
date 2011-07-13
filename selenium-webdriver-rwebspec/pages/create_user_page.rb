
class CreateUserPage < AbstractPage

  def initialize(browser)
    super(browser, "Register")
  end

  def enter_username(username)
    enter_text("username", username)
  end

  def enter_email(email)
    enter_text("email", email)
  end

  def enter_password(password)
    enter_text("password", password)
  end

  def click_create
    click_button("Create User")
  end
end
