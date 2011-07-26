# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class EventListPage < AbstractPage

  def initialize(driver)
    super(driver, "Listing events") # <= 
  end

  def edit(index)
    browser.find_element(:id,"edit_#{index}").click
    EventPage.new(browser)
  end
  
  def click_new
    browser.find_element(:link_text, "New event").click
    EventPage.new(browser) 
  end
end
