
class AnswerCallPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def select_call_category(call_category)
    select_option("call_register[category]", call_category)
  end

  def enter_caller(call_caller)
    enter_text("call_register[caller]", call_caller)
  end

  def enter_caller_phone
    reset_database
  end

  def enter_caller_phone(call_caller_phone)
    enter_text("call_register[caller_phone]", call_caller_phone)
  end

  def click_non_member(call_non_member)
    click_radio_option("call_register[non_member]", call_non_member)
  end

  def click_hang_up
    click_button("Hang up")
  end
end
