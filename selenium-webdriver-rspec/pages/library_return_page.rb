# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class LibraryReturnPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= 
  end

  def click_process
    click_button("Process")
  end
  
  def enter_resource(resource)
    browser.find_element(:name, "item_physical_id").send_keys resource
  end
  
  def click_find
    click_button("Find")
  end

end
