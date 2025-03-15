# Parent class for admin sections policies.
class AdminPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def access?
    user&.admin_role?
  end

  def index?
    user.admin_role?
  end

  def new?
    create?
  end

  def create?
    user.admin_role?
  end

  def edit?
    update?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
