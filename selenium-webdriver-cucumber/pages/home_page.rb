
class HomePage < AbstractPage

  def initialize(browser, identity_text='')
    super(browser)
    browser.page_source.should(identity_text) unless identity_text.blank?
  end
  
  def enter_password(password)
    browser.find_element(:name, "user[password]").clear
    browser.find_element(:name, "user[password]").send_keys(password)
  end
  
  def click_login
    browser.find_element(:name, 'user[password]').submit();
  end
  
  def enter_login(username)
    browser.find_element(:name, "user[username]").send_keys(username)
  end

end
