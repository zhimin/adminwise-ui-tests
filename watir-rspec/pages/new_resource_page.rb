# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class NewResourcePage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= 
  end

  def select_subject(resource_subject)
    browser.select_list(:name, "resource[subject]").select resource_subject
  end
  
  def click_create
    browser.button(:value, "Create").click
  end

  def enter_title(title)
    browser.text_field(:name, "resource[title]").set title
  end
  
  def enter_authors(resource_authors)
    browser.text_field(:name, "resource[authors]").set resource_authors
  end

end
