require 'rubygems'
require 'rspec'
require 'watir'
require 'httpclient'
require 'timeout'

# use utils in RWebSpec and better integration with TestWise
require "#{File.dirname(__FILE__)}/rwebspec_utils.rb"
require "#{File.dirname(__FILE__)}/testwise_support.rb"

require "#{File.dirname(__FILE__)}/pages/abstract_page.rb"
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

Watir::Browser.default = 'ie'


$BASE_URL = ENV['ADMINWISE_URL'] || "http://adminwise.heroku.com"
#localhost:2800"
#$BASE_URL = "http://demo.adminwise.com"
#$BASE_URL = "http://adminwise.macmini"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  include RWebSpecUtils
  include TestWiseSupport

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

  def logout
    begin; @browser.link(:text, "Logout").click;  rescue => e; end
  end


  def reset_database
    begin
      Timeout::timeout(3) {
        reset_database_silient
      }
      @browser.goto("#{base_url}/")
    rescue Timeout::Error => e
      puts "Reset database via HttpClient: #{e}"
      reset_database_via_ui
    rescue => e
      reset_database_via_ui
    end
  end

  def reset_database_via_ui
    base_url = $TESTWISE_PROJECT_BASE_URL || $ITEST2_PROJECT_BASE_URL || $BASE_URL
    @browser.goto("#{base_url}/reset")
    @browser.goto("#{base_url}/")
  end

  def visit(page)
    base_url = $TESTWISE_PROJECT_BASE_URL || $ITEST2_PROJECT_BASE_URL || $BASE_URL
    @browser.goto("#{base_url}#{page}")
  end

  def reset_database_silient
    # Option 2: using HTTP to call reset_database URL directly
    base_url = $TESTWISE_PROJECT_BASE_URL || $ITEST2_PROJECT_BASE_URL || $BASE_URL
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


  def assert_link_present_with_text(link_text)
    @browser.links.each { |link|
      return if link.text.include?(link_text)
    }
    raise ("can't find the link containing text: #{link_text}")
  end

end
