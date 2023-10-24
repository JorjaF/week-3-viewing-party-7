class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_secure_password

  has_many :viewing_parties
end
