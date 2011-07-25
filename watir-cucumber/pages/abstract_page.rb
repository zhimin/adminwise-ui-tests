
class AbstractPage

  attr_accessor :driver

  def initialize(driver, text = nil)
    @browser = driver
  end


end
