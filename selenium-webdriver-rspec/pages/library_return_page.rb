
class LibraryReturnPage < AbstractPage

  def initialize(driver)
    super(driver, "Library - Return Resources")
  end

  def click_process
    browser.find_element(:id, "process_btn").click
  end
  
  def enter_resource(resource)
    browser.find_element(:name, "item_physical_id").send_keys resource
  end
  
  def click_find
    browser.find_element(:id, "find_resource_item").click
  end

end
