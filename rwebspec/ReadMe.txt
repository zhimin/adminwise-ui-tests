Notes on porting Watir to selenium-webdriver (IE)
--------------------------------------------
1. Change test_helper, include rwebpec-webdriver

     require 'rwebspec-webdriver'

2. In TestWise's project settings, change test project to to use framework 

3. In after(:all) block, add close_browser, as webdriver-selenium does not reuse existing browser

4. Change link "Events" (displayed in upcase style) to 
       click_link("EVENTS") 
   Sample of "LIBRARY", "MEMBERSHIPS"

5.  Change link "Control Panel" (displayed in upcase style) to
      click_link("control panel")

6. click_button seem not working reliably.
Impression
----------

* A lot slower

* Can't find links after styling cases
