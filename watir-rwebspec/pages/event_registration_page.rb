
class EventRegistrationPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= 
  end

  def enter_member_id(member_id)
    enter_text("member_id", member_id)
  end
  def enter_member_surname(member_surname)
    enter_text("member_surname", member_surname)
  end
  def click_find
    click_button("Find")
  end
  def click_register
    click_button_with_id("registerBtn")
  end
  def select_is_member(is_member)
    click_radio_option("is_member", is_member)
  end
  
  # function(parameter))
  def enter_person_title(person_title)
      enter_text("person[title]", person_title)
  end
  
  def enter_first_name(person_first_name)
      enter_text("person[first_name]", person_first_name)
  end
  
  def enter_last_name(person_last_name)
      enter_text("person[last_name]", person_last_name)
  end
  
  def enter_organisation(person_organisation)
      enter_text("person[organisation]", person_organisation)
  end
  
  def select_person_occupation(person_occupation)
      select_option("person[occupation]", person_occupation)
  end
  
  def enter_person_email(person_email)
      enter_text("person[email]", person_email)
  end
  
  def enter_person_phone(person_phone)
      enter_text("person[phone]", person_phone)
  end
  
  def enter_address_line1(person_address_line1)
      enter_text("person[address_line1]", person_address_line1)
  end
  
  def enter_person_suburb(person_suburb)
      enter_text("person[suburb]", person_suburb)
  end
  
  def enter_postcode(person_postcode)
      enter_text("person[postcode]", person_postcode)
  end
  
  def uncheck_checkbox_email_notification
      uncheck_checkbox("event_registration[email_notification]", "1")
  end
  
  def uncheck_event_registration_emal_notification
      uncheck_checkbox("event_registration[email_notification]", "1")
  end
  
  def click_register
      click_button_with_id("registerBtn")
  end
  
  def uncheck_checkbox_registration_email_notificaton
      uncheck_checkbox("event_registration[email_notification]", "1")
  end
  
  def click_register
      click_button_with_id("registerBtn")
  end
  
  def click_confirm
      click_button("Confirm")
  end

end
