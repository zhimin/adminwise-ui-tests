require 'rwebspec'

class LibrarySearchPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_query(query)
    browser.find_element(:name, "q").send_keys query
  end

  def click_search
    browser.find_element(:name, "commit").click # Search button
  end
end
