class User < ApplicationRecord
	enum roles: { admin: 0 }
	validates :name, presence: true, uniqueness: true
	has_secure_password
end