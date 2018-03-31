class User < ApplicationRecord
	enum role: { supplier: 0, admin: 1 }
	validates :name, presence: true, uniqueness: true
	validates :password_confirmation, presence: true, on: :create
	has_secure_password
	has_one_attached :avatar

	has_many :cloths, foreign_key: "supplier_id", dependent: :destroy

	def order_items
		# 不要直接關聯 user has_many order_item，因為可能帳號會刪掉
		OrderItem.where(cloth_id: self.cloth_ids)
	end
end