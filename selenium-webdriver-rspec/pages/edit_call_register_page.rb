require File.join(File.dirname(__FILE__), "abstract_page.rb")

class EditCallRegisterPage < AbstractPage

  def initialize(driver)
    super(driver, "Edit Call")
  end

  def select_member_yes
    browser.find_element(:id, "call_register_non_member_false").click
  end

  def click_update
    browser.find_element(:name, "commit").click # Save button
  end
  
  def assert_member_yes
    radios = browser.find_elements(:name, "call_register[non_member]")
    radios.each do |radio|
      if radio.attribute("value") == "false"
        raise "expected radio option not selected" unless radio.selected?
      end
    end
  end
end
