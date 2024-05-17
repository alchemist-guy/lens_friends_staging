class CreatePackage < ActiveRecord::Migration[7.1]
  def change
    create_table :packages, id: :uuid do |t|
      t.uuid    :user_id
      t.text    :description
      t.string  :session_type
      t.string  :service_type


      t.timestamps
    end
  end
end
