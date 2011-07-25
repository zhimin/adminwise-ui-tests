# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class EventListPage < AbstractPage

  def initialize(browser)
    super(browser, "Listing events") # <= 
  end

  def edit(index)
    browser.find_element(:id,"edit_#{index}").click
    EventPage.new(@driver)
  end
  
  def click_new
    browser.find_element(:link_text, "New event").click
    EventPage.new(@driver) 
  end
end
