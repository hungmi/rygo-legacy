class AdminPolicy < ApplicationPolicy
	def index?
    user.present? && (user.admin? || user.supplier?)
  end

  def show?
    user.present? && (user.admin? || user.supplier?)
  end

  def create?
    user.present? && (user.admin? || user.supplier?)
  end

  def new?
    create?
  end

  def update?
    user.present? && (user.admin? || user.supplier?)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (user.admin? || user.supplier?)
  end
end