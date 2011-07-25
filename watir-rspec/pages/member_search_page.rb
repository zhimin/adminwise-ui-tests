# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class MemberSearchPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= 
  end

  def enter_name(member_name)
    browser.text_field(:name, "member_name").set member_name
  end

end
