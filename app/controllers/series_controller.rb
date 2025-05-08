class SeriesController < ApplicationController
  before_action :set_series, only: %i[ show edit update destroy ]
  before_action :authorize_series!, only: %i[show edit update destroy]
  before_action :authorize_series_class!, only: %i[index new create]

  def index
    authorize Series
    @series = Series.all
    @series = @series.search(params[:query]) if params[:query].present?
    @series = @series.ordered_by(params[:order], params[:direction]).page(params[:page]).per(per_page).decorate
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
  end

  def create
    creator = SeriesServices::Creator.call(series_params)
    if creator.success?
      @series = creator.result.decorate
      respond_to do |format|
        format.html { redirect_to series_index_path, notice: t('views.series.create_success') }
        format.turbo_stream do
          if Series.all.count == 1
            @series = Series.all.ordered_by(params[:order], params[:direction]).page(params[:page]).per(per_page).decorate
          end
        end
      end
    else
      @errors = creator.errors
      @series = creator.result
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  # GET /series/new
  def new
    @series = Series.new
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /series/1/edit
  def edit
  end

  def update
    updator = SeriesServices::Updator.call(params[:id], series_params)
    if updator.success?
      @series = updator.result.decorate
      respond_to do |format|
        format.html { redirect_to series_index_path, notice: t('views.series.update_success') }
        format.turbo_stream
      end
    else
      @errors = updator.errors
      respond_to do |format|
        @series = Series.find(params[:id])
        format.html {
          flash.now[:alert] = @errors.values.flatten.join(", ")
          render :edit, status: :unprocessable_entity
        }
        format.turbo_stream
      end
    end
  end

  def destroy
    @series = Series.find(params[:id])
    @series.destroy!

    respond_to do |format|
      format.html { redirect_to series_index_path, status: :see_other, notice: t('views.series.destroy_success') }
      format.turbo_stream
    end
  end

  private
    def authorize_series!
      authorize @series
    end

    def authorize_series_class!
      authorize Series
    end

    def set_series
      @series = Series.find(params.expect(:id))
    end

    def series_params
      params.require(:series).permit(:title, :subtitle, :short_content, :content, :video, :isbn, :active)
    end

    def per_page
      params[:per_page] || SeriesDecorator::PER_PAGES_DEFAULT
    end
end
