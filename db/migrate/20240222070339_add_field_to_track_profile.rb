class AddFieldToTrackProfile < ActiveRecord::Migration[7.1]
  def change
    add_column :track_profiles, :payment_method_data, :integer, default: 0
  end
end
