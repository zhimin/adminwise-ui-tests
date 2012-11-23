
class CreateUserPage < AbstractPage

  def initialize(browser)
    super(browser, "Register")
  end

  def enter_username(username)
    enter_text("user[username]", username)
  end

  def enter_email(email)
    enter_text("user[email]", email)
  end

  def enter_password(password)
    enter_text("user[password]", password)
  end

  def click_create
    click_button("Create")
  end
end
