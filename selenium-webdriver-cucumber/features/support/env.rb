TEST_DATA_DIR = "./features/test_data"

require 'rubygems'
require 'selenium-webdriver'
require 'test/unit/assertions'

require File.join(File.dirname(__FILE__), "..","..", "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| load file }

# Can't use reload
# Dir["#{File.dirname(__FILE__)}/../step_definitions/*_steps.rb"].each { |file| load file }

$BASE_URL = $TESTWISE_PROJECT_BASE_URL || $ITEST2_PROJECT_BASE_URL || ENV["ADMINWISE_URL"] || "http://adminwise.heroku.com"

browser_type = $TESTWISE_BROWSER.downcase.to_sym rescue nil  # set by TestWise if running in TestWise
browser_type = RUBY_PLATFORM =~ /mingw/ ? :ie : :firefox
browser = Selenium::WebDriver.for(browser_type) 
World(Test::Unit::Assertions)

# browser.navigate.to("http://adminwise.agileway.net")
# browser.navigate.to("http://localhost:3000")

Before do
  @browser = browser
  reset_database
end

After do |scenario|
  if scenario.failed?
    puts "Scenario failed: #{scenario.inspect} | #{scenario.exception.message}"
  end
end

at_exit do
  browser.quit if browser unless $ITEST2_DEBUGGING || $TESTWISE_DEBUGGING
end


# Helper methods 

def reset_database
  @browser.navigate.to("#{$BASE_URL}/reset")
  @browser.navigate.to("#{$BASE_URL}/")
end
