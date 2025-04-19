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

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    creator = Users::Creator.call(user_params)
    if creator.success?
      @user = creator.result.decorate
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: t('views.admin.users.create_success') }
        format.turbo_stream
      end
    else
      @errors = creator.errors
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :publisher_id).
      merge(role: params.dig(:user, :role).to_i)
  end

  def per_page
    params[:per_page] || UserDecorator::PER_PAGES_DEFAULT
  end
end
