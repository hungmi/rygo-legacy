class Admin::ClothPolicy < AdminPolicy
	class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.supplier?
        scope.where(supplier: user)
      end
    end
  end
end