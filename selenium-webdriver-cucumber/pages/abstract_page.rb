class AbstractPage
  
  def initialize(driver, text = nil)
    @browser = driver
    # browser.page_source.should include(text) if @driver && text
  end

  def browser
    @browser
  end
  
end