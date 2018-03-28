class ClothPolicy < ApplicationPolicy
	def index?
		user.present?
	end
end