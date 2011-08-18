class LibraryReturnPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= 
  end

  def click_process
    browser.button(:value, "Process").click
  end
  
  def enter_resource(resource)
    browser.text_field(:name, "item_physical_id").set resource
  end
  
  def click_find
    browser.button(:value, "Find").click
  end

end
