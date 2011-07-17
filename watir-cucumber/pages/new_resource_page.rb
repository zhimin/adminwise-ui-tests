# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class NewResourcePage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= 
  end

  def select_subject(resource_subject)
    @driver.select_list(:name, "resource[subject]").set resource_subject
  end
  
  def click_create
    @driver.button(:value, "Create").click
  end

  def enter_title(title)
    @driver.text_field(:name, "resource[title]").set title
  end
  
  def enter_authors(resource_authors)
    @driver.text_field(:name, "resource[authors]").set resource_authors
  end

end
