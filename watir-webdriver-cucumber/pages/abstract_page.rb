# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage

  def initialize(driver, text = "")
    @browser = driver	
  end

  def browser
    @browser
  end
end
