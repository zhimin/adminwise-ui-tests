# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class EventListPage < AbstractPage

  def initialize(browser)
    super(browser, "Listing events") # <= 
  end

  def edit(index)
    @driver.link(:id, "edit_#{index}").click
    EventPage.new(@browser) 
  end
  
  def click_new
    @driver.link(:text, "New event").click
    EventPage.new(@browser) 
  end
end
