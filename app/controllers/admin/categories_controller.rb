class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy move]

  # GET /categories
  def index
    @languages = Language.by_active
    @categories = Category.by_first_category
  end

  # GET /categories/1
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'Kategorie byla úspěšně vytvořena.'
    else
      render :new
    end
  end

  # GET /categories/1/edit
  def edit
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Kategorie byla úspěšně aktualizována.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: 'Kategorie byla úspěšně odstraněna.'
  end

  # PATCH /categories/1/move
  def move
    mover = Categories::Mover.call(params[:id], params[:position])
    @errors = mover.errors if mover.failure?
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :title, :url, :content, :parent_category_id, :category_type_id, :favourite, :seo_title, :seo_description, :active)
  end
end
