TEST_DATA_DIR = "./features/test_data"

require 'rubygems'
require 'selenium-webdriver'

Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| require file }


browser = Selenium::WebDriver.for(:firefox)   
# browser.navigate.to("http://adminwise.agileway.net")
browser.navigate.to("http://localhost:3000")

Before do
  @browser = browser
end

at_exit do
  browser.close if browser
end