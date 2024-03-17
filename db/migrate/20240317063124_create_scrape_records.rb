class CreateScrapeRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :scrape_records do |t|
      t.string :status
      t.integer :duration
      t.text :reason
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
