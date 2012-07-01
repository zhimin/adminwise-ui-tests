
class LibraryBorrowPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <=
  end

  def click_find_member
    click_button("Find")
  end
  
  def enter_resource(resource)
    text_field(:id, "resource_textbox_q").set(resource)
  end

  def click_find_resource
    click_button("Find resource")
  end

  def click_select
    sleep 1
    click_link("Select")
  end

  def click_process
    sleep 1
    click_button("Process")
  end

  def enter_member_name(name)
    text_field(:id, "member_textbox_q").set(name)
  end

end
