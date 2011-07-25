
class AbstractPage

  attr_accessor :driver
  
  def initialize(driver, text = nil)
    @driver = driver
    # browser.page_source.should include(text) if @driver && text
  end

  def browser
    @driver
  end
  
end