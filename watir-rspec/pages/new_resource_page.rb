# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class NewResourcePage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= 
  end

  def select_subject(resource_subject)
    select_option("resource[subject]", resource_subject)
  end
  
  def click_create
    click_button("Create")
  end

  def enter_title(title)
    @driver.text_field(:name, "resource[title]").set title
  end
  
  def enter_authors(resource_authors)
    @driver.text_field(:name, "resource[authors]").set resource_authors
  end

end
