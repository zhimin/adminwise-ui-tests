class AbstractPage

  # If want to use utility methods such as fail_safe { }, uncomment the line below 
  # 
  include RWebSpecUtils

  # If want to use debug('message') to TestWise Console, uncomment the line below
  #
  include TestWiseSupport

  def initialize(driver, identity_text = nil)
    @browser = driver    
    # browser.text.should contain(identity_text) unless identity_text.empty?
  end

  def browser
    @browser
  end

end
