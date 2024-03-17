class CreateScrapingRuns < ActiveRecord::Migration[7.1]
  def change
    create_table :scraping_runs do |t|
      t.datetime :run_time
      t.boolean :success

      t.timestamps
    end
  end
end
