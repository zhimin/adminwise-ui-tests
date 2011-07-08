
class NewProfessionalPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_principal_name(professional_princip)
    @driver.find_element(:name, "professional[principal]").send_keys(professional_princip)
  end
  
  def enter_contact(professional_contact)
    @driver.find_element(:name, "professional[contact_person]").send_keys(professional_contact)
  end
  
  def enter_organisation_name(professional_organis)
    @driver.find_element(:name, "professional[organisation]").send_keys(professional_organis)
  end
  
  def click_create
    @driver.find_element(:name, "commit").click # Watir button:value is better
    # click_button("Create")
  end

  def select_category(professional_categor)
    @driver.find_element(:name, "professional[category]").send_keys(professional_categor)
  end

end
