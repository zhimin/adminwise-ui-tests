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
    failsafe { link(:text, "Logout").click }
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
    base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL
    @driver.goto("#{base_url}/reset")
    @driver.goto("#{base_url}/")
  end

  def reset_database_silient
     # Option 2: using HTTP to call reset_database URL directly
     base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL
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
end
