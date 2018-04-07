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
    user.present? && (user == record || user.admin?)
    # 只有自己或 admin 可以修改
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end