
class AbstractPage

  attr_accessor :driver

  def initialize(driver, text = nil)
    @driver = driver
  end

  def browser
    @driver
  end

end
