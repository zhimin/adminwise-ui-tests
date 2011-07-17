TEST_DATA_DIR = "./features/test_data"

require 'rubygems'
require 'watir'

Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| require file }

browser = Watir::Browser.new
browser.goto("http://10.0.0.6:3000")
#browser.goto("http://adminwise.agileway.net")

Before do
  @browser = browser
end

at_exit do
  browser.close if browser
end