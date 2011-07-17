TEST_DATA_DIR = "./features/test_data"

require 'rubygems'
require 'selenium-webdriver'

Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| require file }


if RUBY_PLATFORM =~ /mingw/ 
  browser = Selenium::WebDriver.for(:ie)   
else
  browser = Selenium::WebDriver.for(:firefox)   
end

browser.navigate.to("http://adminwise.agileway.net")
# browser.navigate.to("http://localhost:3000")

Before do
  @browser = browser
end

at_exit do
  browser.close if browser
end