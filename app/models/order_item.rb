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

	def discounted_unit_price
		if self.cloth.price.to_f >= 0 && self.customer.discount.present?
			# 割引設定 > 0
			(self.cloth.price * self.customer.discount).to_i
		elsif self.customer.discount.to_f == 0.0
			# 割引設定為 0 或是 nil
			self.cloth.price
		end
	end

	def total_price
		discounted_unit_price * amount.to_i
	end
end
