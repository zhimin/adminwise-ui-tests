
class EditProfessionalPage < AbstractPage

  def initialize(browser)
    super(browser, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_principal_name(professional_princip)
    enter_text("professional[principal]", professional_princip)
  end

  def enter_contact(professional_contact)
    enter_text("professional[contact_person]", professional_contact)
  end

  def enter_organisation_name(professional_organis)
    enter_text("professional[organisation]", professional_organis)
  end

  def click_save
    click_button("Save")
  end


end
