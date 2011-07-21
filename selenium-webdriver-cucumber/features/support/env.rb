TEST_DATA_DIR = "./features/test_data"

require 'rubygems'
require 'selenium-webdriver'

require File.join(File.dirname(__FILE__), "..","..", "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| load file }

browser = Selenium::WebDriver.for(browser_type)  # set by TestWise if running in TestWise

$BASE_URL = "http://adminwise.heroku.com"
# browser.navigate.to("http://adminwise.agileway.net")
# browser.navigate.to("http://localhost:3000")

Before do
  @browser = browser
end

After do |scenario|
  if scenario.failed?
    puts "Scenario failed: #{scenario.inspect} | #{scenario.exception.message}"
  end
end

at_exit do
  browser.quit if browser
end


# Helper methods 

def browser_type
  return $ITEST2_BROWSER.downcase.to_sym if $ITEST2_BROWSER
  RUBY_PLATFORM =~ /mingw/ ? :ie : :firefox
end

def reset_database
  base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL
  @browser.navigate.to("#{base_url}/reset")
  @browser.navigate.to("#{base_url}/")
end
