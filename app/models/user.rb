class User < ApplicationRecord
  has_many :passages

  include ActiveModel::Dirty
  has_secure_password

  validate :validate_email, if: :email_changed?
  validate :validate_password, if: :password_digest_changed?
  validate :validate_password_confirmation, on: :create
  validates_presence_of :first_name, message: "First name is required"
  validates_presence_of :last_name, message: "Last name is required"

  before_save :downcase_email

  before_create :generate_confirmation_details

  after_create :send_welcome_email

  def confirmation_token_valid?
    (self.confirmation_sent_at + 30.days) > Time.now.utc
  end

  def mark_as_confirmed!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.utc
    self.save
  end

  private

  def downcase_email
  self.email = self.email.delete(' ').downcase
  end

  def validate_email
    if email.blank?
      errors.add(:email, "Email is required")
    elsif !email.match(/@/)
      errors.add(:email, "Email is not valid")
    elsif User.exists?(email: email)
      errors.add(:email, "Email is already in use")
    end
  end

  def validate_password
    if password.blank?
      errors.delete(:password)
      errors.add(:password, "Password is required")
    elsif password.length < 6
      errors.add(:password, "Password is too short")
    end
  end

  def validate_password_confirmation
    if password_confirmation.blank?
      errors.add(:password_confirmation, "Password confirmation is required")
    elsif password_confirmation != password
      errors.delete(:password_confirmation)
      errors.add(:password_confirmation, "Passwords don't match")
    end
  end

  def generate_confirmation_details
    self.confirmation_token = SecureRandom.hex(10)
    self.confirmation_sent_at = Time.now.utc
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
