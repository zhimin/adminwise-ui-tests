# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class EventPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <=
  end

  def enter_venue(event_venue)
    browser.text_field(:name, "event[venue]").set event_venue
  end

  def click_create
    browser.button(:value, "Create").click
  end

  def enter_presenters(event_presenters)
    browser.text_field(:name, "event[presenters]").set event_presenters
  end

  def enter_date(event_date_from)
    browser.text_field(:name, "event[date_from]").set event_date_from
  end

  def click_update
    browser.button(:value, "Update").click
  end

  def enter_name(name)
    browser.text_field(:name, "event[name]").set name
  end

end
