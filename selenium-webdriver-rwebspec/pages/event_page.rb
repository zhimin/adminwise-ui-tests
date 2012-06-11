
class EventPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= 
  end

  def enter_venue(event_venue)
    enter_text("event[venue]", event_venue)
  end

  def click_create
    click_button("Create")
  end

  def enter_presenters(event_presenters)
    enter_text("event[presenters]", event_presenters)
  end

  def enter_date(event_date_from)
    enter_text("event[date_from]", event_date_from)
  end
  
  def click_update
    click_button("Save")
  end
    
  def enter_name(name)
    enter_text("event[name]", name)
  end

end
