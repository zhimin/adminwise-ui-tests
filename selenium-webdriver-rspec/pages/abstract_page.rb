
class AbstractPage

  attr_accessor :driver
  
  def initialize(driver, identify_text = nil)
    @browser = driver
    if @browser && identify_text && !identify_text.empty?
      raise "Not on page: #{self.class.name}, '#{identify_text}' not found" unless browser.page_source.include?(identify_text)
    end
  end

  def browser
    @browser
  end
  
  def text
    # santiize
  end
end