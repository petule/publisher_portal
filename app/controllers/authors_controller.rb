class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]
  before_action :authorize_author!, only: %i[show edit update destroy]
  before_action :authorize_author_class!, only: %i[index new create]

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
    authorize :author, :show?
  end

  def create
    creator = Authors::Creator.call(author_params)
    if creator.success?
      @author = creator.result.decorate
      respond_to do |format|
        format.html { redirect_to authors_path, notice: t('views.authors.create_success') }
        format.turbo_stream do
          if Author.all.count == 1
            @authors = Author.all.ordered_by(params[:order], params[:direction]).page(params[:page]).per(per_page).decorate
          end
        end
      end
    else
      @errors = creator.errors
      @author = creator.result
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  # GET /series/new
  def new
    @author = Author.new
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /series/1/edit
  def edit
  end

  def update
    updator = Authors::Updator.call(params[:id], author_params)
    if updator.success?
      @author = updator.result.decorate
      respond_to do |format|
        format.html { redirect_to series_index_path, notice: t('views.authors.update_success') }
        format.turbo_stream
      end
    else
      @errors = updator.errors
      respond_to do |format|
        @author = Author.find(params[:id])
        format.html {
          flash.now[:alert] = @errors.values.flatten.join(", ")
          render :edit, status: :unprocessable_entity
        }
        format.turbo_stream
      end
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy!

    respond_to do |format|
      format.html { redirect_to authors_path, status: :see_other, notice: t('views.authors.destroy_success') }
      format.turbo_stream
    end
  end

  private

  def authorize_author!
    authorize @author
  end

  def authorize_author_class!
    authorize Author
  end

  def author_params
    params.require(:author).permit(:first_name, :last_name, :degree, :content, :active).
      merge(author_type: params.dig(:author, :author_type).to_i)
  end

  def set_author
    @author = Author.find(params[:id])
  end

  def per_page
    params[:per_page] || AuthorDecorator::PER_PAGES_DEFAULT
  end
end
