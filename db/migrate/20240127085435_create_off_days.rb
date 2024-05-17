class CreateOffDays < ActiveRecord::Migration[7.1]
  def change
    create_table :off_days, id: :uuid do |t|
      t.uuid :user_id
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
