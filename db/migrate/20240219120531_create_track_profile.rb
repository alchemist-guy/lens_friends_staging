class CreateTrackProfile < ActiveRecord::Migration[7.1]
  def change
    create_table :track_profiles, id: :uuid do |t|
      t.uuid :user_id
      t.integer :user_data, default: 0
      t.integer :session_type_data, default: 0
      t.integer :gallery_data, default: 0
      t.integer :price_package_data, default: 0
      t.integer :profile_status, default: 20
      t.timestamps
    end
  end
end
