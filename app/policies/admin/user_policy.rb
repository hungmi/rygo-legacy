class Admin::UserPolicy < AdminPolicy
  def index?
    user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def show?
    update?
  end

  def update?
    user.present? && (user == record || user.admin?)
    # 因為沒有 admin, 先設定為大家可以互相修改
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end