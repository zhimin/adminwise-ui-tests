
class AnswerCallPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def select_call_category(call_category)
    select = @driver.find_element(:name, "call[category]")
    options = select.find_elements(:tag_name, "option")
    options.each do |opt|
      if opt.text == call_category then
        opt.click
        return
      end
    end
  end

  def enter_caller(call_caller)
    @driver.find_element(:name, "call[caller]").send_keys(call_caller)
  end

  def enter_caller_phone(call_caller_phone)
    @driver.find_element(:name, "call[caller_phone]").send_keys(call_caller_phone)
  end

  def click_non_member(call_non_member)
    radios = @driver.find_elements(:name, "call[non_member]")
    radios.each do |radio|
      radio.click if radio.attribute("value") == call_non_member
    end
  end

  def click_hang_up
    @driver.find_element(:name, "call[caller]").submit
  end
end
