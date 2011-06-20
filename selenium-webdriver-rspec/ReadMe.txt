Notes on porting Watir to selenium-webdriver

1. Change test_helper, include rwebpec-webdriver

     require 'rwebspec-webdriver'

2. In TestWise's project settings, change test project to to use framework 

3. In after(:all) block, add close_browser, as webdriver-selenium does not reuse existing browser

4. 

Impression
----------

* A lot slower

* Can't find links after styling cases 
    in source 'Control Panel', style to 'CONTROL PANEL'  
    web-driver reads
      "control panel"
* assert_link change to 
    @driver.find_element(:link_text, "logout")
