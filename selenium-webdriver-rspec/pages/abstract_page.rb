
class AbstractPage

  attr_accessor :driver
  
  def initialize(driver, identify_text = nil)
    @driver = driver
    if @driver && identify_text && !identify_text.empty?
      raise "Not on page: #{self.class.name}, '#{identify_text}' not found" unless browser.page_source.include?(identify_text)
    end
  end

  def browser
    @driver
  end
  
  def text
    # santiize
  end
end