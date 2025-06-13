class HomeController < ApplicationController
  def index
    @ebooks = Ebook.all
    @ebooks = @ebooks.search(params[:query]) if params[:query].present?
    @ebooks = @ebooks.ordered_by(params[:order], params[:direction]).page(params[:page]).per(ebook_per_page).decorate
  end
end
