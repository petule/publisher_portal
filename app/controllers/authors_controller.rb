class AuthorsController < ApplicationController
  def index
    @authors = Author.all
    @authors = @authors.search(params[:query]) if params[:query].present?
    @authors = @authors.ordered_by(params[:order], params[:direction]).page(params[:page]).per(per_page).decorate
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
  end

  private

  def per_page
    params[:per_page] || AuthorDecorator::PER_PAGES_DEFAULT
  end
end
