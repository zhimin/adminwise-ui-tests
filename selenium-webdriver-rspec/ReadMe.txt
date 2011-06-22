Notes on porting Watir to selenium-webdriver

1. Change test_helper, include rwebpec-webdriver

     require 'rwebspec-webdriver'

2. In TestWise's project settings, change test project to to use framework 

3. In after(:all) block, add close_browser, as webdriver-selenium does not reuse existing browser

4. Convert test steps
    # enter_text("name", "007") =>  @driver.find_element(:name, "name").send_keys("007")
    # click_button("Create") => ?

5. Copied some generic test helper methods from RWebSpec, such as
      - try
      - fail_safe
      - debugging?
           
6. Assertion:
    * page_text.should include("Some text") => @driver.page_source.should include("Some text")
    *

Impression
----------

* A lot slower

* Can't find links after styling cases 
    in source 'Control Panel', style to 'CONTROL PANEL'  
    web-driver reads
      "control panel"
* assert_link change to 
    @driver.find_element(:link_text, "logout")

Reference
---------
selenium-webdriver Intro: http://code.google.com/p/selenium/wiki/RubyBindings
selenium-webdriver API: http://selenium.googlecode.com/svn/trunk/docs/api/rb/index.html