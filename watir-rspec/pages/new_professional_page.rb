require 'rwebspec'

class NewProfessionalPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_principal_name(professional_princip)
    @driver.text_field(:name, "professional[principal]").set professional_princip
  end

  def enter_contact(professional_contact)
    @driver.text_field(:name, "professional[contact_person]").set professional_contact
  end
  
    def enter_organisation_name(professional_organis)
    @driver.text_field(:name, "professional[organisation]").set professional_organis
  end
  
  def click_create
    click_button("Create")
  end
  
  def select_category(professional_category)  
    @driver.select_list(:name, "professional[category]").set professional_category
  end

end
