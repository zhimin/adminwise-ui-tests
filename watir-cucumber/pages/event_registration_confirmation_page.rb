
class EventRegistrationConfirmationPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_confirm
    @driver.button(:value, "Confirm").click
  end

end
