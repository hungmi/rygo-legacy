class Cloth < ApplicationRecord
	belongs_to :supplier, class_name: "User"
	has_many :order_items, dependent: :destroy
	has_many_attached :images

	validates :code, presence: true, uniqueness: { allow_blank: true }

	attr_accessor :remove_images
end
