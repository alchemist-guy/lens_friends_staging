class CreateNotification < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications, id: :uuid do |t|
      t.uuid :admin_id
      t.uuid :user_id
      t.boolean :status
      t.text :message
      t.string :topic
      

      t.timestamps
    end
  end
end
