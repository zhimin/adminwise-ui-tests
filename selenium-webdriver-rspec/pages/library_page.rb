# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class LibraryPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <=
  end

  def click_borrow
    browser.find_element(:link_text, "Borrow").click
  end

  def add_new_resources
    browser.find_element(:link_text, "Add new resources").click
  end

  def enter_query(q)
    browser.find_element(:name, "q").send_keys(q)
  end

  def click_search
    browser.find_element(:name, "commit").click
    # click_button("search")
  end

  def click_return
    browser.find_element(:link_text, "Return").click
  end

  def add_manually
    browser.find_element(:link_text, "Add New resource manually").click
  end

end
