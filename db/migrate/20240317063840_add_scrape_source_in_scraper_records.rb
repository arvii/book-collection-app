class AddScrapeSourceInScraperRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :scrape_records, :scrape_source, :string
  end
end
