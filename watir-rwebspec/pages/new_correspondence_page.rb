
class NewCorrespondencePage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_correspondence(correspondence_direction)
    click_radio_option("correspondence[direction]", correspondence_direction)
  end
  
  def enter_description(correspondence_description)
      enter_text("correspondence[description]", correspondence_description)
  end
  
  def click_add
      click_button("Add")
  end
  
  def enter_sender_receiver(sender_receiver)
    enter_text("correspondence[sender_receiver]", sender_receiver)
  end

end
