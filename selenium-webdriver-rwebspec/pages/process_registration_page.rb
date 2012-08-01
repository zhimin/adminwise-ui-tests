require File.join(File.dirname(__FILE__), "abstract_page.rb")

class ProcessRegistrationPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_amount(payment_amount)
    enter_text("payment[amount]", payment_amount)
  end

  def select_payment_method(payment_method)
    select_option("payment[method]", payment_method)
  end

  def enter_invoice(payment_invoice_number)
    enter_text("payment[invoice_number]", payment_invoice_number)
  end

  def enter_receipt(payment_receipt_number)
    enter_text("payment[receipt_number]", payment_receipt_number)
  end

  def enter_comments(payment_comments)
    enter_text("payment[comments]", payment_comments)
  end

  def click_accept_payment
    click_button("Accept payment")
    a = browser.driver.switch_to.alert
    a.accept
  end

  def click_activate
    click_button("Activate")
  end

end
