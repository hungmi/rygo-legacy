class Customer < ApplicationRecord
	has_many :order_items, dependent: :destroy

	validates :discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1, allow_blank: true }
	validates :name, presence: true

	def name_or_code
		code.present? ? code : name
	end
end
