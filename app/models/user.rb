class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: "must be a valid 10-digit number" }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def admin?
    role == "admin"
  end
end
  