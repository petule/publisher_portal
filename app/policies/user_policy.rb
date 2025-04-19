class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record = nil)
    @user = user
    @record = record
  end

  def admin_access?
    admin?
  end

  def index?
    admin? || user&.publisher_admin_role?
  end

  def admin?
    user&.admin_role?
  end
end
