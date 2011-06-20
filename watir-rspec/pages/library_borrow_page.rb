# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class LibraryBorrowPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <=
  end

  def click_find_member
    click_button("Find member")
  end
  
  def enter_resource(resource)
    @driver.text_field(:id, "resource_textbox_q").set(resource)
  end

  def click_find_resource
    click_button("Find resource")
  end

  def click_select
    sleep 1
    @driver.link(:text, "Select").click
  end

  def click_process
    sleep 1
    click_button("Process")
  end

  def enter_member_name(name)
    @driver.text_field(:id, "member_textbox_q").set(name)
  end

end
