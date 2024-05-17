class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, 
         omniauth_providers: [:google_oauth2]

  has_one_attached :profile_pic
  has_one_attached :cover_pic

  has_many :off_days, dependent: :destroy
  has_many :packages, dependent: :destroy
  has_many :viewed_profiles, dependent: :destroy
  has_many :notifications
  has_one :session_type, dependent: :destroy
  has_one :track_profile, dependent: :destroy

  after_create :create_track_profile

  before_validation :create_stripe_reference, on: :create

  validate :validate_profile_pic_size
  validate :validate_cover_pic_size

  validates :stripe_id, presence: true, uniqueness: true
  
  validates :email, presence: true, uniqueness: true
  validates :user_name, uniqueness: true, format: { with: /\A[a-zA-Z0-9.]+\z/, message: "can only contain letters, numbers, and a dot" }
  validates :first_name, :last_name, presence: true

  # before_create :set_user_name

  def self.ransackable_attributes(auth_object = nil)
    %w[state email first_name last_name]
  end

  def self.ransackable_associations(auth_object = nil)
    ["off_days","session_type", "track_profile"]
  end


  before_validation(on: :create) do
    self.user_name = email.split("@").first if user_name.blank?
  end

  # def set_user_name
  #   sanitized_name = email.split("@").first.gsub(/[^a-zA-Z0-9.]/, '')
  #   self.user_name = sanitized_name if user_name.blank?
  #   # self.user_name = email.split("@").first if user_name.blank?
  # end

  def create_stripe_reference
    response = Stripe::Customer.create(email: email)
    self.stripe_id = response.id
  end

  def retrieve_stripe_reference
    Stripe::Customer.retrieve(stripe_id)
  end

  def active?
    unless Stripe::Subscription.list(customer: stripe_id).data.first.canceled_at == nil
      if subscription_ends_at > Time.at(Stripe::Subscription.list(customer: stripe_id).data.first.canceled_at).to_datetime
        self.subscription_status = "inactive"
      end
    end
  end

  

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name  = auth.info.last_name
      user.user_name  = auth.info.email.split("@").first

      # user.username   = auth.info.email.split("@").first # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  private

  def validate_profile_pic_size
    if profile_pic.attached? && profile_pic.blob.byte_size > 3.megabyte
      errors.add(:profile_pic, 'should be less than 3MB')
      profile_pic.purge # Remove the attached file to prevent saving
    end
  end

  def validate_cover_pic_size
    if cover_pic.attached? && cover_pic.blob.byte_size > 5.megabytes
      errors.add(:cover_pic, 'should be less than 5MB')
      cover_pic.purge # Remove the attached file to prevent saving
    end
  end


  def create_track_profile
    TrackProfile.create!(
      user_id: id
    )
  end

end
