
class HomePage < AbstractPage

  def initialize(browser, identity_text='')
    super(browser)
    # If you want to verify page title, uncomment (remove leading #) in the line below 
    # title.should == "Smart eDA"
    @driver.text.should include(identity_text) unless identity_text.blank?
  end
  
  def enter_password(password)
    @driver.text_field(:name, "user[password]").set password
  end
  
  def click_login
    @driver.button(:value, "Log in").click
  end
  
  def enter_login(username)
    @driver.text_field(:name, "user[username]").set username
  end

end
