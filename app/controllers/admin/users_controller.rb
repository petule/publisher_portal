class Admin::UsersController < ApplicationController
  def index
    authorize User
    @users = User.all
    @users = @users.search(params[:query]) if params[:query].present?
    @users = @users.by_role(params[:role]) if params[:role].present?
    @users = @users.ordered_by(params[:order], params[:direction]).page(params[:page]).per(per_page).decorate
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def per_page
    params[:per_page] || UserDecorator::PER_PAGES_DEFAULT
  end
end
