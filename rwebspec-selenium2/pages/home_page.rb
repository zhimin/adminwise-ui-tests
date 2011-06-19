
class HomePage < RWebSpec::AbstractWebPage

  def initialize(browser, identity_text='')
    super(browser)
    # If you want to verify page title, uncomment (remove leading #) in the line below 
    # title.should == "Smart eDA"
    assert_text_present(identity_text) unless identity_text.blank?
  end
  def enter_password(password)
    enter_text("user[password]", password)
  end
  def click_login
    click_button("Log in")
  end
  
  def enter_login(username)
    enter_text("user[username]", username)
  end

end
