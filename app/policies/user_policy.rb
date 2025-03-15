class UserPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def admin_access?
    admin?
  end

  def admin?
    user&.admin_role?
  end
end
