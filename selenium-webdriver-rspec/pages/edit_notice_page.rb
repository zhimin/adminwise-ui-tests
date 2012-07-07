# encoding: utf-8
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class EditNoticePage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_header(notice_header)
    browser.find_element(:name, "notice[header]").send_keys(notice_header)
  end

  def enter_body(notice_body)
    browser.find_element(:name, "notice[body]").send_keys(notice_body)
  end

  def select_severity(notice_severity)
    Selenium::WebDriver::Support::Select.new(browser.find_element(:id, "notice_severity")).select_by(:text, notice_severity)
  end
  
  def check_active
    unless browser.find_element(:id, "notice_active").selected? 
      browser.find_element(:id, "notice_active").click
    end
  end

  def uncheck_active
    if browser.find_element(:id, "notice_active").selected? 
      browser.find_element(:id, "notice_active").click
    end
  end

  def select_start_year(year)
    Selenium::WebDriver::Support::Select.new(browser.find_element(:id, "notice_start_time_1i")).select_by(:text, year.to_s)
  end

  def select_end_year(year)
    Selenium::WebDriver::Support::Select.new(browser.find_element(:id, "notice_end_time_1i")).select_by(:text, year.to_s)
  end

  def click_save
    browser.find_element(:id, "save_notice_button").click
  end 

end
