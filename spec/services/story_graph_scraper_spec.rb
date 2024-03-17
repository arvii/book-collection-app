require 'rails_helper'

RSpec.describe StoryGraphScraper do
  describe '#scrape' do
    it 'navigates to the URL and performs scraping tasks' do
      driver_double = instance_double(Selenium::WebDriver::Driver)
      allow(Selenium::WebDriver).to receive(:for).and_return(driver_double)
      allow(driver_double).to receive(:get)
      allow(driver_double).to receive(:execute_script).and_return(100, 100) # Mocking scroll height
      allow(driver_double).to receive(:find_elements).and_return([])
      allow(driver_double).to receive(:quit)

      allow(driver_double).to receive(:window_handle).and_return('window_handle_value')

      scraper = StoryGraphScraper.new
      expect { scraper.scrape }.not_to raise_error
    end
  end
end
