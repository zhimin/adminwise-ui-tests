# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class MemberBorrowHistoryPage < RWebSpec::AbstractWebPage

  def initialize(browser)
    super(browser, "Member - Borrowing History ") # <= 
  end


end
