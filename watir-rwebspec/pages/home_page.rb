
class HomePage < AbstractPage

  def initialize(browser, identity_text='')
    super(browser)
    assert_text_present(identity_text) unless identity_text.blank?
  end

  def enter_username(username)
    enter_text("user[username]", username)
  end
  
  def enter_password(password)
    enter_text("user[password]", password)
  end

  def click_login
    click_button("Log in")
  end

end
