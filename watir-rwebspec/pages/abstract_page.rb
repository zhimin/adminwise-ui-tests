require 'rwebspec'

class AbstractPage < RWebSpec::AbstractWebPage

  def initialize(browser, text="")
    super(browser, text)
  end

end