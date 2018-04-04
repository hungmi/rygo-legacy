class Customer < ApplicationRecord
	validates :discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1, allow_blank: true }
	validates :name, presence: true
end
