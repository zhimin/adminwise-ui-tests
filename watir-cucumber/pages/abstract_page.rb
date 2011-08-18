class AbstractPage

  def initialize(driver, identity_text = nil)
    @browser = driver    
    # browser.text.should contain(identity_text) unless identity_text.empty?
  end

  def browser
    @browser
  end

end
