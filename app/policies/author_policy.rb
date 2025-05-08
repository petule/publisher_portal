class AuthorPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    user&.admin_role?
  end

  def update?
    edit?
  end

  def create?
    edit?
  end

  def new?
    edit?
  end

  def destroy?
    edit?
  end
end
