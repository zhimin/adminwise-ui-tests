# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class LibraryBorrowPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <=
  end

  def click_find_member
    @browser.button(:value, "Find member").click
  end
  
  def enter_resource(resource)
    @browser.text_field(:id, "resource_textbox_q").set(resource)
  end

  def click_find_resource
    @browser.button(:value, "Find resource").click
  end

  def click_select
    sleep 1
    @browser.link(:text, "Select").click
  end

  def click_process
    sleep 1
    @browser.button(:value, "Process").click
  end

  def enter_member_name(name)
    @browser.text_field(:id, "member_textbox_q").set(name)
  end

end
