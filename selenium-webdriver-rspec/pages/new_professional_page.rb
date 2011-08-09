
class NewProfessionalPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_principal_name(professional_princip)
    browser.find_element(:name, "professional[principal]").send_keys(professional_princip)
  end
  
  def enter_contact(professional_contact)
    browser.find_element(:name, "professional[contact_person]").send_keys(professional_contact)
  end
  
  def enter_organisation_name(professional_organis)
    browser.find_element(:name, "professional[organisation]").send_keys(professional_organis)
  end
  
  def click_create
    browser.find_element(:name, "commit").click # Watir button:value is better
    # click_button("Create")
  end

  def select_category(professional_category)
    category_element = browser.find_element(:name, "professional[category]")
		category_element.find_elements(:tag_name, "option").each do |option_element|
			if option_element.text == professional_category
				option_element.click
				break
			end
		end
  end

end
