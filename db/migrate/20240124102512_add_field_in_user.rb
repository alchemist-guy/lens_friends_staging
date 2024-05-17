class AddFieldInUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :activate_creator, :boolean
  end
end
