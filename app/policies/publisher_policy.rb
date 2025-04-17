class PublisherPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin_role?
  end

  def show?
    user.admin_role? || (user.publisher.present? && user.publisher == record)
  end

  def create?
    user.admin_role?
  end

  def edit?
    show? || user.publisher_admin_role?
  end

  def new?
    create?
  end

  def update?
    edit?
  end

  def destroy?
    user.admin_role?
  end
end
