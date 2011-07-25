
class AbstractPage

  attr_accessor :driver

  def initialize(driver, identity_text = nil)
    @driver = driver    
    # browser.text.should contain(identity_text) unless identity_text.empty?
  end

  def browser
    @driver
  end

end
