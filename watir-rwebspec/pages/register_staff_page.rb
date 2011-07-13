
class RegisterStaffPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_register
    click_button_with_id("registerBtn")
  end

  def select_level(level="Volunteer")
    select_option("event_registration[level]", level)
  end

  def check_day_1
    check_checkbox("event_registration[day_1]", "1")
  end

  def enter_country(country="Australia")
    enter_text("person[country]", country)
  end

  def enter_postcode(postcode="4013")
    enter_text("person[postcode]", postcode)
  end

  def enter_state(state="QLD")
    enter_text("person[state]", state)
  end

  def enter_suburb(suburb="Kuraby")
    enter_text("person[suburb]", suburb)
  end

  def enter_address_line1(address_line1="8/34 Down Road")
    enter_text("person[address_line1]", address_line1)
  end

  def enter_phone(phone="0414 756 436")
    enter_text("person[phone]", phone)
  end

  def enter_email(email="lkerr2@eq.edu.au")
    enter_text("person[email]", email)
  end

  def select_occupation(occupation="Parent of ASD child")
    select_option("person[occupation]", occupation)
  end

  def enter_organisation(organisation="ABIQ")
    enter_text("person[organisation]", organisation)
  end

  def enter_last_name(last_name="Kerr")
    enter_text("person[last_name]", last_name)
  end

  def enter_first_name(first_name="Lianne")
    enter_text("person[first_name]", first_name)
  end

  def enter_title(title="Mrs")
    enter_text("person[title]", title)
  end

end
