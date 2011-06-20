
class AbstractPage

  attr_accessor :driver

  def initialize(driver, text = nil)
    @driver = driver
  end


end
