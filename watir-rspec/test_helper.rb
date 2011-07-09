require 'rubygems'
require 'spec'
require 'watir'
require 'httpclient'
require 'timeout'

require "#{File.dirname(__FILE__)}/pages/abstract_page.rb"

Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| require file }

Watir::Browser.default = 'ie'

FireWatir::Firefox.firefox_started = true if RUBY_PLATFORM.downcase.include?("darwin")

$BASE_URL = ENV['ADMINWISE_URL'] || "http://adminwise.macmini"
#localhost:2800"
#$BASE_URL = "http://demo.adminwise.com"
#$BASE_URL = "http://adminwise.macmini"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper


  # In you test case, you can use
  #
  #   login_as("homer", "Password")
  #   login_as("bart")  # the password will be default to 'iTest2'
  #   login("lisa")     # same as login_as
  def login_as(username, password = "test")
    home_page = HomePage.new(@driver)
    home_page.enter_login(username)
    home_page.enter_password(password)
    home_page.click_login
  end
  alias login login_as

  def logout
    begin; @driver.link(:text, "Logout").click;  rescue => e; end
  end


  def reset_database
    begin
      Timeout::timeout(3) {
        reset_database_silient
    }
    @driver.goto("#{base_url}/")
    rescue Timeout::Error => e
      puts "Reset database via HttpClient: #{e}"
      reset_database_via_ui
    rescue => e
      reset_database_via_ui
    end
  end

  def reset_database_via_ui
    base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL
    @driver.goto("#{base_url}/reset")
    @driver.goto("#{base_url}/")
  end

  def visit(page)
    base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL
    @driver.goto("#{base_url}#{page}")
  end

  def reset_database_silient
    # Option 2: using HTTP to call reset_database URL directly
    base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL 
    begin
      require 'httpclient'
      client = HTTPClient.new
      reset_response =  client.get("#{base_url}/reset").body
      puts "BASEURL: #{base_url} | #{reset_response}"
      return if reset_response == "Database Reset OK"
      raise "Reset database failed: #{reset_database}"
    rescue => e
      puts  e
      raise "failed to reset the database: #{base_url}, #{e}"
    end
  end
end

# Copy from RWebSpec
def debugging?
  $ITEST2_DEBUGGING && $ITEST2_RUNNING_AS == "test_case"
end

def assert_link_present_with_text(link_text)
  @driver.links.each { |link|
    return if link.text.include?(link_text)
  }
  raise ("can't find the link containing text: #{link_text}")
end

# Try the operation up to specified timeout (in seconds), and sleep given interval (in seconds).
# Error will be ignored until timeout
# Example
#    try { click_link('waiting')}
#    try(10, 2) { click_button('Search' } # try to click the 'Search' button upto 10 seconds, try every 2 seconds
#    try { click_button('Search' }
def try(timeout = 30, polling_interval = 1, & block)
  start_time = Time.now

  last_error = nil
  until (duration = Time.now - start_time) > timeout
    begin
      yield
      last_error = nil
      return true
    rescue => e
      last_error = e
    end
    sleep polling_interval
  end

  raise "Timeout after #{duration.to_i} seconds with error: #{last_error}." if last_error
  raise "Timeout after #{duration.to_i} seconds."
end

