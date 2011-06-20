# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class LibraryReturnPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= 
  end

  def click_process
    click_button("Process")
  end
  
  def enter_resource(resource)
    @driver.text_field(:name, "item_physical_id").set resource
  end
  
  def click_find
    click_button("Find")
  end

end
