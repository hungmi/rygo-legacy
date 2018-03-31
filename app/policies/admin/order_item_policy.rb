class Admin::OrderItemPolicy < AdminPolicy
  def show?
    user.present? && record.cloth.present? && (user.id == record.cloth.supplier_id) || user.admin?
  end

  def create?
    if user.present?
    	if record.cloth_id.present?
    		user.id == record.cloth.supplier_id
    	else
    		record.cloth_id.nil?
    	end
    end
  end

  def new?
    user.present?
  end

  def update?
    user.present? && record.cloth.present? && (user.id == record.cloth.supplier_id) || user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end