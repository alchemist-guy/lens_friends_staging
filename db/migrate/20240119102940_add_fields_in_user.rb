class AddFieldsInUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :state, :string
    add_column :users, :DOB, :date
  end
end
