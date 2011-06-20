# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class LibraryReturnPage < RWebSpec::AbstractWebPage

  def initialize(browser)
    super(browser, "") # <= 
  end

  def click_process
    click_button("Process")
  end
  
  def enter_resource(resource)
    enter_text("item_physical_id", resource)
  end
  
  def click_find
    click_button("Find")
  end

end
