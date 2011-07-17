class MemberLoginsPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_query(login)
    @driver.find_element(:name, "search").send_keys(login)
  end

  def click_search
    @driver.find_element(:name, "search").submit
    # click_button("Search")
  end
end
