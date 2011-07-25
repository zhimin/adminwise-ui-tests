
class EventRegistrationConfirmationPage < AbstractPage

  def initialize(driver)
    super(driver, "")
  end

  def click_confirm
    browser.button(:value, "Confirm").click
  end

end
