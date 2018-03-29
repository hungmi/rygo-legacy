class ClothPolicy < ApplicationPolicy
	def index?
    user.present?
  end

  def show?
    scope.where(id: record.id).exists? && user.present? && (user.id == record.supplier_id) || user.admin?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    scope.where(id: record.id).exists? && user.present? && (user.id == record.supplier_id) || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

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