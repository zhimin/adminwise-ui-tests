# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class NewResourcePage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= 
  end

  def select_subject(resource_subject)
    browser.find_element(:name, "resource[subject]").send_keys(resource_subject)
  end
  
  def click_create
    browser.find_element(:name, "commit").click
  end

  def enter_title(title)
    browser.find_element(:name, "resource[title]").send_keys(title)
  end
  
  def enter_authors(resource_authors)
    browser.find_element(:name, "resource[authors]").send_keys(resource_authors)
  end

end
