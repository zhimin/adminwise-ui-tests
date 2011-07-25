# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class LibraryBorrowPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <=
  end

  def click_find_member
    browser.find_element(:id, "find_member_btn").click # click_button("Find member")
  end
  
  def enter_resource(resource)
    browser.find_element(:id, "resource_textbox_q").send_keys(resource)
  end

  def click_find_resource
    browser.find_element(:id, "find_resource_btn").click # click_button("Find resource")
  end

  def click_select
    sleep 1
    browser.find_element(:link_text, "Select").click
  end

  def click_process
    sleep 1
    browser.find_element(:id, "process_btn").click
    # click_button("Process")
  end

  def enter_member_name(name)
    browser.find_element(:id, "member_textbox_q").send_keys(name)
  end

end
