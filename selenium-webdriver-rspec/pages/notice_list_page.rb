# encoding: utf-8
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class NoticeListPage < AbstractPage

  def initialize(driver)
    super(driver, "") 
  end

  def click_new_notice
    browser.find_element(:id, "new_notice_link").click
  end
  
end
