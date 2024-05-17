class Package < ApplicationRecord
  belongs_to :user
  has_many :price_ranges, dependent: :destroy
  accepts_nested_attributes_for :price_ranges, reject_if: :all_blank, allow_destroy: true

  validates :service_type, :session_type, presence: true
  # validates :session_type, uniqueness: true
  validate :unique_session_type_within_service_type, on: :create

  private

  def unique_session_type_within_service_type
    if Package.where(user_id: user_id, service_type: service_type, session_type: session_type)
              .where.not(id: id) # Exclude the current record during update
              .exists?
      errors.add(:session_type, 'must be unique for each service type')
    end
  end


end