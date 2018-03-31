class Cloth < ApplicationRecord
	belongs_to :supplier, class_name: "User"
	has_many :order_items, dependent: :destroy
	has_many_attached :images
	attr_accessor :remove_images


	def images_or_default
		images.attached? ? images : "http://via.placeholder.com/660x1258/333.jpg"
	end
end
