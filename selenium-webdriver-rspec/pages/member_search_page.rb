# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class MemberSearchPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= 
  end

  def enter_name(member_name)
    enter_text("member_name", member_name)
  end

end
