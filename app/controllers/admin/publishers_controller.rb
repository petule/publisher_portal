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
    params[:per_page] || PublisherDecorator::PER_PAGES_DEFAULT
  end
end
