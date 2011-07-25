

class NewProfessionalPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_principal_name(professional_princip)
    browser.text_field(:name, "professional[principal]").set professional_princip
  end

  def enter_contact(professional_contact)
    browser.text_field(:name, "professional[contact_person]").set professional_contact
  end

  def enter_organisation_name(professional_organis)
    browser.text_field(:name, "professional[organisation]").set professional_organis
  end

  def click_create
    browser.button(:value, "Create").click
  end

  def select_category(professional_category)
    browser.select_list(:name, "professional[category]").set professional_category
  end

end
