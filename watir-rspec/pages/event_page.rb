# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class EventPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= 
  end

  def enter_venue(event_venue)
    @driver.text_field(:name, "event[venue]").set event_venue
  end

  def click_create
    click_button("Create")
  end

  def enter_presenters(event_presenters)
    @driver.text_field(:name, "event[presenters]").set event_presenters
  end

  def enter_date(event_date_from)
    @driver.text_field(:name, "event[date_from]").set event_date_from
  end
  
  def click_update
    click_button("Update")
  end

  def enter_name(name)
    @driver.text_field(:name, "event[name]").set name
  end

end
