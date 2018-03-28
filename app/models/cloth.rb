class Cloth < ApplicationRecord
	belongs_to :supplier, class_name: "User"
	has_many_attached :images
	attr_accessor :remove_image


	def images_or_default
		images.attached? ? images : "http://via.placeholder.com/219x158/333.jpg"
	end
end
