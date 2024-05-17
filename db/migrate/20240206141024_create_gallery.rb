class CreateGallery < ActiveRecord::Migration[7.1]
  def change
    create_table :galleries, id: :uuid do |t|
      t.uuid    :session_type_id
      t.string  :gallery_type

      t.timestamps
    end
  end
end
