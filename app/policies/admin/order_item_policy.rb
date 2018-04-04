class Admin::OrderItemPolicy < AdminPolicy
  def show?
    user.present? && record.cloth.present? && (user.id == record.cloth.supplier_id) || user.admin?
  end

  def create?
    if user.present?
    	if record.cloth_id.present?
        # 該場身自己或是管理員才能新增該衣服的訂單
    		user.id == record.cloth.supplier_id || user.admin?
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