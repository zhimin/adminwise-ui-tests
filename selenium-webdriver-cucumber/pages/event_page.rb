# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class EventPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= 
  end

  def enter_venue(event_venue)
    browser.find_element(:name, "event[venue]").send_keys(event_venue)
  end

  def click_create
    browser.find_element(:id, "event_submit").click
  end

  def enter_presenters(event_presenters)
    browser.find_element(:name, "event[presenters]").send_keys(event_presenters)
  end

  def enter_date(event_date_from)
    browser.find_element(:name, "event[date_from]").send_keys(event_date_from)
  end
  
  def click_update
    browser.find_element(:id, "event_submit").click
  end
  
  def enter_name(name)
    browser.find_element(:name, "event[name]").send_keys(name)
  end

end
