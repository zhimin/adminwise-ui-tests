
class LibraryPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <=
  end

  def click_borrow
    browser.link(:text, "Borrow").click
  end

  def add_new_resources
    browser.link(:text, "Add new resources").click
  end

  def enter_query(q)
    browser.text_field(:name, "q").set q
  end

  def click_search
    browser.button(:value, "search").click
  end

  def click_return
    browser.link(:text, "Return").click
  end

  def add_manually
    browser.link(:text, "Add New resource manually").click
  end

end
