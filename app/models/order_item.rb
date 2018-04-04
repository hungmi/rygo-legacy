class OrderItem < ApplicationRecord
	belongs_to :cloth
	belongs_to :customer
	enum status: { not_yet_shipped: 0, shipped: 1, delivered: 2 }
	enum deliver_period: { up: 0, middle: 1, down: 2 }
	validates :amount, presence: true
	validates :cloth_id, presence: { message: "選択してください" }

	def code
		created_at.strftime("%y%m%d%H%M%S")
	end

	def deliver_time
		period = I18n.t("activerecord.order_item_deliver_period.#{deliver_period}")
		"#{deliver_month}月#{period}"
	end
end
