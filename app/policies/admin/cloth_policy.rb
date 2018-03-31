class Admin::ClothPolicy < AdminPolicy
	def index?
    user.present?
  end

  def show?
    user.present? && (user.id == record.supplier_id) || user.admin?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && (user.id == record.supplier_id) || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end