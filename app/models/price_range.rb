class PriceRange < ApplicationRecord
  belongs_to :package
  validates :hour, :price, presence: true

end