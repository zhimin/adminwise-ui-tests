require 'rwebspec-webdriver'

class MembershipPage < RWebSpec::AbstractWebPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def add_member
    click_link("Add member")
  end

  def enter_first_name(member_fname)
    enter_text("member[fname]", member_fname)
  end

  def enter_last_name(member_lname)
    enter_text("member[lname]", member_lname)
  end

  def enter_street_address(member_street_addr)
    enter_text("member[street_addr]", member_street_addr)
  end

  def enter_suburb(member_suburb)
    enter_text("member[suburb]", member_suburb)
  end

  def enter_state(member_state)
    enter_text("member[state]", member_state)
  end

  def enter_postcode(member_postcode)
    enter_text("member[postcode]", member_postcode)
  end

  def enter_phone(member_phone)
    enter_text("member[phone]", member_phone)
  end

  def enter_mobile(member_mobile)
    enter_text("member[mobile]", member_mobile)
  end

  def enter_email(member_email)
    enter_text("member[email]", member_email)
  end

  def click_member_type(member_member_type)
    click_radio_option("member[member_type]", member_member_type)
  end

  def click_mail_out(member_mail_out)
    click_radio_option("member[mail_out]", member_mail_out)
  end

  def click_doing_aba(member_doing_aba)
    click_radio_option("member[doing_aba]", member_doing_aba)
  end

  def select_aware_from(member_aware_from)
    select_option("member[aware_from]", member_aware_from)
  end

  def click_create_member
    click_button("Create Member")
  end

  def click_membership
    click_link("Membership")
  end

  def click_add_member
    click_link("Add member")
  end

  def enter_organisation_name(member_oname)
    enter_text("member[oname]", member_oname)
  end

  def enter_first_name(member_fname)
    enter_text("member[fname]", member_fname)
  end
end
