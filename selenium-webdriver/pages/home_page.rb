
class HomePage < AbstractPage

  def initialize(browser, identity_text='')
    super(browser)
    assert_text_present(identity_text) unless identity_text.blank?
  end
  
  def enter_password(password)
    @driver.find_element(:name, 'user[password]').send_keys(password)
  end
  
  def click_login
    @driver.find_element(:name, 'user[password]').submit();
#    driver.find_element(:text, "Log in").click
    # click_button("Log in")
  end
  
  def enter_login(username)
    @driver.find_element(:name, 'user[username]').send_keys(username)
  end

end
