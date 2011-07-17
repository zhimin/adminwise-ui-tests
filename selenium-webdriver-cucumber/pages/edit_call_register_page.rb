require File.join(File.dirname(__FILE__), "abstract_page.rb")

class EditCallRegisterPage < AbstractPage

  def initialize(browser)
    super(browser, "Call Register - Edit")
  end

  def select_member_yes
    radios = @driver.find_elements(:name, "call[non_member]")
    radios.each do |radio|
      radio.click if radio.attribute("value") == "false"
    end
  end

  def click_update
    @driver.find_element(:name, "commit").click # Update button
  end
  
  def assert_member_yes
    radios = @driver.find_elements(:name, "call[non_member]")
    radios.each do |radio|
      if radio.attribute("value") == "false"
        raise "expected radio option not selected" unless radio.selected?
      end
    end
  end
end
