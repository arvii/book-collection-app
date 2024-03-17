class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :series
      t.integer :year_of_publication
      t.text :description
      t.float :average_rating

      t.timestamps
    end
  end
end
