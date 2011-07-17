require 'rwebspec'

class LibrarySearchPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_query(query)
    @driver.find_element(:name, "q").send_keys query
  end

  def click_search
    @driver.find_element(:name, "commit").click # Search button
  end
end
