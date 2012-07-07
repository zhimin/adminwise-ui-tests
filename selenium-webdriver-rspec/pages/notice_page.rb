# encoding: utf-8
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class NoticePage < AbstractPage

  def initialize(driver)
    super(driver, "")
  end

  def click_edit
    browser.find_element(:link, "Edit").click
  end
  
end
