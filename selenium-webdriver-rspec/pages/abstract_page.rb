
class AbstractPage

  attr_accessor :driver
  
  def initialize(driver, text = nil)
    @driver = driver
    # @driver.page_source.should include(text) if @driver && text
  end

  
end