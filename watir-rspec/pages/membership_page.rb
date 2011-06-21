class MembershipPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def add_member
    @driver.link(:text,"Add member").click
  end

  def enter_first_name(member_fname)
    @driver.text_field(:name, "member[fname]").set member_fname
  end

  def enter_last_name(member_lname)
    @driver.text_field(:name, "member[lname]").set member_lname
  end

  def enter_street_address(member_street_addr)
    @driver.text_field(:name, "member[street_addr]").set member_street_addr
  end

  def enter_suburb(member_suburb)
    @driver.text_field(:name, "member[suburb]").set member_suburb
  end

  def enter_state(member_state)
    @driver.text_field(:name, "member[state]").set member_state
  end

  def enter_postcode(member_postcode)
    @driver.text_field(:name, "member[postcode]").set member_postcode
  end

  def enter_phone(member_phone)
    @driver.text_field(:name, "member[phone]").set member_phone
  end

  def enter_mobile(member_mobile)
    @driver.text_field(:name, "member[mobile]").set member_mobile
  end

  def enter_email(member_email)
    @driver.text_field(:name, "member[email]").set member_email
  end

  def click_member_type(member_member_type)
    @driver.radio(:name, "member[member_type]", member_member_type).set
  end

  def click_mail_out(member_mail_out)
    @driver.radio(:name, "member[mail_out]", member_mail_out).set
  end

  def click_doing_aba(member_doing_aba)
    @driver.radio(:name, "member[doing_aba]", member_doing_aba)
  end

  def select_aware_from(member_aware_from)
    @driver.select_list(:name, "member[aware_from]").set member_aware_from
  end

  def click_create_member
    @driver.button(:value, "Create Member").click
  end

  def click_membership
    @driver.link(:text, "Membership").click
  end

  def click_add_member
    @driver.link(:text,"Add member").click
  end

  def enter_organisation_name(member_oname)
    @driver.text_field(:name, "member[oname]").set member_oname
  end

  def enter_first_name(member_fname)
    @driver.text_field(:name, "member[fname]").set member_fname
  end
end
