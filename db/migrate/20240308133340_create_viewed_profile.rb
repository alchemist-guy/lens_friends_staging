class CreateViewedProfile < ActiveRecord::Migration[7.1]
  def change
    create_table :viewed_profiles, id: :uuid do |t|
      t.uuid :user_id
      t.string :app_sender_email
      t.string :receiver_email
      t.string :viewed_by_name
      t.string :viewed_by_email
      t.string :msg

      t.timestamps
    end
  end
end
