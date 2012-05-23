Pure Watir Test Scripts in RSpec Syntax
=======================================

Purpose
-------

* Show run pure Watir test scripts in TestWise. 
* Relatively easy to convert RWebSpec to Watir (but why you want to do it? as you can use Watir directly in RWebSpec anyway.)

Converting from RWebSpec
------------------------

1. open_browser  =>     @browser = Watir::Browser.new(browser_type)

2. Create AbstractPage class holds @browser instance

3. Convert rwebspec test steps to Watir steps, e.g.

    @browser.link(:text,"Here") => @browser.link(:text, "Here").click


Impression
----------

1. Lack of execution line indicator in TestWise

2. Now open a new browser every single time, although can add extract test logic to reuse existing browser window (but RWebSpec with built-in support)
  
    click_button("Create") => @browser.button(:value, "Create").click

3. Lack of useful utils such as 
     fallsafe{ }
     try {}

4. Missing some assertions helpers such as
     assert_link_present_with_text

5. The Page class model make it easy to change over, 
     membership_page = expect MembershipPage => membership_page = MembershipPage.new(@browser)

6. Add 'visit' in test_helper, as it is easy to goto the page in site, and handel different environment server URL

7. Assertiong changes:
    page_text.should contain("Something")
    @browser.text.should include("Something")

Upgrade to Watir 2
===================

Watir 1
    browser.radio(:name, "member[member_type]", member_member_type).set

Watir 2
    browser.radio(:name => "member[member_type]", :value => member_member_type).set
