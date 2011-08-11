require File.join(File.dirname(__FILE__), "abstract_page.rb")

class RegisterPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

def register_page
  register_page = RegisterPage.new(@browser)
end

def register_page
  @browser.link(:text, link).click
end

def register_page
  
end
end
