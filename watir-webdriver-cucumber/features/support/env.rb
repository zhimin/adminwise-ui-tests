TEST_DATA_DIR = "./features/test_data"

require 'rubygems'
require 'watir-webdriver'
require 'test/unit/assertions'

# Template version: SC-0.1

# Include all pages defined under /pages, same used in RSpec
load File.join(File.dirname(__FILE__), "..","..", "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/../../pages/*_page.rb"].each { |file| load file }

# include RWebSpec Utils and better integration with TestWise
require "#{File.dirname(__FILE__)}/rwebspec_utils.rb"
require "#{File.dirname(__FILE__)}/testwise_support.rb"

$BASE_URL = $TESTWISE_PROJECT_BASE_URL
$BASE_URL ||= "http://adminwise.herokuapp.com" # Change here

World(Test::Unit::Assertions)

include RWebSpecUtils
include TestWiseSupport

def browser_type
  if $TESTWISE_BROWSER then
    $TESTWISE_BROWSER.downcase.to_sym
  else
    RUBY_PLATFORM =~ /mingw/ ? "ie".to_sym : "firefox".to_sym
  end
end


browser = Watir::Browser.new(browser_type)

##
# Before all scenarios in a feature file 
#
Before do
  @browser = browser
  @browser.goto($BASE_URL)
end

##
# Before each scenario
#
After do |scenario|
  if scenario.failed?
    puts "Scenario failed: #{scenario.exception.message}"
  end
end

## 
# After all scenarios in a feature file
#
at_exit do
  @browser.quit if @browser
end

##
# Helper methods 
#

def reset_database
  # $base_url = base_url = $BASE_URL
  # @browser.goto("#{base_url}/reset")
end
