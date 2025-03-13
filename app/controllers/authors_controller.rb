class AuthorsController < ApplicationController
  def index
    @authors = Author.all
    @authors = @authors.order(params[:order]).page(params[:page]).per(per_page).decorate
  end

  def show
  end

  private

  def per_page
    params[:per_page] || AuthorDecorator::PER_PAGES_DEFAULT
  end
end
