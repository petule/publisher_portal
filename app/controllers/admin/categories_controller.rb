class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy move item]

  # GET /categories
  def index
    @languages = Language.by_active
    @categories = Category.by_first_category
  end

  # GET /categories/1
  def show
    @ebooks = @category.ebooks
    @ebooks = @ebooks.search(params[:query]) if params[:query].present?
    @ebooks = @ebooks.ordered_by(params[:order], params[:direction]).page(params[:page]).per(ebook_per_page).decorate
  end

  # GET /categories/new
  def new
    language = Language.find_by_id(params[:language_id])
    @category = Category.new(language_id: language.id,
                             category_type: CategoryType.by_language(language).first)
  end

  # POST /categories
  def create
    creator = Categories::Creator.call(category_params)
    if creator.success?
      @category = creator.result
      respond_to do |format|
        format.html { redirect_to admin_categories_path, notice: t('views.admin.categories.create_success') }
        format.turbo_stream
      end
    else
      @errors = creator.errors
      @category = creator.result
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  # GET /categories/1/edit
  def edit
  end

  def item
  end

  # PATCH /categories/1/move
  def move
    mover = Categories::Mover.call(params[:id], params[:position], params[:category_id])
    @errors = mover.errors if mover.failure?
  end

  def update
    updator = Categories::Updator.call(params[:id], category_params)
    if updator.success?
      @category = updator.result
      respond_to do |format|
        format.html { redirect_to admin_categories_path, notice: t('views.categories.update_success') }
        format.turbo_stream
      end
    else
      @errors = updator.errors
      respond_to do |format|
        @category = Category.find(params[:id])
        format.html {
          flash.now[:alert] = @errors.values.flatten.join(", ")
          render :edit, status: :unprocessable_entity
        }
        format.turbo_stream
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path, notice: t('views.admin.categories.destroy_success')
  end

  private

  def category_params
    permitted = params.require(:category).permit(:name, :title, :url, :content, :active, :seo_title, :seo_description,
      :language_id, :category_type_id, :favourite, category_id: [], ebook_ids: [])

    if permitted[:category_id].is_a?(Array)
      permitted[:category_id] = permitted[:category_id].reject(&:blank?).first
    end

    permitted
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
