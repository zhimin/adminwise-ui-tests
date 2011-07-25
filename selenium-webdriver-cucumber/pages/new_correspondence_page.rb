
class NewCorrespondencePage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_correspondence(correspondence_direction)
    radios = browser.find_elements(:name, "correspondence[direction]")
    radios.each do |radio| 
      radio.click if correspondence_direction == radio.attribute("value")
    end
  end

  def enter_description(correspondence_description)
    browser.find_element(:name, "correspondence[description]").send_keys(correspondence_description)
  end

  def enter_sender_receiver(sender_receiver)
    browser.find_element(:name, "correspondence[sender_receiver]").send_keys(sender_receiver)
  end

  def click_add
    # click_button("Add")
    browser.find_element(:name, "correspondence[sender_receiver]").submit
  end

end
