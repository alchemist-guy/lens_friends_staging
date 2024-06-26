class Subscription < ApplicationRecord
  attr_accessor :card_number, :exp_month, :exp_year, :cvc
  belongs_to :plan
  belongs_to :user
  validates :stripe_id, presence: true, uniqueness: true
  # before_validation :create_stripe_reference, on: :create
end
