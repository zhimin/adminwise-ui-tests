class EventRegistrationConfirmationPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_confirm
    browser.find_element(:id, "confirmBtn").click
  end

end
