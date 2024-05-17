class CreatePriceRange < ActiveRecord::Migration[7.1]
  def change
    create_table :price_ranges, id: :uuid do |t|
      t.uuid    :package_id
      t.integer :hour
      t.float   :price

      t.timestamps
    end
  end
end
