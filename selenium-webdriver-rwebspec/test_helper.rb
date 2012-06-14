require 'rubygems'
require 'rwebspec-webdriver'
require 'httpclient'
require 'timeout'

require File.join(File.dirname(__FILE__), "pages", "abstract_page.rb")
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

$BASE_URL = $TESTWISE_PROJECT_BASE_URL || ENV['ADMINWISE_URL'] || "http://adminwise.herokuapp.com"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  include RWebSpec::WebDriver::RSpecHelper
  include RWebSpec::WebDriver::Assert

  # In you test case, you can use
  #
  #   login_as("homer", "Password")
  #   login_as("bart")  # the password will be default to 'iTest2'
  #   login("lisa")     # same as login_as
  def login_as(username, password = "test")
    home_page = expect_page HomePage
    home_page.enter_username(username)
    home_page.enter_password(password)
    home_page.click_login
  end
  alias login login_as

  def logout
    click_link_with_id("user_nav_link")
    sleep 0.5
    click_link_with_id("sign_out_link")
  end


  def click_profile
    click_link_with_id("user_nav_link")
    sleep 0.5
    click_link_with_id("profile_link")
  end

  def reset_database
    begin
      Timeout::timeout(3) {
        reset_database_silient
      }
    rescue Timeout::Error => e
      # puts "Reset database via HttpClient: #{e}"
      reset_database_via_ui
    rescue => e
      reset_database_via_ui
    end
  end

  def reset_database_via_ui
    base_url = $ITEST2_PROJECT_BASE_URL || $BASE_URL
    goto_url("#{base_url}/reset")
    goto_page("/")
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
