# load File.dirname(__FILE__) + '/maybe_your_template_page.rb'

class EventRegistrationPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= 
  end

  def enter_member_id(member_id)
    browser.text_field(:name, "member_id").set member_id
  end

  def enter_member_surname(member_surname)
    browser.text_field(:name, "member_surname").set member_surname
  end
  
  def click_find
    browser.button(:value, "Find").click
  end
  
  def click_register
    browser.button(:id, "registerBtn").click
  end

  def select_is_member(is_member)
    browser.radio(:name, "is_member", is_member).set
  end
  
  # function(parameter))
  def enter_person_title(person_title)
    browser.text_field(:name, "person[title]").set person_title
  end
  
  def enter_first_name(person_first_name)
    browser.text_field(:name, "person[first_name]").set person_first_name
  end
  
  def enter_last_name(person_last_name)
    browser.text_field(:name, "person[last_name]").set person_last_name
  end
  
  def enter_organisation(person_organisation)
    browser.text_field(:name, "person[organisation]").set person_organisation
  end
  
  def select_person_occupation(person_occupation)
    browser.select_list(:name, "person[occupation]").set person_occupation
  end
  
  def enter_person_email(person_email)
    browser.text_field(:name, "person[email]").set person_email
  end
  
  def enter_person_phone(person_phone)
    browser.text_field(:name, "person[phone]").set person_phone
  end
  
  def enter_address_line1(person_address_line1)
    browser.text_field(:name, "person[address_line1]").set person_address_line1
  end
  
  def enter_person_suburb(person_suburb)
    browser.text_field(:name, "person[suburb]").set person_suburb
  end
  
  def enter_postcode(person_postcode)
    browser.text_field(:name, "person[postcode]").set person_postcode
  end
  
  def uncheck_checkbox_email_notification
    browser.checkbox(:name, "event_registration[email_notification]", "1").clear
  end
  
  def uncheck_event_registration_emal_notification
    browser.checkbox(:name, "event_registration[email_notification]", "1").clear
  end
  
  def click_register
    browser.button(:id, "registerBtn").click
  end
  
  def uncheck_checkbox_registration_email_notificaton
    browser.checkbox(:name, "event_registration[email_notification]", "1").clear
  end

  def click_confirm
    browser.button(:value, "Confirm").click
  end

end
