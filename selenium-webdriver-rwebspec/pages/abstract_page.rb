require 'rwebspec-webdriver'

class AbstractPage < RWebSpec::WebDriver::AbstractWebPage

  def initialize(browser, text = "")
    super(browser, text)
  end

end
