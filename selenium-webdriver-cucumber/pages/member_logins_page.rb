class MemberLoginsPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_query(login)
    browser.find_element(:name, "search").send_keys(login)
  end

  def click_search
    browser.find_element(:name, "search").submit
    # click_button("Search")
  end
end
