require 'rubygems'
require 'selenium-webdriver'
require 'httpclient'
require 'timeout'

require File.join(File.dirname(__FILE__), "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

$BASE_URL = ENV['ADMINWISE_URL'] || "http://adminwise.macmini"
#localhost:2800"
#$BASE_URL = "http://demo.adminwise.com"
#$BASE_URL = "http://adminwise.macmini"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  def browser_type
    if $ITEST2_BROWSER
      return $ITEST2_BROWSER.downcase.to_sym
		else
			if RUBY_PLATFORM =~ /mingw/ 
				:ie
			else
				:chrome
			end
    end
    #:ie
    # :firefox
    # :chrome
  end
  
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

  def logout(throw_errror = true)
    # NOTES WebDriver: logout
    #  fail_safe { @driver.find_element(:link_text, "Logout").click }
    if throw_errror
      # Somehoe: Selenium-webdriver 2.2 does not click the logout link (by text or id)
      # @driver.find_element(:id, "logout_link").click
      visit("/users/sign_out")
    else
      fail_safe { @driver.find_element(:id, "logout_link").click }
    end
  end


  def reset_database
    begin
      Timeout::timeout(3) {
        reset_database_silient
      }
    rescue Timeout::Error => e
      puts "Reset database via HttpClient: #{e}"
      reset_database_via_ui
    rescue => e
      reset_database_via_ui
    end
  end

  def reset_database_via_ui
    $base_url =  base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL
    @driver.navigate.to("#{base_url}/reset")
    @driver.navigate.to("#{base_url}/")
  end

  def reset_database_silient
    # Option 2: using HTTP to call reset_database URL directly
    $base_url = base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL
    begin
      require 'httpclient'
      client = HTTPClient.new
      reset_response =  client.get("#{base_url}/reset").body
      reset_response =  reset_response.content if reset_database.respond_to?("content")
      raise "Reset database failed: #{reset_database}" unless reset_response == "Database Reset OK"
    rescue => e
      debug e
      raise "failed to reset the database: #{base_url}, #{e}"
    end
  end


  # Copy from RWebSpec
  def visit(page)
    base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL
    @driver.navigate.to("#{base_url}#{page}")
  end
    
  def debugging?
    $ITEST2_DEBUGGING && $ITEST2_RUNNING_AS == "test_case"
  end

  def fail_safe(&block)
    begin
      yield
    rescue => e
    end
  end
  
  def assert_link_present_with_text(link_text)
    the_link = @driver.find_element(:link_text, link_text)
    raise ("can't find the link containing text: #{link_text}") unless the_link
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


end
