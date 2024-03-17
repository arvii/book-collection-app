class ScrapeRecord < ApplicationRecord
  validates :started_at, presence: true
  validates :status, presence: true
end
