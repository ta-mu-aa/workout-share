class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true,      
                      length: { maximum: 30 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
                      length: { maximum: 100 },
                      format: { with: VALID_EMAIL_REGEX }

  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, confirmation: true, presence: true,
                      length: { minimum: 8, maximum: 100 },
                      format: { with: VALID_PASSWORD_REGEX }
  validates :password_confirmation, presence: true

end
