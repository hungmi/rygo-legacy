class OrderItem < ApplicationRecord
	belongs_to :cloth
	enum status: { not_yet_shipped: 0, shipped: 1, delivered: 2 }
	validates :amount, presence: true
	validates :cloth_id, presence: { message: "選択してください" }

	def code
		created_at.strftime("%y%m%d%H%M%S")
	end
end
