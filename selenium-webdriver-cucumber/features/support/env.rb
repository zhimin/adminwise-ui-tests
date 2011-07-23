TEST_DATA_DIR = "./features/test_data"

require 'rubygems'
require 'selenium-webdriver'
require 'test/unit/assertions'

require File.join(File.dirname(__FILE__), "..","..", "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| load file }

# Can't use reload
# Dir["#{File.dirname(__FILE__)}/../step_definitions/*_steps.rb"].each { |file| load file }

$BASE_URL = "http://adminwise.heroku.com"
browser = Selenium::WebDriver.for($ITEST2_BROWSER ? $ITEST2_BROWSER.downcase.to_sym : :ie)  # set by TestWise if running in TestWise
World(Test::Unit::Assertions)

# browser.navigate.to("http://adminwise.agileway.net")
# browser.navigate.to("http://localhost:3000")

Before do
  @driver = @browser = browser
  reset_database
end

After do |scenario|
  if scenario.failed?
    puts "Scenario failed: #{scenario.inspect} | #{scenario.exception.message}"
  end
end

at_exit do
  browser.quit if browser unless $ITEST2_DEBUGGING
end


# Helper methods 

def reset_database
  $base_url = base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL
  @browser.navigate.to("#{base_url}/reset")
  @browser.navigate.to("#{base_url}/")
end
