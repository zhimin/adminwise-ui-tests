require 'rubygems'
require 'selenium-webdriver'
require 'httpclient'
require 'timeout'

require File.join(File.dirname(__FILE__), "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

# use utils in RWebSpec and better integration with TestWise
require "#{File.dirname(__FILE__)}/rwebspec_utils.rb"
require "#{File.dirname(__FILE__)}/testwise_support.rb"

$BASE_URL = $TESTWISE_PROJECT_BASE_URL || ENV['ADMINWISE_URL'] || "http://adminwise.heroku.com"
#localhost:2800"
#$BASE_URL = "http://demo.adminwise.com"
#$BASE_URL = "http://adminwise.macmini"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  include RWebSpecUtils
  include TestWiseSupport

  def browser_type
    if $ITEST2_BROWSER
      return $ITEST2_BROWSER.downcase.to_sym
    elsif $TESTWISE_BROWSER
      return $TESTWISE_BROWSER.downcase.to_sym
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
    home_page = HomePage.new(@browser)
    home_page.enter_login(username)
    home_page.enter_password(password)
    home_page.click_login
  end
  alias login login_as

  def logout(throw_errror = true)
    # NOTES WebDriver: logout
    #  fail_safe { @browser.find_element(:link_text, "Logout").click }
    if throw_errror
      # Somehoe: Selenium-webdriver 2.2 does not click the logout link (by text or id)
      # @browser.find_element(:id, "logout_link").click
      visit("/users/sign_out")
    else
      fail_safe { @browser.find_element(:id, "logout_link").click }
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
    @browser.navigate.to("#{$BASE_URL}/reset")
    @browser.navigate.to("#{$BASE_URL}/")
  end

  def reset_database_silient
    # Option 2: using HTTP to call reset_database URL directly
    begin
      require 'httpclient'
      client = HTTPClient.new
      reset_response = client.get("#{$BASE_URL}/reset").body
      reset_response = reset_response.content if reset_database.respond_to?("content")
      raise "Reset database failed: #{reset_database}" unless reset_response == "Database Reset OK"
    rescue => e
      debug e
      raise "failed to reset the database: #{$BASE_URL}, #{e}"
    end
  end

  # Copy from RWebSpec
  def visit(page)
    @browser.navigate.to("#{$BASE_URL}#{page}")
  end
  
  def assert_link_present_with_text(link_text)
    the_link = @browser.find_element(:link_text, link_text)
    raise ("can't find the link containing text: #{link_text}") unless the_link
  end


end
