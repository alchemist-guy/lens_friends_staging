class OffDay < ApplicationRecord
  belongs_to :user

  validate :unique_date_range_per_user

  def self.ransackable_attributes(auth_object = nil)
    ["start_date"]
  end

  def start_time
    self.start_date  # Assuming start_date is a DateTime or Time attribute
  end

  def end_time
    self.end_date  # Assuming start_date is a DateTime or Time attribute
  end

  private

  def unique_date_range_per_user
    if user_id.present? && OffDay.where(user_id: user_id)
                                    .where('(start_date, end_date) OVERLAPS (?, ?)', start_date, end_date)
                                    .exists?
      errors.add(:base, 'Date range overlaps with an existing OffDay for the same user')
    end
  end
end
