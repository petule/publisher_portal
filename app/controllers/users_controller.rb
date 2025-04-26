class UsersController < ApplicationController
  def profile
    @user = current_user
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update_password
    @user = User.find(params[:id])

    if @user.update_with_password(password_update_params)
      bypass_sign_in(@user) # Devise potřeba
      respond_to do |format|
        format.html { redirect_to profile_path, notice: t('views.users.password_update_success') }
        format.turbo_stream
      end
    else
      @errors = @user.errors.messages
      respond_to do |format|
        format.html {
          flash.now[:alert] = @errors.values.flatten.join(", ")
          render :edit, status: :unprocessable_entity
        }
        format.turbo_stream
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update
    updator = Users::Updator.call(params[:id], user_params)
    if updator.success?
      @user = updator.result.decorate
      respond_to do |format|
        format.html { redirect_to profile_path, notice: t('views.users.update_success') }
        format.turbo_stream
      end
    else
      @errors = updator.errors
      respond_to do |format|
        @user = User.find(params[:id])
        format.html {
          flash.now[:alert] = @errors.values.flatten.join(", ")
          render :edit, status: :unprocessable_entity
        }
        format.turbo_stream
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to admin_users_path, notice: "Uživatel byl smazán." }
    end
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

  def password_update_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :publisher_id, :avatar)
  end

  def per_page
    params[:per_page] || UserDecorator::PER_PAGES_DEFAULT
  end
end
