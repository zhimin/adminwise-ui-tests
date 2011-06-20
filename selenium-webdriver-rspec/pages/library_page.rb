# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class LibraryPage < RWebSpec::AbstractWebPage

  def initialize(browser)
    super(browser, "") # <=
  end

  def click_borrow
    click_link("Borrow")
  end

  def add_new_resources
    click_link("Add new resources")
  end

  def enter_query(q)
    enter_text("q", q)
  end

  def click_search
    click_button("search")
  end

  def click_return
    click_link("Return")
  end

  def add_manually
    click_link("Add New resource manually")
  end

end
