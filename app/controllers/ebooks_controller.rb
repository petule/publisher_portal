class EbooksController < ApplicationController
  before_action :set_ebook, only: %i[ show edit update destroy ]

  # GET /ebooks or /ebooks.json
  def index
    @ebooks = Ebook.all
    @ebooks = @ebooks.search(params[:query]) if params[:query].present?
    @ebooks = @ebooks.ordered_by(params[:order], params[:direction]).page(params[:page]).per(per_page).decorate
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /ebooks/1 or /ebooks/1.json
  def show
  end

  # GET /ebooks/new
  def new
    @ebook = Ebook.new
  end

  # GET /ebooks/1/edit
  def edit
  end

  def create
    creator = Ebooks::Creator.call(ebook_params)
    if creator.success?
      @ebook = creator.result.decorate
      respond_to do |format|
        format.html { redirect_to ebooks_path, notice: t('views.ebooks.create_success') }
        format.turbo_stream do
          if Ebook.all.count == 1
            @ebooks = Ebook.all.ordered_by(params[:order], params[:direction]).page(params[:page]).per(per_page).decorate
          end
        end
      end
    else
      @errors = creator.errors
      @ebook = creator.result
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def update
    updator = Ebooks::Updator.call(params[:id], ebook_params)
    if updator.success?
      @author = updator.result.decorate
      respond_to do |format|
        format.html { redirect_to ebooks_path, notice: t('views.ebooks.update_success') }
        format.turbo_stream
      end
    else
      @errors = updator.errors
      respond_to do |format|
        @ebook = Ebook.find(params[:id])
        format.html {
          flash.now[:alert] = @errors.values.flatten.join(", ")
          render :edit, status: :unprocessable_entity
        }
        format.turbo_stream
      end
    end
  end

  def destroy
    @ebook = Ebook.find(params[:id])
    @ebook.destroy!

    respond_to do |format|
      format.html { redirect_to ebooks_path, status: :see_other, notice: t('views.ebooks.destroy_success') }
      format.turbo_stream
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ebook
      @ebook = Ebook.find(params.expect(:id))
    end

  def ebook_params
    params.require(:ebook).permit(:title, :original_title, :subtitle, :series_id, :part, :main_image, :annotation,
      :language_id, :publication_year, :publication_place, :page_count, :isbn, :isbn_epub, :isbn_mobi, :isbn_epub,
      :licence_end_at, :activate_at, :isbn_pdf,
      :publisher_id, :file_pdf, :file_mobi, :file_epub, author_ids: [], category_ids: [])
  end

  def per_page
    params[:per_page] || EbookDecorator::PER_PAGES_DEFAULT
  end
end
