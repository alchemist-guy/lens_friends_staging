class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :admin

  validates :user_id, :message, :topic, presence: true
  
end