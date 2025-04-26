class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record = nil)
    @user = user
    @record = record
  end

  def edit?
    puts "EDITING EDIT #{admin? }|| #{user.id} == #{record.id}"
    admin? || user.id == record.id
  end

  def update?
    edit?
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
