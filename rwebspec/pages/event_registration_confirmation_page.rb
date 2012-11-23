class EventRegistrationConfirmationPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_confirm
    click_button("Confirm")
  end

end
