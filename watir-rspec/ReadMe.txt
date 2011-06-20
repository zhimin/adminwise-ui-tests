Pure Watir Test Scripts in RSpec Syntax
=======================================

Purpose
-------

* Show run pure Watir test scripts in TestWise. 
* Relatively easy to convert RWebSpec to Watir (but why you want to do it? as you can use Watir directly in RWebSpec anyway.)

Converting from RWebSpec
------------------------

1. open_browser  =>     @driver = Watir::Browser.new

2. Create AbstractPage class holds @driver instance

3. Convert rwebspec test steps to Watir steps, e.g.

    @driver.link(:text,"Here") => @driver.link(:text, "Here").click


Impression
----------

1. Lack of execution line indicator in TestWise

2. Now open a new browser every single time, although can add extract test logic to reuse existing browser window (but RWebSpec with built-in support)
  
3. Lack of useful utils such as 
     fallsafe{ }
     try {}

4. Missing some assertions helpers such as
     assert_link_present_with_text

5. The Page class model make it easy to change over, 
     membership_page = expect MembershipPage => membership_page = MembershipPage.new(@driver)

6. Add 'visit' in test_helper, as it is easy to goto the page in site, and handel different environment server URL