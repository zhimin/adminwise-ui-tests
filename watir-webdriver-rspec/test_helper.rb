require 'rubygems'
require 'watir-webdriver'
require 'rspec'

# this loads defined page objects under pages folder
require "#{File.dirname(__FILE__)}/pages/abstract_page.rb"
Dir["#{File.dirname(__FILE__)}/pages/*_page.rb"].each { |file| load file }

# use utils in RWebSpec and better integration with TestWise
require "#{File.dirname(__FILE__)}/rwebspec_utils.rb"
require "#{File.dirname(__FILE__)}/testwise_support.rb"

# The default base URL for running from command line or continuous build process
# pass ENV here, so that can be dynamcially changed when running in CI server such as BuildWise
$BASE_URL =  ENV['ADMINWISE_URL'] || "http://adminwise.heroku.com"

# This is the helper for your tests, every test file will include all the operation
# defined here.
module TestHelper

  include RWebSpecUtils
  include TestWiseSupport

  def browser_type
    if $TESTWISE_BROWSER then
      $TESTWISE_BROWSER.downcase.to_sym
    else
      RUBY_PLATFORM =~ /mingw/ ? "ie".to_sym : "firefox".to_sym
    end
  end
  alias the_browser browser_type

  def site_url(default = "http://adminwise.heroku.com")
    $TESTWISE_PROJECT_BASE_URL || default
  end

  # -------------------------
  # Business helper functions
  # -------------------------

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
    @browser.link(:id, "user_nav_link").click
    sleep 0.5
    @browser.link(:id, "sign_out_link").click
  end


  def click_profile
    @browser.link(:id, "user_nav_link").click
    sleep 0.5
    @browser.link(:id, "profile_link").click
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
