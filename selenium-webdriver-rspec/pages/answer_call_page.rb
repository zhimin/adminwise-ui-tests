
class AnswerCallPage < AbstractPage

  def initialize(driver)
    debug driver.find_element(:tag_name, "body").text
    super(driver, "New Call")
  end

  def select_call_category(call_category)
    Selenium::WebDriver::Support::Select.new(browser.find_element(:id, "call_register_category")).select_by(:text, call_category)
  end

  def enter_caller(call_caller)
    browser.find_element(:id, "call_register_caller").send_keys(call_caller)
  end

  def enter_caller_phone(call_caller_phone)
    browser.find_element(:id, "call_register_caller_phone").send_keys(call_caller_phone)
  end

  def click_non_member(call_non_member)
    browser.find_element(:id, "call_register_non_member_true").click
  end

  def click_hang_up
    browser.find_element(:name, "commit").click
  end

end
