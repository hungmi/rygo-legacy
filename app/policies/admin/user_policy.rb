class Admin::UserPolicy < AdminPolicy
  def index?
    user.present? && user.admin?
  end

  def new?
    create?
  end

  def create?
    user.present? && user.admin?
  end

  def show?
    update?
  end

  def update?
    # 只有自己或 admin 可以修改
    user.present? && (user == record || user.admin?)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && user.admin?
  end
end