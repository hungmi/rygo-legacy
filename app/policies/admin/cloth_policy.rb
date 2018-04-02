class Admin::ClothPolicy < AdminPolicy
  def show?
    user.present? && (user.id == record.supplier_id) || user.admin?
  end

  def create?
    update?
  end

  def new?
    user.present?
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