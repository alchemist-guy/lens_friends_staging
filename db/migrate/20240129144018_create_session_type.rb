class CreateSessionType < ActiveRecord::Migration[7.1]
  def change
    create_table :session_types, id: :uuid do |t|
      t.uuid    :user_id
      t.boolean :family
      t.boolean :portrait
      t.boolean :couples
      t.boolean :pets
      t.boolean :product
      t.boolean :graduation
      t.boolean :maternity
      t.boolean :newborn
      t.boolean :elopement
      t.boolean :interior
      t.boolean :architecture
      t.boolean :fashion
      t.boolean :branding
      t.boolean :wedding
      t.boolean :boudoir

      t.timestamps
    end
  end
end
