require 'rails_helper'

RSpec.describe ScrapeRecord, type: :model do

  describe 'validations' do
    it 'is valid with valid attributes' do
      scrape_record = ScrapeRecord.new(status: 'started', started_at: Time.current)
      expect(scrape_record).to be_valid
    end

    it 'is not valid without a status' do
      scrape_record = ScrapeRecord.new(started_at: Time.current)
      expect(scrape_record).not_to be_valid
    end

    it 'is not valid without a started_at' do
      scrape_record = ScrapeRecord.new(status: 'started')
      expect(scrape_record).not_to be_valid
    end
  end

  describe 'failure reasons' do
    it 'records the reason for failure' do
      failure_reason = "Network error"
      scrape_record = ScrapeRecord.create(status: 'failure', reason: failure_reason, started_at: Time.current)
      
      expect(scrape_record.reason).to eq(failure_reason)
    end
  end
end
