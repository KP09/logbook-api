class User < ApplicationRecord
  has_secure_password

  validate :validate_email, :validate_password, :validate_password_confirmation
  before_save :downcase_email
  before_create :generate_confirmation_instructions

  validates_presence_of :first_name, message: "First name is required"
  validates_presence_of :last_name, message: "Last name is required"

  def confirmation_token_valid?
    (self.confirmation_sent_at + 30.days) > Time.now.utc
  end

  def mark_as_confirmed!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.utc
    save
  end

  private

  def downcase_email
  self.email = self.email.delete(' ').downcase
  end

  # Why: so there is only ever one email error message
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

  def generate_confirmation_instructions
    self.confirmation_token = SecureRandom.hex(10)
    self.confirmation_sent_at = Time.now.utc
  end
end
