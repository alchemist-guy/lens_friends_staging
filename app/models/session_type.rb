class SessionType < ApplicationRecord
  belongs_to :user
  has_many :galleries, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[family portrait couples product graduation maternity newborn interior fashion branding wedding boudoir]
  end

  def self.ransackable_associations(auth_object = nil)
    ["galleries", "user"]
  end

end