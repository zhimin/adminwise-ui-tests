# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class LibraryPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <=
  end

  def click_borrow
    @driver.find_element(:link_text, "Borrow").click
  end

  def add_new_resources
    @driver.find_element(:link_text, "Add new resources").click
  end

  def enter_query(q)
    @driver.find_element(:name, "q").send_keys(q)
  end

  def click_search
    @driver.find_element(:name, "commit").click
    # click_button("search")
  end

  def click_return
    @driver.find_element(:link_text, "Return").click
  end

  def add_manually
    @driver.find_element(:link_text, "Add New resource manually").click
  end

end
