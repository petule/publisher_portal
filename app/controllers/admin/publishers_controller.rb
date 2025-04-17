class Admin::PublishersController < ApplicationController
  def index
    authorize Publisher
    @publishers = Publisher.all
    @publishers = @publishers.search(params[:query]) if params[:query].present?
    @publishers = @publishers.ordered_by(params[:order], params[:direction]).page(params[:page]).per(per_page).decorate
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @publisher = Publisher.new
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    creator = Publishers::Creator.call(publisher_params, user_params)
    if creator.success?
      @publisher = creator.result.decorate
      respond_to do |format|
        format.html { redirect_to admin_publishers_path, notice: t('views.admin.publishers.create_success') }
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

  def show
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    updator = Publishers::Updator.call(params[:id], publisher_params)
    if updator.success?
      @publisher = updator.result.decorate
      respond_to do |format|
        format.html { redirect_to admin_publishers_path, notice: t('views.admin.publishers.update_success') }
        format.turbo_stream
      end
    else
      @errors = updator.errors
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:publisher).require(:user).permit(:first_name, :last_name)
  end

  def publisher_params
    params.require(:publisher).permit(:title, :content, :address, :url, :email, :active)
  end

  def per_page
    params[:per_page] || PublisherDecorator::PER_PAGES_DEFAULT
  end
end
