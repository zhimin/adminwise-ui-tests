class EventRegistrationConfirmationPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_confirm
    browser.find_element(:id, "confirmBtn").click
  end

end
