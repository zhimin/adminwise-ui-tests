require File.join(File.dirname(__FILE__), "abstract_page.rb")

class RegisterStaffPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_title(person_title)
    enter_text("person[title]", person_title)
  end

  def enter_first_name(person_first_name)
    enter_text("person[first_name]", person_first_name)
  end

  def enter_last_name(person_last_name)
    enter_text("person[last_name]", person_last_name)
  end

  def select_occupation(person_occupation)
    select_option("person[occupation]", person_occupation)
  end

  def enter_email(person_email)
    enter_text("person[email]", person_email)
  end

  def enter_phone(person_phone)
    enter_text("person[phone]", person_phone)
  end

  def enter_address_line1(person_address_line1)
    enter_text("person[address_line1]", person_address_line1)
  end

  def enter_suburb(person_suburb)
    enter_text("person[suburb]", person_suburb)
  end

  def enter_state(person_state)
    enter_text("person[state]", person_state)
  end

  def enter_postcode(person_postcode)
    enter_text("person[postcode]", person_postcode)
  end

  def enter_country(person_country)
    enter_text("person[country]", person_country)
  end

  def check_dieatry_gluten_free
    check_checkbox("event_registration[dietary_gluten_free]", "1")
  end

  def select_level(event_registration_level)
    select_option("event_registration[level]", event_registration_level)
  end

  def click_register
    click_button("Register  »")
  end

end
