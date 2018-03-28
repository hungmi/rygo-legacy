class User < ApplicationRecord
	enum roles: { admin: 0, supplier: 1, customer: 2 }
	validates :name, presence: true, uniqueness: true
	validates :password_confirmation, presence: true, on: :create
	has_secure_password
	has_one_attached :avatar

	has_many :cloths
end