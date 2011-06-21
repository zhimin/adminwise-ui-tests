# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class LibraryPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <=
  end

  def click_borrow
    @driver.link(:text, "Borrow").click
  end

  def add_new_resources
    @driver.link(:text, "Add new resources").click
  end

  def enter_query(q)
    @driver.text_field(:name, "q").set q
  end

  def click_search
    @driver.button(:value, "search").click
  end

  def click_return
    @driver.link(:text, "Return").click
  end

  def add_manually
    @driver.link(:text, "Add New resource manually").click
  end

end
